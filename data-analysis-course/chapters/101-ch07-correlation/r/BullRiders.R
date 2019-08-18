setwd("/home/st/java-eim/da-101/ch/101-ch07-correlation/r/")

bull <- read.table(
  file="BullRiders1.csv", 
  header=TRUE,
  sep=",",
  fileEncoding="UTF-8")


# This is data about length of study vs exam result
theData <- read.table(
  file="theData.csv", 
  header=TRUE,
  sep="",
  fileEncoding="UTF-8")

# find correlation and plot the data
cor(theData$A, theData$B)
cor(theData$A, theData$B)^2
plot(theData$A, theData$B)

# remove outlier
dd <- theData[-7,]

# compute correlation anew
cor(dd$A, dd$B)

