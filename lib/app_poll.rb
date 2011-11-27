
class AppPoll
  POLL_SLEEP = 5

  def initialize(itunes_app_script)
    @ias = itunes_app_script
  end

  def start_poll
    puts "starting app polling thread"
    unless @poll_thread
      @poll_thread = Thread.start do
        start_loop 
      end
    end
    @poll_thread
  end

  def valid_queue?
    @ias.queue_exists? && !@ias.queue_empty? 
  end

  def process_queue
    index = @ias.queue_current_index
    if index > 0
      @ias.queue_remove_previous_tracks(index)
    end
  end

  def start_loop 
     i = 1
     while(true)
       puts "polling #{i+=1}"
       begin
         if valid_queue?
           process_queue
         end
       rescue
         puts $! 
       end
       sleep(POLL_SLEEP)
     end
  end

end


