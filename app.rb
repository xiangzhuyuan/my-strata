require 'sinatra'
require "sinatra/reloader"
require 'yaml'
require 'rack-flash'

use Rack::Flash

# configure sinatra
set :run, false
set :raise_errors, true

# setup logging to file
log = File.new("app.log", "a+")
$stdout.reopen(log)
$stderr.reopen(log)
$stderr.sync = true
$stdout.sync = true

# server-side flow
get '/' do
  #redirect '/auth/strava'
  erb :index
end
get '/index' do
  #redirect '/auth/strava'
  redirect '/'
end

get '/auth/:provider/callback' do
  content_type 'text/html'
  @result                 = JSON.parse(MultiJson.encode(request.env['omniauth.auth']))
  session['current_user'] = @result['info']
  flash[:notice]          = "Welcome back #{@result['info']['nickname']}"
  redirect '/home'
end

get '/home' do
  if session['current_user']
    @result = session['current_user']
    puts @result

    erb :home
  else
    redirect '/'
  end

end

get '/auth/failure' do
  content_type 'application/json'
  MultiJson.encode(request.env)
end

get '/logout' do
  session.clear
  flash[:notice] = "You have logouted"
  redirect 'index'
end