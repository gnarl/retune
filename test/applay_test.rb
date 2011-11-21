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
    sleep(2)
    assert @itu.queue_empty? 
    @itu.q_add('Goodbye Earl')
    assert !@itu.queue_empty? 
  end


end
