require 'htmlentities'
require 'sqlite3'
require 'colorize'
require './lexer'
require './controller'



class Patch < ApplicationController
	def patchxss(sq)
		encoder = HTMLEntities.new
		encoder.encode(sq)	
	end

	def patchsqli(uname, pwd)
        @un = uname
        @pw = pwd
		lex = takein("SELECT * FROM logins WHERE username ='" + @un + "' AND password ='" + @pw + "'")
			def check(lex, uname=@un, pwd=@pw)
				db = SQLite3::Database.open("./logindata.db")
				data = db.execute("SELECT * FROM sqli_rules WHERE sqlirule ='" + lex + "'")

                if !data.empty?
                    puts "#{lex.colorize(:green)}\n"
                    return checklogin(uname, pwd)
                else
                    puts "#{lex.colorize(:red)}\n"
		    	    return "ThisSpecifiedStringSQLi"
                end
			end

		check(lex)
	end

    def patchrce(ip)
        @ipp = ip
        lex = takein(@ipp)
            def check(lex, ip=@ipp)
                puts lex
                db = SQLite3::Database.open("./logindata.db")
                data = db.execute("SELECT * FROM rce_rules WHERE rcerules ='" + lex + "'")
            
                if !data.empty?
                    puts "#{lex.colorize(:green)}\n"
                    return doping(ip)
                else
                    puts "#{lex.colorize(:red)}\n"
		    	    return "ThisSpecifiedStringRCE"
                end     
            end
        check(lex)
    end
end


