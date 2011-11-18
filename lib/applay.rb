require "ap"
require "appscript"
include Appscript


class ItunesAppScript

  def initialize()
    @itu = app('iTunes')
    @whose = Appscript.its
    @lib = @itu.playlists["Library"]
  end
  
  def artists
    artists = @lib.tracks.artist.get
    artists.uniq
  end

  def next 
    @itu.next_track
  end

  def play 
    @itu.play
  end

  def play_song(song_name)
    @itu.play(@lib.tracks[song_name])
  end

  def previous 
    @itu.previous_track
  end

  def songs_by_artist(name)
    @lib.tracks[@whose.artist.eq(name)].name.get
  end

  def stop
    @itu.stop
  end
  
  
  #songs = lib.tracks
  #song_names = songs.name.get.zip(songs.artist.get)
  #ap song_names
end


