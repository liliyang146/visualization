setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
df <- read.table(file="matematikas-centralizetais.csv", 
                 sep=",", header=TRUE)
df$Part23 = (0.50*df$Part2 + (0.1875)*df$Part3)/(0.50 + 0.1875)


# Cik kāda veida gada atzīmes
table(df$Annual)
# Cik pavisam skolēnu
nrow(df)
# Cik skolēnu katrā klasē
table(df$Class)


## 3.solis: Pearson correlation
res <- cor.test(df$Part1, df$Part23, method = "pearson")
res

## 4.solis: Various data summaries
mean(df$Total)
# Vidējā atzīme klasē Nr.4
mean(df$Annual[df$Class=='4'])
# Vidējie procenti par testa 3.daļu klasē Nr.1
mean(df$Part3[df$Class=='1'])
# Dažādi vidējie pa klasēm
aggregate(cbind(Annual,Total) ~ Class, data = df, mean)
aggregate(cbind(Annual,Total) ~ Class, data = df, max)
