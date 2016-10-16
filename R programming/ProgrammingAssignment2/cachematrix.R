## makeCacheMatrix(A) - Creates a matrix object which is supported by cachSolve,
## based on the matrix A.

makeCacheMatrix <- function(x = matrix()) {
        s<-NULL # set a default (NULL) value to the solution of 'x'
        set<-function(y){
                x<<-y
                s<<-NULL ## if the matrix is changed, the inverse must be reset.
        }
        get<-function() x
        setsolve<-function(solve) s<<-solve #auxilary function for cacheSolve
        getsolve<-function() s
        list(set = set, get = get,
             setsolve = setsolve,
             getsolve = getsolve)
}


## cacheSolve(A_c) -  Returns the inverse of the matrix A_c, either by solving
## it, or by retrieving the solution from cache if it exists.

cacheSolve <- function(x, ...) {
        ## Returns a matrix that is the inverse of 'x'
        s <- x$getsolve() ## try to retrieve the inverse from cache
        if(!is.null(s)) {
                message("getting cached data")
                return(s)
        }
        data <- x$get() # if the inverse does not exist in cache - solve it
        s <- solve(data, ...)
        x$setsolve(s)
        s
}
