require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'json'
require './lib/applay'

before do
  @iTunesAppScript = ItunesAppScript.new unless @ItunesAppScript 
end

#TODO figure out how to match routes to appScript method names

get '/music/artists' do
  content_type :json
  list = @iTunesAppScript.artists
  list.sort.to_json
end

get '/music/next' do
  @iTunesAppScript.next
end

get '/music/play' do
  @iTunesAppScript.play
end

get '/music/previous' do
  @iTunesAppScript.previous
end

get '/music/show/:artist' do
  content_type :json
  list = @iTunesAppScript.songs_by_artist(params[:artist])
  list.to_json
end

get '/music/song/:song' do
  @iTunesAppScript.play_song(params[:song])
end

get '/music/stop' do
  @iTunesAppScript.stop
end


