#library(foreign)
#setwd("c:/home/st/java-eim/da-101/ch/101-ch03-histograms/r/")
#dataset = read.spss("2009_dati.sav", to.data.frame=TRUE)

# http://www.cookbook-r.com/Graphs/Plotting_distributions_(ggplot2)/

require(ggplot2)

xx <- c(1,2,3,4,5,6)
yy <- c(11,12,13,12,14,15)

df <- data.frame(x = xx, y = yy)

ggplot(df,aes(x=x,y=y)) +
#  geom_bar(stat='identity') + 
  geom_histogram(breaks = c(0, 3, 5,7), 
                 stat="identity", 
                 col="black", 
                 fill = "white")

