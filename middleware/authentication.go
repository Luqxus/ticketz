package middleware

import (
	"context"
	"log"
	"net/http"

	"github.com/luquxSentinel/ticketz/tokens"
)

func Authentication(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		token := r.Header.Get("authorization")
		if token == "" {
			http.Error(w, "no authorization header provided", http.StatusUnauthorized)
			return
		}

		uid, err := tokens.VerifyJWT(token)
		if err != nil {
			log.Println(err.Error())
			http.Error(w, err.Error(), http.StatusUnauthorized)
			return
		}

		log.Println(uid)

		ctx := context.WithValue(r.Context(), "uid", uid)

		next.ServeHTTP(w, r.WithContext(ctx))
	})
}
