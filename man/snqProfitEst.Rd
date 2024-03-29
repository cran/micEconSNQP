\name{snqProfitEst}
\alias{snqProfitEst}
\title{Estimation of a SNQ Profit function}
\description{
   Estimation of a Symmetric Normalized Quadratic (SNQ) Profit function.
}

\usage{snqProfitEst( priceNames, quantNames, fixNames = NULL, instNames = NULL,
   data, form = 0, base = 1, scalingFactors = NULL,
   weights = snqProfitWeights( priceNames, quantNames, data, "DW92", base = base ),
   method = ifelse( is.null( instNames ), "SUR", "3SLS" ), \dots )
}

\arguments{
   \item{priceNames}{a vector of strings containing the names of netput prices.}
   \item{quantNames}{a vector of strings containing the names of netput quantities
      (inputs must be negative).}
   \item{fixNames}{an optional vector of strings containing the names of the
      quantities of (quasi-)fixed inputs.}
   \item{instNames}{an optional vector of strings containing the names of
      instrumental variables (for 3SLS estimation).}
   \item{data}{a data frame containing the data.}
   \item{form}{the functional form to be estimated (see details).}
   \item{base}{the base period(s) for scaling prices (see details).
      If argument \code{weights} is not specified,
      argument \code{base} is also used to obtain the weights
      for normalizing prices (see \code{\link{snqProfitWeights}}).}
   \item{scalingFactors}{a vector of factors to scale prices (see details).}
   \item{weights}{a vector of weights for normalizing prices.}
   \item{method}{the estimation method (passed to
      \code{\link[systemfit]{systemfit}}).}
   \item{\dots}{arguments passed to \code{\link[systemfit]{systemfit}}}
}

\details{
   The Symmetric Normalized Quadratic (SNQ) profit function is defined as
   follows (this functional form is used if argument \code{form} equals 0):
   \deqn{ \pi \left( p, z \right) =
      \sum_{i=1}^{n} \alpha_{i} p_{i} +
      \frac{1}{2} w^{-1} \sum_{i=1}^{n} \sum_{j=1}^{n} \beta_{ij} p_{i} p_{j} +
      \sum_{i=1}^{n} \sum_{j=1}^{m} \delta_{ij} p_{i} z_{j} +
      \frac{1}{2} w \sum_{i=1}^{m} \sum_{j=1}^{m} \gamma_{ij} z_{i} z_{j}
   }
   with \eqn{\pi} = profit, \eqn{p_i} = netput prices,
      \eqn{z_i} = quantities of fixed inputs,
      \eqn{ w=\sum_{i=1}^{n}\theta_{i}p_{i} } = price index for normalization,
      \eqn{\theta_i} = weights of prices for normalization, and
      \eqn{\alpha_i}, \eqn{\beta_{ij}}, \eqn{\delta_{ij}} and
      \eqn{\gamma_{ij}} = coefficients to be estimated.\cr
   The netput equations (output supply in input demand) can be obtained
   by Hotelling's Lemma (\eqn{ q_{i} = \left. \partial \pi \right/ \partial p_{i} }):
   \deqn{ x_{i} = \alpha_{i} +
      w^{-1} \sum_{j=1}^{n} \beta_{ij} p_{j} -
      \frac{1}{2} \theta_{i} w^{-2} \sum_{j=1}^{n} \sum_{k=1}^{n}
      \beta_{jk} p_{j} p_{k} +
      \sum_{j=1}^{m} \delta_{ij} z_{j} +
      \frac{1}{2} \theta_{i} \sum_{j=1}^{m} \sum_{k=1}^{m} \gamma_{jk} z_{j} z_{k}
   }
   In my experience the fit of the model is sometimes not very good,
   because the effect of the fixed inputs is forced to be proportional
   to the weights for price normalization \eqn{\theta_i}.
   In this cases I use following extended SNQ profit function
   (this functional form is used if argument \code{form} equals 1):
   \deqn{ \pi \left( p, z \right) =
      \sum_{i=1}^{n} \alpha_{i} p_{i} +
      \frac{1}{2} w^{-1} \sum_{i=1}^{n} \sum_{j=1}^{n} \beta_{ij} p_{i} p_{j} +
      \sum_{i=1}^{n} \sum_{j=1}^{m} \delta_{ij} p_{i} z_{j} +
      \frac{1}{2} \sum_{i=1}^{n} \sum_{j=1}^{m} \sum_{k=1}^{m}
      \gamma_{ijk} p_i z_{j} z_{k}
   }
   The netput equations are now:
   \deqn{ x_{i} = \alpha_{i} +
      w^{-1} \sum_{j=1}^{n} \beta_{ij} p_{j} -
      \frac{1}{2} \theta_{i} w^{-2} \sum_{j=1}^{n} \sum_{k=1}^{n}
      \beta_{jk} p_{j} p_{k} +
      \sum_{j=1}^{m} \delta_{ij} z_{j} +
      \frac{1}{2} \sum_{j=1}^{m} \sum_{k=1}^{m} \gamma_{ijk} z_{j} z_{k}
   }

   Argument \code{scalingFactors} can be used to scale prices,
   e.g. for improving the numerical stability of the estimation
   (e.g. if prices are very large or very small numbers)
   or for assessing the robustness of the results
   when changing the units of measurement.
   The prices are multiplied by the scaling factors,
   while the quantities are divided my the scaling factors
   so that the monetary values of the inputs and outputs
   and thus, the profit, remains unchanged.
   If argument \code{scalingFactors} is \code{NULL},
   argument \code{base} is used to automatically obtain scaling factors
   so that the scaled prices are unity in the base period or - if there
   is more than one base period - that the
   means of the scaled prices over the base periods are unity.
   Argument \code{base} can be either \cr
   (a) a single number: the row number of the base prices, \cr
   (b) a vector indicating several observations: The means of these
   observations are used as base prices, \cr
   (c) a logical vector with length equal to the number of rows 
   of the data set that is specified by argument \code{data}: The
   means of the observations indicated as 'TRUE' are used as base prices, or\cr
   (d) \code{NULL}: prices are not scaled. 
   If argument \code{base} is \code{NULL},
   argument \code{weights} must be specified,
   because the weights cannot be calculated
   if the base period is not specified.
   An alternative way to use unscaled prices
   is to set argument \code{scalingFactors} equal to a vector of ones
   (see examples below).\cr
   If the scaling factors are explicitly specified
   by argument \code{scalingFactors},
   argument \code{base} is not used for obtaining scaling factors
   (but it is used for obtaining weights
   if argument \code{weights} is not specified).
}

