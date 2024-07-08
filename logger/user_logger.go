package logger

import (
	"context"

	"github.com/luquxSentinel/ticketz/service"
	"github.com/luquxSentinel/ticketz/types"
	"github.com/sirupsen/logrus"
)

type UserLogger struct {
	userService *service.UserService
	logger      *logrus.Logger
}

func NewUserLogger(userService *service.UserService) *UserLogger {
	return &UserLogger{
		userService: userService,
		logger:      logrus.New(),
	}
}

func (s *UserLogger) SignUp(ctx context.Context, reqData *types.CreateUser) (*types.ResponseUser, string, error) {

	user, token, err := s.userService.SignUp(ctx, reqData)

	s.logger.WithFields(logrus.Fields{
		"error": err,
	}).Info("sign up user")

	return user, token, err
}

func (s *UserLogger) SignIn(ctx context.Context, reqData *types.LoginData) (*types.ResponseUser, string, error) {
	user, token, err := s.userService.SignIn(ctx, reqData)

	s.logger.WithFields(logrus.Fields{
		"error": err,
	}).Info("sign in user")

	return user, token, err
}
