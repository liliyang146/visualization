for (n in 5:45) {
  half <- floor(n/2)
  vals <- sin((1:half)*pi/n)
  for (k1 in 1:half) {
    for (k2 in 1:k1) {
      ss <- sin(k1*pi/n) + sin(k2*pi/n)
      if (min(abs(vals - ss)) < 1e-10) {
        k3 <- which(abs(vals - ss) < 1e-10)[1]
        if (k1 + 2*k2 != k3 || 3*(k3 - k2) != n) {
          print("********************FOUND NONTRIVIAL EXAMPLE")
          print(paste0("n = ", n, ", k1 = ", k1, ", k2 = ", k2))
          print(paste0("  ss = ",ss))
          print(paste0("    k3 = ", k3, ", val[k3] = ", vals[k3]))
        }
      }
    }
  }
}