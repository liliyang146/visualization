library(dplyr)

setwd("/home/kalvis/workspace/ddgatve-stat/zpd-election-ads/candidates")

df <- read.table(
#  file="riga-data.csv", 
  file="vidzeme-data.csv",
#  file="latgale-data.csv",
#  file="kurzeme-data.csv",
#  file="zemgale-data.csv",
  sep=",",
  na.strings="NN",
  header=TRUE,
  row.names=NULL,
  fileEncoding="UTF-8")

# Vieta
# Iecirknis
# Saraksts
# Numurs
# Kandidats
# Plusi
# Svitrojumi

dfdf <- dplyr::filter(df, ListNo == 2 | ListNo == 4 |
                        ListNo == 9 |ListNo == 10 |
                        ListNo == 13 |ListNo == 15 |ListNo == 16)
dfdf <- droplevels(dfdf)
dfdf$Diff <- dfdf$Pluses - dfdf$Minuses

partyNum <- c(2,4,9,10,13,15,16)
partyAbbr <- c("JKP", "NA", "Sask", "A-PAR", "JV", "KPV", "ZZS")

# Plusi: populaacijas vid.veertiiba (1 partijas kandidaatiem)
partyPlusesMean <- numeric(0)
# Plusi: populaacijas standartnovirze  (1 partijas kandidaatiem)
partyPlusesSD <- numeric(0)
# Miinusi: populaacijas vid.veertiiba  (1 partijas kandidaatiem)
partyMinusesMean <- numeric(0)
# Miinusi: populaacijas standartnovirze  (1 partijas kandidaatiem)
partyMinusesSD <- numeric(0)
# Plusu-minusu starpiba un standartnovirze
partyDiffMean <- numeric(0)
partyDiffSD <- numeric(0)

for (party in partyNum) {
  df2 <- dfdf[dfdf$ListNo == party, ]
 
  plusesMean <- mean(df2$Pluses)
  partyPlusesMean <- c(partyPlusesMean, mean(df2$Pluses))
  plusesSD <- sqrt(sum((df2$Pluses - plusesMean)^2)/length(df2$Pluses))
  partyPlusesSD <- c(partyPlusesSD, plusesSD)

  minusesMean <- mean(df2$Minuses)
  partyMinusesMean <- c(partyMinusesMean, mean(df2$Minuses))
  minusesSD <- sqrt(sum((df2$Minuses - minusesMean)^2)/length(df2$Minuses))
  partyMinusesSD <- c(partyMinusesSD, minusesSD)
  
  diffMean <- mean(df2$Diff)
  partyDiffMean <- c(partyDiffMean, mean(df2$Diff))
  diffSD <- sqrt(sum((df2$Diff - diffMean)^2)/length(df2$Diff))
  partyDiffSD <- c(partyDiffSD, diffSD)
}

partyStats <- data.frame(num = partyNum, abbr = partyAbbr, 
                         pMean = partyPlusesMean, pSD = partyPlusesSD, 
                         mMean = partyMinusesMean, mSD = partyMinusesSD, 
                         dMean = partyDiffMean, dSD = partyDiffSD)

getStat <- function(nn, attr, kind) {
  if (attr == "plus") {
    if (kind == "mean") {
      return(partyStats$pMean) 
    }
  }
  return(partyStat)
}

plusNorm <- numeric(0)
minusNorm <- numeric(0)
diffNorm <- numeric(0)
for (i in 1:nrow(dfdf)) {
  statLine <- partyStats[partyStats$num == dfdf$ListNo[i],]
  newPP <- (dfdf$Pluses[i] - statLine$pMean)/statLine$pSD
  newMM <- (dfdf$Minuses[i] - statLine$mMean)/statLine$mSD
  newDD <- (dfdf$Diff[i] - statLine$dMean)/statLine$dSD
  plusNorm <- c(plusNorm, newPP)
  minusNorm <- c(minusNorm, newMM)
  diffNorm <- c(diffNorm, newDD)
}

dfdf$PlusNorm <- plusNorm
dfdf$MinusNorm <- minusNorm
dfdf$DiffNorm <- diffNorm


xx <- 1:length(table(dfdf$CandNo))
yy = aggregate(DiffNorm ~ CandNo, data=dfdf, 
                FUN = mean)


plot(x = xx, y = yy$DiffNorm, type="l", col ="red")


#library(ggplot2)
#p<-ggplot(df, aes(x=Izdevumi, y=Votes, fill=overBarrier)) +
#  geom_point(size=1.5, shape=23, colour="#f8766d") + 
#  
#p
#
#ggsave(p, filename = "declarations/corr1.png", dpi = 300, type = "cairo",
#       width = 4, height = 3, units = "in")  

