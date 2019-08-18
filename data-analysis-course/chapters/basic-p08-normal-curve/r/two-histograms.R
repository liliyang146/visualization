if (!"png" %in% installed.packages()) install.packages("png")
library(png)
setwd("/home/st/java-eim/dataproc-101/Chapters/statistics-intro/Source-Material/")

png("two-histograms.png", width=600, height=450)


N <- 10000
men <- rnorm(N/2, 178, 10)
women <- rnorm(N/2, 165, 9)
maxAll <- round(max(c(men,women)))

menHist <- rep(0,times=maxAll)
womenHist <- rep(0,times=maxAll)

for (i in 1:(N/2)) {
  slot1 <- round(men[i])
  menHist[slot1] <- menHist[slot1] + 1
  slot2 <- round(women[i])
  womenHist[slot2] <- womenHist[slot2] + 1
}

ep1 <- min(which(womenHist+menHist > 1))
ep2 <- max(which(womenHist+menHist > 1))

barplot(menHist[ep1:ep2], col="blue", space=0, ylim=c(0,N/40), 
        xlab="", ylab="")

# Try transparent colors
lightgrayRGB <- as.vector(col2rgb("lightgray"))/255
newLightgray <- rgb(lightgrayRGB[1],lightgrayRGB[2],lightgrayRGB[3],0.5)

blueRGB <- as.vector(col2rgb("lightskyblue"))/255
newBlue <- rgb(blueRGB[1],blueRGB[2],blueRGB[3],1)

pinkRGB <- as.vector(col2rgb("violetred1"))/255
newPink <- rgb(pinkRGB[1],pinkRGB[2],pinkRGB[3],1)


barplot(menHist[ep1:ep2], col=newBlue, space=0, add=TRUE)
barplot(womenHist[ep1:ep2], col=newPink, space=0, add=TRUE)
thirdWay = pmin(menHist[ep1:ep2],womenHist[ep1:ep2])
barplot(thirdWay, col="mediumpurple1", space=0, add=TRUE)

offset <- 10*(ceiling(ep1/10) - ep1/10)
for (m in 0:20) {
  if (m %% 2 == 0) {
    polygon(offset + c(m*10,m*10,(m+1)*10,(m+1)*10),
            c(0,N/40,N/40,0), col=newLightgray, border=NA)
  }
}

xx <- seq(ep1,ep2,by=0.1)
yyM <- (N/2)*dnorm(xx,178,10)
yyF <- (N/2)*dnorm(xx,165,9)
lines(xx-ep1+0.5,yyM,type="l",col="navyblue",lwd=2)
lines(xx-ep1+0.5,yyF,type="l",col="darkred",lwd=2)

box()
abline(col="lightgray",lty="dotted",h=50*1:4)
midpts <- seq(ep1+offset,ep2,by=5)
midptsShifted <- midpts + 0.5 - ep1
midpts <- as.character(midpts)
axis(1, at = midptsShifted, labels=midpts, cex.axis=0.9)
dev.off()
