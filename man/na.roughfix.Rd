\name{na.roughfix}
\alias{na.roughfix}
\alias{na.roughfix.default}
\alias{na.roughfix.data.frame}
\title{Rough Imputation of Missing Values}
\description{
  Impute Missing Values by median/mode.
}
\usage{
na.roughfix(object, ...)
}
\arguments{
  \item{object}{a data frame or numeric matrix.}
  \item{\dots}{further arguments special methods could require.}
}
\value{
  A completed data matrix or data frame.  For numeric variables,
  \code{NA}s are replaced with column medians.  For factor variables,
  \code{NA}s are replaced with the most frequent levels (breaking ties
  at random).  If \code{object} contains no \code{NA}s, it is returned
  unaltered. 
}
\note{
  This is used as a starting point for imputing missing values by snpRF.  However as noted in snpRFImpute, only the covariates can be imputed, since genetic data should be imputed using software specifically designed for SNP imputation.
}
%\references{
%}
\seealso{
\code{\link{snpRFImpute}}, \code{\link{snpRF}}.
}
\examples{
data(snpRFexample)
covar.na <- covariates
set.seed(111)
## artificially drop some data values.
for (i in 1:2) covar.na[sample(200, sample(20)), i] <- NA
eg.roughfix <- na.roughfix(covar.na)
eg.narf <- snpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
                 xchrom.names=xchrom.snps.names,x.covar=eg.roughfix,
                 y=phenotype)
print(eg.narf)
}
\author{Andy Liaw (copied from randomForest package by Greg Jenkins)}
\keyword{NA}
