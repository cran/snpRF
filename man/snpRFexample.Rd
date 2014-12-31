\name{snpRFexample}
\docType{data}
\alias{snpRFexample}
\alias{autosome.snps}
\alias{xchrom.snps}
\alias{xchrom.snps.names}
\alias{covariates}
\alias{phenotype}
\alias{gender}
\title{Simulated genetic data}
\description{
  This is simulated genetic (autosomal and X-chromosome markers) and non-genetic data (gender, age, and smoking status).}
\usage{
data(snpRFexample)
}
\format{
  \code{snpRFexample} contains 6 objects: 
 \describe{
  \item{autosome.snps}{A matrix of 20 autosomal SNPs with each column corresponding to a SNP coded as count of a particular allele (i.e. 0,1 or 2), and each row corresponding to a subject (n=200).}


  \item{xchrom.snps}{A matrix of 10 X chromosome SNPs, each SNP coded as two adjacent columns (20 columns in all), alleles of a marker are coded as 0 or 1 for carrying a particular allele. Altough males only have one X-chromosome, their SNPs are coded as 2 columns as well, the second column being a duplicate of the first.  Each row of this matrix corresponsponds to a subject (n=200). This data is phased and in chromosomal order.}

  \item{xchrom.snps.names}{A vector of names for markers in the xchrom.snps matrix ordered in the same manner as markers in xchrom.snps.}
 
  \item{covariates}{A matrix of 2 covariates, each column being a different covariate (ie. age and smoking status (yes=1, no=0)) and each row a subject (n=200).}

  \item{phenotype}{A vector indicating whether each subject is a case or a control.} 
  \item{gender}{A vector indicating whether each subject is male or female.}
}}
\source{
Data was simulated using the hapsim R package (http://CRAN.R-project.org/package=hapsim).

}
\references{

  Giovanni Montana (2012). hapsim: Haplotype Data Simulation. R package
  version 0.3. http://CRAN.R-project.org/package=hapsim

}
\seealso{
  \code{\link{snpRF}}
}
\examples{
data(snpRFexample)

stopifnot(require(snpRF))
eg.rf<-snpRF(x.autosome=autosome.snps,x.xchrom=xchrom.snps,
             xchrom.names=xchrom.snps.names,x.covar=covariates, 
             y=phenotype)
print(eg.rf)
}
\author{Greg Jenkins}
\keyword{datasets}