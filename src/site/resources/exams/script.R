#########################################
### Bankas depozita procenti (pieskaita 1x gada)
#########################################

# Sakotnejais depozits
x <- c(100)
# 20 reizes palielina par 5% - atbilst depozitam uz 20 gadiem.
for (i in 1:20) { 
   last <- x[length(x)]
   x <- c(x, round(last *1.05, digits=2))
}
x
length(x)



#########################################
### Bankas depozita procenti (pieskaita 1x menesi)
#########################################

x <- c(100)
for (i in 1:240) { 
   last <- x[length(x)]
   x <- c(x,  round(last * (1 + 0.05/12), digits=2))
}
x
length(x)



#########################################
### Ka izveleties vislabako piedavajumu
#########################################

numExperiments <- 1000
alist <- blist <- clist <- rep(0,99)
for (N in 1:99) {
   for (experiment in 1:numExperiments) {
       # nejausi pieskir 100 dzivoklu novertejumus no 0 lidz 1
       flats <- runif(100, min=0, max=1)
       # atrod labako starp pirmajiem N (kurus palaida garam)
       firstNmax <- max(flats[1:N])
       # atlikusie dzivokli, kuri parsniedz firstNmax
       remainingFlats <- flats[(N+1):100]
       remainingFlats <- remainingFlats[remainingFlats > firstNmax]
       
       # (C) paliek bez, ja nekas labs vairs nav atlicis
       if (length(remainingFlats) == 0) { clist[N] <- clist[N] +  1 }
       # (B) panem ne-vislabako, ja velak butu vel labaks 
       else if (remainingFlats[1] < max(remainingFlats)) { blist[N] <- blist[N] + 1 }
       # (A) panem vislabako, ja neizpildas ne (C) ne (B)
       else { alist[N] <- alist[N] + 1 }
  }
}
plot(alist/numExperiments, type="l", col="red", lwd=2, xlim=c(0,100), ylim=c(0,1))
lines(blist/numExperiments, type="l", col="gray", lwd=2)
lines(clist/numExperiments, type="l", col="blue", lwd=2)
grid()

maxA <- max(alist)
bestN <- which(maxA == alist)[1]
bestSuccessRate <- maxA/numExperiments
print(paste("Optimalais N ir ", bestN, sep=""))
print(paste("Biezums, ar kuru atrod vislabako ir ", bestSuccessRate, sep=""))



#########################################
### PVN nodokli un "neiespejamas cenas"
#########################################

withoutVAT <- function(x) {round(x/1.21, digits=2)  }
getVAT <- function(x) {round(x*0.21, digits=2)}
# rukisa aprekins
prices <- 1:100
pricesNoVAT <- withoutVAT(prices)
VAT <- prices - pricesNoVAT
# RID aprekins
correctVAT <- getVAT(pricesNoVAT)
# realu skaitlu salidzinasana :)
VAT == correctVAT
print(paste("vat[1]=",VAT[1], sep=""))
print(paste("correctVAT[1]=",correctVAT[1], sep=""))
print(paste("vat[1]-correctVAT[1]=",VAT[1]-correctVAT[1], sep=""))

# uzlabota realu skaitlu salidzinasana
# atrod atskirigos (tipiski atskiriba ir par 1 sant.)
badLines <- abs(VAT - correctVAT) > 1E-7
# saskaita, cik ir vertibu TRUE
sum(badLines)
# saskaita rukisa izdevumus
sum(badLines) + sum(VAT)

round(3.30*0.21, digits=2) + 3.30
round(3.31*0.21, digits=2) + 3.31


#########################################
### Gaidisanas laiki: 
### Cik cilveku videji jasatiek, lai atrastu 
###   pirmo vai otro, kuram ar Jums sakrit dz.diena
#########################################

install.packages("Rlab")
library(Rlab)
numExperiments <- 10000
alist <- blist <- clist <- rep(0,numExperiments)
for (experiment in 1:numExperiments) {
  x <- rbern(10000, 1/365)
  xx <- cumsum(x)
  alist[experiment] <- which(xx == 1)[1]
  blist[experiment] <- which(xx == 2)[1]
  clist[experiment] <- sum(x)
}
sum(alist)/numExperiments
sum(blist)/numExperiments
sum(clist)/numExperiments


