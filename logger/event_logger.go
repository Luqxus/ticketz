package logger

import (
	"context"

	"github.com/luquxSentinel/ticketz/service"
	"github.com/luquxSentinel/ticketz/types"
	"github.com/sirupsen/logrus"
)

type EventLogger struct {
	eventService *service.EventService
	logger       *logrus.Logger
}

func NewEventLogger(eventService *service.EventService) *EventLogger {
	return &EventLogger{
		eventService: eventService,
		logger:       logrus.New(),
	}
}

func (s *EventLogger) CreateEvent(ctx context.Context, uid string, reqData types.CreateEvent) error {
	err := s.eventService.CreateEvent(ctx, uid, reqData)

	s.logger.WithFields(logrus.Fields{
		"error": err,
	}).Info("create event")

	return err
}

func (s *EventLogger) GetEvents(ctx context.Context) ([]*types.Event, error) {

	events, err := s.eventService.GetEvents(ctx)
	s.logger.WithFields(logrus.Fields{
		"error": err,
	}).Info("get events")

	return events, err
}

func (s *EventLogger) GetEvent(ctx context.Context, event_id string) (*types.Event, error) {
	event, err := s.eventService.GetEvent(ctx, event_id)
	s.logger.WithFields(logrus.Fields{
		"error": err,
	}).Info("get events")

	return event, err
}
