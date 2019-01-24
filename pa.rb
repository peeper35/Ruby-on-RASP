Dir.glob('./*rb').each {|file| require file}
require 'sinatra/base'

run PachedApplication
