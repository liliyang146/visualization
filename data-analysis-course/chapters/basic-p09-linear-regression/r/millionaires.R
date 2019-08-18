setwd("/home/st/java-eim/da-101/ch/101-ch09-linear-regression/r/")

mi <- read.table(
  file="millionaires.csv", 
  header=TRUE,
  quote="\"",
  fileEncoding="UTF-8")


lm(mi$Millionaires ~ mi$Population)
summary(lm(mi$Millionaires ~ mi$Population))
cor(mi$Millionaires,mi$Population)
