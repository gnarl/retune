require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'json'
require './lib/applay'

before do
  @ituAppScript = ItunesAppScript.new unless @ItunesAppScript 
end

#TODO figure out how to match routes to appScript method names

get '/music/artists' do
  content_type :json
  list = @ituAppScript.artists
  list.sort.to_json
end

get '/music/next' do
  @ituAppScript.next
end

get '/music/play' do
  @ituAppScript.play
end

get '/music/previous' do
  @ituAppScript.previous
end

get '/music/selection' do
  r = @ituAppScript.selection
end

get '/music/show/:artist' do
  content_type :json
  list = @ituAppScript.songs_by_artist(params[:artist])
  list.to_json
end

get '/music/song/:song' do
  @ituAppScript.play_song(params[:song])
end

get '/music/stop' do
  @ituAppScript.stop
end

get '/queue/show' do
  content_type :json
  list = @ituAppScript.q_show
  list.to_json
end

post '/queue' do
  @ituAppScript.q_add(params[:song]) 
end

delete '/queue/next' do
  @ituAppScript.skip
end
