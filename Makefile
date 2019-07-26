
MAKEFLAGS += --no-builtin-rules

PROTO_DIR = proto
PB_GO_DIR = service

GOPATH = $(shell go env GOPATH)
PROTOS = $(shell find $(PROTO_DIR) | grep proto$$)
PB_GOS = $(PROTOS:%.proto=$(PB_GO_DIR)/%.pb.go)

BUILD_CMD ?= go build

all: genproto
	cd $(CURDIR)/cmd/server/ && go build

genproto: service/user.pb.go

service/user.pb.go: proto/user.proto
	mkdir -p $(dir $@)
	protoc \
		-I proto \
		-I $(GOPATH)/src \
		--go_out=plugins=grpc:$(dir $@) \
		--govalidators_out=$(dir $@) \
		./$<
	grpc_tools_ruby_protoc \
		-I proto \
		-I $(GOPATH)/src \
		--ruby_out=$(dir $@) \
		--grpc_out=$(dir $@) \
		./$<

clean:
	rm -rf service
