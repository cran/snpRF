\name{MDSplot}
\alias{MDSplot}
\title{Multi-dimensional Scaling Plot of Proximity matrix from snpRF}
\description{
  Plot the scaling coordinates of the proximity matrix from snpRF.
}
\usage{
MDSplot(rf, fac, k=2, palette=NULL, pch=20, ...)
}
\arguments{
  \item{rf}{an object of class \code{\link{snpRF}} that contains
    the \code{proximity} component.}
  \item{fac}{a factor that was used as response to train \code{rf}.}
  \item{k}{number of dimensions for the scaling coordinates.}
  \item{palette}{colors to use to distinguish the classes; length must
    be the equal to the number of levels.}
  \item{pch}{plotting symbols to use.}
  \item{...}{other graphical parameters.}
}
\value{
  The output of \code{\link[stats]{cmdscale}} on 1 - \code{rf$proximity} is
  returned invisibly.
}
\note{
  If \code{k > 2}, \code{\link{pairs}} is used to produce the
  scatterplot matrix of the coordinates.
}
\seealso{\code{\link{snpRF}}}
\examples{
set.seed(1)
data(snpRFexample)
eg.rf <- snpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
               xchrom.names=xchrom.snps.names,x.covar=covariates,
               y=phenotype, proximity=TRUE,keep.forest=FALSE)
MDSplot(eg.rf, phenotype)
## Using different symbols for the classes:
MDSplot(eg.rf, phenotype, palette=rep(1, 2), pch=as.numeric(phenotype))
}
\author{Robert Gentleman, with slight modifications by Andy Liaw and modifications for use with snpRF by Greg Jenkins}
\keyword{classif}
\keyword{tree}
