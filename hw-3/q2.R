
gaussian <- function(x1, x2, t1, t2, sigma){
  return exp( -1 * norm(x1-t1,x2-t2)/sigma)
