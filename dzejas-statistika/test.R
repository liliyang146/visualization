# Ja nav pievienota pakotne "stringr", uzstāda un pievieno
# Mums to vajadzēs - sk. funkciju "str_trim" zemāk
if (!"stringr" %in% installed.packages()) install.packages("stringr")
library(stringr)

normalize <- function(lines) {
  # Novāc pieturzīmes
  noPunctuation <- gsub("[0-9]|[:;\\|\\.\\?!,]|---|\"|\\(|\\)|_|-"," ",lines)
  # Ja ir vairāki tukšumi pēc kārtas, aizstāj tos ar vienu tukšumu
  normSpace <- gsub(" +"," ",noPunctuation)
  # Aizstāj lielos latviešu burtus ar mazajiem (ĀČĒ...->āčē)
  linesAA <- gsub("\u0100","\u0101",normSpace)
  linesCH <- gsub("\u010c","\u010d",linesAA)
  linesEE <- gsub("\u0112","\u0113",linesCH)
  linesGJ <- gsub("\u0122","\u01e7",linesEE)
  linesII <- gsub("\u012a","\u012b",linesGJ)
  linesKJ <- gsub("\u0136","\u0137",linesII)
  linesLJ <- gsub("\u013b","\u013c",linesKJ)
  linesNJ <- gsub("\u0145","\u0146",linesLJ)
  linesSH <- gsub("\u0160","\u0161",linesNJ)
  linesUU <- gsub("\u016a","\u016b",linesSH)
  linesZH <- gsub("\u017d","\u017e",linesUU)
  # Pārtaisa par mazajiem burtiem visus citus burtus
  lowerCase <- tolower(linesZH)
  # Ja rindas sākumā vai beigās ir tukšums, novāc nost
  trimmedLines <- str_trim(lowerCase)
  return(trimmedLines)
}



mylist <- new.env()

incr <- function(word) {
  if (length(word) > 0) {
    if (word != "") {
      if (!(word %in% ls(mylist))) {
        mylist[[word]] <- 1
      }
      else {
        mylist[[word]] <- mylist[[word]] + 1
      }
    }
  }
}




setwd("/home/st/java-eim/java-eim-parent/src/site/resources/reports/AB/")
allLines <- readLines("../dzeguzlaiks.rmd", n = -1, encoding="UTF-8")
#allLines <- readLines("tnzv.rmd", n = -1, encoding="UTF-8")
# atlasa tās rindas, kas sākas ar "|" - vertikālo svītru
poemLines <- allLines[substr(allLines,1,1) == "|"]
# pārraksta bez pieturzīmēm, liekiem tukšumiem un tikai ar mazajiem burtiem
normLines <- normalize(poemLines)
# katru rindu sadala vārdos, atdalot ar tukšumiem
splitLines <- strsplit(normLines, " ")

theWords <- unlist(splitLines, recursive=FALSE)

wTable <- table(theWords)
keys <- names(wTable)
vals <- sapply(keys, function(x) {wTable[[x]]})


df <- data.frame("keys" = keys, "vals" = vals, stringsAsFactors=TRUE)

dfs <- df[with(df, order(-vals,keys)), ]
row.names(dfs) <- NULL








