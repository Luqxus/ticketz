package types

import "time"

type Event struct {
	EventID     string    `json:"event_id"`
	Title       string    `json:"title"`
	Description string    `json:"description"`
	ImageUrl    string    `json:"image_url"`
	Location    Location  `json:"location"`
	CreatedAt   time.Time `json:"created_at"`
}

type CreateEvent struct {
	Title       string   `json:"title"`
	Description string   `json:"description"`
	ImageUrl    string   `json:"image_url"`
	Location    Location `json:"location"`
}

type Location struct {
	City    string `json:"city"`
	Provice string `json:"province"`
	Country string `json:"country"`
}
