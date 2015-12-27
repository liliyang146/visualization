windows.options(width=10, height=4)


# Ä¶Ä«mijas centralizÄtajÄ eksÄmenÄ rezultÄtu 
# vidÄjÄ vÄrtÄ«ba bija Î¼ = 51, bet dispersija bija Ï = 4. 
# KÄdai daÄ¼ai eksaminÄjamo rezultÄts bija starp 50.3 un 58.1?
setwd("/Users/kapsitis/workspace/java-eim/ddgatve-exam/")
constants <- read.csv('normal-distr.csv')

for (jj in 1:nrow(constants)) {
  mu = constants$mu[jj]
  sigma = constants$sigma[jj]
  x1 = constants$x1[jj]
  x2 = constants$x2[jj]
  
  
  cord.x <- c(x1,seq(x1,x2,0.01),x2) 
  cord.y <- c(0,dnorm(seq(x1,x2,0.01), mean=mu, sd=sigma),0) 
  curve(pnorm(x, mean = mu, sd=sigma), 
        lwd=2, col="#CC0000",
        xlim=c(mu - 3.2*sigma, mu + 3.2*sigma), 
        xaxp=c(mu - 3*sigma, mu + 3*sigma, 6), 
        xlab="Punkti \u0137\u012Bmijas eks\u0101men\u0101", 
        ylab=paste("pnorm(x,",mu,",",sigma ,
                   ") - k\u0101da dala ir pa kreisi no grafika?", sep="") )
 abline(h=0, col="#999999")
 abline(h=1, col="#999999")
#  polygon(cord.x,cord.y,col='skyblue')

  
  
  y1 <- pnorm(x1, mean = mu, sd=sigma)
  y2 <- pnorm(x2, mean = mu, sd=sigma)
  
  xx0 <- c(x1, x2)
  xx1 <- xx0
  yy0 <- c(0,0)
  yy1 <- c(y1,y2)
  segments(xx0, yy0, xx1, yy1, col="blue")
  points(xx1, yy1, cex=1.5, col="blue", bg="blue", pch=21 )
  
  
  dev.copy(png,
           paste("c:/Users/kapsitis/workspace/java-eim/ddgatve-exam/soln6-", jj, ".png",sep=""))
  dev.off()
}
