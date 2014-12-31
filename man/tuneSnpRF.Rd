\name{tuneSnpRF}
\alias{tuneSnpRF}
\title{Tune snpRF for the optimal mtry parameter}
\description{
  Starting with the default value of mtry, search for the optimal value
  (with respect to Out-of-Bag error estimate) of mtry for snpRF.
}
\usage{
tuneSnpRF(x.autosome=NULL, x.xchrom=NULL, xchrom.names=NULL, x.covar=NULL, y, 
          mtryStart, ntreeTry=50, stepFactor=2, improve=0.05, trace=TRUE, 
          plot=TRUE, doBest=FALSE, ...)


}
\arguments{
  \item{x.autosome}{A matrix of autosomal markers with each column correspond to a SNP coded as
                    count of a particular allele (i.e. 0,1 or 2), and each row corresponding to
                    a sample/individual.}
  \item{x.xchrom}{A matrix of X chromosome markers, each marker coded as two adjacent columns,
                  alleles of a marker are coded as 0 or 1 for carrying a particular allele. Although
		  males only have one X-chromosome, their markers are coded as 2 columns as well, the
                  second column being a duplicate of the first.  Each row of this matrix corresponds
                  to a sample/individual. This data must be phased in chromosomal order.}
  \item{xchrom.names}{A vector of names for markers (1 name per marker) in the x.xchrom matrix ordered
                      in the same manner as markers in x.xchrom.}
  \item{x.covar}{A matrix of covariates, each column being a different covariate and each row,
  		 a sample/individual.}
  \item{y}{A response vector.  Must be a factor, regression has not been implemented.}
  \item{mtryStart}{starting value of mtry; default is the same as in
    \code{\link{snpRF}}}
  \item{ntreeTry}{number of trees used at the tuning step}
  \item{stepFactor}{at each iteration, mtry is inflated (or deflated) by
    this value}
  \item{improve}{the (relative) improvement in OOB error must be by this
    much for the search to continue}
  \item{trace}{whether to print the progress of the search}
  \item{plot}{whether to plot the OOB error as function of mtry}
  \item{doBest}{whether to run a forest using the optimal mtry found}
  \item{...}{options to be given to \code{\link{snpRF}}}
}
\value{
  If \code{doBest=FALSE} (default), it returns a matrix whose first
  column contains the mtry values searched, and the second column the
  corresponding OOB error.

  If \code{doBest=TRUE}, it returns the \code{\link{snpRF}}
  object produced with the optimal \code{mtry}.
}
%\details{
%}
%\references{
%}
\seealso{
\code{\link{snpRF}}
}
\examples{
data(snpRFexample)
eg.res <- tuneSnpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
                    xchrom.names=xchrom.snps.names,x.covar=covariates, 
                    y=phenotype, stepFactor=1.5)
}
%\author{}
\keyword{classif}
\keyword{tree}
