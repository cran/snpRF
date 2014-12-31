\name{varUsed}
\alias{varUsed}
\title{Variables used in a random forest}
\description{
  Find out which predictor variables are actually used in the random forest.
}
\usage{
varUsed(x, by.tree=FALSE, count=TRUE)
}
\arguments{
  \item{x}{An object of class \code{snpRF}.}
  \item{by.tree}{Should the list of variables used be broken down by
    trees in the forest?}
  \item{count}{Should the frequencies that variables appear in trees be
    returned?}
}
\value{
  If \code{count=TRUE} and \code{by.tree=FALSE}, a integer vector containing
  frequencies that variables are used in the forest.  If
  \code{by.tree=TRUE}, a matrix is returned, breaking down the counts by
  tree (each column corresponding to one tree and each row to a variable).

  If \code{count=FALSE} and \code{by.tree=TRUE}, a list of integer
  indices is returned giving the variables used in the trees, else if
  \code{by.tree=FALSE}, a vector of integer indices giving the
  variables used in the entire forest.
}
\seealso{
\code{\link{snpRF}}
}
\examples{
data(snpRFexample)
set.seed(17)
varUsed(snpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
              xchrom.names=xchrom.snps.names,x.covar=covariates, 
              y=phenotype,ntree=100))
}
\author{Andy Liaw, with slight modifications for use with snpRF by Greg Jenkins}
\keyword{tree}
