###
### Combine manual spot calls with cell observations
### Oct 20, 2017
### Trent
###

### Packages
library(xlsx)
library(readxl)
library(plyr)
###

### Experiment
exp <- "URA3WT6_t0"

### Load data
setwd("/Volumes/SilverSeaGate/Archive/Work/3 Appointments/UC Davis/Shared/Research/Yeast/teto-tetr/Timecourse data/neworg/URA3/WT/Exp6/t0/7_manonetwo")

aaa <- "rep0"
bbb <- "rep4"
ccc <- "rep9"

otty1 <- read_excel(paste(exp, "_onetwo_", aaa, ".xlsx", sep=""))
otty1 <- data.frame(otty1)
otty2 <- read_excel(paste(exp, "_onetwo_", bbb, ".xlsx", sep=""))
otty2 <- data.frame(otty2)
otty3 <- read_excel(paste(exp, "_onetwo_", ccc, ".xlsx", sep=""))
otty3 <- data.frame(otty3)
obsy <- read_excel(paste(exp, "_cells_obs_v2_xy.xlsx", sep=""))
obsy <- data.frame(obsy)
###

### Combine observations and spot calls
head(obsy)
obsy <- obsy[ order(obsy[,5]), ]
head(obsy)
obs <- obsy[c("Strain", "Cond", "Exp", "t", "Cell", "Observations")]
otty1 <- arrange(otty1, Cell)
otty2 <- arrange(otty2, Cell)
otty3 <- arrange(otty3, Cell)

obs$spotrep1 <- otty1[otty1$Cell %in% obs$Cell, 'Spots']
obs$spotrep2 <- otty2[otty2$Cell %in% obs$Cell, 'Spots']
obs$spotrep3 <- otty3[otty3$Cell %in% obs$Cell, 'Spots']
obst <- obs
head(obst, 20)
colnames(obst)[c(7,8,9)] <- c(aaa, bbb, ccc)
###

### Export xlsx
write.xlsx(obst, paste(exp, "_obs_spotsrepsy1.xlsx", sep=""))
