
module AppCatalog
  
  def all_artists
    artists = @lib.tracks.artist.get
    artists.uniq
  end

  def all_songs_by_artist(name)
    @lib.tracks[@whose.artist.eq(name)].name.get
  end

  def library_track(song_name)
    @lib.tracks[song_name].get
  end

# Plays song by name from catalog
#  def play_song(song_name)
#    @itu.play(@lib.tracks[song_name])
#  end


  def setup_playlist(name)
    pl = @itu.playlists[name]
    unless pl.exists
      @itu.make(:new => :user_playlist, :with_properties => {:name => name})
    end
    pl
  end

  def queue_empty?
    @queue.tracks.get.size == 0
  end

  def queue_exists?
    @queue.exists
  end

  def queue_remove_previous_tracks(index)
    (0..(index-1)).each do |i|
      trax = @queue.tracks.get
      puts "removed #{trax[i].name.get} from queue"
      @queue.tracks[trax[i].name.get].delete
    end
  end


  def queue_current_index
    trax = @queue.tracks.get
    trax.index(@itu.current_track.get)
  end

  def player_state
    @itu.player_state.get.to_s
  end
  
end
