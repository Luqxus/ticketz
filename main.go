package main

import (
	"fmt"
	"log"
	"os"
	"strconv"

	"github.com/joho/godotenv"
	"github.com/luquxSentinel/ticketz/logger"
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

	dbport, err := strconv.Atoi(os.Getenv("DATABASE_PORT"))
	if err != nil {
		log.Fatal(err)
	}

	dbconfig := &storage.DatabaseConfig{
		Host:     os.Getenv("DATABASE_HOST"),
		User:     os.Getenv("DATABASE_USER"),
		Port:     dbport,
		Password: os.Getenv("DATABASE_PASSWORD"),
		DBName:   os.Getenv("DATABASE_NAME"),
	}

	storage, err := storage.NewPgStorage(dbconfig)
	if err != nil {
		log.Fatal(err)
	}

	eventService := service.NewEventService(storage)
	userService := service.NewUserService(storage)
	ticketService := service.NewTicketService(storage)

	listenAddress := fmt.Sprintf("%s:%s", address, port)
	server := NewAPIServer(listenAddress, logger.NewUserLogger(userService), logger.NewEventLogger(eventService), logger.NewTicketLogger(ticketService))

	if err := server.Run(); err != nil {
		log.Fatal(err)
	}

}
