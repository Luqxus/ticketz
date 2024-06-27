package types

import "time"

// e.event_id, e.title, e.description, e.ticket_price, e.event_date, e.end_time, e.image_url, l.city, l.province, l.country

type Ticket struct {
	TicketID      string    `json:"ticket_id"`
	EventID       string    `json:"event_id"`
	EventTitle    string    `json:"event_title"`
	TicketPrice   float64   `json:"ticket_price"`
	EventDate     time.Time `json:"event_time"`
	EventEndTime  time.Time `json:"event_end_time"`
	EventImageUrl string    `json:"event_image_url"`
	EventLocation Location  `json:"location"`
}
