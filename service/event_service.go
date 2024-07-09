package service

import (
	"context"
	"time"

	"github.com/google/uuid"
	"github.com/luquxSentinel/ticketz/storage"
	"github.com/luquxSentinel/ticketz/types"
)

type IEventService interface {
	CreateEvent(ctx context.Context, uid string, reqData types.CreateEvent) error
	GetEvents(ctx context.Context, uid string) ([]*types.Event, error)
	GetEvent(ctx context.Context, event_id string) (*types.Event, error)
	BookmarkEvent(ctx context.Context, uid string, eventID string) error
}

type EventService struct {
	storage storage.Storage
}

func NewEventService(storage storage.Storage) *EventService {
	return &EventService{
		storage: storage,
	}
}

func (s *EventService) CreateEvent(ctx context.Context, uid string, reqData types.CreateEvent) error {
	event := new(types.Event)

	event.EventID = uuid.NewString()
	event.Organizer = uid
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

func (s *EventService) GetEvents(ctx context.Context, uid string) ([]*types.Event, error) {
	return s.storage.GetEvents(ctx, uid)
}

func (s *EventService) GetEvent(ctx context.Context, event_id string) (*types.Event, error) {
	return s.storage.GetEvent(ctx, event_id)
}

func (s *EventService) BookmarkEvent(ctx context.Context, uid string, eventID string) error {
	return s.storage.BookmarkEvent(ctx, uid, eventID)
}
