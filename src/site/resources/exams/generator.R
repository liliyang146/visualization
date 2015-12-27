## Skripts, kurš ģenerē parametrus normālā sadalījuma uzdevumam

# mu <- sort(sample(50:100,16))
mu <- c( 51,52,53,60,61,63,67,69,72,75,80,87,90,97,98,99)

# sigma <- sample(c(1:10, 1:10, 1:10), 16)
sigma <- c(4,2,1,4, 9,7,1,8, 8,1,3,6, 3,7,5,9)

xx <- c()
yy <- c()
for (i in 1:16) {
  pair <- sort(round(rnorm(2,mean=mu[i], sd=sigma[i]), digits=1))
  xx <- c(xx,pair[1])
  yy <- c(yy,pair[2])
}