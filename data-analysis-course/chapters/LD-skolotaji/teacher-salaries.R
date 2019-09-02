import(subset)


# Try transparent colors
lightgrayRGB <- as.vector(col2rgb("lightgray"))/255
newLightgray <- rgb(lightgrayRGB[1],lightgrayRGB[2],lightgrayRGB[3],0.5)



csvFile <- "/home/st/ddgatve-stat/reports/skolotaju-algas-large.csv"

tSalaries <- read.csv(file=csvFile,head=TRUE,sep=",")

#posSal <- tSalaries[which(tSalaries$Alga > 0),]

posSal <- subset(tSalaries, Alga > 0)

#bb <- seq(0,2450,by=25)
bb <- c(0,420,600,800,1000,1200,2500)

countTeachers <- function(n) {
  if (n==1) {
     return(sum(posSal$Alga > bb[n] & posSal$Alga < bb[n+1] ))
  } else {
    return(sum(posSal$Alga >= bb[n] & posSal$Alga < bb[n+1] ))
  } 
}

theBins <- sapply(1:6,countTeachers)
theProc <- round(100*theBins/sum(theBins), digits=1)
teachersPerBin <- paste("",bins)
teachersPerBinProc <- paste("",theProc,"%")
hist(posSal$Alga, breaks = bb, 
     main="Skolot\u0101ju algu sadal\u012Bjums",
     xlab="Alga (da\u017E\u0101d\u0101m slodz\u0113m: no 0.044 l\u012Bdz 5.235)", 
     ylab="", axes=FALSE, labels=teachersPerBinProc)
axis(side=1,at=bb,tick=TRUE, labels=FALSE)
labs <- paste0(bb," \u20AC")
#text(cex=.6, x=x-.25, y=-1.25, labs, xpd=TRUE, srt=45)
oldPar <- par(xpd=NA)
text(x=bb,y=-0.0001,labels=labs,srt=45,adj=1)
par(oldPar)




lbb <- seq(0,2500,by=250)
cnt250 <- function(n) {
  if (n==1) {
    return(sum(posSal$Alga > lbb[n] & posSal$Alga < lbb[n+1] ))
  } else {
    return(sum(posSal$Alga >= lbb[n] & posSal$Alga < lbb[n+1] ))
  } 
}


pinkRGB <- as.vector(col2rgb("violetred1"))/255
newPink <- rgb(pinkRGB[1],pinkRGB[2],pinkRGB[3],1)
bb <- seq(0,2450,by=25)
hist(posSal$Alga, breaks = bb, 
     main="Skolot\u0101ju algu sadal\u012Bjums",
     xlab="Alga (da\u017E\u0101d\u0101m slodz\u0113m: no 0.044 l\u012Bdz 5.235)", 
     ylab="Skolot\u0101ju skaits algu interv\u0101l\u0101", 
     col=newPink, axes=TRUE, ylim=c(0,1000),
     xlim=c(0,2000))

offset <- 250*0:10
for (m in 0:9) {
  if (m %% 2 == 0) {    
  polygon(offset[m+1] + c(0,0,250,250),
        c(0,1000,1000,0), col=newLightgray, border=NA)
  }
}

largeSlips <- sapply(1:10, cnt250)
largePerc <- round(100*largeSlips/sum(largeSlips), digits=1)
newLabs <- paste0("",largeSlips)
percLabs <- paste0("",largePerc,"%")

box()
abline(col="lightgray",lty="dotted",h=100*1:10)

text(x=125+250*0:9,y=980,labels=newLabs,adj=0.5)
text(x=125+250*0:9,y=930,labels=percLabs,adj=0.5)






##################################################
###################  Removed outliers
##################################################
posSal$Alga[posSal$Alga >= 2000] <- 2000

lbb <- seq(0,2500,by=250)
cnt250 <- function(n) {
  if (n==1) {
    return(sum(posSal$Alga > lbb[n] & posSal$Alga < lbb[n+1] ))
  } else if (n == 8) {
    return(sum(posSal$Alga >= lbb[n])) 
  } else {
    return(sum(posSal$Alga >= lbb[n] & posSal$Alga < lbb[n+1] ))
  }
}

bb <- seq(0,2000,by=25)
hist(posSal$Alga, breaks = bb, 
     main="Skolot\u0101ju algu sadal\u012Bjums",
     xlab="Alga (da\u017E\u0101d\u0101m slodz\u0113m: no 0.044 l\u012Bdz 5.235)", 
     ylab="Skolot\u0101ju skaits algu interv\u0101l\u0101", 
     col=newPink, axes=TRUE, ylim=c(0,1000),
     xlim=c(0,2000))

offset <- 250*0:8
for (m in 0:7) {
  if (m %% 2 == 0) {    
    polygon(offset[m+1] + c(0,0,250,250),
            c(0,1000,1000,0), col=newLightgray, border=NA)
  }
}

largeSlips <- sapply(1:8, cnt250)
largePerc <- round(100*largeSlips/sum(largeSlips), digits=1)
newLabs <- paste0("",largeSlips)
percLabs <- paste0("",largePerc,"%")

box()
abline(col="lightgray",lty="dotted",h=100*1:10)

text(x=125+250*0:7,y=980,labels=newLabs,adj=0.5)
text(x=125+250*0:7,y=940,labels=percLabs,adj=0.5)
















#bb <- c(0,420,600,800,1000,1200,2500)
step <- 10
bb <- seq(0,step*ceiling(2433.34/step),by=step)
countTeachers <- function(n) {
  if (n==1) {
    return(sum(posSal$Alga > bb[n] & posSal$Alga < bb[n+1] ))
  } else {
    return(sum(posSal$Alga >= bb[n] & posSal$Alga < bb[n+1] ))
  } 
}

aa <- sapply((1:(length(bb)-1)), countTeachers)

for (i in (1:(length(bb)-1))) {
  print.noquote(sprintf("%d %d %d",bb[i],bb[i+1],aa[i]))
}

