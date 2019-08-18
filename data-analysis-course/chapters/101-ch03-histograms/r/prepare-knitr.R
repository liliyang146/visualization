if (!"knitr" %in% installed.packages()) install.packages("knitr")
if (!"ggplot2" %in% installed.packages()) install.packages("ggplot2")
if (!"lattice" %in% installed.packages()) install.packages("lattice")
if (!"markdown" %in% installed.packages()) install.packages("markdown")

library(knitr)
library(ggplot2)
library(lattice)
library(markdown)

setwd("/home/st/java-eim/da-101/www/age-structure/")

knit("age-histogram1.rmd", "age-histogram1.md")
markdownToHTML("age-histogram1.md", "age-histogram1.html", stylesheet="custom.css") 

knit("age-histogram5.rmd", "age-histogram5.md")
markdownToHTML("age-histogram5.md", "age-histogram5.html", stylesheet="custom.css") 

knit("population-pyramid.rmd", "population-pyramid.md")
markdownToHTML("population-pyramid.md", "population-pyramid.html", stylesheet="custom.css") 
