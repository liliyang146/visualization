setwd("/home/st/java-eim/java-eim-parent/src/site/resources/reports/AB/")


if (!"knitr" %in% installed.packages()) install.packages("knitr")
if (!"markdown" %in% installed.packages()) install.packages("markdown")

library(knitr)
library(markdown)


files <- c("parts-of-speech")
for (file in files) {
    knit(sprintf("%s.rmd",file))
    system(sprintf("pandoc -o %s.docx %s.md", 
                   file, file))
  
}

