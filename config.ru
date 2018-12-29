require 'bundler/setup'
require 'omniauth-strava'
require './app.rb'

use Rack::Session::Cookie, :secret => ENV['COOKIE_SECRET']
use OmniAuth::Builder do
  provider :strava, ENV['APP_ID'], ENV['APP_SECRET'], :scope => 'read,read_all,profile:read_all,profile:write,activity:read,activity:read_all,activity:write'
end
class String
  def numeric?
    Float(self) != nil rescue false
  end
end

run Sinatra::Application
