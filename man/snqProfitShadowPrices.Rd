\name{snqProfitShadowPrices}
\alias{snqProfitShadowPrices}
\title{Shadow Prices of a SNQ Profit function}

\description{
   Calculates the shadow prices of a Symmetric Normalized Quadratic (SNQ)
   profit function.
}

\usage{
   snqProfitShadowPrices( priceNames, fixNames, estResult = NULL,
   data = estResult$data, weights = estResult$weights,
   scalingFactors = estResult$scalingFactors,
   coef = estResult$coef, form = estResult$form )
}

\arguments{
   \item{priceNames}{a vector of strings containing the names of netput prices.}
   \item{fixNames}{an optional vector of strings containing the names of the
      quantities of (quasi-)fix inputs.}
   \item{estResult}{object returned by \code{\link{snqProfitEst}}.}
   \item{data}{a data frame containing the data.}
   \item{weights}{vector of weights of prices used for normalization.}
   \item{scalingFactors}{factors to scale prices (see details).}
   \item{coef}{a list containing the coefficients (at least delta and gamma).}
   \item{form}{the functional form to be estimated (see details).}
}

\seealso{
   \code{\link{snqProfitEst}}, \code{\link{snqProfitCalc}} and
   \code{\link{snqProfitEla}}.
}

\author{Arne Henningsen}

\examples{
if( requireNamespace( 'micEcon', quietly = TRUE ) ) {
   data( germanFarms, package = "micEcon" )
   germanFarms$qOutput   <- germanFarms$vOutput   / germanFarms$pOutput
   germanFarms$qVarInput <- -germanFarms$vVarInput / germanFarms$pVarInput
   germanFarms$qLabor    <- -germanFarms$qLabor
   germanFarms$time      <- c( 0:19 )
   priceNames <- c( "pOutput", "pVarInput", "pLabor" )
   quantNames <- c( "qOutput", "qVarInput", "qLabor" )
   fixNames <- c( "land", "time" )

   estResult <- snqProfitEst( priceNames, quantNames, fixNames, data = germanFarms )

   snqProfitShadowPrices( priceNames, fixNames, estResult )
}
}

\keyword{models}
