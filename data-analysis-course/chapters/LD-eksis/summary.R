setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

df <- read.table(file="iestaajeksaamens_matemaatika_2017.csv", header=TRUE, sep=";")



barplot(sort(df$Procenti, decreasing=TRUE))

