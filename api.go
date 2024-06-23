package main

import (
	"context"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"time"

	"github.com/luquxSentinel/ticketz/types"
)

type APIFunc func(writer http.ResponseWriter, request *http.Request) error

type APIServer struct {
	listenAddress string
	port          int
	router        *http.ServeMux
}

func NewAPIServer(listenAddress string, port int) *APIServer {
	return &APIServer{
		listenAddress: listenAddress,
		port:          port,
		router:        http.NewServeMux(),
	}
}

func (api *APIServer) Run() error {

	// start server and listen
	return http.ListenAndServe(fmt.Sprintf("%s:%d", api.listenAddress, api.port), api.router)
}

func handlerFunc(fn APIFunc) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		ctx, cancel := context.WithTimeout(r.Context(), 30*time.Second)
		defer cancel()

		err := fn(w, r.WithContext(ctx))
		if err != nil {
			log.Panic(err)
		}
	}
}

func (api *APIServer) createEvent(w http.ResponseWriter, r *http.Request) error {

	reqData := new(types.CreateEvent)

	if err := RequestReader(r.Body, reqData); err != nil {
		http.Error(w, "invalid request body", http.StatusBadRequest)
		return nil
	}

	return nil
}

func (api *APIServer) getEvents(w http.ResponseWriter, r *http.Request) error {
	return nil

}

func (api *APIServer) getEvent(w http.ResponseWriter, r *http.Request) error {
	return nil
}

func (api *APIServer) removeEvent(w http.ResponseWriter, r *http.Request) error {
	return nil
}

func Writer(w io.Writer, v any) error {
	return json.NewEncoder(w).Encode(v)
}

func RequestReader(r io.Reader, v any) error {
	return json.NewDecoder(r).Decode(v)
}
