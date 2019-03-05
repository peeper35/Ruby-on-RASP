require 'sinatra/base'
require 'haml'
require './controller'
require './patch'

class PatchedApplication < Sinatra::Base
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
		ApplicationController.new.readfile(params[:file])
	end

	get '/server' do
		@server = "127.0.0.1"
		
		haml :server
	end

	post '/server' do
		@msg = Patch.new.patchrce(params[:server])
		@server = params[:server]
		
        if @msg == "ThisSpecifiedStringRCE"
            haml :rasp_cmdi
        else
		    haml :server
        end
	end

	get '/search' do
		@search_query = Patch.new.patchxss(params[:q])
		
		haml :search
	end

	get '/login' do
		haml :login
	end

	post '/login' do
		@app = Patch.new.patchsqli(params[:username], params[:password])
        
        if @app == "ThisSpecifiedStringSQLi"
            haml :rasp_sqli
        else
		    haml :login
        end
	end
end
