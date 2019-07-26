package main

import (
	"log"

	"github.com/pankona/grpc-validation-test/server"
)

func main() {
	u := server.UserService{
		Port: 50051,
	}

	err := u.Run()
	if err != nil {
		log.Fatal(err)
	}
}
