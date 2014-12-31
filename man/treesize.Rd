\name{treesize}
\alias{treesize}

\title{Size of trees in an ensemble}

\description{
Size of trees (number of nodes) in and ensemble.
}

\usage{
treesize(x, terminal=TRUE)
}

\arguments{
  \item{x}{an object of class \code{snpRF}, which contains a
    \code{forest} component.}
  \item{terminal}{count terminal nodes only (\code{TRUE}) or all nodes
    (\code{FALSE}}
}

\value{
A vector containing number of nodes for the trees in the
\code{snpRF} object.
}

\note{
  The \code{snpRF} object must contain the \code{forest} component; i.e., created with \code{snpRF(...,keep.forest=TRUE)}. 
}

\seealso{\code{snpRF}}

\author{Andy Liaw, with slight modifcations for use with snpRF by Greg Jenkins}

\examples{
data(snpRFexample)
eg.rf <- snpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
               xchrom.names=xchrom.snps.names,x.covar=covariates, 
               y=phenotype)
hist(treesize(eg.rf))
}

\keyword{classif}
