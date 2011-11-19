require "ap"
require "appscript"
include Appscript


class ItunesAppScript

  POLL_SLEEP = 5

  def initialize()
    @itu = app('iTunes')
    @whose = Appscript.its
    @lib = @itu.playlists["Library"]
    @queue = @itu.playlists["queue"]
    #TODO check that queue has tracks

    @itu.play(@queue.tracks[1])
    @known_current_track = @queue.tracks[1].get
    start_poll
  end
  
  def artists
    artists = @lib.tracks.artist.get
    artists.uniq
  end

  #TODO refactor polling
  #Add testing
  def start_poll
    puts "starting polling thread"
    unless @poll_thread
      @poll_thread = Thread.start do
        while(true)
          begin
            trax = @queue.tracks.get
            index = trax.index(@itu.current_track.get)
            if index > 0
              (0..(index-1)).each do |i|
                puts "current index: #{index}" 
                puts "removed #{trax[i].name.get} from queue"
                q_remove(trax[i].name.get)
              end
            end
          rescue
            puts $! 
          end
          sleep(POLL_SLEEP)
        end
      end
    end
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
  
  def skip
    self.next 
  end

  def q_show
    ret_q = []
    q_tracks = @queue.tracks.get
    q_tracks.each {|x| ret_q << "#{x.artist.get} - #{x.name.get}"}
    ret_q
  end

  def q_add(song_name)
    this_track = @lib.tracks[song_name].get
    ap this_track
    this_track.duplicate(:to => @queue)
  end

  def q_remove(song_name)
    this_track = @queue.tracks[song_name].delete
  end
  
  #songs = lib.tracks
  #song_names = songs.name.get.zip(songs.artist.get)
  #ap song_names
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


