package main

import (
	"context"
	"encoding/json"
	"io"
	"log"
	"net/http"
	"strings"
	"time"

	"github.com/luquxSentinel/ticketz/service"
	"github.com/luquxSentinel/ticketz/types"
)

type APIFunc func(writer http.ResponseWriter, request *http.Request) error

type APIServer struct {
	listenAddress string
	router        *http.ServeMux
	eventService  *service.EventService
}

func NewAPIServer(listenAddress string, eventService *service.EventService) *APIServer {
	return &APIServer{
		listenAddress: listenAddress,
		router:        http.NewServeMux(),
		eventService:  eventService,
	}
}

func (api *APIServer) Run() error {

	api.router.HandleFunc("POST /events", handlerFunc(api.createEvent))
	api.router.HandleFunc("GET /events/event/{event_id}", handlerFunc(api.getEvent))
	api.router.HandleFunc("GET /events/", handlerFunc(api.getEvents))

	// start server and listen
	return http.ListenAndServe(api.listenAddress, api.router)
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

	err := api.eventService.CreateEvent(r.Context(), *reqData)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return nil
	}

	return ResponseWriter(w, map[string]string{"message": "event created"})
}

func (api *APIServer) getEvents(w http.ResponseWriter, r *http.Request) error {

	events, err := api.eventService.GetEvents(r.Context())
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return nil
	}

	return ResponseWriter(w, events)
}

func (api *APIServer) getEvent(w http.ResponseWriter, r *http.Request) error {

	path := r.URL.Path
	parts := strings.Split(path, "/")
	if len(parts) != 4 {
		http.Error(w, "invalid event id provided", http.StatusBadRequest)
		return nil
	}

	event_id := parts[len(parts)-1]

	event, err := api.eventService.GetEvent(r.Context(), event_id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return nil
	}

	return ResponseWriter(w, event)
}

// func (api *APIServer) removeEvent(w http.ResponseWriter, r *http.Request) error {
// 	return nil
// }

func ResponseWriter(w io.Writer, v any) error {
	return json.NewEncoder(w).Encode(v)
}

func RequestReader(r io.Reader, v any) error {
	return json.NewDecoder(r).Decode(v)
}
