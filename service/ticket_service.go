package service

import (
	"context"
	"time"

	"github.com/google/uuid"
	"github.com/luquxSentinel/ticketz/storage"
	"github.com/luquxSentinel/ticketz/types"
)

type ITicketService interface {
	CreateTicket(ctx context.Context, uid string, eventId string) error
	GetTickets(ctx context.Context, uid string) ([]*types.GetTicket, error)
	GetTicket(ctx context.Context, ticket_id string) (*types.GetTicket, error)
}

type TicketService struct {
	storage storage.Storage
}

func NewTicketService(s storage.Storage) *TicketService {
	return &TicketService{storage: s}
}

func (s *TicketService) CreateTicket(ctx context.Context, uid string, eventId string) error {

	ticket := new(types.Ticket)

	ticket.TicketID = uuid.NewString()
	ticket.EventID = eventId
	ticket.UID = uid
	ticket.CreatedAt = time.Now().UTC()

	return s.storage.CreateTicket(ctx, ticket)

}

func (s *TicketService) GetTickets(ctx context.Context, uid string) ([]*types.GetTicket, error) {
	return s.storage.GetTickets(ctx, uid)
}

func (s *TicketService) GetTicket(ctx context.Context, ticket_id string) (*types.GetTicket, error) {
	return s.storage.GetTicket(ctx, ticket_id)
}
