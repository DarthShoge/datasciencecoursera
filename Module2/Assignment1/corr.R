loadmonitor <- function(index,directory){
  cInd <- toString(index)
  cleanIndex <- if (index >=100){
    cInd
  }
  else if(index < 10){
    paste("00",cInd,sep = "", collapse = NULL)
  }
  else{
    paste("0",cInd,sep = "", collapse = NULL)
  }
  file <- paste(directory,"\\",cleanIndex,".csv",sep = "", collapse = NULL)
  read.csv(file)
}


complete <- function(directory, id = 1:332){
  outnobvec <- vector(mode = "numeric", length =0)
  for(i in id){
    df_current <- loadmonitor(i,directory)
    
    outnobvec <- c(outnobvec,nrow(na.omit(df_current)))
  }
  res_df <- data.frame(id = id,nobs = outnobvec)
  res_df
}

corr <- function(directory, threshold = 0){
  
  comcases <- complete(directory)
  corvec <- vector(mode="numeric",length = 0)
  comcases <- subset(comcases, nobs > threshold)
  for(i in comcases$id){
    cur_df <- loadmonitor(i,directory)
    correlation <- cor(cur_df$sulfate, cur_df$nitrate, use ="pairwise.complete.obs" )
    corvec <- c(corvec, correlation)
  }
  corvec[complete.cases(corvec)]
}