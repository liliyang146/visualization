require(Unicode)
require(plyr)

setwd("/Users/kapsitis/workspace/ddgatve-stat/dzejas-statistika/")


getNiceName <- function(names) {
  vv <- sapply(names, function(name) {
    name <- gsub("\u0100","\\\\={A}",name)
    name <- gsub("\u0101","\\\\={a}",name)
    name <- gsub("\u010C","\\\\v{C}",name)
    name <- gsub("\u010D","\\\\v{c}",name)
    name <- gsub("\u0112","\\\\={E}",name)
    name <- gsub("\u0113","\\\\={e}",name)
    name <- gsub("\u0122","\\\\c{G}",name)
    name <- gsub("\u0123","\\\\v{g}",name)
    name <- gsub("\u012A","\\\\={I}",name)
    name <- gsub("\u012B","\\\\={\\\\i}",name)
    name <- gsub("\u0136","\\\\c{K}",name)
    name <- gsub("\u0137","\\\\c{k}",name)
    name <- gsub("\u013B","\\\\c{L}",name)
    name <- gsub("\u013C","\\\\c{l}",name)
    name <- gsub("\u0145","\\\\c{N}",name)
    name <- gsub("\u0146","\\\\c{n}",name)
    name <- gsub("\u0160","\\\\v{S}",name)
    name <- gsub("\u0161","\\\\v{s}",name)
    name <- gsub("\u016A","\\\\={U}",name)
    name <- gsub("\u016B","\\\\={u}",name)
    name <- gsub("\u017D","\\\\v{Z}",name)
    name <- gsub("\u017E","\\\\v{z}",name)
    
    return(name)
  })
  return(vv)
}

unescapeLatex <- function(str) {
#  str <- gsub(pattern="\\$\\\\backslash\\$=\\\\\\{a\\\\\\}", replacement = "\\\\={a}", x = str)
  str <- gsub(pattern="\\$\\\\backslash\\$([=vc])\\\\\\{([acegklnsuzACEGIKLNSUZ])\\\\\\}", replacement = "\\\\\\1{\\2}", x = str)
  str <- gsub(pattern="\\$\\\\backslash\\$=\\\\\\{\\$\\\\backslash\\$i\\\\\\}", replacement = "\\\\={\\\\i}", x = str)
  str <- gsub(pattern="\\$\\\\backslash\\$(Circle|CIRCLE|RIGHTcircle|LEFTcircle|textperthousand)", replacement="\\\\\\1", x=str)
  return(str)
}

smallLatex <- function(str, size) {
  str <- gsub(pattern = "\\\\begin\\{tabular\\}", 
                 replacement = sprintf("\\\\begingroup\\\\%s\n\\\\begin{tabular}",size),
                 x = str)
  str <- gsub(pattern = "\\\\end\\{tabular\\}", 
                 replacement = "\\\\end{tabular}\n\\\\endgroup",
                 x = str)
  return(str)
}


letterFromUnicode <- function(arg) {
  if (arg == "\u0100") return("A")
  if (arg == "\u010C") return("C")
  if (arg == "\u0112") return("E")
  if (arg == "\u0122") return("G")
  if (arg == "\u012A") return("I")
  if (arg == "\u0136") return("K")
  if (arg == "\u013B") return("L")
  if (arg == "\u0145") return("N")
  if (arg == "\u0160") return("S")
  if (arg == "\u016A") return("U")
  if (arg == "\u017D") return("Z")  
  if (arg == "\u0101") return("a")
  if (arg == "\u010D") return("c")
  if (arg == "\u0113") return("e")
  if (arg == "\u01E7") return("g")
  if (arg == "\u0123") return("g")
  if (arg == "\u012B") return("i")
  if (arg == "\u0137") return("k")
  if (arg == "\u013C") return("l")
  if (arg == "\u0146") return("n")
  if (arg == "\u0161") return("s")
  if (arg == "\u016B") return("u")
  if (arg == "\u017E") return("z")
  return(arg)
}

strFromUnicode <- function(arg) {
  xx <- as.vector(strsplit(arg,"")[[1]])
  yy <- as.vector(sapply(xx, letterFromUnicode))
  return(paste(yy,sep="",collapse=""))
}




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


# 
# mylist <- new.env()
# 
# incr <- function(word) {
#   if (length(word) > 0) {
#     if (word != "") {
#       if (!(word %in% ls(mylist))) {
#         mylist[[word]] <- 1
#       }
#       else {
#         mylist[[word]] <- mylist[[word]] + 1
#       }
#     }
#   }
# }


getTheWords <- function(fName) {
  allLines <- readLines(fName, n = -1, encoding="UTF-8")
  # atlasa tās rindas, kas sākas ar "|" - vertikālo svītru
  poemLines <- allLines[substr(allLines,1,1) == "|"]
  # pārraksta bez pieturzīmēm, liekiem tukšumiem un tikai ar mazajiem burtiem
  normLines <- normalize(poemLines)
  # katru rindu sadala vārdos, atdalot ar tukšumiem
  splitLines <- strsplit(normLines, " ")
  theWords <- unlist(splitLines, recursive=FALSE)
  return(theWords)
}

getTheList <- function(fName) {
  allLines <- readLines(fName, n = -1, encoding="UTF-8")
  thePoemLines <- character(0)
  rr <- list()
  for (i in 1:(length(allLines))) {
    ll <- allLines[i]
    if (grepl("^#",ll)) {
      if (length(thePoemLines > 0)) {
        tll <- table(strsplit(paste0(thePoemLines, collapse=""),"")[[1]])
        myList <- as.list(tll)
        rr[[as.character(current)]] <- myList
      }
      current <- i
      thePoemLines <- character(0)
    } else {
      if (grepl("^\\|",ll)) {
        nll <- normalize(ll)
        # katru rindu sadala vārdos, atdalot ar tukšumiem
        sll <- strsplit(nll, " ")
        thePoemLines <- c(thePoemLines, unlist(sll, recursive=FALSE))
      }
    }
  }
  return(rr)
}


