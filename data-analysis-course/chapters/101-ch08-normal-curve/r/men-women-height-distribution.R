#Vīriešu vidējais garums 178cm, dispersija 10cm; 
#sieviešu vidējais garums 165cm, dispersija 9cm. 

N <- 10000
men <- rnorm(N/2, 178, 10)
women <- rnorm(N/2, 165, 9)
men <- round(men, digits=1)
women <- round(women, digits=1)
all <- sort(c(men,women))
plot(all,type="l",ylim=c(0,max(all)), 
     ylab="",xlab="", axes=FALSE, col="gray", lwd=2)
abline(h=0, col="gray")