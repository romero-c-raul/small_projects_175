require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  #sorted = params['sorted']
  
  @files = Dir.glob("*").select { |e| File.file?(e) }
  
  if params['sorted'] == 'descending'
    @files = @files.sort { |a, b| b.downcase <=> a.downcase }
  else
    @files = @files.sort { |a, b| a.downcase <=> b.downcase }
  end
  

  erb :home
end

get "/:file_name" do
  @current_file = params['file_name']
  @contents = File.readlines("#{@current_file}")

  erb :file_contents
end
