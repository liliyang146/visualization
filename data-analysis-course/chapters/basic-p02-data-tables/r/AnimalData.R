setwd("/home/st/java-eim/da-101/ch/101-ch02-data-tables/r/")

animaldata  <- read.table(
  file="AnimalData.csv", 
  header=TRUE,
  sep=",",
  fileEncoding="UTF-8")

#Find the number of animals that were adopted
table(animaldata$Outcome.Type)

#Pull out only adopted animals
adopted <- animaldata[animaldata$Outcome.Type=="Adoption",]

#Pull out just the days in shelter for the adopted animals
daystoadopt <- adopted$Days.Shelter

#Visualize and describe this variable
hist(daystoadopt)
fivenum(daystoadopt)
mean(daystoadopt)
sd(daystoadopt)
which(animaldata$Days.Shelter==max(daystoadopt))


# Lab
allCats <- animaldata[animaldata$Animal.Type == "Cat" & animaldata$Age.Intake >=1,]
allDogs <- animaldata[animaldata$Animal.Type == "Dog" & animaldata$Age.Intake >=1,]

nrow(allCats)
nrow(allDogs)
nrow(animaldata)

hist(allCats$Weight)

hist(allDogs$Weight)

zcat <- (13 - mean(allCats$Weight))/sd(allCats$Weight)
1 - pnorm(zcat)


fivenum(allDogs$Weight)

nrow(allDogs[allDogs$Weight > 13,])/226


table(animaldata$Intake.Type[animaldata$Animal.Type == "Dog"])

surrDogs <- animaldata[animaldata$Animal.Type == "Dog" & animaldata$Intake.Type == "Owner Surrender",]




