source('rankbystate.R')

best <- function(statename, outcomename){
  sortedsubset <- rankbystate(statename,outcomename)
  sortedsubset$Hospital.Name[1]
}

