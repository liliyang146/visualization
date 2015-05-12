## These functions are called to complement math olympiad data tables

setwd("/home/st/ddgatve-stat/reports/")
## Given the firstname, return the gender of the person (Male/Female)
getGender <- function(name) {
  sex <- "Other"
  # extract first name (if there are multiple names)
  firstName <- sub("(^[^ ]+)( ([^ ]+))?", "\\1",name) 
  if (firstName == "Adam" |
        firstName == "Alexander" |
        firstName == "Aliaksandr" |
        firstName == "Andrey" |
        firstName == "Anton" |
        firstName == "Artem" |
        firstName == "Bruno" |
        firstName == "Čiro" |
        firstName == "Dmitry" |
        firstName == "Dmytro" |
        firstName == "Hugo" |
        firstName == "Ivo" |
        firstName == "Nikita" | 
        firstName == "Ņikita" |
        firstName == "Nikolay" |
        firstName =="Oleksandr" |
        firstName == "Oto" |        
        firstName == "Raivo" |
        firstName == "Uko" |
        firstName == "Vladimir") {
    sex <- "Male"
  } else if (firstName == "Nelli" | 
               firstName == "Fani" |
               firstName == "Romi") {
    sex <- "Female"
  } else if (length(grep("[sš]$", firstName)) > 0) {
    sex <- "Male"
  } else if (length(grep("[ae]$", firstName)) > 0) {
    sex <- "Female"
  } else {
    nch <- nchar(firstName)
    lst <- substr(firstName,nch,nch)
    if (lst == "š") {
      sex <- "Male"
    } else if (as.u_char(utf8ToInt(lst)) == "U+009A") {
      sex <- "Male"
    } else {      
      print(paste0("***** Unidentified name:***** ",name))
      sex <- "Male"
    }
  }
  return(sex)
}


getSchoolLanguageList <- function() {
  filenames <- c("dalibnieki-pa-pilsetam-riga.csv",
                 "dalibnieki-pa-pilsetam-daugavpils.csv",
                 "dalibnieki-pa-pilsetam-liepaja.csv")
  schoolLanguageList = ldply(filenames, function(filename) {    
    dum = read.table(
      file=filename, 
      sep=",",
      header=TRUE,
      row.names=NULL,  
      fileEncoding="UTF-8")
    return(dum)
  })
  return(schoolLanguageList)
}

# %%%% Voluntāri izvēlētās valodas
# %% Ozolnieku vidusskola - L
# %% Jūrmalas pilsētas Kauguru vidusskola - K
# %% Kalnciema pagasta vidusskola - L
# %% Krāslavas Valsts ģimnāzija - L
# %% Kuldīgas Centra vidusskola - L
# %% Rīgas 51. vidusskola - K
# %% Rīgas 61. vidusskola - K
# %% Rīgas 86.vidusskola - K
# %% Rīgas 89. vidusskola - K
# %% Rīgas Sergeja Žoltoka vidusskola - K
# %% Rīgas vakara ģimnāzija - L
# %% Rīgas Valsts vācu ģimnāzija - L
# %% Sunākstes pamatskola - L
# %% Vaiņodes vidusskola - L
# %% Asūnes pamatskola - L
# %% Preiļu Valsts ģimnāzija - L
# %% Rēzeknes Valsts ģimnāzija - L
# %% Rēzeknes 5.vidusskola - L
# %% Priekules vidusskola - L
# %% Skrundas vidusskola - L


getSchoolsForLanguage <- function(lang) {
  
  schoolLanguageList <- getSchoolLanguageList()
  skolas <- names(table(schoolLanguageList$Skola))
  
  result <- character(0)
  for (skola in skolas) {
    subThis <- schoolLanguageList[schoolLanguageList$Skola == skola
                                  & schoolLanguageList$Valoda == lang,]
    subOther <- schoolLanguageList[schoolLanguageList$Skola == skola
                                   & schoolLanguageList$Valoda != lang,]
    numThis <- nrow(subThis)
    numOther <- nrow(subOther)
    #  print(sprintf("%s: %d %d", skola,numLV, numRU))
    if (numThis > 0 & numOther == 0) {
      result <- c(result,skola)
    } else if (numThis > 0 & numOther > 0) {
      print(paste0("***************** WARNING: Multi-language school: ",skola ))
    } 
  }
  return(result)
}

schoolsLanguages <- read.table(
  file="schools-languages.csv", 
  sep=",",
  header=TRUE,
  row.names=NULL,  
  fileEncoding="UTF-8")


