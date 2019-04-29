setwd("/home/kalvis/workspace/ddgatve-stat/zpd-election-ads")

df <- read.table(
  file="declaration-data.csv", 
  sep=",",
  na.strings="NN",
  header=TRUE,
  row.names=NULL,
  fileEncoding="UTF-8")


library(ggplot2)
p<-ggplot(df, aes(x=Izdevumi, y=Votes)) +
  geom_point(size=1.5, shape=23) + 
  geom_text(label=df$ShortName, hjust=-0.3, vjust=0.5, color="black", size=2)+
  theme_minimal() +
  theme(legend.position = "none") + 
  scale_y_continuous(name ="Balsis (1K=1000gab.)", breaks = 50000*(0:3), 
                     labels=c("0K", "50K", "100K", "150K"), 
                     limits = c(0, 175000))+
  scale_x_continuous(name ="Izdevumi EUR (1K=1000EUR)", breaks = 200000*(0:5), 
                   labels=c("0K", "20K", "40K", "60K", "80K", "100K"), 
                   limits = c(0, 1150000))
p

ggsave(p, filename = "declarations/corr1.png", dpi = 300, type = "cairo",
       width = 4, height = 3, units = "in")

