package storage

import (
	"context"

	"github.com/luquxSentinel/ticketz/types"
)

type Storage interface {
	CreatEvent(ctx context.Context, event *types.Event) error
	GetEvents(ctx context.Context) ([]*types.Event, error)
	GetEvent(ctx context.Context, id string) (*types.Event, error)
}
