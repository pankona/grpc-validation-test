# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: user.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("user.proto", :syntax => :proto3) do
    add_message "service.UserCreateRequest" do
      optional :id, :string, 1
      optional :name, :string, 2
      optional :age, :int32, 3
    end
    add_message "service.UserCreateResponse" do
      optional :message, :string, 1
    end
  end
end

module Service
  UserCreateRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("service.UserCreateRequest").msgclass
  UserCreateResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("service.UserCreateResponse").msgclass
end
