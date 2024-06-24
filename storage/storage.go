package storage

import (
	"context"
	"time"

	"github.com/luquxSentinel/ticketz/types"
)

type Storage interface {
	CreateUser(ctx context.Context, uid string, email string, username string, password string, createdAt time.Time) error
	GetUser(ctx context.Context, email string) (*types.User, error)
	CountEmail(ctx context.Context, email string) (int64, error)
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
