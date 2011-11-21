require 'test/unit'
require 'applay'

class ApplayTest < Test::Unit::TestCase

  TEST_QUEUE = 'test_queue'

  def setup
    @itu = ItunesAppScript.new(TEST_QUEUE)
  end

  def teardown
    @test_itu = app('iTunes')
    test_queue = @test_itu.playlists[TEST_QUEUE]
    test_queue.delete
  end

  def test_empty_queue
    assert @itu.queue_empty? 
    @itu.q_add('Goodbye Earl')
    assert !@itu.queue_empty? 
  end

  def test_player_state
    assert @itu.queue_empty?
    assert_equal('stopped', @itu.player_state)
  end

  def test_play_and_stop
    @itu.q_add('Goodbye Earl')
    assert_equal('stopped', @itu.player_state)
    @itu.play
    assert_equal('playing', @itu.player_state)
    @itu.stop
    assert_equal('stopped', @itu.player_state)
  end


end
