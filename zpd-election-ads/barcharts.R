setwd("/home/kalvis/workspace/ddgatve-stat/zpd-election-ads")

df <- read.table(
  file="declaration-data.csv", 
  sep=",",
  na.strings="NN",
  header=TRUE,
  row.names=NULL,
  fileEncoding="UTF-8")

# Cik reklamu naudas vajag, lai dabutu 1 balsi
df$priceOfVote <- df$Izdevumi/df$Votes

# Cik reklamu naudas vajag, lai dabutu 1 deputatu
df$priceOfMP <- df$Izdevumi/df$Mps

# Nomet uz 0 tas partijas, kas neparsniedz 5% barjeru
df$priceOfMP[which(is.infinite(df$priceOfMP))] <- 0


library(ggplot2)
p<-ggplot(data=df, aes(x=ShortName, y=priceOfVote)) +
  geom_bar(stat="identity") + 
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  theme_minimal() +
  coord_flip()
p

ggsave(p, filename = "declarations/barchart1.png", dpi = 300, type = "cairo",
       width = 4, height = 3, units = "in")
