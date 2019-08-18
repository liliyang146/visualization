setwd("/home/st/java-eim/da-101/ch/101-ch03-histograms/r/")

exams <- read.table(
  file="2014_dati.csv", 
  header=TRUE,
  sep=",",quote="\"",
  fileEncoding="UTF-8")

#math <- exams[exams$prieksmets=="MAT" &
#                exams$valdes_kod ==11,]
math <- exams[exams$prieksmets=="MAT",]

hist(math$koppro, breaks=c(0,5,10,20,40,70,100))

hist(math$koppro, breaks=c(0,5,95,100))

hist(math$koppro, breaks=20)


