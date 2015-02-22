
ws <- "D:\\Documents\\Coursera\\DataScience\\Module3\\Quiz2"
setwd(ws)
downloaddest <- "./downloads"

download.read <- function(link, filename, postfunc = NULL){
  fullfilename <- paste(downloaddest, "/", filename,
                        sep = "")
  if(!file.exists(fullfilename))
    download.file(link,destfile = fullfilename)
  
  if(!is.null(postfunc)){
    return(postfunc(fullfilename))
  }
  else{ 
    return(NULL)
  }
}


question1 <- function(){
  library(httr)
  library(httpuv)
  
  oauth_endpoints("github")
  
  myapp <- oauth_app(appname = "datasciencecoursera"
                     ,secret = "c8f42311398805b8aefdfaeb0aff1e7dfc2be89e"
                     ,key = "5c4c7f339502afef6969")
  
  github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
  
  oauth_endpoints("github")
  
  myapp <- oauth_app(appname = "datasciencecoursera"
                     ,secret = "c8f42311398805b8aefdfaeb0aff1e7dfc2be89e"
                     ,key = "5c4c7f339502afef6969")
  
  github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
qu
  req <- GET("https://api.github.com/users/jtleek/repos")
  stop_for_status(req)
  a <- content(req)
}

question2 <- function(){
  library(sqldf)
  link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
  fname <- "ss06pid.csv"
  
  acs <- download.read(link,fname,
                       function(x) read.csv(file = x))
  sqldf("select pwgtp1 from acs where AGEP < 50")
}

question3 <- function(){
  library(sqldf)
  link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
  fname <- "ss06pid.csv"
  
  acs <- download.read(link,fname,
                       function(x) read.csv(file = x))
  sqldf("select distinct AGEP from acs")
}

question4 <- function(){
  con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
  html <- readLines(con)
  nchar(html[c(10,20,30,100)])
}

question5 <- function(){
  link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
  fname <- "forFile.for"
  ff <-download.read(link,fname, 
                     function(x) read.fwf(x, widths=c(12, 7,4, 9,4, 9,4, 9,4)
                                          ,skip = 4))
  sum(ff[,4])
}