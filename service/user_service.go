package service

import (
	"context"
	"errors"
	"time"

	"github.com/google/uuid"
	"github.com/luquxSentinel/ticketz/storage"
	"github.com/luquxSentinel/ticketz/tokens"
	"github.com/luquxSentinel/ticketz/types"
	"golang.org/x/crypto/bcrypt"
)

type UserService struct {
	storage storage.Storage
}

func NewUserService(storage storage.Storage) *UserService {
	return &UserService{
		storage: storage,
	}
}

func (s *UserService) SignUp(ctx context.Context, reqData *types.CreateUser) (*types.ResponseUser, string, error) {

	count, err := s.storage.CountEmail(ctx, reqData.Email)
	if err != nil {
		return nil, "", err
	}

	if count > 0 {
		return nil, "", errors.New("email already in use")
	}

	password, err := hash(reqData.Password)
	if err != nil {
		return nil, "", err
	}

	user, err := s.storage.CreateUser(
		ctx,
		uuid.NewString(),
		reqData.Email,
		reqData.Username,
		password,
		time.Now().Local().UTC(),
	)

	if err != nil {
		return nil, "", err
	}

	// TODO: generate jwt token
	token, err := tokens.GenerateJWT(user.UID, user.Email)
	if err != nil {
		return nil, "", err
	}

	return user.ResponseUser(), token, nil
}

func (s *UserService) SignIn(ctx context.Context, reqData *types.LoginData) (*types.ResponseUser, string, error) {
	user, err := s.storage.GetUser(ctx, reqData.Email)

	if err != nil {
		return nil, "", err
	}

	if verify(user.Password, reqData.Password) != nil {
		return nil, "", errors.New("wrong email or password")
	}

	// TODO: generate jwt token
	token, err := tokens.GenerateJWT(user.UID, user.Email)
	if err != nil {
		return nil, "", err
	}

	return user.ResponseUser(), token, nil
}

func hash(pwd string) (string, error) {
	b, err := bcrypt.GenerateFromPassword([]byte(pwd), 14)
	return string(b), err
}

func verify(foundPwd, pwd string) error {
	return bcrypt.CompareHashAndPassword([]byte(foundPwd), []byte(pwd))
}
