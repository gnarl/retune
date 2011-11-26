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
    assert_equal('stopped', @itu.player_state)
    @itu.q_add('Goodbye Earl')
    assert_equal('playing', @itu.player_state)
    @itu.stop
    assert_equal('stopped', @itu.player_state)
    @itu.q_play
    assert_equal('playing', @itu.player_state)
  end


  def test_show
    assert @itu.queue_empty? 
    @itu.q_add('Goodbye Earl')
    assert_equal("Me First and the Gimme Gimmes - Goodbye Earl", @itu.q_show[0])
    @itu.q_add("Lookin' for Love")
    assert_equal("Me First and the Gimme Gimmes - Lookin' for Love", @itu.q_show[1])
  end

  def test_remove
    assert @itu.queue_empty? 
    @itu.q_add('Goodbye Earl')
    @itu.q_add("Lookin' for Love")
    assert_equal(2, @itu.q_show.size)
    @itu.q_remove('Goodbye Earl')
    assert_equal("Me First and the Gimme Gimmes - Lookin' for Love", @itu.q_show[0])
    @itu.q_add('E-Pro')
    @itu.q_remove("Lookin' for Love")
    assert_equal(1, @itu.q_show.size)
    assert_equal("Beck - E-Pro", @itu.q_show[0])
  end

end
