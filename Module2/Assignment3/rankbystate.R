throweif <- function(predicate , message){
  if(predicate) stop(message)
}

getcolindexfromName <- function(ocname){
  if(ocname == "heart attack" )
    11
  else if (ocname == "heart failure")
    17
  else if (ocname == "pneumonia")
    23
  else
    throweif(TRUE,"invalid outcome");
}



rankbystate <- function(statename, outcomename){
  
  outcomes <- read.csv('outcome-of-care-measures.csv'
                       ,colClasses = "character")
  
  outcomes[outcomes$State == statename,]
  getrankedsubset(outcomes,statename,outcomename)
}

getrankedsubset <- function(outcomes,statename,outcomename){
  statesubset <- outcomes[outcomes$State == statename,]
  throweif(nrow(statesubset) == 0,"invalid state");
  indxtoconsider <- getcolindexfromName(outcomename)
  statesubset[,indxtoconsider] <- as.numeric(statesubset[,indxtoconsider])
  statesubset <- statesubset[complete.cases(statesubset[,indxtoconsider]),]
  sortedsubset <- statesubset[order( statesubset[,indxtoconsider],
                                     rank(statesubset$Hospital.Name)),]
  sortedsubset
}