# Given school and teacher strings, try to deduce participant's language
getLang <- function(school, teacher) {
  spacedSchool <- gsub("\\.", ". ", school)
  allSchools <- as.vector(schoolsLanguages$School)
  currSchoolLocations <- which(school == allSchools | spacedSchool == allSchools)
  if (length(currSchoolLocations) == 0) {
    # "school" is not found in the schools-languages.csv file
    # Return "L" - global default
    print(sprintf("WARNING - Missing school: %s",school))
    return("L")
  } else if (length(currSchoolLocations) == 1) {
    # There is exactly one "school" entry; return its language
    lang <- schoolsLanguages[currSchoolLocations[1],"Language"]
    return(lang)
  } else {
    # "school" is probably multi-lingual. 
    # Find a matching teacher, or return school's default (teacher=*).  
    defaultLang <- ""
    lang <- ""
    for (i in currSchoolLocations) {
      tt <- as.character(schoolsLanguages[i,"Teacher"])
      if (tt == "*") {
        defaultLang <- schoolsLanguages[i,"Language"]
      } else if (tt != "*" & grepl(tt,teacher)) {
        lang <- schoolsLanguages[i,"Language"]
      } 
    }    
    if (lang == "") {
      return(defaultLang)
    } else {
      return(lang)
    }    
  }
}

schoolsTest <- read.table(
  file="schools-test.csv", 
  sep=",",
  header=TRUE,
  row.names=NULL,  
  fileEncoding="UTF-8")


for (ii in 1:nrow(schoolsTest)) {
  arg1 <- as.character(schoolsTest[ii,1])
  arg2 <- as.character(schoolsTest[ii,2])
  lang <- getLang(arg1,arg2)
  print(sprintf("'%s' '%s' '%s'",arg1, arg2, lang))
}



getLanguage <- function(school, teacher, skolasLV, skolasRU) {  
  
  spacedSchool <- gsub("\\.", ". ", school)
  #   if (grepl("\x0100da\x017Eu vidusskola",
  #             school,ignore.case = TRUE)) {
  #     if (grepl("Dagnija Ķikāne",teacher)) {
  #       return("K")
  #     } else {
  #       return("L")
  #     }
  #   } else 
  
  if (grepl("Baložu vidusskola",
            school,ignore.case = TRUE)) { 
    if (grepl("Margarita Ižika",teacher)) {
      return("K")
    } else {
      return("L")
    }
  } else if (grepl("Liepājas pilsetas 8\\. ?vidusskola",
                   school,ignore.case = TRUE) |
               grepl("Liepājas 8\\. ?vidusskola",
                     school,ignore.case = TRUE)) {
    if (grepl("Elga Jēkabsone",teacher)) {
      return("L")
    } else {
      return("K")
    }
    #   } else if (grepl("E(\\.|mīla) ?Dārziņa mūzikas vidusskola",
    #                    school,ignore.case = TRUE)) {
    #     if (grepl("Laila Kampe",teacher)) {
    #       return("K")
    #     } else {
    #       return("L")    
    #     }
  } else if (grepl("Garkalnes Mākslu un vispārizglītojošā vidusskola",
                   school,ignore.case = TRUE)) {
    if (grepl("Inese Muižniece",teacher)) {
      return("K")
    } else if (grepl("Ņina Kārkliņa",teacher)) {
      return("K")
    } else {
      return("L")
    }
  } else if (grepl("Jelgavas 4\\. ?vidusskola",
                   school,ignore.case = TRUE)) {
    return("L")    
  } else if (grepl("Riga International meridian School",
                   school,ignore.case = TRUE)) {
    return("K")
    #   } else if (grepl("Rīgas 33\\. ?vidusskola",
    #                    school,ignore.case = TRUE)) {
    #     if (grepl("Kristīne Isaka",teacher)) {
    #       return("K")
    #     } else if (grepl("Nataļja Kaļiņikova",teacher)) {
    #       return("K")
    #     } else {
    #       return("K")
    #     }
  } else if (grepl("Ventspils 6\\. ?vidusskola",
                   school,ignore.case = TRUE)) {
    if (grepl("Tereza Rediko",teacher)) {
      return("K")
    } else if (grepl("Vineta Trokša",teacher)) {
      return("L")
    } else {
      return("K")
    }
  } else if (school %in% skolasRU | 
               spacedSchool %in% skolasRU) {
    return("K")
  } else if (school %in% skolasLV | 
               spacedSchool %in% skolasLV) {
    return("L")
  } else {
    print(sprintf("Missing school language: %s",school))
    return("L")
  }
}



