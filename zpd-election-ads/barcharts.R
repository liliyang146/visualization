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

#df$bcolor <- levels(droplevels(df$bcolor))

library(ggplot2)
p<-ggplot(data=df, aes(x=reorder(ShortName, priceOfVote), y=priceOfVote, width=0.7, fill="pink")) +
  geom_bar(stat="identity") + 
  theme_minimal() +
  theme(legend.position = "none",
        axis.text.x = element_text(face="plain", color="#0066CC", 
                                   size=10),
        axis.text.y = element_text(face="plain", color="#0066CC", 
                                   size=10))+
  scale_x_discrete(name ="Partija")+
  scale_y_continuous(name ="Izdevumi (EUR) par 1 balsi")+
#  scale_fill_manual(values = c("red", "green", "blue","red", "green", "blue","red", "green", "blue","red"))+
  coord_flip()
p

ggsave(p, filename = "declarations/barchart1.png", dpi = 300, type = "cairo",
       width = 4, height = 3, units = "in")


df2 <- df[df$Mps>0,]

p<-ggplot(data=df2, aes(x=reorder(ShortName, priceOfMP), y=priceOfMP, width=0.7, fill="pink")) +
  geom_bar(stat="identity") + 
  theme_minimal() +
  theme(legend.position = "none",
        axis.text.x = element_text(face="plain", color="#0066CC", 
                                   size=10),
        axis.text.y = element_text(face="plain", color="#0066CC", 
                                   size=10))+
  scale_x_discrete(name ="Partija")+
  scale_y_continuous(name ="Izdevumi (EUR) par 1 deput\u0101ta vietu")+
  #  scale_fill_manual(values = c("red", "green", "blue","red", "green", "blue","red", "green", "blue","red"))+
  coord_flip()
p

ggsave(p, filename = "declarations/barchart2.png", dpi = 300, type = "cairo",
       width = 4, height = 3, units = "in")



