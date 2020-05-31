########## Graph ##########


### Packages ###
library(ggplot2)
library(grid)
library(gridExtra)
library(plyr)
library(reshape)
library(reshape2)
library(extrafont)
library(xlsx)
library(R.matlab)


### File load ###
dir <- "/Volumes/SilverSeaGate/Archive/Work/3 Appointments/UC Davis/Shared/Research/Yeast/teto-tetr/wlys/spot/confdist3"
setwd(dir)

########## MAT EXTRACTOR ##########


fileNames <- Sys.glob("*dist.csv")
fileNames 

for (fileName in fileNames) {
  #testfile <- "URA3SP1_t1_conf_dist.csv"
  #fileName <- testfile
  
  ### experiment info ###
  fileName
  #useless
  nm <- sub(".csv", "", fileName)
  nm
  #start-info
  strain <- substr(nm, 1, 4)
  strain
  cond <- substr(nm, 5, 6)
  cond
  exp <- substr(nm, 7, 7)
  exp
  #middle-info
  info <- as.matrix(strsplit(nm, "_"))
  info <- c(do.call("cbind",info)) 
  info
  t <- info[2]
  t
  conf <- info[3]
  conf
  acquisition <- info[4]
  acquisition

  ### Load data ###
  dist <-read.csv(fileName, na.strings=c("NA"), header=FALSE)
  head(dist)

  #convert data
  cellno <- ncol(dist)
  colnames(dist) <- seq(1:cellno)
  head(dist)
  tpno <- nrow(dist)
  tpno
  dist$t <- seq(1:tpno)
  head(dist)

  #melt
  md <- melt(dist, id=c("t"))
  colnames(md) <- c("tp",  "cell",	"dist")
  head(md)
  
  
  #info
  mx <- cbind(strain=strain, cond=cond, exp=exp, t=t, conf=conf, 
              acquisition=acquisition, md)
  head(mx)
  length(mx$dist)
  
  df <- as.data.frame(mx)
  df
  
  #write temp
  write.csv(df, paste("Melt-",fileName,"-outy.csv",sep=""), row.names=F)
  
} #end bracket for "for (fileName in fileNames)"

### masterfile
multiplefiles <- list.files(path = dir, pattern = "-outy.csv")
#multiplefiles
matcall <- do.call("rbind", lapply(multiplefiles, read.csv, header = TRUE))
write.csv(matcall, paste("../conf_comb5.csv",sep=""), row.names=F)
