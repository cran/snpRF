\name{varImpPlot}
\alias{varImpPlot}
\title{Variable Importance Plot}
\description{
  Dotchart of variable importance as measured by the modified Random Forest algorithm implemented in snpRF.
}
\usage{
varImpPlot(x, sort=TRUE, n.var=min(30, nrow(x$importance)),
           type=NULL, class=NULL, scale=TRUE, 
           main=deparse(substitute(x)), ...) 
}
\arguments{
  \item{x}{An object of class \code{snpRF}.}
  \item{sort}{Should the variables be sorted in decreasing order of
    importance?}
  \item{n.var}{How many variables to show? (Ignored if
    \code{sort=FALSE}.)}
  \item{type, class, scale}{arguments to be passed on to
    \code{\link{importance}}}
  \item{main}{plot title.}
  \item{...}{Other graphical parameters to be passed on to
    \code{\link{dotchart}}.}
}
\value{
  Invisibly, the importance of the variables that were plotted.
}
\seealso{
  \code{\link{snpRF}}, \code{\link{importance}}
}
\examples{
set.seed(4543)
data(snpRFexample)
eg.rf <- snpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
               xchrom.names=xchrom.snps.names,x.covar=covariates, 
               y=phenotype,keep.forest=FALSE, importance=TRUE)
varImpPlot(eg.rf)
}
\author{Andy Liaw, with slight modifications for use with snpRF by Greg Jenkins}
\keyword{classif}
\keyword{tree}