\value{
   a list of class \code{snqProfitEst} containing following objects:
   \item{coef}{a list containing the vectors/matrix of the estimated
      coefficients:\cr
      * alpha = \eqn{\alpha_i}.\cr
      * beta = \eqn{\beta_{ij}}.\cr
      * delta =  \eqn{\delta_{ij}} (only if quasi-fix inputs are present).\cr
      * gamma = \eqn{\gamma_{ij}} (only if quasi-fix inputs are present).\cr
      * allCoef = vector of all coefficients.\cr
      * allCoefCov = covariance matrix of all coefficients.\cr
      * stats = all coefficients with standard errors, t-values and p-values.\cr
      * liCoef = vector of linear independent coefficients.\cr
      * liCoefCov = covariance matrix of linear independent coefficients.}
   \item{ela}{a list of class \code{snqProfitEla} that contains
      (amongst others) the price elasticities at mean prices and mean
      quantities (see \code{\link{snqProfitEla}}).}
   \item{fixEla}{matrix of the fixed factor elasticities at mean prices and
      mean quantities.}
   \item{hessian}{hessian matrix of the profit function with respect to prices
      evaluated at mean prices.}
   \item{convexity}{logical. Convexity of the profit function.}
   \item{r2}{\eqn{R^2}-values of all netput equations.}
   \item{est}{estimation results returned by \code{\link[systemfit]{systemfit}}.}
   \item{weights}{the weights of prices used for normalization.}
   \item{normPrice}{vector used for normalization of prices.}
   \item{data}{data frame of originally supplied data.}
   \item{fitted}{data frame that contains the fitted netput quantities and
      the fitted profit.}
   \item{pMeans}{means of the scaled netput prices.}
   \item{qMeans}{means of the scaled netput quantities.}
   \item{fMeans}{means of the (quasi-)fixed input quantities.}
   \item{priceNames}{a vector of strings containing the names of netput prices.}
   \item{quantNames}{a vector of strings containing the names of netput quantities
      (inputs must be negative).}
   \item{fixNames}{an optional vector of strings containing the names of the
      quantities of (quasi-)fixed inputs.}
   \item{instNames}{an optional vector of strings containing the names of
      instrumental variables (for 3SLS estimation).}
   \item{form}{the functional form (see details).}
   \item{base}{the base period(s) for scaling prices (see details).}
   \item{weights}{vector of weights of the prices for normalization.}
   \item{scalingFactors}{factors to scale prices (and quantities).}
   \item{method}{the estimation method.}
}

\references{
   Diewert, W.E. and T.J. Wales (1987)
   Flexible functional forms and global curvature conditions.
   \emph{Econometrica}, 55, p. 43-68.

   Diewert, W.E. and T.J. Wales (1992)
   Quadratic Spline Models for Producer's Supply and Demand Functions.
   \emph{International Economic Review}, 33, p. 705-722.

   Kohli, U.R. (1993)
   A symmetric normalized quadratic GNP function and the US demand
   for imports and supply of exports.
   \emph{International Economic Review}, 34, p. 243-255.
}

\seealso{\code{\link{snqProfitEla}} and \code{\link{snqProfitWeights}}.}

\author{Arne Henningsen}


\examples{
if( requireNamespace( 'micEcon', quietly = TRUE ) ) {
   data( germanFarms, package = "micEcon" )
   germanFarms$qOutput   <- germanFarms$vOutput / germanFarms$pOutput
   germanFarms$qVarInput <- -germanFarms$vVarInput / germanFarms$pVarInput
   germanFarms$qLabor    <- -germanFarms$qLabor
   priceNames <- c( "pOutput", "pVarInput", "pLabor" )
   quantNames <- c( "qOutput", "qVarInput", "qLabor" )

   estResult <- snqProfitEst( priceNames, quantNames, "land", data = germanFarms )
   estResult$ela   # Oh, that looks bad!

   # it it reasonable to account for technological progress
   germanFarms$time <- c( 0:19 )
   estResult2 <- snqProfitEst( priceNames, quantNames, c("land","time"), 
      data = germanFarms )
   estResult2$ela   # Ah, that looks better!
   
   # estimation with unscaled prices
   estResultNoScale <- snqProfitEst( priceNames, quantNames, c("land","time"), 
    data = germanFarms, scalingFactors = rep( 1, 3 ) )
   print( estResultNoScale )
   
   # alternative way of estimation with unscaled prices
   estResultNoScale2 <- snqProfitEst( priceNames, quantNames, c("land","time"), 
      data = germanFarms, base = NULL, 
      weights = snqProfitWeights( priceNames, quantNames, germanFarms ) )
   all.equal( estResultNoScale[-20], estResultNoScale2[] )

   # please note that the SNQ Profit function is not invariant
   # to units of measurement so that different scaling factors 
   # result in different estimates of elasticities:
   all.equal( estResult2$ela, estResultNoScale$ela )
}
}

\keyword{models}

