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
	userService   service.UserService
}

func NewAPIServer(listenAddress string, userService *service.UserService, eventService *service.EventService) *APIServer {
	return &APIServer{
		listenAddress: listenAddress,
		router:        http.NewServeMux(),
		eventService:  eventService,
		userService:   *userService,
	}
}

func (api *APIServer) Run() error {

	api.router.HandleFunc("POST /users", handlerFunc(api.createUser))
	api.router.HandleFunc("POST /users/login", handlerFunc(api.signIn))

	api.router.HandleFunc("POST /events/ticket", handlerFunc(api.buyTicket))
	api.router.HandleFunc("GET /tickets", handlerFunc(api.getTickets))
	api.router.HandleFunc("GET /tickets/{ticket}", handlerFunc(api.getTicket))

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

func (api *APIServer) createUser(w http.ResponseWriter, r *http.Request) error {
	reqData := new(types.CreateUser)

	if err := RequestReader(r.Body, reqData); err != nil {
		http.Error(w, "invalid request body", http.StatusBadRequest)
		return nil
	}

	err := api.userService.SignUp(r.Context(), reqData)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return nil
	}

	return ResponseWriter(w, map[string]string{"message": "user created"})
}

func (api *APIServer) signIn(w http.ResponseWriter, r *http.Request) error {
	reqData := new(types.LoginData)

	if err := RequestReader(r.Body, reqData); err != nil {
		http.Error(w, "invalid request body", http.StatusBadRequest)
		return nil
	}

	user, token, err := api.userService.SignIn(r.Context(), reqData)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return nil
	}

	w.Header().Set("authorization", token)

	return ResponseWriter(w, user)
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

func (api *APIServer) buyTicket(w http.ResponseWriter, r *http.Request) error {
	event_id := r.URL.Query().Get("eventid")
	if event_id == "" {
		http.Error(w, "event id query param not provided", http.StatusBadRequest)
		return nil
	}

	uid := ""

	err := api.eventService.BuyTicket(r.Context(), uid, event_id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return nil
	}

	return ResponseWriter(w, map[string]string{"message": "purchase successful"})
}

func (api *APIServer) getTickets(w http.ResponseWriter, r *http.Request) error {
	uid := ""

	tickets, err := api.eventService.GetTickets(r.Context(), uid)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return nil
	}

	return ResponseWriter(w, tickets)
}

func (api *APIServer) getTicket(w http.ResponseWriter, r *http.Request) error {
	ticketID := r.URL.Query().Get("ticketid")
	if ticketID == "" {
		http.Error(w, "ticket id query param not provided", http.StatusBadRequest)
		return nil
	}
	ticket, err := api.eventService.GetTicket(r.Context(), ticketID)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return nil
	}

	return ResponseWriter(w, ticket)

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
