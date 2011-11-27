retune
======

Most of my music ends up in iTunes but I've never liked using the iTunes GUI. 
This app allows a remote client to add, show and skip songs in a queue.
A Sinatra web service, defined in retune.rb, provides the interface.  The rb-appscript
gem provides the ruby to AppleScript bridge to control iTunes.

Startup
-------
On startup a playlist named "queue" is created in iTunes if it does not already exist.
A polling thread is also started that monitors the playlist and removes skipped and 
played songs.


Notes
------------
The app works on OS X and has not been tested on Windows.  

