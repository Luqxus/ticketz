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

type MockStorage struct{}

func NewMockStorage() (*MockStorage, error) {
	return &MockStorage{}, nil
}

func (mock *MockStorage) CreatEvent(ctx context.Context, event *types.Event) error {
	return nil
}
func (mock *MockStorage) GetEvents(ctx context.Context) ([]*types.Event, error) {
	return nil, nil
}
func (mock *MockStorage) GetEvent(ctx context.Context, id string) (*types.Event, error) {
	return nil, nil
}
