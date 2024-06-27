build:
	@go build -o ./bin/ticketz

run: build
	./bin/ticketz

test:
	@go test ./...

