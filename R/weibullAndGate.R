#' The Weibull And Gate Model
#'
#' @param t Numeric vector of input reliability times
#' @param ...
#'
#' @returns An object of class `stanfit` returned by `rstan::sampling`
#' @export


weibull_and_gate <- function(t,...){
  standata <- list(t = t, N = length(t))
  out <- rstan::sampling(
    stanmodels$weibullAndGate,
    data = standata,
    cores = 4,
    iter = 4000,
    ...)
  return(out)
}
