require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

require_relative 'recipe'
require_relative 'cookbook'
csv_file   = File.join(__dir__, 'recipes.csv')
@@cookbook = Cookbook.new(csv_file)

get '/' do
  # 'Hello worlds!'
  # "<h1>Hello <em>world</em>!</h1>"
  erb :about
end

get '/about' do
  erb :about
end

get '/index' do
  @recipes = @@cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/recipe' do
  # erb :index
  # raise
  name = params["recipe_name"]
  description = params["recipe_description"]
  time = params["recipe_time"]
  skill = params["recipe_skill"]
  new_recipe = Recipe.new(name, description, time, skill)
  @@cookbook.add_recipe(new_recipe)
  redirect to('/index')
end

delete '/delete/:id' do
  # binding.pry
  index = params[:id].to_i
  @@cookbook.remove_recipe(index)
  redirect to('/index')
end
