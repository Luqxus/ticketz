package storage

import (
	"context"

	"github.com/luquxSentinel/ticketz/types"
)

type PgStorage struct {
}

func (pg *PgStorage) CreatEvent(ctx context.Context, event types.Event) error {
	return nil
}

func (pg *PgStorage) GetEvents(ctx context.Context) ([]*types.Event, error) {
	return nil, nil
}

func (pg *PgStorage) GetEvent(ctx context.Context, id string) (*types.Event, error) {
	return nil, nil
}
