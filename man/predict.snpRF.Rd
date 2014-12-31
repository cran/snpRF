\name{predict.snpRF}
\alias{predict.snpRF}
\title{predict method for snpRF objects}
\description{
  Prediction of test data using the modified random forest algorithm implemented in snpRF.
}
\usage{
\method{predict}{snpRF}(object, newdata.autosome=NULL, newdata.xchrom=NULL, 
                xchrom.names=NULL, newdata.covar=NULL, type = "response",
                norm.votes = TRUE, predict.all=FALSE, proximity = FALSE, 
                nodes=FALSE, cutoff, ...)


}
\arguments{
  \item{object}{an object of class \code{snpRF}, as that
    created by the function \code{snpRF}.}
  \item{newdata.autosome}{A matrix of autosomal markers with each column corresponding to a SNP coded as
                          the count of a particular allele (i.e. 0,1 or 2), and each row corresponding to
                          a sample/individual.(Note: If all newdata.* are not given, the out-of-bag prediction
                          in \code{object} is returned.)}
  \item{newdata.xchrom}{A matrix of X chromosome markers, each marker coded as two adjacent columns,
                        alleles of a marker are coded as 0 or 1 for carrying a particular allele. Although
		        males only have one X-chromosome, their markers are coded as 2 columns as well, the 
			second column being a duplicate of the first.  Each row of this matrix corresponds to
		        a sample/individual. This data must be phased in chromosomal order. (Note: If all
                        newdata.* are not given, the out-of-bag prediction in \code{object} is returned.)}
  \item{xchrom.names}{A vector of names for markers (1 name per marker) in the newdata.xchrom matrix ordered
    in the same manner as markers in newdata.xchrom.}
  \item{newdata.covar}{A matrix of covariates, each column being a different covariate and each row,
  		       a sample/individual. (Note: If all newdata.* are not given, the out-of-bag prediction
                       in \code{object} is returned.)}
  \item{type}{one of \code{response}, \code{prob}. or \code{votes},
  indicating the type of output: predicted values, matrix of class
  probabilities, or matrix of vote counts.  \code{class} is allowed, but
  automatically converted to "response", for backward compatibility.}
  \item{norm.votes}{Should the vote counts be normalized (i.e.,
    expressed as fractions)?}
  \item{predict.all}{Should the predictions of all trees be kept?}
  \item{proximity}{Should proximity measures be computed?}
  \item{nodes}{Should the terminal node indicators (an n by ntree
    matrix) be return?  If so, it is in the ``nodes'' attribute of the
    returned object.}
  \item{cutoff}{(Classification only)  A vector of length equal to
    number of classes.  The `winning' class for an observation is the
    one with the maximum ratio of proportion of votes to cutoff.
    Default is taken from the \code{forest$cutoff} component of
    \code{object} (i.e., the setting used when running
    \code{\link{snpRF}}).}
  \item{...}{not used currently.}
}

\value{
 
  The object returned depends on the argument \code{type}:
  \item{response}{predicted classes (the classes with majority vote).}
  \item{prob}{matrix of class probabilities (one column for each class
  and one row for each input).}
  \item{vote}{matrix of vote counts (one column for each class
  and one row for each new input); either in raw counts or in fractions
  (if \code{norm.votes=TRUE}).}

If \code{predict.all=TRUE}, then the \code{individual} component of the
returned object is a character matrix where each column contains the
predicted class by a tree in the forest.

If \code{proximity=TRUE}, the returned object is a list with two
components: \code{pred} is the prediction (as described above) and
\code{proximity} is the proximitry matrix.

If \code{nodes=TRUE}, the returned object has a ``nodes'' attribute,
which is an n by ntree matrix, each column containing the node number
that the cases fall in for that tree.

NOTE: Any ties are broken at random, so if this is undesirable, avoid it by
using odd number \code{ntree} in \code{snpRF()}.
}
\references{
  Breiman, L. (2001), \emph{Random Forests}, Machine Learning 45(1),
  5-32.
}
\author{ Greg Jenkins\email{jenkins.gregory@mayo.edu}; modification of Andy Liaw and Matthew Wiener
         randomForest package function predict.randomForest.R, based on original Fortran code by
         Leo Breiman and Adele Cutler.}

\seealso{\code{\link{snpRF}}}

\examples{
data(snpRFexample)
set.seed(111)
ind <- sample(2, nrow(autosome.snps), replace = TRUE, prob=c(0.8, 0.2))
eg.rf <- snpRF(x.autosome=autosome.snps[ind==1,],x.xchrom=xchrom.snps[ind==1,],
               xchrom.names=xchrom.snps.names,x.covar=covariates[ind==1,], 
               y=phenotype[ind==1])
eg.pred <- predict(eg.rf, newdata.autosome=autosome.snps[ind==2,], 
                   newdata.xchrom=xchrom.snps[ind==2,], 
                   xchrom.names=xchrom.snps.names, 
                   newdata.covar=covariates[ind==2,])
table(observed = phenotype[ind==2], predicted = eg.pred)
## Get prediction for all trees.
predict(eg.rf,newdata.autosome=autosome.snps[ind==2,], 
        newdata.xchrom=xchrom.snps[ind==2,], 
        xchrom.names=xchrom.snps.names, 
        newdata.covar=covariates[ind==2,], predict.all=TRUE)
## Proximities.
predict(eg.rf,newdata.autosome=autosome.snps[ind==2,], 
        newdata.xchrom=xchrom.snps[ind==2,], 
        xchrom.names=xchrom.snps.names,	
        newdata.covar=covariates[ind==2,], proximity=TRUE)
## Nodes matrix.
str(attr(predict(eg.rf,newdata.autosome=autosome.snps[ind==2,], 
                 newdata.xchrom=xchrom.snps[ind==2,], 
                 xchrom.names=xchrom.snps.names, 
                 newdata.covar=covariates[ind==2,], nodes=TRUE), "nodes"))
}
\keyword{classif}% at least one, from doc/KEYWORDS
