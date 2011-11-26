
class AppPoll
  POLL_SLEEP = 5

  def initialize(itunes_app, queue_name='queue')
    @itu = itunes_app 
    @queue = @itu.playlists[queue_name]
  end

  def start_poll
    puts "starting app polling thread"
    unless @poll_thread
      @poll_thread = Thread.start do
      i = 1
        while(true)
          puts "polling #{i+=1}"
          begin
            remove_previous_tracks 
          rescue
            puts $! 
          end
          sleep(POLL_SLEEP)
        end
      end
    end
    @poll_thread
  end

  def remove_previous_tracks
    if @queue.exists && !queue_empty? 
        #puts  @itu.current_track.exists
        trax = @queue.tracks.get
        index = trax.index(@itu.current_track.get)
        if index > 0
          (0..(index-1)).each do |i|
            puts "removed #{trax[i].name.get} from queue"
            @queue.tracks[trax[i].name.get].delete
          end
        end
      end
  end
end

