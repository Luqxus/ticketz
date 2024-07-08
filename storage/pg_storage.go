package storage

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
	"log"
	"time"

	_ "github.com/lib/pq"

	"github.com/luquxSentinel/ticketz/types"
)

// const (
// 	host     = "localhost"
// 	port     = 5432
// 	user     = "luqus"
// 	password = "Luqus-@1041"
// 	dbname   = "ticketz"
// )

type PgStorage struct {
	db *sql.DB
}

type DatabaseConfig struct {
	Host     string
	User     string
	Port     int
	Password string
	DBName   string
}

func NewPgStorage(config *DatabaseConfig) (*PgStorage, error) {

	pgConfig := fmt.Sprintf("host=%s port=%d user=%s "+
		"password=%s dbname=%s sslmode=disable",
		config.Host, config.Port, config.User, config.Password, config.DBName)

	db, err := sql.Open("postgres", pgConfig)
	if err != nil {
		return nil, err
	}

	if err := db.Ping(); err != nil {
		return nil, err
	}

	return &PgStorage{
		db: db,
	}, nil

}

func (pg *PgStorage) CreatEvent(ctx context.Context, event *types.Event) error {
	tx, err := pg.db.Begin()
	if err != nil {
		return err
	}

	query := `
	INSERT INTO Events (event_id, organizer, title, description, ticket_price, event_date, end_time, image_url, created_at) 
	VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9)`

	_, err = tx.ExecContext(
		ctx,
		query,
		event.EventID,
		event.Organizer,
		event.Title,
		event.Description,
		event.TicketPrice,
		event.EventDate,
		event.EndTime,
		event.ImageUrl,
		event.CreatedAt,
	)

	if err != nil {
		tx.Rollback()
		return err
	}

	query = `
	INSERT INTO Locations (location_id, event_id, city, province, country, venue) 
	VALUES($1, $2, $3, $4, $5, $6)`

	_, err = tx.ExecContext(
		ctx,
		query,
		event.Location.LocationID,
		event.EventID,
		event.Location.City,
		event.Location.Provice,
		event.Location.Country,
		event.Location.Venue,
	)
	if err != nil {
		tx.Rollback()
		return err
	}

	tx.Commit()
	return nil
}

func (pg *PgStorage) GetEvents(ctx context.Context) ([]*types.Event, error) {
	query := `
	SELECT Events.event_id, Events.organizer, Events.title, Events.description, Events.ticket_price, Events.event_date, Events.end_time, Events.image_url, Locations.city, Locations.province, Locations.country, Locations.venue 
	FROM Events INNER JOIN Locations ON Events.event_id=Locations.event_id`

	result, err := pg.db.QueryContext(ctx, query)
	if err != nil {
		return nil, err
	}

	defer result.Close()

	events := make([]*types.Event, 0)

	for result.Next() {
		event := new(types.Event)

		err = result.Scan(
			&event.EventID,
			&event.Organizer,
			&event.Title,
			&event.Description,
			&event.TicketPrice,
			&event.EventDate,
			&event.EndTime,
			&event.ImageUrl,
			&event.Location.City,
			&event.Location.Provice,
			&event.Location.Country,
			&event.Location.Venue,
		)

		if err != nil {
			return nil, err
		}

		events = append(events, event)

	}

	return events, nil
}

func (pg *PgStorage) GetEvent(ctx context.Context, event_id string) (*types.Event, error) {
	query := `
	 SELECT Events.event_id, Events.title, Events.description, Events.ticket_price, Events.event_date, Events.end_time, Events.image_url, Locations.city, Locations.province, Locations.country, Locations.venue 
	FROM Events INNER JOIN Locations ON Events.event_id=Locations.event_id
	WHERE Events.event_id=$1
	`

	row := pg.db.QueryRowContext(ctx, query, event_id)

	if row.Err() != nil {
		return nil, row.Err()
	}

	event := new(types.Event)

	if err := row.Scan(&event.EventID,
		&event.Title,
		&event.Description,
		&event.TicketPrice,
		&event.EventDate,
		&event.EndTime,
		&event.ImageUrl,
		&event.Location.City,
		&event.Location.Provice,
		&event.Location.Country,
		&event.Location.Venue,
	); err != nil {
		return nil, err
	}

	return event, nil
}

