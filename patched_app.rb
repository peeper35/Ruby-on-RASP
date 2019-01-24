require './controller'
require 'haml'

class PatchedApplication < ApplicationController

  	['/', '/index'].each do |path|
		get path  do 
			haml :index
 		end
 	end

	post '/upload' do
		@filename = params[:file][:filename]
		file = params[:file][:tempfile]

		File.open("./public/uploads/#{@filename}", 'wb') do |f|
			f.write(file.read)
		end

		haml :upload_successful
	end	

	get '/read' do 
		self.readfile(params[:file])
	end

	get '/server' do
		@server = "127.0.0.1"
		
		haml :server
	end

	post '/server' do
		@msg = doping(params[:server])
		@server = params[:server]
		
		haml :server
	end

	get '/search' do
		@escapedsearchquery = params[:q]
		
		haml :search
	end

	get '/login' do
		haml :login
	end

	post '/login' do
		@app = self.checklogin("#{params[:username]}", "#{params[:password]}")

		haml :login
	end
end
