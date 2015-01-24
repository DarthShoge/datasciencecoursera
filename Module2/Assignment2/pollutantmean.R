pollutantmean <- function(directory, pollutant, id= 1:332){
  actualFileName <- function(index, directory){
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
    paste(directory,"\\",cleanIndex,".csv",sep = "", collapse = NULL)
  }
  
  outVector <- vector(mode="numeric", length =0)
  
  for(i in id){
    df_current <- read.csv(actualFileName(i,directory)) 
    outVector <- c(outVector, df_current[[pollutant]])
  }
  
  mean(x = outVector,na.rm = TRUE)
}
