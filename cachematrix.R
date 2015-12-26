# func 1
makeCacheMatrix <- function(X = matrix()) {
inverse <- NULL
set <- function(Y){
	X <<- Y
	inverse <<- NULL
	}
get <- function() X
setinverse <- function(Inverse) inverse <<- Inverse
getinverse <- function() inverse
list(set=set,get=get,setinverse=setinverse,getinverse=getinverse)
}
#func 2
cacheSolve <- function(X, ...) 
{
if(require("corpcor")){
	print("corpcor package is there")
	} else {
		print("if not trying to install corpcor")
		install.packages("corpcor")
		if(require(corpcor)){
			print("corpcor installed and loaded")
			} else {
			stop("not able to install corpcor package")
			}
		}
inverse <- X$getinverse()
if(!is.null(inverse))
  message("matrix is in memory so take it from memory")
	return(inverse)
	}
message("inverse is not in memory so the inverse is to be computed")
data <- X$get()
inverse <- pseudoinverse(data, ...)
X$setinverse(inverse)
inverse
}
# example
b <- matrix(rpois(25,2), nrow = 5)
cd <- makeCacheMatrix(b)
cd$get()
cacheSolve(cd)
cacheSolve(cd)
invb <- cacheSolve(cd)
