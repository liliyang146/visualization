if (!"png" %in% installed.packages()) install.packages("png")
library(png)
setwd("/home/st/java-eim/dataproc-101/Chapters/statistics-intro/Source-Material/")

ima <- readPNG("Latvia_blank_contour.png")
counts <- c(NA, NA, NA, NA, NA, 2.00, 1.88, 2.2)

png("latvia-population-estimates.png", width=600, height=450)
b <- barplot(counts, main="", horiz=TRUE,
        axes=FALSE,
        col=c("black", "black", 
              "black", "black", "black", 
              "darkred", "darkgreen", "deepskyblue4"), 
               ylim=c(0,15), xlim=c(0,3), 
        offset=c(0.3))
legend("bottomleft", 
       c("Iedz\u012Bvot\u0101ju re\u01E7istrs", "Faktiski saskait\u012Btie", "Kori\u01E7\u0113ti tautskaites dati"), 
       col=c("deepskyblue4", "darkgreen", "darkred"), lwd=10);

text(x=1.7,y=b[c(6,7,8)]-0.75,labels=c("2,067,887","1,880,000","2,236,910"),cex=1.25,pos=3,col="white") 
lim <- par()
rasterImage(ima, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4])
dev.off()
