package service

import (
	"context"
	"time"

	"github.com/google/uuid"
	"github.com/luquxSentinel/ticketz/storage"
	"github.com/luquxSentinel/ticketz/types"
)

type EventService struct {
	storage storage.Storage
}

func NewEventService(storage storage.Storage) *EventService {
	return &EventService{
		storage: storage,
	}
}

func (s *EventService) CreateEvent(ctx context.Context, reqData types.CreateEvent) error {
	event := new(types.Event)

	event.EventID = uuid.NewString()
	event.Title = reqData.Title
	event.Description = reqData.Description
	event.TicketPrice = reqData.TicketPrice
	event.EventDate = reqData.EventDate
	event.EndTime = reqData.EndTime
	event.ImageUrl = reqData.ImageUrl
	event.Location = reqData.Location
	event.Location.LocationID = uuid.NewString()
	event.CreatedAt = time.Now().UTC().Local()

	return s.storage.CreatEvent(ctx, event)
}

func (s *EventService) GetEvents(ctx context.Context) ([]*types.Event, error) {
	return s.storage.GetEvents(ctx)
}

func (s *EventService) GetEvent(ctx context.Context, event_id string) (*types.Event, error) {
	return s.storage.GetEvent(ctx, event_id)
}

func (s *EventService) BuyTicket(ctx context.Context, uid string, eventID string) error {

	return s.storage.CreateTicket(ctx, uid, eventID)
}

func (s *EventService) GetTicket(ctx context.Context, ticketID string) (*types.Ticket, error) {
	return s.storage.GetTicket(ctx, ticketID)
}

func (s *EventService) GetTickets(ctx context.Context, uid string) ([]*types.Ticket, error) {
	return s.storage.GetTickets(ctx, uid)
}
