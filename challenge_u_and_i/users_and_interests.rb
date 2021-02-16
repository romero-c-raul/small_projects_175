require "yaml"

require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

before do
  @users = YAML.load_file('users.yml')
end

get "/" do
  redirect "/users"
end

get "/users" do
  erb :home
end

get "/:user" do
  @user_data = select_user(params['user'])
  @email = @user_data.values[0][:email]
  @interests = @user_data.values[0][:interests].join(", ")

  erb :profile
end

helpers do
  def select_user(name)
    @users.select do |user, content|
      name == user.to_s
    end
  end

  def total_users
    @users.keys.size
  end

  def total_interests
    @users.values.map do |hash|
      hash[:interests]
    end.flatten.size
  end
end