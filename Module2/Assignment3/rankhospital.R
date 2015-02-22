source('rankbystate.R')


rankhospital <- function(state,outcome,rank){
  sortedsubset <- rankbystate(state,outcome)
  actualrank <- if (rank == "worst"){
    nrow(sortedsubset)
  }
  else{
    rank
  }

  sortedsubset$Hospital.Name[actualrank]
}