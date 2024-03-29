\name{residuals.snqProfitEst}
\alias{residuals.snqProfitEst}
\alias{residuals.snqProfitImposeConvexity}

\title{Residuals of an SNQ profit function}

\description{
   Extract the residuals from the estimation of a Symmetric Normalized
   Quadratic (SNQ) profit function.
}

\usage{
\method{residuals}{snqProfitEst}( object, scaled = TRUE, \dots )

\method{residuals}{snqProfitImposeConvexity}( object, scaled = TRUE, \dots )
}

\arguments{
   \item{object}{an object of type \code{snqProfitEst} or
      \code{snqProfitImposeconvexity}.}
   \item{scaled}{logical. Return scaled quantities?}
   \item{\dots}{currently not used.}
}

\value{
   \code{residuals.snqProfitEst} and \code{residuals.snqProfitEst} return a
   dataframe that contains the residuals for each netput and the profit.
}

\author{Arne Henningsen}


\seealso{
   \code{\link{snqProfitEst}}, \code{\link{snqProfitImposeConvexity}}
   and \code{\link{residuals}}
}

\examples{
if( requireNamespace( 'micEcon', quietly = TRUE ) ) {
   data( germanFarms, package = "micEcon" )
   germanFarms$qOutput   <- germanFarms$vOutput / germanFarms$pOutput
   germanFarms$qVarInput <- -germanFarms$vVarInput / germanFarms$pVarInput
   germanFarms$qLabor    <- -germanFarms$qLabor
   germanFarms$time      <- c( 0:19 )
   priceNames <- c( "pOutput", "pVarInput", "pLabor" )
   quantNames <- c( "qOutput", "qVarInput", "qLabor" )
   estResult <- snqProfitEst( priceNames, quantNames, c("land","time"), data=germanFarms )
   residuals( estResult )
   residuals( estResult, scaled = FALSE )
}
}

\keyword{models}



