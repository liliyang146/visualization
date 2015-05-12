windows.options(width=10, height=4)


# Ķīmijas centralizētajā eksāmenā rezultātu 
# vidējā vērtība bija μ = 51, bet dispersija bija σ = 4. 
# Kādai daļai eksaminējamo rezultāts bija starp 50.3 un 58.1?
setwd("/Users/kapsitis/workspace/java-eim/ddgatve-exam/")
constants <- read.csv('normal-distr.csv')

for (jj in 1:nrow(constants)) {
mu = constants$mu[jj]
sigma = constants$sigma[jj]
x1 = constants$x1[jj]
x2 = constants$x2[jj]


cord.x <- c(x1,seq(x1,x2,0.01),x2) 
cord.y <- c(0,dnorm(seq(x1,x2,0.01), mean=mu, sd=sigma),0) 
curve(dnorm(x, mean = mu, sd=sigma), 
      xlim=c(mu - 3.2*sigma, mu + 3.2*sigma), 
      main='Norm\u0101lais sadal\u012Bjums', 
      xaxp=c(mu - 3*sigma, mu + 3*sigma, 6), 
      xlab="Punkti \u0137\u012Bmijas eks\u0101men\u0101", 
      ylab="Relat\u012Bvais bie\u017Eums") 
abline(h=0)
polygon(cord.x,cord.y,col='skyblue')

xx0 <- seq(mu - 3*sigma, by=sigma, length.out = 7)
xx1 <- xx0
yy0 <- rep(0,7)
yy1 <- dnorm(xx0, mean=mu, sd=sigma)

segments(xx0, yy0, xx1, yy1, col="#CC0000", lwd=2)

dev.copy(png,
         paste("c:/Users/kapsitis/workspace/java-eim/ddgatve-exam/chart6-", jj, ".png",sep=""))
dev.off()
}
