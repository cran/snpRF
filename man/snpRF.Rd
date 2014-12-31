\name{snpRF}
\alias{snpRF}
\alias{print.snpRF}

\title{Classification with Random Forest for SNP Data}
\description{
  \code{snpRF} implements Breiman's random forest algorithm (based on
  Breiman and Cutler's original Fortran code) for classification and
  regression.  It can also be used in unsupervised mode for assessing
  proximities among data points.  This is a modified version of the
  randomForest function in the randomForest package addressing issues
  of X-chromosome SNP importance bias by simulating the process of
  X-inactivation.   
}
\usage{
snpRF(x.autosome=NULL,x.xchrom=NULL, xchrom.names=NULL, x.covar=NULL, y,  
      xtest.autosome=NULL,xtest.xchrom=NULL, xtest.covar=NULL,
      ytest=NULL, ntree=500,
      mtry=floor(sqrt(sum(c(ncol(x.autosome),ncol(x.xchrom)/2,
                            ncol(x.covar))))),
      replace=TRUE, classwt=NULL, cutoff, strata,
      sampsize = if (replace) max(c(nrow(x.autosome),nrow(x.xchrom),
                                    nrow(x.covar))) 
                 else ceiling(.632*max(c(nrow(x.autosome),
                                         nrow(x.xchrom),nrow(x.covar)))),
      nodesize = 1,
      maxnodes=NULL,
      importance=FALSE, localImp=FALSE,
      proximity, oob.prox=proximity,
      norm.votes=TRUE, do.trace=FALSE,
      keep.forest=!is.null(y) && (is.null(xtest.autosome) & 
                                  is.null(xtest.xchrom) & 
                                  is.null(xtest.covar)),
      keep.inbag=FALSE, ...)

\method{print}{snpRF}(x, ...)
}
\arguments{
  \item{x}{a \code{snpRF} object.}
  \item{x.autosome}{A matrix of autosomal markers with each column corresponding to a SNP coded as
                    the count of a particular allele (i.e. 0,1 or 2), and each row corresponding to
                    a sample/individual.}
  \item{x.xchrom}{A matrix of X chromosome markers, each marker coded as two adjacent columns,
                  alleles of a marker are coded as 0 or 1 for carrying a particular allele. Although
		  males only have one X-chromosome, their markers are coded as 2 columns as well, the 
                  second column being a duplicate of the first.  Each row of this matrix corresponsponds to
		  a sample/individual. This data must be phased in chromosomal order.}
  \item{xchrom.names}{A vector of names for markers (1 name per marker) in the x.xchrom matrix ordered
                      in the same manner as markers in x.xchrom.}
  \item{x.covar}{A matrix of covariates, each column being a different covariate and each row,
  		 a sample/individual.}
  \item{y}{A response vector.  Must be a factor, regression has not been implemented.  
    If omitted, \code{snpRF} will run in unsupervised mode.}
  \item{xtest.autosome}{a matrix (like \code{x.autosome}) containing
    predictors for the test set.}
  \item{xtest.xchrom}{a matrix (like \code{x.xchrom}) containing
    predictors for the test set.}  
  \item{xtest.covar}{a matrix (like \code{x.covar}) containing
    predictors for the test set.}    
  \item{ytest}{response for the test set.}
  \item{ntree}{Number of trees to grow.  This should not be set to too
    small a number, to ensure that every input row gets predicted at
    least a few times. }
  \item{mtry}{Number of variables randomly sampled as candidates at each
    split.  Note that the default values are different for
    classification (sqrt(p) where p is number of variables in: \code{x.autosome},
    half of \code{x.xchrom}, and \code{x.covar})}
  \item{replace}{Should sampling of cases be done with or without
    replacement?}
  \item{classwt}{Priors of the classes.  Need not add up to one.}
  \item{cutoff}{A vector of length equal to
    number of classes.  The `winning' class for an observation is the
    one with the maximum ratio of proportion of votes to cutoff.
    Default is 1/k where k is the number of classes (i.e., majority vote
    wins).}
  \item{strata}{A (factor) variable that is used for stratified sampling.}
  \item{sampsize}{Size(s) of sample to draw.  For classification, if
    sampsize is a vector of the length the number of strata, then
    sampling is stratified by strata, and the elements of sampsize
    indicate the numbers to be drawn from the strata.}
  \item{nodesize}{Minimum size of terminal nodes.  Setting this number
    larger causes smaller trees to be grown (and thus take less time).}
  \item{maxnodes}{Maximum number of terminal nodes trees in the forest
	can have.  If not given, trees are grown to the maximum possible
	(subject to limits by \code{nodesize}).  If set larger than maximum
	possible, a warning is issued.}
  \item{importance}{Should importance of predictors be assessed? }
  \item{localImp}{Should casewise importance measure be computed?
    (Setting this to \code{TRUE} will override \code{importance}.) }
  \item{proximity}{Should proximity measure among the rows be
    calculated?}
  \item{oob.prox}{Should proximity be calculated only on ``out-of-bag''
    data?}
  \item{norm.votes}{If \code{TRUE} (default), the final result of votes
    are expressed as fractions.  If \code{FALSE}, raw vote counts are
    returned (useful for combining results from different runs).
    Ignored for regression.}
  \item{do.trace}{If set to \code{TRUE}, give a more verbose output as
    \code{snpRF} is run.  If set to some integer, then running
    output is printed for every \code{do.trace} trees.}
  \item{keep.forest}{If set to \code{FALSE}, the forest will not be
    retained in the output object.  If \code{xtest} is given, defaults
    to \code{FALSE}.}
  \item{keep.inbag}{Should an \code{n} by \code{ntree} matrix be
    returned that keeps track of which samples are ``in-bag'' in which
    trees (but not how many times, if sampling with replacement)}
  \item{...}{optional parameters to be passed to the low level function
    \code{snpRF}.}
}

\value{
  An object of class \code{snpRF}, which is a list with the
  following components:

  \item{call}{the original call to \code{snpRF}}
  \item{type}{\code{classification}, or
    \code{unsupervised}.}
  \item{predicted}{the predicted values of the input data based on
    out-of-bag samples.}
  \item{importance}{a matrix with \code{nclass} + 2 columns.  The first
    \code{nclass} columns are the class-specific measures computed as
    mean descrease in accuracy.  The \code{nclass} + 1st column is the
    mean descrease in accuracy over all classes.  The last column is the
    mean decrease in Gini index.}
  \item{importanceSD}{The ``standard errors'' of the permutation-based
    importance measure.  For classification, a \code{p} by \code{nclass
      + 1} matrix corresponding to the first \code{nclass + 1} columns
    of the importance matrix.  For regression, a length \code{p} vector.}
  \item{localImp}{a p by n matrix containing the casewise importance
    measures, the [i,j] element of which is the importance of i-th
    variable on the j-th case. \code{NULL} if \code{localImp=FALSE}.}
  \item{ntree}{number of trees grown.}
  \item{mtry}{number of predictors sampled for spliting at each node.}
  \item{forest}{(a list that contains the entire forest; \code{NULL} if
    \code{snpRF} is run in unsupervised mode or if
    \code{keep.forest=FALSE}.}
  \item{err.rate}{(classification only) vector error rates of the
    prediction on the input data, the i-th element being the (OOB) error rate
    for all trees up to the i-th.}
  \item{confusion}{(classification only) the confusion matrix of the
    prediction (based on OOB data).}
  \item{votes}{(classification only) a matrix with one row for each
    input data point and one column for each class, giving the fraction
    or number of (OOB) `votes' from the random forest.}
  \item{oob.times}{number of times cases are `out-of-bag' (and thus used
    in computing OOB error estimate)}
  \item{proximity}{if \code{proximity=TRUE} when
    \code{snpRF} is called, a matrix of proximity measures among
    the input (based on the frequency that pairs of data points are in
    the same terminal nodes).}
  \item{test}{if test set is given (through the \code{xtest} or additionally
  \code{ytest} arguments), this component is a list which contains the
  corresponding \code{predicted}, \code{err.rate}, \code{confusion},
  \code{votes} for the test set.  If
  \code{proximity=TRUE}, there is also a component, \code{proximity},
  which contains the proximity among the test set as well as proximity
  between test and training data.}
}

\note{
  For details on how the trees are
  stored, see the help page for \code{\link{getTree}}.

  If \code{xtest.*} is given, prediction of the test set is done ``in
  place'' as the trees are grown.  If \code{ytest} is also given, and
  \code{do.trace} is set to some positive integer, then for every
  \code{do.trace} trees, the test set error is printed.  Results for the
  test set is returned in the \code{test} component of the resulting
  \code{snpRF} object.  For classification, the \code{votes}
  component (for training or test set data) contain the votes the cases
  received for the classes.  If \code{norm.votes=TRUE}, the fraction is
  given, which can be taken as predicted probabilities for the classes.

  The ``local'' (or casewise) variable importance is computed as the 
  increase in percent of times a case is OOB and misclassified when the
  variable is permuted.
}

\references{
  Breiman, L. (2001), \emph{Random Forests}, Machine Learning 45(1),
  5-32.

  Breiman, L (2002), ``Manual On Setting Up, Using, And Understanding
  Random Forests V3.1'', \url{http://oz.berkeley.edu/users/breiman/Using_random_forests_V3.1.pdf}.

  Jenkins, G., Biernacka J., Winham S.,  Random forest for genetic analysis: Integrating the X chromosome; (Abstract #1853). Presented at the 64th Annual Meeting of The American Society of Human Genetics, Date, October 21, 2014 in San Diego, CA.
}

\author{Greg Jenkins\email{jenkins.gregory@mayo.edu}; modification of Andy Liaw and Matthew Wiener
        randomForest function in the randomForest package, based on original Fortran code by Leo
        Breiman and Adele Cutler.}

\seealso{\code{\link{predict.snpRF}}, \code{\link{varImpPlot}}}

\examples{
## Classification:
data(snpRFexample)
set.seed(71)
eg.rf <- snpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
               xchrom.names=xchrom.snps.names,x.covar=covariates, 
               y=phenotype,importance=TRUE, proximity=TRUE)

print(eg.rf)
## Look at variable importance:
round(importance(eg.rf), 2)
## Do MDS on 1 - proximity:
eg.mds <- cmdscale(1 - eg.rf$proximity, eig=TRUE)

print(eg.mds$GOF)



## Grow no more than 4 nodes per tree:
(treesize(snpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
                xchrom.names=xchrom.snps.names,x.covar=covariates, 
                y=phenotype, maxnodes=4, ntree=30)))
}
\keyword{classif}% at least one, from doc/KEYWORDS
\keyword{tree}
