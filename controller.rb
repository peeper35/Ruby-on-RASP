require 'sinatra/base'
require 'sinatra/reloader'
require './dm_setup'
require 'sqlite3'

class ApplicationController < Sinatra::Base
	register Sinatra::Reloader

	def readfile(fileloc)
		fileopen = File.open("./read/#{fileloc}", 'r')
		return fileopen
	end

	def doping(ip)
		return `ping -c 4 #{ip}`
	end

	def checklogin(uname, pwd)
		db = SQLite3::Database.open("./logindata.db")
		data = db.execute("SELECT * FROM Logins WHERE username ='" + uname + "' AND password ='" + pwd + "'")

		return "Login Succesful, Hello #{uname.capitalize}!" if !data.empty?
		return "Bad Username & Password" if data.empty?
	end
end