package tokens

import (
	"errors"
	"os"
	"time"

	"github.com/golang-jwt/jwt/v5"
)

type Claims struct {
	UID   string
	Email string
	jwt.RegisteredClaims
}

func GenerateJWT(uid, email string) (string, error) {

	key := os.Getenv("SECRET_KEY")
	if key == "" {
		panic(errors.New("SECRET_KEY NOT FOUND"))
	}

	claims := &Claims{
		UID:   uid,
		Email: email,
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(time.Now().Local().UTC()),
		},
	}

	token, err := jwt.NewWithClaims(jwt.SigningMethodHS256, claims).SignedString([]byte(key))
	if err != nil {
		return "", err
	}

	return token, nil
}

func VerifyJWT(signedJWT string) (string, error) {

	claims := new(Claims)

	token, err := jwt.ParseWithClaims(signedJWT, claims, func(t *jwt.Token) (interface{}, error) {

		key := os.Getenv("SECRET_KEY")
		if key == "" {
			panic(errors.New("SECRET_KEY NOT FOUND"))
		}

		return []byte(key), nil
	})

	if err != nil {
		return "", errors.Join(errors.New("invalid authorization header"), err)
	}

	if !token.Valid {
		return "", errors.New("invalid authorization header")
	}

	return claims.UID, nil
}
