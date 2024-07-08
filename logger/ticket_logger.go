package logger

import (
	"context"

	"github.com/luquxSentinel/ticketz/service"
	"github.com/luquxSentinel/ticketz/types"
	"github.com/sirupsen/logrus"
)

type TicketLogger struct {
	ticketService *service.TicketService
	logger        *logrus.Logger
}

func NewTicketLogger(ticketService *service.TicketService) *TicketLogger {
	return &TicketLogger{
		ticketService: ticketService,
		logger:        logrus.New(),
	}
}

func (s *TicketLogger) CreateTicket(ctx context.Context, uid string, eventId string) error {

	err := s.ticketService.CreateTicket(ctx, uid, eventId)

	s.logger.WithFields(logrus.Fields{
		"error": err,
	}).Info("create ticket")

	return err
}

func (s *TicketLogger) GetTickets(ctx context.Context, uid string) ([]*types.GetTicket, error) {
	tickets, err := s.ticketService.GetTickets(ctx, uid)

	s.logger.WithFields(logrus.Fields{
		"error": err,
	}).Info("get tickets")

	return tickets, err
}

func (s *TicketLogger) GetTicket(ctx context.Context, ticket_id string) (*types.GetTicket, error) {
	ticket, err := s.ticketService.GetTicket(ctx, ticket_id)

	s.logger.WithFields(logrus.Fields{
		"error": err,
	}).Info("get tickets")

	return ticket, err
}
