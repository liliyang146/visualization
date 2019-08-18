# source data about cars (2 categories)
A <- matrix(c(146,191,18,26,51,79), nrow=3, byrow=TRUE)
colnames(A) <- c("domestic","foreign")
rownames(A) <- c("gasoline", "diesel", "hybrid")
B <- matrix(rep(0,6), nrow=3)
for (i in 1:3) {
  for (j in 1:2) {
    fRow <- sum(A[i,])/sum(A)
    fCol <- sum(A[,j])/sum(A)
    B[i,j] <- fRow*fCol*sum(A)
  }
}
chiVal <- sum((A - B)^2/B)
