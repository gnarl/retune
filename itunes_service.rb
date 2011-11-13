# itunes_service.rb
require 'sinatra'
require 'json'
require './applay'


get '/music/play' do
  ItunesAppScript.new.play
end

get '/music/song/:song' do
  ItunesAppScript.new.play_song(params[:song])
end

get '/music/artists' do
  content_type :json
  list = ItunesAppScript.new.artists
  list.sort.to_json
end

get '/music/show/:artist' do
  list = ItunesAppScript.new.songs_by_artist(params[:artist])
  content_type :json
  list.to_json
end

get '/music/stop' do
  ItunesAppScript.new.stop
end


