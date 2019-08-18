setwd("/home/st/java-eim/da-101/ch/101-ch02-data-tables/r/")

acl <- read.table(
  file="AustinCityLimits.csv", 
  header=TRUE,
  sep=",",quote="\"",
  fileEncoding="UTF-8")



# Create tables of marginal distributions
genre <- table(acl$Genre)
genre
gender <- table(acl$Gender)
gender

grammy <- table(acl$Grammy)


# Create contingency table 
twoway <- table (acl$Genre,acl$Grammy)
twoway

# Visualize the counts
barplot(twoway, legend=T, beside=T)

# Calculate P(A): the probability of each genre being played
prop.table(genre)

# Calculate P(A|B): the probability of each genre being played, given the artist’s gender
prop.table(twoway,1)


barplot(prop.table(twoway,1), beside=T, legend=T)

nrow(acl[acl$Facebook.100k==1 & acl$Age >= 20 & acl$Age < 30,])/
  nrow(acl[acl$Age >= 20 & acl$Age < 30,])


# popularity by age group
popular <- table(acl$Age.Group, acl$Facebook.100k)
round(prop.table(popular,1),digits=3)


grades <- 
  matrix(c(5,8,11,9,10,10,5,9,9,9,4,4,10,7,4,2,6,4,2,0),
         nrow=4, dimnames=list(c("FR","SO","JU","SE"),
                               c("A","B","C","D","F")))



