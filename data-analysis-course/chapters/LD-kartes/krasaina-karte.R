setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# nolasa CSV failu kā data.frame
vpd <- read.table(
  file="Pasvaldibas_pec_VPD_ASCII.csv", 
  sep=",",
  header=TRUE,
  row.names=NULL,  
  fileEncoding="UTF-8")

# saskaita, cik pavisam iedzīvotāju ir katrā novadā (visi statusi)
totalCount <- 
  aggregate(Kopa ~ Novads,
            data = vpd,
            FUN=sum)

# izfiltrē katram novadam nepilsoņu rindiņu
noncitCount <- 
  vpd[vpd$Statuss == "LATVIJAS NEPILSONIS",]


# apvieno vienā tabuliņā visus iedzīvotājus un nepilsoņus vienam novadam
# atbilstošos ierakstus atrod pēc kopīgās kolonnas "Novads"
noncitMain <- merge(totalCount, noncitCount, 
                    by="Novads")

# atrod nepilsoņu īpatsvaru procentos
noncitMain$Frac <- 
  round(100*noncitMain$Kopa.y/noncitMain$Kopa.x,digits=2)

# Ja vēlas, var sakārtot pašvaldības nepilsoņu īpatsvaru dilšanas secībā
#noncitOrdered <- noncitMain[with(noncitMain, order(-Frac, Novads)), ]

# Nokopē data.frame kolonnu kā vektoru, 
# bet nevelk līdzi "factor levels", kas bija data.frame
fixedNovads <- as.vector(noncitMain$Novads)
# Atbrīvojas no diakritiskajām zīmītēm: Č, Š, Ž
fixedNovads[grepl("ADA.U NOVADS",fixedNovads)] <- "ADAZU NOVADS"
fixedNovads[grepl("IK.KILES NOVADS",fixedNovads)] <- "IKSKILES NOVADS"
fixedNovads[grepl("LIMBA.U NOVADS",fixedNovads)] <- "LIMBAZU NOVADS"
fixedNovads[grepl("NAUK.ENU NOVADS",fixedNovads)] <- "NAUKSENU NOVADS"
fixedNovads[grepl("ROPA.U NOVADS",fixedNovads)] <- "ROPAZU NOVADS"

# Izveido attīrītu data.frame, kur ir tikai 
# novadu nosaukumi (bez diakritiskajām zīmītēm) un nepilsoņu procenti
noncitFrame <- data.frame(loc=fixedNovads, per = noncitMain$Frac)


# dazhas bibliotēkas, lai strādātu ar SHP failiem
library(rgeos)
require(maptools)
require(sp)
# lai ērtāk sadalīt vektoru vairākos intervālos (mūsu gadījumā 11 intervāli)
require(classInt)
require(RColorBrewer)

novFrame <- read.table(
  file="lv-municipalities.csv", 
  sep=",",
  header=TRUE,
  row.names=NULL,  
  fileEncoding="UTF-8", colClasses=c("character","character","character","character"))


# maina darba direktoriju, lai lasītu SHP failus
setwd(paste0(getwd(),"/shape-data"))
mapSHP <-  readShapePoly(fn = "Export_Output")
mapaDat <- as.data.frame(mapSHP)

panel.str <- deparse(panel.polygonsplot, width=500)
panel.str <- sub("grid.polygon\\((.*)\\)",
                 "grid.polygon(\\1, name=paste('ID', slot(pls\\[\\[i\\]\\], 'ID'\\), sep=':'))",
                 panel.str)
panel.polygonNames <- eval(parse(text=panel.str),
                           envir=environment(panel.polygonsplot))

bigdata <- merge(mapaDat, novFrame, sort=FALSE, 
                 by.x="ATVK", by.y="Classifier")

noncitFrame$loc <- factor(noncitFrame$loc)

biggerdata <- merge(bigdata,noncitFrame, sort=FALSE, 
                    by.x="UpperName", by.y="loc")

n <- 11
# workaround - stretch the interval a little bit
theVector <- c(min(biggerdata$per)*0.999,
               as.vector(biggerdata$per),max(biggerdata$per)*1.001)
int <- classIntervals(theVector, n, style='jenks')
pal <- rev(brewer.pal(n, "Spectral"))

Total <- biggerdata$per
mapSHP@data <- cbind(mapSHP@data, Total)


# Maina darba direktoriju atpakaļ, lai saglabātu attēlu
setwd(paste0(getwd(),"/.."))
p <- spplot(mapSHP["Total"], panel=panel.polygonNames,
            col.regions=pal, at=int$brks)
png("krasaina-karte-2018-01-01.png", width=600, height=350)
p
dev.off()
p


