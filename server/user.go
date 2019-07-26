package server

import (
	"context"
	"errors"
	"net"
	"strconv"

	grpc_middleware "github.com/grpc-ecosystem/go-grpc-middleware"
	grpc_validator "github.com/grpc-ecosystem/go-grpc-middleware/validator"
	"github.com/pankona/grpc-validation-test/service"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

type UserService struct {
	Port int

	server *grpc.Server
}

// Run starts User service (as gRPC server)
func (u *UserService) Run() error {
	p := ":" + strconv.Itoa(u.Port)
	listen, err := net.Listen("tcp", p)
	if err != nil {
		return errors.New("gRPC server failed to listen [" + p + "]: " + err.Error())
	}
	s := grpc.NewServer(
		grpc.UnaryInterceptor(grpc_middleware.ChainUnaryServer(
			grpc_validator.UnaryServerInterceptor(),
		)),
	)
	reflection.Register(s)
	service.RegisterUserServer(s, u)

	u.server = s

	return u.server.Serve(listen)
}

// Stop stops User service
func (u *UserService) Stop() {
	u.server.Stop()
}

func (u *UserService) Create(context.Context, *service.UserCreateRequest) (*service.UserCreateResponse, error) {
	return &service.UserCreateResponse{Message: "success!"}, nil
}
