require 'sinatra'
require "sinatra/reloader"
require 'yaml'
require 'rack-flash'
require 'json'
require 'strava/api/v3'
require 'polylines'

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
  session['token']        = @result['credentials']['token']
  flash[:notice]          = "Welcome back #{@result['info']['nickname']}"
  redirect '/home'
end

get '/home' do
  if session['current_user']
    @result = session['current_user']

    # new client
    @client = Strava::Api::V3::Client.new(:access_token => session['token'])
    @routes = @client.list_athlete_routes[0...3]
    # get only latest 3 routes
    @route_point_arr = []
    @routes.each do |route|
      point_arr = Polylines::Decoder.decode_polyline(route['map']['summary_polyline'])
      route_str = ''
      route_str += "["
      point_arr.each_with_index do |latlng, index|
        route_str += "{lat:#{latlng[0]}, lng: #{latlng[1]}}"
        if index < point_arr.length-1
          route_str += ","
        end
      end
      route_str += "]"

      _center = "{lat:#{ point_arr[point_arr.length-1][0]}, lng: #{point_arr[point_arr.length-1][1]}}"

      @route_point_arr << {
        :name => route['name'],
        :center => _center,
        :route  => route_str
      }
    end
    puts @route_point_arr[0]
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