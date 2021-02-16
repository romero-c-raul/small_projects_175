# list.rb
require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @files = Dir.glob("*").map {|file| File.basename(file) }.sort
  @files.reverse! if params[:sort] == "desc"
  erb :list
end