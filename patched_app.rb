require './controller'
require 'haml'
require './patch'

class PatchedApplication < ApplicationController

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
		readfile(params[:file])
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
		@search_query = Patch.new.patchxss(params[:q])
		
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