#########################################
### Monetas mesanas spele: 
### Cik % no laika viens speletajs ir prieksa otram
#########################################
install.packages("Rlab")
library(Rlab)
x <- rbern(1000000,0.5)
xx <- 2*x - 1
pxx <- cumsum(xx)

payoffs <- sign(pxx)
table(payoffs)

plot(1:1000000, pxx, type="l")
abline(h=0)


#########################################
### Gaidisanas laiki: 
### Cik cilveku videji jasatiek, lai diviem 
###  no viniem sakristu dzimsanas diena
#########################################
pr <- c(1)
for (i  in 1:365) {
  pr <- c(pr,pr[i]*(365-i)/365)
}
which(pr < 1/2)[1]
pr


#########################################
### Gaidisanas laiki: 
### Cik cipsu pakas jaatver, lai atrastu tajas
### pilnu komplektu ar 12 zetoniem
#########################################

# Simule 1000 cipsu pakas
x <- floor(12*runif(1000)) + 1
y <- rep(0,12)
for (i in 1:1000) {
  y[i] <- length(table(x[1:i]))
}
which(y==12)[1]



#########################################
### Cepuru samainisana: 
### Kada varbutiba, ka neviens no 100 cilvekiem nedabus savu cepuri
#########################################

# Simule 1000 eksperimentus
numExperiments <- 1000
total <- 0
for (i in 1:numExperiments) {
  x <- 1:100
  y <- sample(1:100)
  z <- (x == y)
  if (sum(z)==0) { total <- total + 1} 
}
total/numExperiments





#########################################
### Atrod un izvada pirmskaitlus no 1 lidz 1000
#########################################

primes <- c()
for (i in 2:1000) {
  isPrime <- TRUE
  for (j in 2:(sqrt(i)+1)) {
    if (j < i && i %% j == 0) { isPrime <- FALSE; break }
  }
  if (isPrime) { primes <- c(primes,i)}
}
primes


#########################################
### Pleseju-plesamo populaciju attistiba: 
### Lotkas-Volterras vienadojumi
#########################################
x <- c(40)
y <- c(6)
alpha <- 1.5E-3
beta <- 3E-4
gamma <- 3E-2
delta <- 1E-3


for (i in 1:4000) {
  lastx <- x[length(x)]
  lasty <- y[length(y)]
  dx = lastx*(alpha - beta*lasty)
  dy = -lasty*(gamma - delta*lastx)
  x <- c(x, lastx + dx)
  y <- c(y, lasty + dy)
}

#plot(x, type="l", col="green",ylim=c(0,max(x)))
#lines(y, type="l", col="black")

plot(x,y, type="l", col="gray", xlab="pavi\u0101ni",ylab="gepardi")




#########################################
### Diagramma, kas zime krasainus kvadratinus
#########################################
xx <- seq(3, by=3, length.out = 17)
plot(xx %% 17, col=rep(rainbow(6),3), pch=15, cex=rep(c(2,3,4),6), xlab="", ylab="")
grid()




#########################################
### Vienkarsa lineara regresija
#########################################
plot(-10:10, -10:10, xaxp=c(-10,10,20), yaxp=c(-10,10,20),type='n',xlab='',ylab='',asp=1)
xx <- c(-2,-2,-1,-1,-1,2,3,3)
yy <- c(7,9,5,6,9,0,-3,-2)
cor(xx,yy)

points(xx, yy, col='blue', bg='blue', pch=21, cex=1.5)
grid()
beta <- (mean(xx*yy) - mean(xx)*mean(yy))/(mean(xx*xx) - (mean(xx))*(mean(xx)))
alpha <- mean(yy) - beta*mean(xx)

zz <- seq(-10,10,by=0.1)
bestfitline <- function(x) {
  alpha + beta*x
}
points(zz,bestfitline(zz),type='l',col='red', lwd=2)




#########################################
### Normalais sadalijums
#########################################

# The scores on a statewide history exam were normally distributed with ??=81 and ??=5.
# What fraction of test-takers had a grade between 92 and 93 on the exam? 

z1 <- (92 - 81)/5
z2 <- (93 - 81)/5

prob <- abs(pnorm(z2) - pnorm(z1))
prob

