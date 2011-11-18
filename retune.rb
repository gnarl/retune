require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'json'
require './lib/applay'

before do
  @iTunesAppScript = ItunesAppScript.new unless @ItunesAppScript 
end

get '/music/play' do
  @iTunesAppScript.play
end

get '/music/song/:song' do
  @iTunesAppScript.play_song(params[:song])
end

get '/music/artists' do
  content_type :json
  list = @iTunesAppScript.artists
  list.sort.to_json
end

get '/music/show/:artist' do
  list = @ItunesAppScript.songs_by_artist(params[:artist])
  content_type :json
  list.to_json
end

get '/music/stop' do
  @iTunesAppScript.stop
end


