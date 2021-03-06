\name{mvnlookup}
\docType{data}
\alias{mvnlookup}
\title{Lookup Table for mvnconv() Function}
\description{Lookup table for the \code{\link{mvnconv}} function.}
\usage{mvnlookup}
\format{The data frame contains the following columns:
\tabular{lll}{
   \bold{rhos}     \tab \code{numeric} \tab correlations among the test statistics \cr
   \bold{m2lp_1}   \tab \code{numeric} \tab \eqn{\mbox{Cov}[-2 \ln(p_i), -2 \ln(p_j)]} (for one-sided tests) \cr
   \bold{m2lp_2}   \tab \code{numeric} \tab \eqn{\mbox{Cov}[-2 \ln(p_i), -2 \ln(p_j)]} (for two-sided tests) \cr
   \bold{z_1}      \tab \code{numeric} \tab \eqn{\mbox{Cov}[\Phi^{-1}(1 - p_i), \Phi^{-1}(1 - p_j)]} (for one-sided tests) \cr
   \bold{z_2}      \tab \code{numeric} \tab \eqn{\mbox{Cov}[\Phi^{-1}(1 - p_i), \Phi^{-1}(1 - p_j)]} (for two-sided tests) \cr
   \bold{chisq1_1} \tab \code{numeric} \tab \eqn{\mbox{Cov}[F^{-1}(1 - p_i, 1), F^{-1}(1 - p_j, 1)]} (for one-sided tests) \cr
   \bold{chisq1_2} \tab \code{numeric} \tab \eqn{\mbox{Cov}[F^{-1}(1 - p_i, 1), F^{-1}(1 - p_j, 1)]} (for two-sided tests) \cr
   \bold{p_1}      \tab \code{numeric} \tab \eqn{\mbox{Cov}[p_i, p_j]} (for one-sided tests) \cr
   \bold{p_2}      \tab \code{numeric} \tab \eqn{\mbox{Cov}[p_i, p_j]} (for two-sided tests) \cr
}
}
\details{
   Assume

   \if{html}{\figure{mvn.png}{options: width=250}}
   \if{latex}{\figure{mvn.png}{options: width=2in}}
   \if{text}{[t_i, t_j]' ~ MVN([0,0]', [1, rho_ij | rho_ij, 1])}

   is the joint distribution for test statistics \eqn{t_i} and \eqn{t_j}. For one-sided tests, let \eqn{p_i = 1 - \Phi(t_i)} and \eqn{p_j = 1 - \Phi(t_j)} where \eqn{\Phi(\cdot)} denotes the cumulative distribution function of a standard normal distribution. For two-sided tests, let \eqn{p_i = 2(1 - \Phi(|t_i|))} and \eqn{p_j = 2(1 - \Phi(|t_j|))}. These are simply the one- and two-sided \eqn{p}-values corresponding to \eqn{t_i} and \eqn{t_j}.

   Columns \code{p_1} and \code{p_2} contain the values for \eqn{\mbox{Cov}[p_i, p_j]}.

   Columns \code{m2lp_1} and \code{m2lp_2} contain the values for \eqn{\mbox{Cov}[-2 \ln(p_i), -2 \ln(p_j)]}.

   Columns \code{chisq1_1} and \code{chisq1_2} contain the values for \eqn{\mbox{Cov}[F^{-1}(1 - p_i, 1), F^{-1}(1 - p_j, 1)]}, where \eqn{F^{-1}(\cdot,1)} denotes the inverse of the cumulative distribution function of a chi-square distribution with one degree of freedom.

   Columns \code{z_1} and \code{z_2} contain the values for \eqn{\mbox{Cov}[\Phi^{-1}(1 - p_i), \Phi^{-1}(1 - p_j)]}, where \eqn{\Phi^{-1}(\cdot)} denotes the inverse of the cumulative distribution function of a standard normal distribution.

   Computation of these covariances required numerical integration. The values in this table were precomputed.

}
\keyword{datasets}
