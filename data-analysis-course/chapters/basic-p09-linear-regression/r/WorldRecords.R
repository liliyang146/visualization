setwd("/home/st/java-eim/da-101/ch/101-ch09-linear-regression/r/")

WR <- read.table(
  file="WorldRecords.csv", 
  header=TRUE,
  sep=",",
  quote="\"",
  fileEncoding="UTF-8")


menshot <- WR[WR$Event=='Mens Shotput',]
womenshot <- WR[WR$Event=='Womens Shotput',] 

#Create scatterplots

plot(menshot$Year,menshot$Record,main='Mens Shotput World Records',xlab='Year',ylab='World Record Distance (m)',pch=16)
plot(womenshot$Year,womenshot$Record,main='Womens Shotput World Records',xlab='Year',ylab='World Record Distance (m)',pch=16)

#Run linear models

summary(lm(menshot$Record ~ menshot$Year))
summary(lm(womenshot$Record ~ womenshot$Year))




mensmile <- WR[WR$Event=='Mens Mile',]
womensmile <- WR[WR$Event=='Womens Mile',]
plot(mensmile$Year,mensmile$Record,main='Mens Mile World Records',xlab='Year',ylab='World Record Distance (m)',pch=16)
plot(womensmile$Year,womensmile$Record,main='Womens Mile World Records',xlab='Year',ylab='World Record Distance (m)',pch=16)

lm(mensmile$Record ~ mensmile$Year)
lm(womensmile$Record ~ womensmile$Year)

summary(lm(mensmile$Record ~ mensmile$Year))
summary(lm(womensmile$Record ~ womensmile$Year))




mpv <- WR[WR$Event == "Mens Polevault" & WR$Year >= 1970,]
plot(mpv$Year, mpv$Record)
lm(mpv$Record ~ mpv$Year)
abline(lm(mpv$Record ~ mpv$Year))

