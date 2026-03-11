#' The Weibull Or Gate Model
#'
#' @param t Numeric vector of input reliability times
#' @param ...
#'
#' @returns An object of class `stanfit` returned by `rstan::sampling`
#' @export


weibull_or_gate <- function(t,...){
  standata <- list(t = t, N = length(t))
  out <- rstan::sampling(
    stanmodels$weibullOrGate,
    data = standata,
    cores = 4,
    ...)
  return(out)
}
