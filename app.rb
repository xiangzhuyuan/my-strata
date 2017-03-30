require 'sinatra'
require "sinatra/reloader"
require 'yaml'
require 'rack-flash'
require 'json'
require 'strava/api/v3'
require 'polylines'

require 'uri'
require 'open-uri'

require 'tcxxxer'

use Rack::Flash

# configure sinatra
set :run, false
set :raise_errors, true

# setup logging to file
log = File.new("logs/app.log", "a+")
configure do
  # logging is enabled by default in classic style applications,
  # so `enable :logging` is not needed
  file = File.new("logs/app.log", 'a+')
  file.sync = true
  use Rack::CommonLogger, file
end
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
    @result          = session['current_user']

    # new client
    @client          = Strava::Api::V3::Client.new(:access_token => session['token'])
    @routes          = @client.list_athlete_routes[0...3]
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
        :name   => route['name'],
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


get '/tcx' do
  logger.info 'get tcx'
  erb :tcx, :layout => :tcx_layout
end

get '/list' do
  prefix = "https://strava.xiangzhuyuan.com/tcx_result/"
  @f_lst = [] 
  _lst = Dir["/var/www/strava.xiangzhuyuan.com/my-strata/public/tcx_result/**/*.html"]
           .sort_by{ |f| File.mtime(f) }
           .reverse!
           .first(20)
  _lst.each do |f|
    # get title in html file
    require 'nokogiri'
    doc   = Nokogiri::HTML(File.open(f))
    title = doc.css("h1").text
    @f_lst <<{ path: prefix + File.basename(f), title: title }
    #@f_lst << prefix + File.basename(f) 
  end
  erb :lists, :layout => :tcx_layout
end


get '/about' do 

 erb :about, :layout => :tcx_layout
end



post '/tcx' do
  @route_url       = params['latlonglab_url']
  @range          = params['distance_range']
  logger.error @route_url
  logger.error @range
  unless  @range.numeric? && @route_url =~ /http:\/\/latlonglab.yahoo.co.jp\/route\/watch\?id=[a-zA-Z\d]+$/
    flash[:notice] = "Caution!@ looks like you give us some invalid parameter~ try again!"
    redirect 'tcx'
  end
  @route_id       = CGI.parse(URI.parse(params['latlonglab_url']).query)['id'].first

  @html_file_list = []
  @course_name = ''
  # input parameter
  tcx_url         = "http://latlonglab.yahoo.co.jp/route/get?id=#{@route_id}&format=tcx"
  tcx_file        = "./public/tcx/#{@route_id}.tcx"


  open(tcx_file, 'wb') do |file|
    file << open(tcx_url).read
  end

  # if ルートが空です。
  if IO.read(tcx_file).include? "ルートが空です"
    flash[:notice] = "Caution!@ looks like you give us an invalid route ID ~ try again!"
    redirect 'tcx'
  end

  begin
    db           = Tcxxxer::DB.open(tcx_file)
    @points_list = []
    db.courses.each do |course|
      @course_name = course.name
      @part = 0
      max_distance = (course.track.last.distance/1000).round(2).to_s + "km"
      slice_ = course.track.length.to_f/((course.track.last.distance/1000).round(2)/@range.to_f)


      logger.info  max_distance
      logger.info  course.track.length.to_f
      logger.info  (course.track.last.distance/1000).round(2)
      logger.info  @range
      logger.info  slice_
      logger.info  slice_.ceil

      course_range = course.track.each_slice(slice_).to_a

      course_range.each_with_index do |range, _i|
        @part = _i
        @points    = []
        @altitudes = []
        range.each do |point|
          @points << (point.distance/1000).round(2).to_s + "km"
          @altitudes << point.altitude.round(2)
          # @points_list << {:points => @points, :altitudes => @altitudes}
        end

        begin
          # read all, get each id
          file_locate = "/tcx_result/#{@route_id}_#{_i}.html"
          html_file   = "./public/#{file_locate}"
          @html_file_list << file_locate
          puts "start read erb, and create html file ...."
          renderer = ERB.new(File.read("./views/template.erb"))
          result   = renderer.result(binding)

          File.open(html_file, 'w') do |f|
            puts "write #{html_file} start"
            f.write(result)
          end

        rescue => e
          flash[:notice] = e.message
        end
      end
    end
  rescue => e
    flash[:notice] = e.message

  end
  erb :tcx_result, :layout => :tcx_layout
end
