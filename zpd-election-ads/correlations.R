setwd("/home/kalvis/workspace/ddgatve-stat/zpd-election-ads")

df <- read.table(
  file="declaration-data.csv", 
  sep=",",
  na.strings="NN",
  header=TRUE,
  row.names=NULL,
  fileEncoding="UTF-8")

df$overBarrier <- (df$Mps > 0)

# Videjaas veertiibas un standartnovirzes
meanX <- mean(df$Izdevumi[1:7])
meanY <- mean(df$Votes[1:7])
sdX <- sd(df$Izdevumi[1:7])
sdY <- sd(df$Votes[1:7])
# Korelacijas koeficients
r <- cor(df$Izdevumi[1:7], df$Votes[1:7])

# Taisnes virziena koeficients
B1 <- r * (sdY)/(sdX)
# Kur taisne krusto Y asi
B0 <- meanY - B1 * meanX


library(ggplot2)
p<-ggplot(df, aes(x=Izdevumi, y=Votes, fill=overBarrier)) +
  geom_point(size=1.5, shape=23, colour="#f8766d") + 
  geom_text(label=df$ShortName, hjust=-0.3, vjust=0.5, color="black", size=2)+
  geom_hline(yintercept=42196, linetype="dashed", color = "darkred", size=0.3)+
  annotate("text", x=100000, y=46000, size=1.6,
           colour="darkred", label= "5% barjera (42196 balsis)") +
  geom_abline(intercept = B0, slope = B1, color="darkgreen", 
              linetype="solid", size=0.3)+
  theme_minimal() +
  theme(legend.position = "none", 
        axis.text.x = element_text(face="plain", color="#0066CC", 
                                   size=7),
        axis.text.y = element_text(face="plain", color="#0066CC", 
                                   size=7),
        panel.grid.major = 
          element_line(size = 0.1, colour="darkgray", linetype="solid"),
        panel.grid.minor = 
          element_line(size = 0.1, colour="darkgray", linetype="dotted")) + 
  scale_y_continuous(name ="Balsis (1K=1000gab.)", breaks = 50000*(0:3), 
                     labels=c("0K", "50K", "100K", "150K"), 
                     limits = c(0, 175000))+
  scale_x_continuous(name ="Izdevumi EUR (1K=1000EUR)", breaks = 200000*(0:5), 
                   labels=c("0K", "200K", "400K", "600K", "800K", "1000K"), 
                   limits = c(0, 1150000))+
  scale_fill_manual(values = c("white", "#f8766d"))
p

ggsave(p, filename = "declarations/corr1.png", dpi = 300, type = "cairo",
       width = 4, height = 3, units = "in")




meanSlope <- sum(df$Votes)/sum(df$Izdevumi)
x0 <- (1/meanSlope)*42196


library(ggplot2)
p<-ggplot(df, aes(x=Izdevumi, y=Votes, fill=overBarrier)) +
  geom_point(size=1.5, shape=23, colour="#f8766d") + 
  geom_text(label=df$ShortName, hjust=-0.3, vjust=0.5, color="black", size=2)+
  geom_hline(yintercept=42196, linetype="dashed", color = "darkred", size=0.3)+
  geom_vline(xintercept=x0, linetype="dashed", color = "darkred", size=0.3)+
  geom_abline(intercept = 0, slope = meanSlope, color="darkgreen", 
              linetype="solid", size=0.3)+
  annotate("text", x=100000, y=46000, size=1.6,
           colour="darkred", label= "5% barjera (42196 balsis)") +
  theme_minimal() +
  theme(legend.position = "none", 
        axis.text.x = element_text(face="plain", color="#0066CC", 
                                   size=7),
        axis.text.y = element_text(face="plain", color="#0066CC", 
                                   size=7),
        panel.grid.major = 
          element_line(size = 0.1, colour="darkgray", linetype="solid"),
        panel.grid.minor = 
          element_line(size = 0.1, colour="darkgray", linetype="dotted")) + 
  scale_y_continuous(name ="Balsis (1K=1000gab.)", breaks = 50000*(0:3), 
                     labels=c("0K", "50K", "100K", "150K"), 
                     limits = c(0, 175000))+
  scale_x_continuous(name ="Izdevumi EUR (1K=1000EUR)", breaks = 200000*(0:5), 
                     labels=c("0K", "200K", "400K", "600K", "800K", "1000K"), 
                     limits = c(0, 1150000))+
  scale_fill_manual(values = c("white", "#f8766d"))
p

ggsave(p, filename = "declarations/corr2.png", dpi = 300, type = "cairo",
       width = 4, height = 3, units = "in")
