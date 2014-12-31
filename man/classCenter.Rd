\name{classCenter}
\alias{classCenter}
\title{Prototypes of groups.}
\description{
  Prototypes are `representative' cases of a group of data points, given
  the similarity matrix among the points.  They are very similar to
  medoids.  The function is named `classCenter' to avoid conflict with
  the function \code{prototype} in the \code{methods} package.
}
\usage{
classCenter(x, label, prox, nNbr = min(table(label))-1) 
}
\arguments{
  \item{x}{a matrix or data frame}
  \item{label}{group labels of the rows in \code{x}}
  \item{prox}{the proximity (or similarity) matrix, assumed to be
    symmetric with 1 on the diagonal and in [0, 1] off the diagonal (the
  order of row/column must match that of \code{x})}
  \item{nNbr}{number of nearest neighbors used to find the prototypes.}
}
\value{
  A data frame containing one prototype in each row.
}
\details{
  This version only computes one prototype per class.  For each case in
  \code{x}, the \code{nNbr} nearest neighors are found.  Then, for each
  class, the case that has most neighbors of that class is identified.
  The prototype for that class is then the medoid of these neighbors
  (coordinate-wise medians for numerical variables and modes for
  categorical variables).

  This version only computes one prototype per class.  In the future
  more prototypes may be computed (by removing the `neighbors' used,
  then iterate).

  Note that for use with snpRF, the X chromosome output is somewhat difficult
  to interpret.  However, this function is still included to mimic what
  is included in randomForest.
}
%\references{}
\seealso{\code{\link{snpRF}}, \code{\link{MDSplot}}
}
\examples{
data(snpRFexample)
eg.rf <- snpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
               xchrom.names=xchrom.snps.names,x.covar=covariates, 
               y=phenotype,prox=TRUE)

### interpret Xchromosome output with caution ###

dimnames(xchrom.snps)[[2]]<-paste(rep(xchrom.snps.names,each=2),1:2,sep=".")
classCenter(cbind(autosome.snps,xchrom.snps,covariates), phenotype, eg.rf$prox)


}
\author{Andy Liaw (copied from RandomForest package by Greg Jenkins)}
\keyword{classif}
