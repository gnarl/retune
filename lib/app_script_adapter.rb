require 'ap'
require 'appscript'
require './lib/app_catalog' 

include Appscript
include AppCatalog

class AppScriptAdapter

  def initialize(queue_name='queue')
    @itu = app('iTunes')
    @whose = Appscript.its
    @lib = setup_playlist("Library")
    @queue = setup_playlist(queue_name)
  end
  
  def stop
    @itu.stop
  end
  
  def skip
    @itu.next_track 
  end

  def q_play 
    @itu.play(@queue.tracks[1]) unless queue_empty?
  end

  def q_show
    ret_q = []
    q_tracks = @queue.tracks.get
    q_tracks.each {|x| ret_q << "#{x.artist.get} - #{x.name.get}"}
    ret_q
  end

  def q_add(song_name)
    empty = queue_empty?
    this_track = library_track(song_name)
    this_track.duplicate(:to => @queue)
    q_play if empty
  end

  def q_remove(song_name)
    @queue.tracks[song_name].delete
  end
  
end


