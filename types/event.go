package types

import "time"

type Event struct {
	EventID     string    `json:"event_id"`
	Title       string    `json:"title"`
	Description string    `json:"description"`
	ImageUrl    string    `json:"image_url"`
	EventDate   time.Time `json:"event_date"`
	Location    Location  `json:"location"`
	TicketPrice float64   `json:"event_price"`
	EndTime     time.Time `json:"end_time"`
	CreatedAt   time.Time `json:"created_at"`
}

type CreateEvent struct {
	Title       string    `json:"title"`
	Description string    `json:"description"`
	ImageUrl    string    `json:"image_url"`
	Location    Location  `json:"location"`
	EventDate   time.Time `json:"event_date"`
	EndTime     time.Time `json:"end_time"`
	TicketPrice float64   `json:"event_price"`
}

type Location struct {
	LocationID string `json:"-"`
	City       string `json:"city"`
	Provice    string `json:"province"`
	Country    string `json:"country"`
}
