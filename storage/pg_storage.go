package storage

import (
	"context"
	"database/sql"
	"fmt"

	_ "github.com/lib/pq"

	"github.com/luquxSentinel/ticketz/types"
)

const (
	host     = "localhost"
	port     = 5432
	user     = "luqus"
	password = ""
	dbname   = "ticketz"
)

type PgStorage struct {
	db *sql.DB
}

func NewPgStorage() (*PgStorage, error) {
	pgConfig := fmt.Sprintf("host=%s port=%d user=%s "+
		"password=%s dbname=%s sslmode=disable",
		host, port, user, password, dbname)

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
	INSERT INTO Event (event_id, title, description, ticket_price, event_date, end_time, image_url, created_at) 
	VALUES($1, $2, $3, $4, $5, $6, $7, $8)`

	result, err := tx.ExecContext(
		ctx,
		query,
		event.EventID,
		event.Title,
		event.Description,
		event.TicketPrice,
		event.EventDate,
		event.EndTime,
		event.ImageUrl,
		event.CreatedAt,
	)

	fmt.Println(result.LastInsertId())

	if err != nil {
		tx.Rollback()
		return err
	}

	query = `
	INSERT INTO Location (location_id, event_id, city, province, country) 
	VALUES($1, $2, $3, $4, $5)`

	_, err = tx.ExecContext(
		ctx,
		query,
		event.Location.LocationID,
		event.EventID,
		event.Location.City,
		event.Location.Provice,
		event.Location.Country,
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
	SELECT Event.event_id, Event.title, Event.description, Event.ticket_price, Event.event_date, Event.end_time, Event.image_url, Location.city, Location.province, Location.country 
	FROM Event INNER JOIN LOCATION ON Event.event_id=Location.event_id`

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
			&event.Title,
			&event.Description,
			&event.TicketPrice,
			&event.EventDate,
			&event.EndTime,
			&event.ImageUrl,
			&event.Location.City,
			&event.Location.Provice,
			&event.Location.Country,
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
	 SELECT Event.event_id, Event.title, Event.description, Event.ticket_price, Event.event_date, Event.end_time, Event.image_url, Location.city, Location.province, Location.country 
	FROM Event INNER JOIN LOCATION ON Event.event_id=Location.event_id
	WHERE EVENT.event_id=$1
	`

	row := pg.db.QueryRowContext(ctx, query, event_id)

	if row.Err() != nil {
		return nil, row.Err()
	}

	event := new(types.Event)

	if err := row.Scan(event); err != nil {
		return nil, err
	}

	return event, nil
}
