#!/usr/bin/env python

import datetime
import os
import subprocess
import re
import urllib2
import math


####################################################################
## TODO: Replace this function by another one, which simply reads all lines from a file
####################################################################

def readLines(fPath):
    if not os.path.isfile(fPath):
        open(fPath, 'a').close()    
    with open(fPath) as ff:
        lines = ff.read().splitlines()
    return lines
    



def currentUser(): 
    #pattern = re.compile(r"^(anna|eduards|kalvis|laima|marta|nelda).*$",re.MULTILINE)
    pattern = re.compile(r"^(anna|eduards|kalvis|laima|marta|nelda)+\s.*$",re.MULTILINE)
    m = pattern.match(subprocess.check_output("who"))
    if m:
        return m.group(1)
    else:
        return "nobody"

def getStatus(): 
    url = 'http://85.254.250.28/downloads1/timeouts/index.html'
    try:
        response=urllib2.urlopen(url,timeout=1)
        webFile = response.read()
        pattern2 = re.compile(r"^green",re.MULTILINE)
        m2 = pattern2.match(webFile)
        if m2: 
            return "green"
        else:
            return "yellow"        
    except urllib2.URLError as err: pass
    return "offline"
    

def getYellowCount(theLog):
    yellowCount = 0
    grayCount = 0 
    ll = readLines(theLog)
    for theLine in ll: 
        if (theLine.find("yellow") >= 0) or (theLine.find("red") >= 0):
            yellowCount = yellowCount + 1
        if (theLine.find("green") >= 0):
            yellowCount = 0
        if (theLine.find("offline") >= 0):
            grayCount = grayCount + 1
    yellowCount = yellowCount + (grayCount//12)
    return(yellowCount)


##################################################################### 
## Find the right logfile; logfiles are different for different days
#####################################################################
ddat = datetime.datetime.now()
theLog = '/home/kalvis/.timeouts/access-{yyyy}-{mm}-{dd}.log'.format( \
        yyyy = ddat.year, mm=ddat.month, dd=ddat.day)

yellowCount = getYellowCount(theLog)

status = getStatus()
if yellowCount >= 5:
    status = "red"

if yellowCount > 1:
    os.system("/home/kalvis/.timeouts/msg.py")



logline = '{user}:{time}:{status}({yellowCount})\n'.format(user=currentUser(), \
        time=ddat,status=getStatus(),yellowCount=yellowCount)

if not os.path.isfile(theLog):
    open(theLog, 'a').close()

with open(theLog, "a") as myfile:
    myfile.write(logline)


if yellowCount >= 5:
    from subprocess import call
    call(["pkill","-KILL","-u","marta"])


