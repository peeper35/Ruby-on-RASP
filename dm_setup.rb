require 'dm-core'
require 'dm-migrations'
require 'dm-sqlite-adapter'


DataMapper.setup :default, "sqlite://#{Dir.pwd}/logindata.db"

class Logins
	include DataMapper::Resource

	property :id, 		 Serial
	property :username,  String
	property :password,  String
end


DataMapper.auto_upgrade!
DataMapper.auto_migrate!

#use these usernames and passwords at /login.

Logins.create username: "Sahil", password: "Sahil"
Logins.create username: "admin", password: "admin"
Logins.create username: "elliot", password: "qwerty"
Logins.create username: "user1", password: "ih8uall"
Logins.create username: "dinesh", password: "iamnotindian"
Logins.create username: "rick", password: "dubdub"

