# client.rb
$LOAD_PATH << File.expand_path("../../service")

require 'user_services_pb'

client = Service::User::Stub.new('localhost:50051', :this_channel_is_insecure)
resp = client.create(Service::UserCreateRequest.new(id: "1", name: "aaa", age: -10))

pp resp
