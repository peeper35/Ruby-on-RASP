require 'sinatra/base'
require 'haml'
require './patch'

class PatchedApplication < Sinatra::Base
    patch = Patch.new

  	['/', '/index'].each do |path|
		get path  do 
			haml :index
 		end
 	end

	post '/upload' do
		filename = params[:file][:filename]
		file = params[:file][:tempfile]


		@getback = patch.patchupload(filename, file)


		if @getback == "SuchExtensionCanHurtMe"
			haml :canhurt
		else
			haml :upload_successful
		end
	end	

	get '/read' do 
		@read = patch.patchlfi(params[:file])

		if @read == "FLIIIIII!!!"
			haml :cantread
		else
			return @read
		end
	end

	get '/server' do
		@server = "127.0.0.1"
		
		haml :server
	end

	post '/server' do
		@msg = patch.patchrce(params[:server])
		@server = params[:server]
		
        if @msg == "ThisSpecifiedStringRCE"
            haml :rasp_cmdi
        else
		    haml :server
        end
	end

	get '/search' do
		@search_query = patch.patchxss(params[:q])
		
		haml :search
	end

	get '/login' do
		haml :login
	end

	post '/login' do
		@app = patch.patchsqli(params[:username], params[:password])
        
        if @app == "ThisSpecifiedStringSQLi"
            haml :rasp_sqli
        else
		    haml :login
        end
	end
end

