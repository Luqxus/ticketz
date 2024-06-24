package main

import (
	"fmt"
	"log"
	"os"

	"github.com/joho/godotenv"
	"github.com/luquxSentinel/ticketz/service"
	"github.com/luquxSentinel/ticketz/storage"
)

func main() {

	if err := godotenv.Load(".env"); err != nil {
		log.Fatal(err)
	}

	address := os.Getenv("ADDRESS")
	if address == "" {
		fmt.Println("ERROR: ADDRESS not found in env, resolving to default.")
		address = "127.0.0.1"
	}

	port := os.Getenv("PORT")
	if port == "" {
		fmt.Println("ERROR: PORT not found in env, resolving to default.")
		port = "3000"
	}

	storage, err := storage.NewPgStorage()
	if err != nil {
		log.Fatal(err)
	}

	eventService := service.NewEventService(storage)
	userService := service.NewUserService(storage)

	listenAddress := fmt.Sprintf("%s:%s", address, port)
	server := NewAPIServer(listenAddress, userService, eventService)

	if err := server.Run(); err != nil {
		log.Fatal(err)
	}

}
