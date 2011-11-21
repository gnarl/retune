require 'ap'
require 'appscript'
require './lib/app_catalog' 

include Appscript
include AppCatalog

class ItunesAppScript

  POLL_SLEEP = 5

  def initialize(queue_name='queue')
    @itu = app('iTunes')
    @whose = Appscript.its

    @lib = setup_playlist("Library")
    @queue = setup_playlist(queue_name)

    start_poll
  end
  
  def q_play 
    @itu.play(@queue.tracks[1]) unless queue_empty?
  end

  def stop
    @itu.stop
  end
  
  def skip
    @itu.next 
  end

  def q_show
    ret_q = []
    q_tracks = @queue.tracks.get
    q_tracks.each {|x| ret_q << "#{x.artist.get} - #{x.name.get}"}
    ret_q
  end

  def q_add(song_name)
    this_track = catalog_track(song_name)
    ap this_track
    this_track.duplicate(:to => @queue)
  end

  def q_remove(song_name)
    this_track = @queue.tracks[song_name].delete
  end
  
end


