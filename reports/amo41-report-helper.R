setwd("/home/st/ddgatve-stat/reports/")
#setwd("/home/kalvis/workspace/ddgatve-stat/reports/")


if (!"plyr" %in% installed.packages()) install.packages("plyr")
library(plyr)
if (!"Unicode" %in% installed.packages()) install.packages("Unicode")
library(Unicode)


#schoolLanguageList <- getSchoolLanguageList()

skoleniALL = read.table(
  file="vs-apmac-val_all-2014.csv", 
  sep=",",
  header=TRUE,
  row.names=NULL,  
  fileEncoding="UTF-8")[1:14,]

skoleniALL$Region6 = c("Kurzeme","Latgale","Pierīga","Vidzeme","Zemgale",
                       "Zemgale","Vidzeme","Latgale","Zemgale",
                       "Pierīga","Kurzeme","Latgale","Kurzeme","Rīga")

xx <- aggregate(. ~ Region6, data=skoleniALL, FUN=sum)



# skoleniLV = read.table(
#   file="vs-apmac-val-lv-2014.csv", 
#   sep=",",
#   header=TRUE,
#   row.names=NULL,  
#   fileEncoding="UTF-8")
# 
# skoleniRU = read.table(
#   file="vs-apmac-val-ru-2014.csv", 
#   sep=",",
#   header=TRUE,
#   row.names=NULL,  
#   fileEncoding="UTF-8")


skolaPasvaldiba <- read.table(
  file="skola-pasvaldiba.csv", 
  sep=",",
  header=TRUE,
  row.names=NULL,  
  fileEncoding="UTF-8")

sp <- list()
for(i in 1:length(skolaPasvaldiba$School)) {
  aa <- as.vector(skolaPasvaldiba$School[i])
  bb <- as.vector(skolaPasvaldiba$Municipality[i])
  sp[[aa]] <- bb
}


pasvaldibas <- read.table(
  file="pasvaldibas.csv", 
  sep=",",
  header=TRUE,
  row.names=NULL,  
  fileEncoding="UTF-8")



pr <- list()
pr14 <- list()
for(i in 1:length(pasvaldibas$Municipality)) {
  aa <- as.vector(pasvaldibas$Municipality[i])
  bb <- as.vector(pasvaldibas$Region6[i])
  cc <- as.vector(pasvaldibas$Region14[i])
  pr[[aa]] <- bb
  pr14[[aa]] <- cc
}


getMunicipality <- function(school) {
  if (!(school %in% names(sp))) {
    spacedSchool <- gsub("\\.", ". ", school)
    if (!(spacedSchool %in% names(sp))) {
      return("NNN")
    } else {
      return(sp[[spacedSchool]])
    }  
  } else {
    return(sp[[school]])
  }
}

getRegion <- function(theMunicipality) {
  theRegion <- pr[[theMunicipality]]
  return(theRegion)
}

getRegion14 <- function(theMunicipality) {
  theRegion14 <- pr14[[theMunicipality]]
  return(theRegion14)
}


# results <- read.table(
#   file="results-10kl.csv", 
#   sep=",",
#   header=TRUE,
#   row.names=NULL,  
#   fileEncoding="UTF-8")


getExtResults <- function() {
  results <- getResultTables()
  
  dzimums <- sapply(as.vector(results$Vards), getGender)
  results$Dzimums <- dzimums
  
  municipalities <- as.vector(sapply(as.vector(results$Skola), getMunicipality))
  regions <- as.vector(sapply(municipalities,getRegion))
  regions14 <- as.vector(sapply(municipalities,getRegion14))
  
  results$Municipality <- municipalities
  results$Region6 <- regions
  results$Region14 <- regions14
  
  
  
  # skolasLV <- getSchoolsForLanguage("L")
  # skolasRU <- getSchoolsForLanguage("K")
  languages <- character(0) 
  
  for (i in 1:nrow(results)) {
    theSchool <- results$Skola[i]
    theTeacher <- results$Skolotaji[i]
    if (theTeacher == "") {
      theTeacher <- "NA"
    }
    theLanguage <- getLang(theSchool,theTeacher)
    languages <- c(languages,theLanguage)
    #  print(sprintf("%d - %d",i,length(languages)))
  }
  
  results$Language <- languages
  return(results)
}

results <- getExtResults()

getAllPupils <- function(year) {
  result <- read.table(
    file=sprintf("vs-apmac-val_all-%d.csv",year), 
    sep=",",
    header=TRUE,
    row.names=NULL,  
    fileEncoding="UTF-8")
  return(result[1:14,])
}




