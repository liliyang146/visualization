library(astrolibR)

jd <- jdcnv(2001,1,1,0) # get Julian date of midnight on Jan 1
out <- planet_coords(jd+seq(0,365), planet='mars')
plot(jd+seq(0,365), out$dec, pch=20, xlab='Day of 2001', ylab='Declination of Mars (degrees)')


jd <- jdcnv(1982, 5, 1,0) 
out <- sunpos(jd)

jd = jdcnv(2015,2,7,0.8) # Julian date on Jan 1, 1997
#days = 0:365
#plot(days, sunpos(jd+days)$longmed, type="l", pch=20, lwd=2)

thePos <- sunpos(jd)

eq2hor(thePos$ra, thePos$dec, jd,
       lat=ten(56,56,56), lon=ten(24,6,23))


