require "ap"
require "appscript"
include Appscript


class ItunesAppScript

  POLL_SLEEP = 5

  def initialize(queue_name='queue')
    @itu = app('iTunes')
    @whose = Appscript.its
    @lib = setup_playlist("Library")
    @queue = setup_playlist(queue_name)

    start_poll
  end
  
  #playlist method
  def setup_playlist(name)
    pl = @itu.playlists[name]
    unless pl.exists
      @itu.make(:new => :user_playlist, :with_properties => {:name => name})
    end
    pl
  end

  #playlist method
  def queue_empty?
    @queue.tracks.get.size == 0
  end

  #service method
  def artists
    artists = @lib.tracks.artist.get
    artists.uniq
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
    unless queue_empty?
      trax = @queue.tracks.get
      index = trax.index(@itu.current_track.get)
      if index > 0
        (0..(index-1)).each do |i|
          puts "current index: #{index}" 
          puts "removed #{trax[i].name.get} from queue"
          q_remove(trax[i].name.get)
        end
      end
    end
  end

  #service method
  def next 
    @itu.next_track
  end

  #service method
  def play 
    @itu.play(@queue.tracks[1]) unless queue_empty?
  end

  #service method
  def play_song(song_name)
    @itu.play(@lib.tracks[song_name])
  end

  #service method
  def previous 
    @itu.previous_track
  end


  #service method
  def songs_by_artist(name)
    @lib.tracks[@whose.artist.eq(name)].name.get
  end

  #service method
  def stop
    @itu.stop
  end
  
  #service method
  def skip
    self.next 
  end

  #service method
  def q_show
    ret_q = []
    q_tracks = @queue.tracks.get
    q_tracks.each {|x| ret_q << "#{x.artist.get} - #{x.name.get}"}
    ret_q
  end

  #service method
  def q_add(song_name)
    this_track = @lib.tracks[song_name].get
    ap this_track
    this_track.duplicate(:to => @queue)
  end

  #service method
  def q_remove(song_name)
    this_track = @queue.tracks[song_name].delete
  end
  
end

#ert = ItunesAppScript.new
##ap ert.q_add("Goodbye Earl")
#ap ert.q_show
#sleep(7)
#
#ert.skip
#ert.skip
#
#sleep(15)


