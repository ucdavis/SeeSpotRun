###
### Combine multiple obs spot files
### Dec 18, 2017
### Trent
###

### Packages
library(xlsx)
library(readxl)
library(plyr)
library(reshape2)
###

### Combine multiple files
dir <- "/Volumes/SilverSeaGate/Archive/Work/3 Appointments/UC Davis/Shared/Research/Yeast/teto-tetr/wlys/spot/obs_spot_rep5"
setwd(dir)
multiplefiles <- list.files(path = dir, pattern = "obs_spotsrepsy1.xlsx")
multiplefiles

lll <- list()
for(i in 1:length(multiplefiles)){
ddd <- read.xlsx(multiplefiles[i], sheetIndex=1, header=TRUE)
ddd <- ddd[,-1]
head(ddd)
colnames(ddd)[c(7,8,9)] <- c("rep1", "rep2", "rep3")
lll[[i]] <- ddd
}

multi <- do.call("rbind", lll)
head(multi)

write.xlsx(multi, "../obs_spotreps_comb6.xlsx")


jjj <- list()
for(x in 1:length(multiplefiles)){
  eee <- read.xlsx(multiplefiles[x], sheetIndex=1, header=TRUE)
  eee <- eee[,-1]
  head(eee)
  vec <- colnames(eee)[c(7,8,9)]
  vec <- gsub("rep", '', vec)
  reptp1 <- vec[1]
  reptp2 <- vec[2]
  reptp3 <- vec[3]
  desc <- unique(paste(eee$Strain, "_", eee$Cond, "_", eee$Exp, "_t", eee$t, sep=""))
  jjj[[x]] <- cbind(desc, reptp1, reptp2, reptp3)
}

times <- do.call("rbind", jjj)
times <- as.data.frame(times)
head(times)

write.xlsx(times, "../times4.xlsx", row.names=FALSE)