func (pg *PgStorage) CreateUser(
	ctx context.Context,
	uid string,
	email string,
	username string,
	password string,
	createdAt time.Time,
) (*types.User, error) {
	query := `
	INSERT INTO Users (uid, email, username, password, created_at)
	VALUES ($1, $2, $3, $4, $5)
	`

	_, err := pg.db.ExecContext(ctx, query, uid, email, username, password, createdAt)
	if err != nil {
		return nil, err
	}

	user, err := pg.GetUser(ctx, email)
	if err != nil {
		return nil, errors.New("error signing you up")
	}
	return user, nil
}

func (pg *PgStorage) GetUser(ctx context.Context, email string) (*types.User, error) {
	query := `
	SELECT uid, email, username, password, created_at
	FROM Users
	WHERE email=$1`

	row := pg.db.QueryRowContext(ctx, query, email)

	if row.Err() != nil {
		return nil, row.Err()
	}

	user := new(types.User)

	err := row.Scan(&user.UID, &user.Email, &user.Username, &user.Password, &user.CreatedAt)
	if err != nil {
		return nil, err
	}

	return user, nil
}

func (pg *PgStorage) CountEmail(ctx context.Context, email string) (int64, error) {
	query := `SELECT COUNT(email) FROM Users WHERE email=$1`

	var count int64

	row := pg.db.QueryRowContext(ctx, query, email)

	if row.Err() != nil {
		return -1, row.Err()
	}

	err := row.Scan(&count)

	if err != nil {
		return -1, err
	}

	return count, nil
}

func (pg *PgStorage) CreateTicket(ctx context.Context, ticket *types.Ticket) error {
	query := `
	INSERT INTO Tickets (ticket_id, event_id, uid, created_at)
	VALUES ($1, $2, $3, $4)
	`

	fmt.Printf("%+v\n", ticket)

	_, err := pg.db.ExecContext(ctx, query, ticket.TicketID, ticket.EventID, ticket.UID, ticket.CreatedAt)
	if err != nil {
		log.Println(err)
	}

	return err
}

func (pg *PgStorage) GetTicket(ctx context.Context, ticket_id string) (*types.GetTicket, error) {
	query := `SELECT
	Tickets.ticket_id, 
    Events.event_id, 
    Events.title, 
    Events.ticket_price, 
    Events.event_date, 
    Events.image_url, 
    Locations.city, 
    Locations.province, 
    Locations.country,
	Locations.venue,
	Tickets.created_at 
	FROM 
		Tickets
	INNER JOIN 
		Events 
	ON 
		Tickets.event_id = Events.event_id
	INNER JOIN 
		Locations 
	ON 
		Events.event_id = Locations.event_id
	WHERE 
		Tickets.ticket_id = $1`

	row := pg.db.QueryRowContext(ctx, query, ticket_id)

	if row.Err() != nil {
		return nil, row.Err()
	}

	ticket := new(types.GetTicket)

	if err := row.Scan(
		&ticket.TicketID,
		&ticket.EventID,
		&ticket.EventTitle,
		&ticket.EventPrice,
		&ticket.EventDate,
		&ticket.ImageUrl,
		&ticket.Location.City,
		&ticket.Location.Provice,
		&ticket.Location.Country,
		&ticket.Location.Venue,
		&ticket.CreatedAt,
	); err != nil {
		return nil, err
	}

	return ticket, nil
}

func (pg *PgStorage) GetTickets(ctx context.Context, uid string) ([]*types.GetTicket, error) {
	query := `SELECT
	Tickets.ticket_id, 
    Events.event_id, 
    Events.title, 
    Events.ticket_price, 
    Events.event_date, 
    Events.image_url, 
    Locations.city, 
    Locations.province, 
    Locations.country,
	Locations.venue,
	Tickets.created_at 
	FROM 
		Tickets
	INNER JOIN 
		Events 
	ON 
		Tickets.event_id = Events.event_id
	INNER JOIN 
		Locations 
	ON 
		Events.event_id = Locations.event_id
	WHERE 
		Tickets.uid = $1`

	result, err := pg.db.QueryContext(ctx, query, uid)
	if err != nil {
		return nil, err
	}

	defer result.Close()

	tickets := make([]*types.GetTicket, 0)

	for result.Next() {
		ticket := new(types.GetTicket)

		err = result.Scan(
			&ticket.TicketID,
			&ticket.EventID,
			&ticket.EventTitle,
			&ticket.EventPrice,
			&ticket.EventDate,
			&ticket.ImageUrl,
			&ticket.Location.City,
			&ticket.Location.Provice,
			&ticket.Location.Country,
			&ticket.Location.Venue,
			&ticket.CreatedAt,
		)

		if err != nil {
			return nil, err
		}

		tickets = append(tickets, ticket)

	}

	return tickets, nil
}
