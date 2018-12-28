require 'bundler/setup'
require 'omniauth-strava'
require './app.rb'

use Rack::Session::Cookie, :secret => 'abc123'




ENV['APP_ID']     = '12159'
ENV['APP_SECRET'] = 'b48b5dbd9351f67b063708fe24989f0032cbc453'
ENV['APP_TOKEN']  = ''

use OmniAuth::Builder do
  provider :strava, ENV['APP_ID'], ENV['APP_SECRET'], :scope => 'public'
end


class String
  def numeric?
    Float(self) != nil rescue false
  end
end

run Sinatra::Application
