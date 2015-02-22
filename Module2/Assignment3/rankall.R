source('rankbystate.R')

collapse<- function(vals){
  matr <- matrix(ncol = 2,nrow = length(vals))
  for(i in 1:length(vals)){
    row <- vals[[i]]
    matr <- rbind(matr,c(row[1],row[2]))
  }
  df <- data.frame(matr[55:108,])
  colnames(df) <- c('hospital','state')
  df
}

rankall <- function(outcome,rank = "best"){
  outcomes <- read.csv('outcome-of-care-measures.csv'
                       ,colClasses = "character")
  statefactors <- as.factor(outcomes$State)
  splitstates <- split(outcomes,statefactors)

  getranked <- function(values){
    state <- values$State[[1]]
    thisstate <- getrankedsubset(outcomes,state,outcome)
    actualrank <- if (rank == "worst"){
      nrow(thisstate)
    }
    else if (rank == 'best'){
      1
    }
    else{
      rank
    }
    hospital <- thisstate$Hospital.Name[actualrank]
    c(hospital,state)
  }
  allvalues <- lapply(splitstates,getranked)
  collapse(allvalues)
}