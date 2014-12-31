\name{snpRFImpute}
\alias{snpRFImpute}
\title{Missing Value Imputations by snpRF}
\description{
  Impute missing values (in covariate predictor data only) using proximity from snpRF.
}
\usage{
snpRFImpute(x.autosome=NULL,x.xchrom=NULL,x.covar, y, iter=5, ntree=300, ...)
}
\arguments{

  \item{x.autosome}{A matrix of autosomal markers with each column corresponding to a SNP coded as
                    count of a particular allele (i.e. 0,1 or 2), and each row corresponding to
                    a sample/individual.(\code{NA}'s not allowed).}
  \item{x.xchrom}{A matrix of X chromosome markers, each marker coded as two adjacent columns,
                  alleles of a marker are coded as 0 or 1 for carrying a particular allele. Since
		  males only have one X-chromosome, their markers are 2 columns as well, the second
		  column being a duplicate of the first.  Each row of this matrix corresponsponds to
		  a sample/individual. This data must be phased in chromosomal order. (\code{NA}'s not allowed).}
  \item{x.covar}{A matrix of covariates, each column being a different covariate and each row,
  		 a sample/individual, some entries with \code{NA}.}
  \item{y}{Response vector, must be a factor (\code{NA}'s not allowed).}
  \item{iter}{Number of iterations to run the imputation.}
  \item{ntree}{Number of trees to grow in each iteration of
    randomForest.}
  \item{...}{Other arguments to be passed to \code{\link{snpRF}}.}
}
\value{
  A matrix containing the completed covariate matrix, where
  \code{NA}s are imputed using proximity from randomForest.  The first
  column contains the response.
}
\details{
  It is assumed that the genetic data (autosome and x-chromosome) would
  have missing values imputed in a different manner prior to using snpRF 
  (i.e. using a program specifically intended for imputing SNP data).
  Thus only missing values in the covariate matrix can be imputed using
  data from genetic and covariate matrices. 
  
  The algorithm starts by imputing \code{NA}s using
  \code{\link{na.roughfix}}.  Then \code{\link{snpRF}} is called
  with the completed data.  The proximity matrix from the randomForest
  is used to update the imputation of the \code{NA}s.  For continuous
  predictors, the imputed value is the weighted average of the
  non-missing obervations, where the weights are the proximities.  For
  categorical predictors, the imputed value is the category with the
  largest average proximity.  This process is iterated \code{iter}
  times.

  Note: Imputation has not (yet) been implemented for the unsupervised
  case.  Also, Breiman (2003) notes that the OOB estimate of error from
  randomForest tend to be optimistic when run on the data matrix with
  imputed values.
}
\references{
  Leo Breiman (2003).  Manual for Setting Up, Using, and Understanding
  Random Forest V4.0.
  \url{http://oz.berkeley.edu/users/breiman/Using_random_forests_v4.0.pdf}
}
\seealso{
  \code{\link{na.roughfix}}.
}
\examples{

data(snpRFexample)
covar.na <- covariates
set.seed(111)
## artificially drop some data values.
for (i in 1:2) covar.na[sample(200, sample(20)), i] <- NA
set.seed(222)
eg.imputed <- snpRFImpute(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
                          x.covar=covar.na, y=phenotype)

set.seed(333)
eg.rf <- snpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
               xchrom.names=xchrom.snps.names,x.covar=eg.imputed, 
               y=phenotype)
print(eg.rf)
}
\author{Andy Liaw, with slight modifications by Greg Jenkins}
\keyword{classif}
\keyword{tree}
