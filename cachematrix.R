# Write the following functions:
  
# makeCacheMatrix: This function creates a special "matrix" object that can cache its inverse.
# cacheSolve: This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. If the inverse has already been calculated (and the matrix has not changed), then the cachesolve should retrieve the inverse from the cache.
# Computing the inverse of a square matrix can be done with the solve function in R. 
# For example, if X is a square invertible matrix, then solve(X) returns its inverse.
# For this assignment, assume that the matrix supplied is always invertible.

# based off the examples from the assignment
# not sure if I need to change the format of the return values?

makeCacheMatrix <- function(x = matrix()) {
  
  v <- NULL
  
  # creating 4 functions: 
  # set, get, setv, and get v:
  set <- function(y) {
    x <<- y
    v <<- NULL
  }
  get <- function() x
  setv <- function(v) v <<- v
  getv <- function() v
  list(set = set, 
       get = get,
       setv = setv,
       getv = getv)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the verse of 'x'
  v <- x$getv()
  if(!is.null(v)) {
    message("getting cached data")
    return(v)
  }
  data <- x$get()
  v <- solve(data, ...)
  x$setv(v)
  v
}
