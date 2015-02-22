library(XML)
library(bitops)
library(RCurl)
library(data.table)
library(rJava)
library(xlsx)
setwd("D:\\Documents\\Coursera\\DataScience\\Module3\\Quiz1")

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
fileDest <- "./data/property.csv"

if(!file.exists(fileDest)){
  download.file(fileUrl , destfile = fileDest)
}

propdf <- read.csv(file = fileDest)
expHsesdf <- propdf[propdf$VAL == 24,]
expHsesdf <- expHsesdf[!is.na(expHsesdf$VAL),]

####################END OF Q1 ##########################################

fileurl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx" 
filedest2 <- "./data/dat.xlsx"

if(!file.exists(filedest2)){
  download.file(fileurl2,destfile = filedest2)
}

dat <- read.xlsx(filedest2,sheetIndex = 1,header = T)
dat <- dat[18:23,7:15]
sumofDat <-  sum(dat$Zip*dat$Ext,na.rm=T) 
####################END OF Q3 ##########################################

fileurl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
xData <- getURL(fileurl3, ssl.verifypeer = FALSE)
doc <- xmlTreeParse(xData,useInternalNodes = TRUE)
rootnode <- xmlRoot(doc)
xmlres <- a <- xpathApply(rootnode,"//row[zipcode ='21231']",xmlValue)

####################END OF Q4 ##########################################
fileurl4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx" 
filedest4  <- "./data/DT.xlsx"

if(!file.exists(filedest4)){
  download.file(fileurl4,destfile = filedest4)
}

DT <- fread(filedest4)