\name{importance}
\alias{importance}
\alias{importance.default}
\alias{importance.snpRF}
\title{Extract variable importance measure}
\description{
  This is the extractor function for variable importance measures as
  produced by \code{\link{snpRF}}.
}
\usage{
\method{importance}{snpRF}(x, type=NULL, class=NULL, scale=TRUE, ...)
}
\arguments{
  \item{x}{an object of class \code{\link{snpRF}}}.
  \item{type}{either 1 or 2, specifying the type of importance measure
    (1=mean decrease in accuracy, 2=mean decrease in node impurity).}
  \item{class}{which class-specific measure
    to return.}
  \item{scale}{For permutation based measures, should the measures be
    divided their ``standard errors''?}
  \item{...}{not used.}
}
\value{
  A matrix of importance measure(s), one row for each predictor variable.
  The column(s) are different importance measures.
}
\details{
  Two importance measures are extracted using this function.  The first
  measure is computed by permuting OOB data:  For each tree, the 
  prediction error on the out-of-bag portion of the data is recorded 
  (error rate for classification).  Then the same is done after permuting
  each predictor variable.  The differences between the two are then
  averaged over all trees, and normalized by the standard deviation of
  the differences.  If the standard deviation of the difference is equal
  to 0 for a variable, the division is not done (but the average is
  almost always equal to 0 in that case).

  The second measure is the total decrease in node impurities (measured 
  by the Gini index) from splitting on the variable, averaged over all trees.
}
%\references{
%}
\seealso{
  \code{\link{snpRF}}, \code{\link{varImpPlot}}
}
\examples{
set.seed(4543)
data(snpRFexample)

eg.rf<-snpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
             xchrom.names=xchrom.snps.names,x.covar=covariates, 
             y=phenotype,keep.forest=FALSE,importance=TRUE)

importance(eg.rf)
importance(eg.rf, type=1)
}
%\author{}
\keyword{classif}
\keyword{tree}

