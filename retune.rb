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

get '/queue/play' do
  @ituAppScript.play
end

get '/catalog/show/:artist' do
  content_type :json
  list = @ituAppScript.songs_by_artist(params[:artist])
  list.to_json
end

get '/queue/stop' do
  @ituAppScript.stop
end

get '/queue/show' do
  content_type :json
  list = @ituAppScript.q_show
  list.to_json
end

get '/queue/add/:song' do
  @ituAppScript.q_add(params[:song]) 
end

get '/queue/skip' do
  @ituAppScript.skip
end
