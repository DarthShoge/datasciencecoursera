

## creates a invertible cachable square matrix 
makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y){
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) inv <<- inverse
  getinverse <- function() inv
  list(get = get, set = set,
       setinverse = setinverse,
       getinverse = getinverse)
}


## solves for inverse of a invertible square matrix using cached values if available 
cacheSolve <- function(x, ...) {
  inv <- x$getinverse()
  
  if(!is.null(inv)){
    message("retrieving from cache")
    return(inv)
  }
  
  values <- x$get()
  inverse <- solve(values)
  x$setinverse(inverse)
  inverse
}
