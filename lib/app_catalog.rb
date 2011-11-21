
module AppCatalog
  
  def artists
    artists = @lib.tracks.artist.get
    artists.uniq
  end

  def songs_by_artist(name)
    @lib.tracks[@whose.artist.eq(name)].name.get
  end

  def catalog_track(song_name)
    @lib.tracks[song_name].get
  end

# Plays song by name from catalog
#  def play_song(song_name)
#    @itu.play(@lib.tracks[song_name])
#  end



###########################################
#TODO Move following to another class/module
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

 
  def player_state
    @itu.player_state.get.to_s
  end
  
  #TODO refactor polling
  #Add testing
  #management method
  def start_poll
    puts "starting polling thread"
    unless @poll_thread
      @poll_thread = Thread.start do
        while(true)
          begin
            remove_previous_tracks 
          rescue
            puts $! 
          end
          sleep(POLL_SLEEP)
        end
      end
    end
  end

  #management method
  def remove_previous_tracks
    if @queue.exists 
       puts "q: #{@queue.exists} : "
      unless queue_empty?
        trax = @queue.tracks.get
        index = trax.index(@itu.current_track.get)
        if index > 0
          (0..(index-1)).each do |i|
            puts "removed #{trax[i].name.get} from queue"
            q_remove(trax[i].name.get)
          end
        end
      end
    end
  end



  
end
