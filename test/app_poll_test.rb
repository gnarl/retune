require 'test/unit'
require 'app_poll'

class AppPollTest < Test::Unit::TestCase

  TEST_QUEUE = 'test_queue'

#Add Testing
  # mock out applay

  def setup
    @itu = AppscriptStub.new
    @app_poll = AppPoll(@itu)
  end


   def test_skip_and_auto_remove
    @itu.q_add('Goodbye Earl')
    @itu.start_poll
    @itu.q_add("Lookin' for Love")
    @itu.q_add('E-Pro')
    assert_equal('playing', @itu.player_state)
    @itu.skip
    @itu.skip
    sleep(8)
    assert_equal("Beck - E-Pro", @itu.q_show[0])
  end

 

end

class ItunesAppscriptStub

  def playlists(ary)
    @queue = QueueStub.new(ary[0])
  end

  def current_track.get
    @queue.current
  end
end

class QueueStub
  def initialize(name)
   @name = name 
  end

  def exists?
    ret = true
    ret = false if name.eql?("no_queue")
    ret 
  end

  def empty?
    ret = false 
    ret = true if name.eql?("empty_queue")
    ret 
  end

  def tracks.get

  end

  def tracks[trax[i].name.get].delete
  end

end

class TrackStub
    def delete
      
    end

    def get

    end
end
