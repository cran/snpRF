\name{plot.snpRF}
\alias{plot.snpRF}
\title{Plot method for snpRF objects}
\description{
  Plot the error rates or MSE of a snpRF object
}
\usage{
\method{plot}{snpRF}(x, type="l", main=deparse(substitute(x)), ...)
}
\arguments{
  \item{x}{an object of class \code{snpRF}.}
  \item{type}{type of plot.}
  \item{main}{main title of the plot.}
  \item{...}{other graphical parameters.}
}
\value{
  Invisibly, the error rates or MSE of the \code{snpRF} object.
  If the object has a non-null \code{test} component, then the returned
  object is a matrix where the first column is the out-of-bag estimate
  of error, and the second column is for the test set.
}
\note{
  If the \code{x} has a non-null \code{test} component, then the test
  set errors are also plotted.
}
\seealso{
  \code{\link{snpRF}}
}
\examples{
data(snpRFexample)
plot(snpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
           xchrom.names=xchrom.snps.names,x.covar=covariates,
           y=phenotype,keep.forest=TRUE), log="y")
}
\author{Andy Liaw, with slight modifications for use with snpRF by Greg Jenkins}
\keyword{classif}
\keyword{tree}
