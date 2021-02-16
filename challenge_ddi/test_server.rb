require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  "This is the main page"
  location = "/new"
end

get "/new" do
  "This is another page!"
end