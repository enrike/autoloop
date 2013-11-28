autoloop 0.4 / November 2013 / www.ixi-software.net

Download :
www.ixi-software.net/content/body_software_autoloop.html


--- Contact ---
any question please email info@ixi-software.net


--- License --- GPL
This library is free software; you can redistribute it and/or modify it under the terms of the Lesser GNU, General Public License as published by the Free Software Foundation.

This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
You should have received a copy of the GNU General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA



--- System requirements ---
Autoloop is a PureData patch, so to run it you must have Pure Data (http://puredata.info/downloads or http://puredata.org/Members/hans) in
your machine. It uses few PD externals so you better use PD extended version.

Windows users: Because of the use of py/pyExt external for PureData you must have Python 2.4 installed in your machine. The installer can be downloaded from www.python.org


--- Description ---
Autoloop has been developed after several applications doing similar stuff (Shell, Autocrap by www.ixi-software.net). Autoloop samples incomming sound. It has several buffers or layers being played concurrently. It has as well different set of timers that can be adjusted to sample different lenghts into the layers. Just plug your instrument or mic into your machine or select a sound to stream, set some values in the timers, click start and have fun.
For me it works very well with long sounds (40 min) that contain drones. It chops them creating different layers that loop evolving slowly. It is also fun to play an instrument into it. 

Rec Mixmode : specify how audio signal should be mixed in (none, mixed, added).


-- Changes ---
0.4
Python programing moved to Lua
xgroove functionality moved to pure python abstractions

0.3.5 11/07
- added few effects and filters
- modified GUI
- added grid on foldover and freeverb
- added direct sound input to effects area
- effects area is abstraction now

0.3
- removed sample from file. Better use Jack.
- added freeverb
- effect conections can be patched on the fly

0.2 12/06
- added play head to show where in sound we currently are
- autopan
- dist~ for in and out
- better in and our vol control

0.1 - 10/1/06
- flush single buffers / all buffers
- individual pitch and volume
- lock/unlock layers 
- loop on off doesnt work properly
- loop bidirectional as general option
- stereo sampling
- loc replaced by available


--- To do ---
- joystick support
- OSC to allow autoloop to be controlled from other apps or graphical interfaces (like Shell, etc...)
- store and load presets
- timers in compases with BMP?
- develop th whole ting with supercollider ?? 
...



