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
	event.ImageUrl = reqData.ImageUrl
	event.Location = reqData.Location
	event.CreatedAt = time.Now().UTC().Local()

	return s.storage.CreatEvent(ctx, event)

}
