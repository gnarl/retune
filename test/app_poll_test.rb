require 'test/unit'
require 'app_poll'

class AppPollTest < Test::Unit::TestCase

  TEST_QUEUE = 'test_queue'

  def test_invalid_queue
    @ias = AppScriptAdapterStub.new({:exists => false, :empty => false, :current_index => 0})
    @app_poll = AppPoll.new(@ias)
    assert(!@app_poll.valid_queue?, "#{@app_poll.valid_queue?} but should be false") 
  end

  def test_empty_queue
    @ias = AppScriptAdapterStub.new({:exists => true, :empty => true})
    @app_poll = AppPoll.new(@ias)
    assert(!@app_poll.valid_queue?) 
  end

  def test_valid_queue
    @ias = AppScriptAdapterStub.new({:exists => true, :empty => false, :current_index => 0})
    @app_poll = AppPoll.new(@ias)
    assert(@app_poll.valid_queue?)
  end

  def test_process_queue
    @ias = AppScriptAdapterStub.new({:exists => true, :empty => false, :current_index => 3})
    assert(@ias.current_index == 3)
    @app_poll = AppPoll.new(@ias)
    @app_poll.process_queue
    assert(@ias.current_index == 0)
  end



end

class AppScriptAdapterStub
  attr_accessor :current_index

  def initialize(params)
    @exists = params[:exists] 
    @empty = params[:empty] 
    @current_index = params[:current_index] 
  end

  def queue_exists? 
    @exists
  end

  def queue_empty?
    @empty
  end

  def queue_current_index
    @current_index
  end

  def queue_remove_previous_tracks(index)
    @current_index = 0
  end

end


