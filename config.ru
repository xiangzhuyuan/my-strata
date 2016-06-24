require 'bundler/setup'
require 'omniauth-strava'
require './app.rb'

use Rack::Session::Cookie, :secret => 'abc123'

use OmniAuth::Builder do
  provider :strava, ENV['APP_ID'], ENV['APP_SECRET'], :scope => 'public'
end

run Sinatra::Application
