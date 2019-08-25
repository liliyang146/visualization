setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
factorial <- function(n) { return(prod(1:n)) }

sinPartial <- function(x,n) {
  result <- 0
  for (k in 0:n) {
    result <- result + (-1)^k*x^(2*k+1)/factorial(2*k+1)
  }
  return(result)
}

xx <- seq(-6,6,by=0.01)
for (k in 0:3) {
  png(paste0("sin",k,".png"), 
      width = 5, height = 3, 
      units = 'in', res = 600)
  plot(xx,sin(xx),type="l",col="red")
  grid()
  points(xx,sinPartial(xx,k),type="l",col="blue")
  dev.off()
}

if (Sys.info()['sysname'] == "Windows") {
  cmdPrefix <- "cmd /c "
} else { cmdPrefix <- "" } 
system(paste0(
  cmdPrefix,
  "convert -delay 75 -loop 0 sin*.png animation.gif"
))
