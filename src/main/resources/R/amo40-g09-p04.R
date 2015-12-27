xx <- seq(0.5, 3, by=0.01)
ff <- function(x) {
  for (i in 1:100) { x <- x + 2/x }
  return(x)
}
yy <- ff(xx)
plot(xx,yy,type="l", xlab="x_0", ylab="x_100")
grid()
