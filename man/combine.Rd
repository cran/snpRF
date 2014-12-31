\name{combine}
\alias{combine}

\title{Combine Ensembles of Trees}

\description{
Combine two or more more ensembles of trees into one.
}

\usage{
combine(...)
}

\arguments{
  \item{...}{list of two or more objects of class \code{snpRF}, 
    to be combined into one.}
}

\value{
An object of class \code{snpRF}.
}

\note{
The \code{confusion}, \code{err.rate}, \code{mse} and \code{rsq}
components (as well as the corresponding components in the \code{test}
compnent, if exist) of the combined object will be \code{NULL}.  
}

\seealso{\code{\link{snpRF}}, \code{\link{grow}}}

\author{Andy Liaw, with slight modifications for use with snpRF by Greg Jenkins}

\examples{
data(snpRFexample)
rf1 <- snpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
             xchrom.names=xchrom.snps.names,x.covar=covariates, 
             y=phenotype,ntree=50, norm.votes=FALSE)
rf2 <- snpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
             xchrom.names=xchrom.snps.names,x.covar=covariates, 
             y=phenotype,ntree=50, norm.votes=FALSE)
rf3 <- snpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
             xchrom.names=xchrom.snps.names,x.covar=covariates, 
             y=phenotype,ntree=50, norm.votes=FALSE)

rf.all <- combine(rf1, rf2, rf3)
print(rf.all)
}

\keyword{classif}
