require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'json'
require './lib/applay'
require './lib/app_poll'

set :itu_app_script, ItunesAppScript.new
app_poll = AppPoll.new(settings.itu_app_script)
set :itu_poll_thread, app_poll.start_poll

get '/catalog/artists' do
  content_type :json
  list = settings.itu_app_script.all_artists
  list.sort.to_json
end

get '/catalog/show/:artist' do
  content_type :json
  list = settings.itu_app_script.all_songs_by_artist(params[:artist])
  list.to_json
end

post '/queue/add' do
  settings.itu_app_script.q_add(params[:song]) 
end

get '/queue/play' do
  settings.itu_app_script.q_play
end

get '/queue/show' do
  content_type :json
  list = settings.itu_app_script.q_show
  list.to_json
end

get '/queue/skip' do
  settings.itu_app_script.skip
end

get '/queue/stop' do
  settings.itu_app_script.stop
end

