require 'sinatra/base'
require './controller'
require 'haml'

class Application < Sinatra::Base

  	['/', '/index'].each do |path|
		get path  do 
			haml :index
 		end
 	end

    not_found do
     status 404
     haml :notfound
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
		ApplicationController.new.readfile(params[:file])
	end

	get '/server' do
		@server = "127.0.0.1"
		
		haml :server
	end

	post '/server' do
		@msg = ApplicationController.new.doping(params[:server])
		@server = params[:server]
		
		haml :server
	end

	get '/search' do
		@search_query = params[:q]
		
		haml :search
	end

	get '/login' do
		haml :login
	end

	post '/login' do
		@app = ApplicationController.new.checklogin("#{params[:username]}", "#{params[:password]}")

		haml :login
	end
end
