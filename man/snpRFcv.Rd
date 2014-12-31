\name{snpRFcv}
\alias{snpRFcv}
\title{Random Forest Cross-Valdidation for feature selection}
\description{
This function shows the cross-validated prediction performance of
models with sequentially reduced number of predictors (ranked by
variable importance) via a nested cross-validation procedure.
}
\usage{
snpRFcv(trainx.autosome=NULL,trainx.xchrom=NULL,trainx.covar=NULL, trainy, 
        cv.fold=5, scale="log", step=0.5, 
        mtry=function(p) max(1, floor(sqrt(p))), recursive=FALSE, ...)
}
\arguments{
  \item{trainx.autosome}{A matrix of autosomal markers with each column corresponding to a SNP coded as
                         count of a particular allele (i.e. 0,1 or 2), and each row corresponding to
                         a sample/individual.}
  \item{trainx.xchrom}{A matrix of X chromosome markers, each marker coded as two adjacent columns,
                       alleles of a marker are coded as 0 or 1 for carrying a particular allele. Although
		       males only have one X-chromosome, their markers are coded as 2 columns as well, the
                       second column being a duplicate of the first.  Each row of this matrix corresponds to
		       a sample/individual. This data must be phased in chromosomal order.}
  \item{trainx.covar}{A matrix of covariates, each column being a different covariate, and each row,
  		 a sample/individual.}
  \item{trainy}{vector of response, must be a factor and have length equal to the number
                of rows in \code{trainx.*}}
  \item{cv.fold}{number of folds in the cross-validation}
  \item{scale}{if \code{"log"}, reduce a fixed proportion (\code{step})
  of variables at each step, otherwise reduce \code{step} variables at a
  time}
  \item{step}{if \code{log=TRUE}, the fraction of variables to remove at
	each step, else remove this many variables at a time}
  \item{mtry}{a function of number of remaining predictor variables to
	use as the \code{mtry} parameter in the \code{snpRF} call}
  \item{recursive}{whether variable importance is (re-)assessed at each
  step of variable reduction}
  \item{...}{other arguments passed on to \code{snpRF}}
}
\value{
  A list with the following components:

    list(n.var=n.var, error.cv=error.cv, predicted=cv.pred)
	\item{n.var}{vector of number of variables used at each step}
	\item{error.cv}{corresponding vector of error rates or MSEs at each
	  step}
	\item{predicted}{list of \code{n.var} components, each containing
	  the predicted values from the cross-validation}
}
%\details{
%}
\references{
Svetnik, V., Liaw, A., Tong, C. and Wang, T., ``Application of Breiman's
Random Forest to Modeling Structure-Activity Relationships of
Pharmaceutical Molecules'', MCS 2004, Roli, F. and Windeatt, T. (Eds.)
pp. 334-343.
}
\seealso{
  \code{\link{snpRF}}, \code{\link{importance}}
}
\examples{
set.seed(647)
data(snpRFexample)
result <- snpRFcv(trainx.autosome=autosome.snps,trainx.xchrom=xchrom.snps,
                  trainx.covar=covariates, trainy=phenotype)
with(result, plot(n.var, error.cv, log="x", type="o", lwd=2))

## The following can take a while to run, so if you really want to try
## it, copy and paste the code into R.

\dontrun{
result <- replicate(5,snpRFcv(trainx.autosome=autosome.snps,
                              trainx.xchrom=xchrom.snps,
                              trainx.covar=covariates, trainy=phenotype), 
		    simplify=FALSE)
error.cv <- sapply(result, "[[", "error.cv")
matplot(result[[1]]$n.var, cbind(rowMeans(error.cv), error.cv), type="l",
        lwd=c(2, rep(1, ncol(error.cv))), col=1, lty=1, log="x",
        xlab="Number of variables", ylab="CV Error")
}
}
\author{Andy Liaw, with slight modifications by Greg Jenkins}
\keyword{classif}

