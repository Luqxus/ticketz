package types

import "time"

type Ticket struct {
	TicketID  string
	EventID   string
	UID       string
	CreatedAt time.Time
}

type GetTicket struct {
	TicketID   string    `json:"ticket_id"`
	EventID    string    `json:"event_id"`
	EventTitle string    `json:"event_title"`
	EventDate  string    `json:"event_date"`
	EventPrice float64   `json:"price"`
	Location   Location  `json:"location"`
	ImageUrl   string    `json:"image_url"`
	CreatedAt  time.Time `json:"created_at"`
}
