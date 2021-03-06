\name{meff}
\alias{meff}
\title{Estimate the Effective Number of Tests}
\description{Estimate the effective number of tests.}
\usage{
meff(R, eigen, method, \dots)
}
\arguments{
   \item{R}{a \eqn{k \times k} symmetric matrix that reflects the correlations structure among the tests.}
   \item{eigen}{optional vector to directly supply the eigenvalues to the function (instead of computing them from the matrix given via \code{R}).}
   \item{method}{character string to specify the method to be used to estimate the effective number of tests (either \code{"nyholt"}, \code{"liji"}, \code{"gao"}, or \code{"galwey"}. See \sQuote{Details}.}
   \item{\dots}{other arguments.}
}
\details{

   The function estimates the effective number of tests based on one of four different methods. All methods work by extracting the eigenvalues from the \eqn{R} matrix supplied via the \code{R} argument (or from the eigenvalues directly passed via the \code{eigen} argument). Letting \eqn{\lambda_i} denote the \eqn{i}th eigenvalue of this matrix (with \eqn{i = 1, \ldots, k}), the effective number of tests (\eqn{m}) is estimated as follows.

   \bold{Method by Nyholt (2004)}

   \deqn{m = 1 + (k - 1) \left(1 - \frac{\mbox{Var}(\lambda)}{k}\right)} where \eqn{\mbox{Var}(\lambda)} is the observed sample variance of the \eqn{k} eigenvalues.

   \bold{Method by Li & Ji (2005)}

   \deqn{m = \sum_{i = 1}^k f(|\lambda_i|)} where \eqn{f(x) = I(x \geq 1) + (x - \lfloor x \rfloor)} and \eqn{\lfloor . \rfloor} is the floor function.

   \bold{Method by Gao et al. (2008)}

   \deqn{m = \min(x) \; \mbox{such that} \; \frac{\sum_{i = 1}^x \lambda_{(i)}}{\sum_{i = 1}^k \lambda_{(i)}} > C} where \eqn{\lambda_{(1)}, \lambda_{(2)}, \ldots, \lambda_{(k)}} are the sorted eigenvalues in decreasing order and \eqn{C} is a pre-defined parameter which is set to 0.995.

   \bold{Method by Galwey (2009)}

   \deqn{m = \frac{\left(\sum_{i = 1}^k \sqrt{\lambda_i'}\right)^2}{\sum_{i = 1}^k \lambda_i'}} where \eqn{\lambda_i' = 0} if \eqn{\lambda_i < 0} and \eqn{\lambda_i} otherwise.

   \bold{Note:} For all methods that can yield a non-integer estimate (all but the method by Gao et al., 2008), the resulting estimate \eqn{m} is rounded down to an integer.

   \bold{Specifying the R Matrix}

   The \eqn{R} matrix should reflect the correlation structure among the tests. There is no general solution for constructing such a correlation matrix, as this depends on the type of test and the sidedness of these tests. For example, we can use the correlations among related but changing elements across the analyses/tests, or a function thereof, as a proxy for the correlation structure. For example, when conducting \eqn{k} analyses with the same dependent variable and \eqn{k} different independent variables, the correlations among the independent variables could serve as such a proxy. Analogously, if analyses are conducted for \eqn{k} dependent variables with the same set of independent variables, the correlations among the dependent variables could be used instead.

   If the tests of interest have test statistics that can be assumed to follow a multivariate normal distribution and a matrix is available that reflects the correlations among the test statistics (which could be approximated by the correlations among the interchanging independent or dependent variables), then the \code{\link{mvnconv}} function can be used to convert this correlation matrix into the correlations among the (one- or two-sided) \eqn{p}-values, which can then be passed to the \code{R} argument. See \sQuote{Examples}.

   \bold{Not Positive Semi-Definite R}

   Depending on the way \eqn{R} is constructed, it may happen that this matrix is not positive semi-definite, leading to negative eigenvalues. The methods given above can all still be carried out in this case. However, another possibility is to handle such a case by using an algorithm that finds the nearest positive semi-definite matrix (e.g., Higham 2002) before passing this matrix to the function (see \code{\link[Matrix]{nearPD}} for a corresponding implementation).

}
\value{
   A scalar giving the estimate of the effective number of tests.
}
\author{
   Ozan Cinar \email{ozancinar86@gmail.com} \cr
   Wolfgang Viechtbauer \email{wvb@wvbauer.com} \cr
}
\references{
   Gao, X., Starmer, J., & Martin, E. R. (2008). A multiple testing correction method for genetic association studies using correlated single nucleotide polymorphisms. \emph{Genetic Epidemiology, 32}(4), 361-369.

   Galwey, N. W. (2009). A new measure of the effective number of tests, a practical tool for comparing families of non-independent significance tests. \emph{Genetic Epidemiology, 33}(7), 559-568.

   Higham, N. J. (2002). Computing the nearest correlation matrix: A problem from finance. \emph{IMA Journal of Numerical Analysis, 22}(3), 329-343.

   Li, J., & Ji, L. (2005). Adjusting multiple testing in multilocus analyses using the eigenvalues of a correlation matrix. \emph{Heredity, 95}(3), 221-227.

   Nyholt, D. R. (2004). A simple correction for multiple testing for single-nucleotide polymorphisms in linkage disequilibrium with each other. \emph{American Journal of Human Genetics, 74}(4), 765-769.
}
\examples{
# copy LD correlation matrix into r (see help(grid2ip) for details on these data)
r <- grid2ip.ld

# estimate the effective number of tests based on the LD correlation matrix
meff(r, method = "nyholt")
meff(r, method = "liji")
meff(r, method = "gao")
meff(r, method = "galwey")

# use mvnconv() to convert the LD correlation matrix into a matrix with the
# correlations among the (two-sided) p-values assuming that the test
# statistics follow a multivariate normal distribution with correlation
# matrix r (note: 'side = 2' by default in mvnconv())
mvnconv(r, target = "p", cov2cor = TRUE)[1:5,1:5] # show only rows/columns 1-5

# use this matrix instead for estimating the effective number of tests
meff(mvnconv(r, target = "p", cov2cor = TRUE), method = "nyholt")
meff(mvnconv(r, target = "p", cov2cor = TRUE), method = "liji")
meff(mvnconv(r, target = "p", cov2cor = TRUE), method = "gao")
meff(mvnconv(r, target = "p", cov2cor = TRUE), method = "galwey")
}
\keyword{htest}
