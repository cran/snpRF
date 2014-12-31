\name{grow}
\alias{grow}
\alias{grow.default}
\alias{grow.snpRF}

\title{Add trees to an ensemble}

\description{
  Add additional trees to an existing ensemble of trees.
}

\usage{
\method{grow}{snpRF}(x, how.many, ...)
}

\arguments{
  \item{x}{an object of class \code{snpRF}, which contains a
    \code{forest} component.}
  \item{how.many}{number of trees to add to the \code{snpRF}
    object.}
  \item{...}{currently ignored.}
}

\value{
An object of class \code{snpRF}, containing \code{how.many}
additional trees. 
}

\note{
The \code{confusion}, \code{err.rate}, \code{mse} and \code{rsq}
components (as well as the corresponding components in the \code{test}
component, if exist) of the combined object will be \code{NULL}.  
}

\seealso{\code{\link{combine}}, \code{\link{snpRF}}}

\author{Andy Liaw, with slight modifications for use with snpRF by Greg Jenkins}

\examples{
data(snpRFexample)
eg.rf <- snpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
               xchrom.names=xchrom.snps.names,x.covar=covariates, 
               y=phenotype,ntree=50, norm.votes=FALSE)
eg.rf <- grow(eg.rf, 50)
print(eg.rf)
}

\keyword{classif}
