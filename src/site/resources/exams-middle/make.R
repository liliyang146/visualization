setwd("/home/st/java-eim/java-eim-parent/src/site/resources/exams-middle/")

# http://quantifyingmemory.blogspot.be/2013/02/reproducible-research-with-r-knitr.html

#if(!require(installr)) { install.packages("installr"); require(installr)} #load / install+load installr 
#install.pandoc()

if (!"knitr" %in% installed.packages()) install.packages("knitr")
if (!"markdown" %in% installed.packages()) install.packages("markdown")

library(knitr)
library(markdown)

primes = read.table(
  file="numbers.csv", 
  header=TRUE,
  sep=",",
  row.names=NULL,  
  fileEncoding="UTF-8"
)

prob01.data = read.table(
  file="prob01-dati.csv", 
  header=TRUE,
  sep=",",
  row.names=NULL,  
  fileEncoding="UTF-8"
)

prob01.questions = read.table(
  file="prob01-dati.csv", 
  header=TRUE,
  sep=",",
  row.names=NULL,  
  fileEncoding="UTF-8"
)


prob15.questions = read.table(
  file="prob15-dati.csv", 
  header=TRUE,
  sep=",",
  row.names=NULL,  
  fileEncoding="UTF-8"
)




files <- c("template")
for (file in files) {
  for (var in 1:4) {
    prob01 <- as.vector(primes[var,])
    prob15 <- as.vector(prob15.questions[var,])[2:(prob15.questions[var,1]+1)]
    knit(sprintf("%s.rmd",file))
    system(sprintf("pandoc -o %s%02d.docx %s.md", 
                   "exam", var, file))
  }
}

