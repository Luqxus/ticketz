package storage

import (
	"context"
	"database/sql"
	"fmt"

	_ "github.com/mattn/go-sqlite3"

	"github.com/luquxSentinel/ticketz/types"
)

type SqliteStorage struct {
	db *sql.DB
}

func NewSqliteStorage() (*SqliteStorage, error) {

	db, err := sql.Open("sqlite3", "ticketz.db")
	if err != nil {
		return nil, err
	}

	if err := db.Ping(); err != nil {
		return nil, err
	}

	return &SqliteStorage{
		db: db,
	}, nil

}

func (pg *SqliteStorage) CreatEvent(ctx context.Context, event *types.Event) error {
	tx, err := pg.db.Begin()
	if err != nil {
		return err
	}

	query := `
	INSERT INTO Event (event_id, title, description, ticket_price, event_date, image_url, created_at) 
	VALUES($1, $2, $3, $4, $5, $6, $7)`

	result, err := tx.ExecContext(
		ctx,
		query,
		event.EventID,
		event.Title,
		event.Description,
		event.TicketPrice,
		event.EventDate,
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

	return nil
}

func (pg *SqliteStorage) GetEvents(ctx context.Context) ([]*types.Event, error) {
	query := `
	SELECT Event.event_id, Event.title, Event.description, Event.ticket_price, Event.event_date, Event.image_url, Location.city, Location.province, Location.country 
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
			event.EventDate,
			event.ImageUrl,
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

func (pg *SqliteStorage) GetEvent(ctx context.Context, id string) (*types.Event, error) {

	return nil, nil
}
