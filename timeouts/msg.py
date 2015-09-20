#!/usr/bin/env python
import os

from subprocess import call
call(["notify-send", "-i", "/home/kalvis/.timeouts/logo.png", "Sveicinaati, Laimsi!", "Atlikushas 1-5 min. Saglabaajiet failus!"])
#call(["firefox","file:///home/kalvis/Documents/index.html"])
Freq = 2500 # Set Frequency To 2500 Hertz
Dur = 1 # Set Duration To 1000 ms == 1 second
os.system('play --no-show-progress --null --channels 1 synth %s sine %f' % ( Dur, Freq))

