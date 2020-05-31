###
### Merge manual and computer spot calls
### Dec 01, 2017
### Trent
###

### Packages ###
#library(xlsx)
library(readxl)


### File load ###
setwd("/media/trent/INT2TB/root/Work/3 Appointments/UC Davis/Shared/Research/Yeast/teto-tetr/wlys/spot")
####################

####################
obs <- read_excel("obs_spotreps_comb6.xlsx")
obs <- data.frame(obs)
obs <- obs[,-1]
tail(obs)

obs$t <- paste("t", obs$t, sep="")
obs$desc <- paste(obs$Strain, "_", obs$Cond, "_", obs$Exp, "_", obs$t, sep="")
obs <- subset(obs, Cond %in% c("WT", "SP"))
bc <- obs
head(bc)

bc <- bc[ order(bc[,5]), ]
head(bc, 10)
bc <- unique(bc)
tail(bc)
unique(bc$desc)

####################

####################
dist <- read.csv("conf_comb5.csv", na.strings=c("NA"))
#dist1 <- subset(dist, cond %in% c("WT"))
dist1 <- dist
dist2 <- dist1[,c(-5,-6)]
dist2$desc <- paste(dist2$strain, "_", dist2$cond, "_", dist2$exp, "_", dist2$t, sep="")
d2c <- dist2
head(d2c)

dist2cc <- d2c[ order(d2c[,1], d2c[,2], d2c[,3], d2c[,4], d2c[,5], d2c[,6]), ]
head(dist2cc)
unique(dist2cc$desc)
########################################
########################################



#####
ddd <- "HET5_WT_2_t0"
bc.het.wt.2.t0 <- subset(bc, desc == ddd)
tail(bc.het.wt.2.t0)
cdist.het.wt.2.t0 <- subset(dist2cc, desc == ddd)
head(cdist.het.wt.2.t0)
cdist.het.wt.2.t0$obs <- bc.het.wt.2.t0$Observations
cdist.het.wt.2.t0$rep1 <- bc.het.wt.2.t0$rep1
cdist.het.wt.2.t0$rep2 <- bc.het.wt.2.t0$rep2
cdist.het.wt.2.t0$rep3 <- bc.het.wt.2.t0$rep3
ddd <- "HET5_WT_2_t1"
bc.het.wt.2.t1 <- subset(bc, desc == ddd)
head(bc.het.wt.2.t1)
cdist.het.wt.2.t1 <- subset(dist2cc, desc == ddd)
head(cdist.het.wt.2.t1)
cdist.het.wt.2.t1$obs <- bc.het.wt.2.t1$Observations
cdist.het.wt.2.t1$rep1 <- bc.het.wt.2.t1$rep1
cdist.het.wt.2.t1$rep2 <- bc.het.wt.2.t1$rep2
cdist.het.wt.2.t1$rep3 <- bc.het.wt.2.t1$rep3
ddd <- "HET5_WT_2_t2"
bc.het.wt.2.t2 <- subset(bc, desc == ddd)
head(bc.het.wt.2.t2)
cdist.het.wt.2.t2 <- subset(dist2cc, desc == ddd)
head(cdist.het.wt.2.t2)
cdist.het.wt.2.t2$obs <- bc.het.wt.2.t2$Observations
cdist.het.wt.2.t2$rep1 <- bc.het.wt.2.t2$rep1
cdist.het.wt.2.t2$rep2 <- bc.het.wt.2.t2$rep2
cdist.het.wt.2.t2$rep3 <- bc.het.wt.2.t2$rep3
ddd <- "HET5_WT_2_t3"
bc.het.wt.2.t3 <- subset(bc, desc == ddd)
head(bc.het.wt.2.t3)
cdist.het.wt.2.t3 <- subset(dist2cc, desc == ddd)
head(cdist.het.wt.2.t3)
cdist.het.wt.2.t3$obs <- bc.het.wt.2.t3$Observations
cdist.het.wt.2.t3$rep1 <- bc.het.wt.2.t3$rep1
cdist.het.wt.2.t3$rep2 <- bc.het.wt.2.t3$rep2
cdist.het.wt.2.t3$rep3 <- bc.het.wt.2.t3$rep3
ddd <- "HET5_WT_2_t4"
bc.het.wt.2.t4 <- subset(bc, desc == ddd)
head(bc.het.wt.2.t4)
cdist.het.wt.2.t4 <- subset(dist2cc, desc == ddd)
head(cdist.het.wt.2.t4)
cdist.het.wt.2.t4$obs <- bc.het.wt.2.t4$Observations
cdist.het.wt.2.t4$rep1 <- bc.het.wt.2.t4$rep1
cdist.het.wt.2.t4$rep2 <- bc.het.wt.2.t4$rep2
cdist.het.wt.2.t4$rep3 <- bc.het.wt.2.t4$rep3
ddd <- "HET5_WT_2_t5"
bc.het.wt.2.t5 <- subset(bc, desc == ddd)
tail(bc.het.wt.2.t5)
cdist.het.wt.2.t5 <- subset(dist2cc, desc == ddd)
tail(cdist.het.wt.2.t5)
cdist.het.wt.2.t5$obs <- bc.het.wt.2.t5$Observations
cdist.het.wt.2.t5$rep1 <- bc.het.wt.2.t5$rep1
cdist.het.wt.2.t5$rep2 <- bc.het.wt.2.t5$rep2
cdist.het.wt.2.t5$rep3 <- bc.het.wt.2.t5$rep3
#####

#####
ddd <- "HET5_WT_3_t0"
bc.het.wt.3.t0 <- subset(bc, desc == ddd)
head(bc.het.wt.3.t0)
cdist.het.wt.3.t0 <- subset(dist2cc, desc == ddd)
head(cdist.het.wt.3.t0)
cdist.het.wt.3.t0$obs <- bc.het.wt.3.t0$Observations
cdist.het.wt.3.t0$rep1 <- bc.het.wt.3.t0$rep1
cdist.het.wt.3.t0$rep2 <- bc.het.wt.3.t0$rep2
cdist.het.wt.3.t0$rep3 <- bc.het.wt.3.t0$rep3
ddd <- "HET5_WT_3_t1"
bc.het.wt.3.t1 <- subset(bc, desc == ddd)
head(bc.het.wt.3.t1)
cdist.het.wt.3.t1 <- subset(dist2cc, desc == ddd)
head(cdist.het.wt.3.t1)
cdist.het.wt.3.t1$obs <- bc.het.wt.3.t1$Observations
cdist.het.wt.3.t1$rep1 <- bc.het.wt.3.t1$rep1
cdist.het.wt.3.t1$rep2 <- bc.het.wt.3.t1$rep2
cdist.het.wt.3.t1$rep3 <- bc.het.wt.3.t1$rep3
ddd <- "HET5_WT_3_t2"
bc.het.wt.3.t2 <- subset(bc, desc == ddd)
head(bc.het.wt.3.t2)
cdist.het.wt.3.t2 <- subset(dist2cc, desc == ddd)
head(cdist.het.wt.3.t2)
cdist.het.wt.3.t2$obs <- bc.het.wt.3.t2$Observations
cdist.het.wt.3.t2$rep1 <- bc.het.wt.3.t2$rep1
cdist.het.wt.3.t2$rep2 <- bc.het.wt.3.t2$rep2
cdist.het.wt.3.t2$rep3 <- bc.het.wt.3.t2$rep3
ddd <- "HET5_WT_3_t3"
bc.het.wt.3.t3 <- subset(bc, desc == ddd)
head(bc.het.wt.3.t3)
cdist.het.wt.3.t3 <- subset(dist2cc, desc == ddd)
head(cdist.het.wt.3.t3)
cdist.het.wt.3.t3$obs <- bc.het.wt.3.t3$Observations
cdist.het.wt.3.t3$rep1 <- bc.het.wt.3.t3$rep1
cdist.het.wt.3.t3$rep2 <- bc.het.wt.3.t3$rep2
cdist.het.wt.3.t3$rep3 <- bc.het.wt.3.t3$rep3
ddd <- "HET5_WT_3_t4"
bc.het.wt.3.t4 <- subset(bc, desc == ddd)
head(bc.het.wt.3.t4)
cdist.het.wt.3.t4 <- subset(dist2cc, desc == ddd)
head(cdist.het.wt.3.t4)
cdist.het.wt.3.t4$obs <- bc.het.wt.3.t4$Observations
cdist.het.wt.3.t4$rep1 <- bc.het.wt.3.t4$rep1
cdist.het.wt.3.t4$rep2 <- bc.het.wt.3.t4$rep2
cdist.het.wt.3.t4$rep3 <- bc.het.wt.3.t4$rep3
ddd <- "HET5_WT_3_t5"
bc.het.wt.3.t5 <- subset(bc, desc == ddd)
head(bc.het.wt.3.t5)
cdist.het.wt.3.t5 <- subset(dist2cc, desc == ddd)
head(cdist.het.wt.3.t5)
cdist.het.wt.3.t5$obs <- bc.het.wt.3.t5$Observations
cdist.het.wt.3.t5$rep1 <- bc.het.wt.3.t5$rep1
cdist.het.wt.3.t5$rep2 <- bc.het.wt.3.t5$rep2
cdist.het.wt.3.t5$rep3 <- bc.het.wt.3.t5$rep3
ddd <- "HET5_WT_3_ta"
bc.het.wt.3.ta <- subset(bc, desc == ddd)
head(bc.het.wt.3.ta)
cdist.het.wt.3.ta <- subset(dist2cc, desc == ddd)
head(cdist.het.wt.3.ta)
cdist.het.wt.3.ta$obs <- bc.het.wt.3.ta$Observations
cdist.het.wt.3.ta$rep1 <- bc.het.wt.3.ta$rep1
cdist.het.wt.3.ta$rep2 <- bc.het.wt.3.ta$rep2
cdist.het.wt.3.ta$rep3 <- bc.het.wt.3.ta$rep3
#####

#####
ddd <- "LYS2_SP_1_t0"
bc.lys.sp.1.t0 <- subset(bc, desc == ddd)
tail(bc.lys.sp.1.t0)
cdist.lys.sp.1.t0 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.1.t0)
cdist.lys.sp.1.t0$obs <- bc.lys.sp.1.t0$Observations
cdist.lys.sp.1.t0$rep1 <- bc.lys.sp.1.t0$rep1
cdist.lys.sp.1.t0$rep2 <- bc.lys.sp.1.t0$rep2
cdist.lys.sp.1.t0$rep3 <- bc.lys.sp.1.t0$rep3
ddd <- "LYS2_SP_1_t1"
bc.lys.sp.1.t1 <- subset(bc, desc == ddd)
tail(bc.lys.sp.1.t1)
cdist.lys.sp.1.t1 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.1.t1)
cdist.lys.sp.1.t1$obs <- bc.lys.sp.1.t1$Observations
cdist.lys.sp.1.t1$rep1 <- bc.lys.sp.1.t1$rep1
cdist.lys.sp.1.t1$rep2 <- bc.lys.sp.1.t1$rep2
cdist.lys.sp.1.t1$rep3 <- bc.lys.sp.1.t1$rep3
ddd <- "LYS2_SP_1_t2"
bc.lys.sp.1.t2 <- subset(bc, desc == ddd)
tail(bc.lys.sp.1.t2)
cdist.lys.sp.1.t2 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.1.t2)
cdist.lys.sp.1.t2$obs <- bc.lys.sp.1.t2$Observations
cdist.lys.sp.1.t2$rep1 <- bc.lys.sp.1.t2$rep1
cdist.lys.sp.1.t2$rep2 <- bc.lys.sp.1.t2$rep2
cdist.lys.sp.1.t2$rep3 <- bc.lys.sp.1.t2$rep3
ddd <- "LYS2_SP_1_t3"
bc.lys.sp.1.t3 <- subset(bc, desc == ddd)
tail(bc.lys.sp.1.t3)
cdist.lys.sp.1.t3 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.1.t3)
cdist.lys.sp.1.t3$obs <- bc.lys.sp.1.t3$Observations
cdist.lys.sp.1.t3$rep1 <- bc.lys.sp.1.t3$rep1
cdist.lys.sp.1.t3$rep2 <- bc.lys.sp.1.t3$rep2
cdist.lys.sp.1.t3$rep3 <- bc.lys.sp.1.t3$rep3
ddd <- "LYS2_SP_1_t4"
bc.lys.sp.1.t4 <- subset(bc, desc == ddd)
tail(bc.lys.sp.1.t4)
cdist.lys.sp.1.t4 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.1.t4)
cdist.lys.sp.1.t4$obs <- bc.lys.sp.1.t4$Observations
cdist.lys.sp.1.t4$rep1 <- bc.lys.sp.1.t4$rep1
cdist.lys.sp.1.t4$rep2 <- bc.lys.sp.1.t4$rep2
cdist.lys.sp.1.t4$rep3 <- bc.lys.sp.1.t4$rep3
ddd <- "LYS2_SP_1_t5"
bc.lys.sp.1.t5 <- subset(bc, desc == ddd)
tail(bc.lys.sp.1.t5)
cdist.lys.sp.1.t5 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.1.t5)
cdist.lys.sp.1.t5$obs <- bc.lys.sp.1.t5$Observations
cdist.lys.sp.1.t5$rep1 <- bc.lys.sp.1.t5$rep1
cdist.lys.sp.1.t5$rep2 <- bc.lys.sp.1.t5$rep2
cdist.lys.sp.1.t5$rep3 <- bc.lys.sp.1.t5$rep3
#####

#####
ddd <- "LYS2_SP_2_t0"
bc.lys.sp.2.t0 <- subset(bc, desc == ddd)
tail(bc.lys.sp.2.t0)
cdist.lys.sp.2.t0 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.2.t0)
cdist.lys.sp.2.t0$obs <- bc.lys.sp.2.t0$Observations
cdist.lys.sp.2.t0$rep1 <- bc.lys.sp.2.t0$rep1
cdist.lys.sp.2.t0$rep2 <- bc.lys.sp.2.t0$rep2
cdist.lys.sp.2.t0$rep3 <- bc.lys.sp.2.t0$rep3
ddd <- "LYS2_SP_2_t1"
bc.lys.sp.2.t1 <- subset(bc, desc == ddd)
tail(bc.lys.sp.2.t1)
cdist.lys.sp.2.t1 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.2.t1)
cdist.lys.sp.2.t1$obs <- bc.lys.sp.2.t1$Observations
cdist.lys.sp.2.t1$rep1 <- bc.lys.sp.2.t1$rep1
cdist.lys.sp.2.t1$rep2 <- bc.lys.sp.2.t1$rep2
cdist.lys.sp.2.t1$rep3 <- bc.lys.sp.2.t1$rep3
ddd <- "LYS2_SP_2_t2"
bc.lys.sp.2.t2 <- subset(bc, desc == ddd)
tail(bc.lys.sp.2.t2)
cdist.lys.sp.2.t2 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.2.t2)
cdist.lys.sp.2.t2$obs <- bc.lys.sp.2.t2$Observations
cdist.lys.sp.2.t2$rep1 <- bc.lys.sp.2.t2$rep1
cdist.lys.sp.2.t2$rep2 <- bc.lys.sp.2.t2$rep2
cdist.lys.sp.2.t2$rep3 <- bc.lys.sp.2.t2$rep3
ddd <- "LYS2_SP_2_t3"
bc.lys.sp.2.t3 <- subset(bc, desc == ddd)
tail(bc.lys.sp.2.t3)
cdist.lys.sp.2.t3 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.2.t3)
cdist.lys.sp.2.t3$obs <- bc.lys.sp.2.t3$Observations
cdist.lys.sp.2.t3$rep1 <- bc.lys.sp.2.t3$rep1
cdist.lys.sp.2.t3$rep2 <- bc.lys.sp.2.t3$rep2
cdist.lys.sp.2.t3$rep3 <- bc.lys.sp.2.t3$rep3
ddd <- "LYS2_SP_2_t4"
bc.lys.sp.2.t4 <- subset(bc, desc == ddd)
tail(bc.lys.sp.2.t4)
cdist.lys.sp.2.t4 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.2.t4)
cdist.lys.sp.2.t4$obs <- bc.lys.sp.2.t4$Observations
cdist.lys.sp.2.t4$rep1 <- bc.lys.sp.2.t4$rep1
cdist.lys.sp.2.t4$rep2 <- bc.lys.sp.2.t4$rep2
cdist.lys.sp.2.t4$rep3 <- bc.lys.sp.2.t4$rep3
ddd <- "LYS2_SP_2_t5"
bc.lys.sp.2.t5 <- subset(bc, desc == ddd)
tail(bc.lys.sp.2.t5)
cdist.lys.sp.2.t5 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.2.t5)
cdist.lys.sp.2.t5$obs <- bc.lys.sp.2.t5$Observations
cdist.lys.sp.2.t5$rep1 <- bc.lys.sp.2.t5$rep1
cdist.lys.sp.2.t5$rep2 <- bc.lys.sp.2.t5$rep2
cdist.lys.sp.2.t5$rep3 <- bc.lys.sp.2.t5$rep3
ddd <- "LYS2_SP_2_t6"
bc.lys.sp.2.t6 <- subset(bc, desc == ddd)
tail(bc.lys.sp.2.t6)
cdist.lys.sp.2.t6 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.2.t6)
cdist.lys.sp.2.t6$obs <- bc.lys.sp.2.t6$Observations
cdist.lys.sp.2.t6$rep1 <- bc.lys.sp.2.t6$rep1
cdist.lys.sp.2.t6$rep2 <- bc.lys.sp.2.t6$rep2
cdist.lys.sp.2.t6$rep3 <- bc.lys.sp.2.t6$rep3
#####

#####
ddd <- "LYS2_SP_3_t0"
bc.lys.sp.3.t0 <- subset(bc, desc == ddd)
tail(bc.lys.sp.3.t0)
cdist.lys.sp.3.t0 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.3.t0)
cdist.lys.sp.3.t0$obs <- bc.lys.sp.3.t0$Observations
cdist.lys.sp.3.t0$rep1 <- bc.lys.sp.3.t0$rep1
cdist.lys.sp.3.t0$rep2 <- bc.lys.sp.3.t0$rep2
cdist.lys.sp.3.t0$rep3 <- bc.lys.sp.3.t0$rep3
ddd <- "LYS2_SP_3_t1"
bc.lys.sp.3.t1 <- subset(bc, desc == ddd)
tail(bc.lys.sp.3.t1)
cdist.lys.sp.3.t1 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.3.t1)
cdist.lys.sp.3.t1$obs <- bc.lys.sp.3.t1$Observations
cdist.lys.sp.3.t1$rep1 <- bc.lys.sp.3.t1$rep1
cdist.lys.sp.3.t1$rep2 <- bc.lys.sp.3.t1$rep2
cdist.lys.sp.3.t1$rep3 <- bc.lys.sp.3.t1$rep3
ddd <- "LYS2_SP_3_t2"
bc.lys.sp.3.t2 <- subset(bc, desc == ddd)
tail(bc.lys.sp.3.t2)
cdist.lys.sp.3.t2 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.3.t2)
cdist.lys.sp.3.t2$obs <- bc.lys.sp.3.t2$Observations
cdist.lys.sp.3.t2$rep1 <- bc.lys.sp.3.t2$rep1
cdist.lys.sp.3.t2$rep2 <- bc.lys.sp.3.t2$rep2
cdist.lys.sp.3.t2$rep3 <- bc.lys.sp.3.t2$rep3
ddd <- "LYS2_SP_3_t3"
bc.lys.sp.3.t3 <- subset(bc, desc == ddd)
tail(bc.lys.sp.3.t3)
cdist.lys.sp.3.t3 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.3.t3)
cdist.lys.sp.3.t3$obs <- bc.lys.sp.3.t3$Observations
cdist.lys.sp.3.t3$rep1 <- bc.lys.sp.3.t3$rep1
cdist.lys.sp.3.t3$rep2 <- bc.lys.sp.3.t3$rep2
cdist.lys.sp.3.t3$rep3 <- bc.lys.sp.3.t3$rep3
ddd <- "LYS2_SP_3_t4"
bc.lys.sp.3.t4 <- subset(bc, desc == ddd)
tail(bc.lys.sp.3.t4)
cdist.lys.sp.3.t4 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.3.t4)
cdist.lys.sp.3.t4$obs <- bc.lys.sp.3.t4$Observations
cdist.lys.sp.3.t4$rep1 <- bc.lys.sp.3.t4$rep1
cdist.lys.sp.3.t4$rep2 <- bc.lys.sp.3.t4$rep2
cdist.lys.sp.3.t4$rep3 <- bc.lys.sp.3.t4$rep3
ddd <- "LYS2_SP_3_t5"
bc.lys.sp.3.t5 <- subset(bc, desc == ddd)
tail(bc.lys.sp.3.t5)
cdist.lys.sp.3.t5 <- subset(dist2cc, desc == ddd)
head(cdist.lys.sp.3.t5)
cdist.lys.sp.3.t5$obs <- bc.lys.sp.3.t5$Observations
cdist.lys.sp.3.t5$rep1 <- bc.lys.sp.3.t5$rep1
cdist.lys.sp.3.t5$rep2 <- bc.lys.sp.3.t5$rep2
cdist.lys.sp.3.t5$rep3 <- bc.lys.sp.3.t5$rep3
#####

#####
ddd <- "LYS2_WT_1_t0"
bc.lys.wt.1.t0 <- subset(bc, desc == ddd)
tail(bc.lys.wt.1.t0)
cdist.lys.wt.1.t0 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.1.t0)
cdist.lys.wt.1.t0$obs <- bc.lys.wt.1.t0$Observations
cdist.lys.wt.1.t0$rep1 <- bc.lys.wt.1.t0$rep1
cdist.lys.wt.1.t0$rep2 <- bc.lys.wt.1.t0$rep2
cdist.lys.wt.1.t0$rep3 <- bc.lys.wt.1.t0$rep3
ddd <- "LYS2_WT_1_t1"
bc.lys.wt.1.t1 <- subset(bc, desc == ddd)
tail(bc.lys.wt.1.t1)
cdist.lys.wt.1.t1 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.1.t1)
cdist.lys.wt.1.t1$obs <- bc.lys.wt.1.t1$Observations
cdist.lys.wt.1.t1$rep1 <- bc.lys.wt.1.t1$rep1
cdist.lys.wt.1.t1$rep2 <- bc.lys.wt.1.t1$rep2
cdist.lys.wt.1.t1$rep3 <- bc.lys.wt.1.t1$rep3
ddd <- "LYS2_WT_1_t2"
bc.lys.wt.1.t2 <- subset(bc, desc == ddd)
tail(bc.lys.wt.1.t2)
cdist.lys.wt.1.t2 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.1.t2)
cdist.lys.wt.1.t2$obs <- bc.lys.wt.1.t2$Observations
cdist.lys.wt.1.t2$rep1 <- bc.lys.wt.1.t2$rep1
cdist.lys.wt.1.t2$rep2 <- bc.lys.wt.1.t2$rep2
cdist.lys.wt.1.t2$rep3 <- bc.lys.wt.1.t2$rep3
ddd <- "LYS2_WT_1_t3"
bc.lys.wt.1.t3 <- subset(bc, desc == ddd)
tail(bc.lys.wt.1.t3)
cdist.lys.wt.1.t3 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.1.t3)
cdist.lys.wt.1.t3$obs <- bc.lys.wt.1.t3$Observations
cdist.lys.wt.1.t3$rep1 <- bc.lys.wt.1.t3$rep1
cdist.lys.wt.1.t3$rep2 <- bc.lys.wt.1.t3$rep2
cdist.lys.wt.1.t3$rep3 <- bc.lys.wt.1.t3$rep3
ddd <- "LYS2_WT_1_t4"
bc.lys.wt.1.t4 <- subset(bc, desc == ddd)
tail(bc.lys.wt.1.t4)
cdist.lys.wt.1.t4 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.1.t4)
cdist.lys.wt.1.t4$obs <- bc.lys.wt.1.t4$Observations
cdist.lys.wt.1.t4$rep1 <- bc.lys.wt.1.t4$rep1
cdist.lys.wt.1.t4$rep2 <- bc.lys.wt.1.t4$rep2
cdist.lys.wt.1.t4$rep3 <- bc.lys.wt.1.t4$rep3
ddd <- "LYS2_WT_1_t5"
bc.lys.wt.1.t5 <- subset(bc, desc == ddd)
tail(bc.lys.wt.1.t5)
cdist.lys.wt.1.t5 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.1.t5)
cdist.lys.wt.1.t5$obs <- bc.lys.wt.1.t5$Observations
cdist.lys.wt.1.t5$rep1 <- bc.lys.wt.1.t5$rep1
cdist.lys.wt.1.t5$rep2 <- bc.lys.wt.1.t5$rep2
cdist.lys.wt.1.t5$rep3 <- bc.lys.wt.1.t5$rep3
ddd <- "LYS2_WT_1_t6"
bc.lys.wt.1.t6 <- subset(bc, desc == ddd)
tail(bc.lys.wt.1.t6)
cdist.lys.wt.1.t6 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.1.t6)
cdist.lys.wt.1.t6$obs <- bc.lys.wt.1.t6$Observations
cdist.lys.wt.1.t6$rep1 <- bc.lys.wt.1.t6$rep1
cdist.lys.wt.1.t6$rep2 <- bc.lys.wt.1.t6$rep2
cdist.lys.wt.1.t6$rep3 <- bc.lys.wt.1.t6$rep3
#####

#####
ddd <- "LYS2_WT_2_t0"
bc.lys.wt.2.t0 <- subset(bc, desc == ddd)
tail(bc.lys.wt.2.t0)
cdist.lys.wt.2.t0 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.2.t0)
cdist.lys.wt.2.t0$obs <- bc.lys.wt.2.t0$Observations
cdist.lys.wt.2.t0$rep1 <- bc.lys.wt.2.t0$rep1
cdist.lys.wt.2.t0$rep2 <- bc.lys.wt.2.t0$rep2
cdist.lys.wt.2.t0$rep3 <- bc.lys.wt.2.t0$rep3
ddd <- "LYS2_WT_2_t1"
bc.lys.wt.2.t1 <- subset(bc, desc == ddd)
tail(bc.lys.wt.2.t1)
cdist.lys.wt.2.t1 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.2.t1)
cdist.lys.wt.2.t1$obs <- bc.lys.wt.2.t1$Observations
cdist.lys.wt.2.t1$rep1 <- bc.lys.wt.2.t1$rep1
cdist.lys.wt.2.t1$rep2 <- bc.lys.wt.2.t1$rep2
cdist.lys.wt.2.t1$rep3 <- bc.lys.wt.2.t1$rep3
ddd <- "LYS2_WT_2_t2"
bc.lys.wt.2.t2 <- subset(bc, desc == ddd)
tail(bc.lys.wt.2.t2)
cdist.lys.wt.2.t2 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.2.t2)
cdist.lys.wt.2.t2$obs <- bc.lys.wt.2.t2$Observations
cdist.lys.wt.2.t2$rep1 <- bc.lys.wt.2.t2$rep1
cdist.lys.wt.2.t2$rep2 <- bc.lys.wt.2.t2$rep2
cdist.lys.wt.2.t2$rep3 <- bc.lys.wt.2.t2$rep3
ddd <- "LYS2_WT_2_t3"
bc.lys.wt.2.t3 <- subset(bc, desc == ddd)
tail(bc.lys.wt.2.t3)
cdist.lys.wt.2.t3 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.2.t3)
cdist.lys.wt.2.t3$obs <- bc.lys.wt.2.t3$Observations
cdist.lys.wt.2.t3$rep1 <- bc.lys.wt.2.t3$rep1
cdist.lys.wt.2.t3$rep2 <- bc.lys.wt.2.t3$rep2
cdist.lys.wt.2.t3$rep3 <- bc.lys.wt.2.t3$rep3
ddd <- "LYS2_WT_2_t4"
bc.lys.wt.2.t4 <- subset(bc, desc == ddd)
tail(bc.lys.wt.2.t4)
cdist.lys.wt.2.t4 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.2.t4)
cdist.lys.wt.2.t4$obs <- bc.lys.wt.2.t4$Observations
cdist.lys.wt.2.t4$rep1 <- bc.lys.wt.2.t4$rep1
cdist.lys.wt.2.t4$rep2 <- bc.lys.wt.2.t4$rep2
cdist.lys.wt.2.t4$rep3 <- bc.lys.wt.2.t4$rep3
#####

#####
ddd <- "LYS2_WT_3_t0"
bc.lys.wt.3.t0 <- subset(bc, desc == ddd)
tail(bc.lys.wt.3.t0)
cdist.lys.wt.3.t0 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.3.t0)
cdist.lys.wt.3.t0$obs <- bc.lys.wt.3.t0$Observations
cdist.lys.wt.3.t0$rep1 <- bc.lys.wt.3.t0$rep1
cdist.lys.wt.3.t0$rep2 <- bc.lys.wt.3.t0$rep2
cdist.lys.wt.3.t0$rep3 <- bc.lys.wt.3.t0$rep3
ddd <- "LYS2_WT_3_t1"
bc.lys.wt.3.t1 <- subset(bc, desc == ddd)
tail(bc.lys.wt.3.t1)
cdist.lys.wt.3.t1 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.3.t1)
cdist.lys.wt.3.t1$obs <- bc.lys.wt.3.t1$Observations
cdist.lys.wt.3.t1$rep1 <- bc.lys.wt.3.t1$rep1
cdist.lys.wt.3.t1$rep2 <- bc.lys.wt.3.t1$rep2
cdist.lys.wt.3.t1$rep3 <- bc.lys.wt.3.t1$rep3
ddd <- "LYS2_WT_3_t2"
bc.lys.wt.3.t2 <- subset(bc, desc == ddd)
tail(bc.lys.wt.3.t2)
cdist.lys.wt.3.t2 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.3.t2)
cdist.lys.wt.3.t2$obs <- bc.lys.wt.3.t2$Observations
cdist.lys.wt.3.t2$rep1 <- bc.lys.wt.3.t2$rep1
cdist.lys.wt.3.t2$rep2 <- bc.lys.wt.3.t2$rep2
cdist.lys.wt.3.t2$rep3 <- bc.lys.wt.3.t2$rep3
ddd <- "LYS2_WT_3_t3"
bc.lys.wt.3.t3 <- subset(bc, desc == ddd)
tail(bc.lys.wt.3.t3)
cdist.lys.wt.3.t3 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.3.t3)
cdist.lys.wt.3.t3$obs <- bc.lys.wt.3.t3$Observations
cdist.lys.wt.3.t3$rep1 <- bc.lys.wt.3.t3$rep1
cdist.lys.wt.3.t3$rep2 <- bc.lys.wt.3.t3$rep2
cdist.lys.wt.3.t3$rep3 <- bc.lys.wt.3.t3$rep3
ddd <- "LYS2_WT_3_t5"
bc.lys.wt.3.t5 <- subset(bc, desc == ddd)
tail(bc.lys.wt.3.t5)
cdist.lys.wt.3.t5 <- subset(dist2cc, desc == ddd)
head(cdist.lys.wt.3.t5)
cdist.lys.wt.3.t5$obs <- bc.lys.wt.3.t5$Observations
cdist.lys.wt.3.t5$rep1 <- bc.lys.wt.3.t5$rep1
cdist.lys.wt.3.t5$rep2 <- bc.lys.wt.3.t5$rep2
cdist.lys.wt.3.t5$rep3 <- bc.lys.wt.3.t5$rep3
#####

#####
ddd <- "URA3_SP_1_t0"
bc.ura3.sp.1.t0 <- subset(bc, desc == ddd)
head(bc.ura3.sp.1.t0)
length(bc.ura3.sp.1.t0$Strain)
cdist.ura3.sp.1.t0 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.1.t0)
length(cdist.ura3.sp.1.t0$strain)
cdist.ura3.sp.1.t0$obs <- bc.ura3.sp.1.t0$Observations
cdist.ura3.sp.1.t0$rep1 <- bc.ura3.sp.1.t0$rep1
cdist.ura3.sp.1.t0$rep2 <- bc.ura3.sp.1.t0$rep2
cdist.ura3.sp.1.t0$rep3 <- bc.ura3.sp.1.t0$rep3
ddd <- "URA3_SP_1_t1"
bc.ura3.sp.1.t1 <- subset(bc, desc == ddd)
head(bc.ura3.sp.1.t1)
cdist.ura3.sp.1.t1 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.1.t1)
cdist.ura3.sp.1.t1$obs <- bc.ura3.sp.1.t1$Observations
cdist.ura3.sp.1.t1$rep1 <- bc.ura3.sp.1.t1$rep1
cdist.ura3.sp.1.t1$rep2 <- bc.ura3.sp.1.t1$rep2
cdist.ura3.sp.1.t1$rep3 <- bc.ura3.sp.1.t1$rep3
ddd <- "URA3_SP_1_t2"
bc.ura3.sp.1.t2 <- subset(bc, desc == ddd)
head(bc.ura3.sp.1.t2)
cdist.ura3.sp.1.t2 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.1.t2)
cdist.ura3.sp.1.t2$obs <- bc.ura3.sp.1.t2$Observations
cdist.ura3.sp.1.t2$rep1 <- bc.ura3.sp.1.t2$rep1
cdist.ura3.sp.1.t2$rep2 <- bc.ura3.sp.1.t2$rep2
cdist.ura3.sp.1.t2$rep3 <- bc.ura3.sp.1.t2$rep3
ddd <- "URA3_SP_1_t3"
bc.ura3.sp.1.t3 <- subset(bc, desc == ddd)
head(bc.ura3.sp.1.t3)
cdist.ura3.sp.1.t3 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.1.t3)
cdist.ura3.sp.1.t3$obs <- bc.ura3.sp.1.t3$Observations
cdist.ura3.sp.1.t3$rep1 <- bc.ura3.sp.1.t3$rep1
cdist.ura3.sp.1.t3$rep2 <- bc.ura3.sp.1.t3$rep2
cdist.ura3.sp.1.t3$rep3 <- bc.ura3.sp.1.t3$rep3
ddd <- "URA3_SP_1_t4"
bc.ura3.sp.1.t4 <- subset(bc, desc == ddd)
head(bc.ura3.sp.1.t4)
cdist.ura3.sp.1.t4 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.1.t4)
cdist.ura3.sp.1.t4$obs <- bc.ura3.sp.1.t4$Observations
cdist.ura3.sp.1.t4$rep1 <- bc.ura3.sp.1.t4$rep1
cdist.ura3.sp.1.t4$rep2 <- bc.ura3.sp.1.t4$rep2
cdist.ura3.sp.1.t4$rep3 <- bc.ura3.sp.1.t4$rep3
ddd <- "URA3_SP_1_t5"
bc.ura3.sp.1.t5 <- subset(bc, desc == ddd)
head(bc.ura3.sp.1.t5)
cdist.ura3.sp.1.t5 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.1.t5)
cdist.ura3.sp.1.t5$obs <- bc.ura3.sp.1.t5$Observations
cdist.ura3.sp.1.t5$rep1 <- bc.ura3.sp.1.t5$rep1
cdist.ura3.sp.1.t5$rep2 <- bc.ura3.sp.1.t5$rep2
cdist.ura3.sp.1.t5$rep3 <- bc.ura3.sp.1.t5$rep3
ddd <- "URA3_SP_1_t6"
bc.ura3.sp.1.t6 <- subset(bc, desc == ddd)
head(bc.ura3.sp.1.t6)
cdist.ura3.sp.1.t6 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.1.t6)
cdist.ura3.sp.1.t6$obs <- bc.ura3.sp.1.t6$Observations
cdist.ura3.sp.1.t6$rep1 <- bc.ura3.sp.1.t6$rep1
cdist.ura3.sp.1.t6$rep2 <- bc.ura3.sp.1.t6$rep2
cdist.ura3.sp.1.t6$rep3 <- bc.ura3.sp.1.t6$rep3
#####

#####
ddd <- "URA3_SP_2_t1"
bc.ura3.sp.2.t1 <- subset(bc, desc == ddd)
head(bc.ura3.sp.2.t1)
cdist.ura3.sp.2.t1 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.2.t1)
cdist.ura3.sp.2.t1$obs <- bc.ura3.sp.2.t1$Observations
cdist.ura3.sp.2.t1$rep1 <- bc.ura3.sp.2.t1$rep1
cdist.ura3.sp.2.t1$rep2 <- bc.ura3.sp.2.t1$rep2
cdist.ura3.sp.2.t1$rep3 <- bc.ura3.sp.2.t1$rep3
ddd <- "URA3_SP_2_t3"
bc.ura3.sp.2.t3 <- subset(bc, desc == ddd)
head(bc.ura3.sp.2.t3)
cdist.ura3.sp.2.t3 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.2.t3)
cdist.ura3.sp.2.t3$obs <- bc.ura3.sp.2.t3$Observations
cdist.ura3.sp.2.t3$rep1 <- bc.ura3.sp.2.t3$rep1
cdist.ura3.sp.2.t3$rep2 <- bc.ura3.sp.2.t3$rep2
cdist.ura3.sp.2.t3$rep3 <- bc.ura3.sp.2.t3$rep3
ddd <- "URA3_SP_2_t4"
bc.ura3.sp.2.t4 <- subset(bc, desc == ddd)
head(bc.ura3.sp.2.t4)
cdist.ura3.sp.2.t4 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.2.t4)
cdist.ura3.sp.2.t4$obs <- bc.ura3.sp.2.t4$Observations
cdist.ura3.sp.2.t4$rep1 <- bc.ura3.sp.2.t4$rep1
cdist.ura3.sp.2.t4$rep2 <- bc.ura3.sp.2.t4$rep2
cdist.ura3.sp.2.t4$rep3 <- bc.ura3.sp.2.t4$rep3
ddd <- "URA3_SP_2_t5"
bc.ura3.sp.2.t5 <- subset(bc, desc == ddd)
head(bc.ura3.sp.2.t5)
cdist.ura3.sp.2.t5 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.2.t5)
cdist.ura3.sp.2.t5$obs <- bc.ura3.sp.2.t5$Observations
cdist.ura3.sp.2.t5$rep1 <- bc.ura3.sp.2.t5$rep1
cdist.ura3.sp.2.t5$rep2 <- bc.ura3.sp.2.t5$rep2
cdist.ura3.sp.2.t5$rep3 <- bc.ura3.sp.2.t5$rep3
#####

#####
ddd <- "URA3_SP_3_t0"
bc.ura3.sp.3.t0 <- subset(bc, desc == ddd)
head(bc.ura3.sp.3.t0)
cdist.ura3.sp.3.t0 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.3.t0)
cdist.ura3.sp.3.t0$obs <- bc.ura3.sp.3.t0$Observations
cdist.ura3.sp.3.t0$rep1 <- bc.ura3.sp.3.t0$rep1
cdist.ura3.sp.3.t0$rep2 <- bc.ura3.sp.3.t0$rep2
cdist.ura3.sp.3.t0$rep3 <- bc.ura3.sp.3.t0$rep3
ddd <- "URA3_SP_3_t1"
bc.ura3.sp.3.t1 <- subset(bc, desc == ddd)
tail(bc.ura3.sp.3.t1)
cdist.ura3.sp.3.t1 <- subset(dist2cc, desc == ddd)
tail(cdist.ura3.sp.3.t1)
cdist.ura3.sp.3.t1$obs <- bc.ura3.sp.3.t1$Observations
cdist.ura3.sp.3.t1$rep1 <- bc.ura3.sp.3.t1$rep1
cdist.ura3.sp.3.t1$rep2 <- bc.ura3.sp.3.t1$rep2
cdist.ura3.sp.3.t1$rep3 <- bc.ura3.sp.3.t1$rep3
ddd <- "URA3_SP_3_t3"
bc.ura3.sp.3.t3 <- subset(bc, desc == ddd)
tail(bc.ura3.sp.3.t3)
cdist.ura3.sp.3.t3 <- subset(dist2cc, desc == ddd)
tail(cdist.ura3.sp.3.t3)
cdist.ura3.sp.3.t3$obs <- bc.ura3.sp.3.t3$Observations
cdist.ura3.sp.3.t3$rep1 <- bc.ura3.sp.3.t3$rep1
cdist.ura3.sp.3.t3$rep2 <- bc.ura3.sp.3.t3$rep2
cdist.ura3.sp.3.t3$rep3 <- bc.ura3.sp.3.t3$rep3
ddd <- "URA3_SP_3_t4"
bc.ura3.sp.3.t4 <- subset(bc, desc == ddd)
head(bc.ura3.sp.3.t4)
cdist.ura3.sp.3.t4 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.3.t4)
length(bc.ura3.sp.3.t4$Strain)
length(cdist.ura3.sp.3.t4$strain)
cdist.ura3.sp.3.t4$obs <- bc.ura3.sp.3.t4$Observations
cdist.ura3.sp.3.t4$rep1 <- bc.ura3.sp.3.t4$rep1
cdist.ura3.sp.3.t4$rep2 <- bc.ura3.sp.3.t4$rep2
cdist.ura3.sp.3.t4$rep3 <- bc.ura3.sp.3.t4$rep3
ddd <- "URA3_SP_3_t5"
bc.ura3.sp.3.t5 <- subset(bc, desc == ddd)
tail(bc.ura3.sp.3.t5)
cdist.ura3.sp.3.t5 <- subset(dist2cc, desc == ddd)
tail(cdist.ura3.sp.3.t5)
cdist.ura3.sp.3.t5$obs <- bc.ura3.sp.3.t5$Observations
cdist.ura3.sp.3.t5$rep1 <- bc.ura3.sp.3.t5$rep1
cdist.ura3.sp.3.t5$rep2 <- bc.ura3.sp.3.t5$rep2
cdist.ura3.sp.3.t5$rep3 <- bc.ura3.sp.3.t5$rep3
#####

#####
#####

#####
ddd <- "URA3_SP_5_t1"
bc.ura3.sp.5.t1 <- subset(bc, desc == ddd)
head(bc.ura3.sp.5.t1)
cdist.ura3.sp.5.t1 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.5.t1)
cdist.ura3.sp.5.t1$obs <- bc.ura3.sp.5.t1$Observations
cdist.ura3.sp.5.t1$rep1 <- bc.ura3.sp.5.t1$rep1
cdist.ura3.sp.5.t1$rep2 <- bc.ura3.sp.5.t1$rep2
cdist.ura3.sp.5.t1$rep3 <- bc.ura3.sp.5.t1$rep3
ddd <- "URA3_SP_5_t2"
bc.ura3.sp.5.t2 <- subset(bc, desc == ddd)
head(bc.ura3.sp.5.t2)
cdist.ura3.sp.5.t2 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.5.t2)
cdist.ura3.sp.5.t2$obs <- bc.ura3.sp.5.t2$Observations
cdist.ura3.sp.5.t2$rep1 <- bc.ura3.sp.5.t2$rep1
cdist.ura3.sp.5.t2$rep2 <- bc.ura3.sp.5.t2$rep2
cdist.ura3.sp.5.t2$rep3 <- bc.ura3.sp.5.t2$rep3
ddd <- "URA3_SP_5_t3"
bc.ura3.sp.5.t3 <- subset(bc, desc == ddd)
head(bc.ura3.sp.5.t3)
cdist.ura3.sp.5.t3 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.5.t3)
cdist.ura3.sp.5.t3$obs <- bc.ura3.sp.5.t3$Observations
cdist.ura3.sp.5.t3$rep1 <- bc.ura3.sp.5.t3$rep1
cdist.ura3.sp.5.t3$rep2 <- bc.ura3.sp.5.t3$rep2
cdist.ura3.sp.5.t3$rep3 <- bc.ura3.sp.5.t3$rep3
ddd <- "URA3_SP_5_t4"
bc.ura3.sp.5.t4 <- subset(bc, desc == ddd)
head(bc.ura3.sp.5.t4)
cdist.ura3.sp.5.t4 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.5.t4)
cdist.ura3.sp.5.t4$obs <- bc.ura3.sp.5.t4$Observations
cdist.ura3.sp.5.t4$rep1 <- bc.ura3.sp.5.t4$rep1
cdist.ura3.sp.5.t4$rep2 <- bc.ura3.sp.5.t4$rep2
cdist.ura3.sp.5.t4$rep3 <- bc.ura3.sp.5.t4$rep3
ddd <- "URA3_SP_5_t5"
bc.ura3.sp.5.t5 <- subset(bc, desc == ddd)
head(bc.ura3.sp.5.t5)
cdist.ura3.sp.5.t5 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.5.t5)
cdist.ura3.sp.5.t5$obs <- bc.ura3.sp.5.t5$Observations
cdist.ura3.sp.5.t5$rep1 <- bc.ura3.sp.5.t5$rep1
cdist.ura3.sp.5.t5$rep2 <- bc.ura3.sp.5.t5$rep2
cdist.ura3.sp.5.t5$rep3 <- bc.ura3.sp.5.t5$rep3
#####

#####
ddd <- "URA3_SP_6_t0"
bc.ura3.sp.6.t0 <- subset(bc, desc == ddd)
head(bc.ura3.sp.6.t0)
cdist.ura3.sp.6.t0 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.6.t0)
cdist.ura3.sp.6.t0$obs <- bc.ura3.sp.6.t0$Observations
cdist.ura3.sp.6.t0$rep1 <- bc.ura3.sp.6.t0$rep1
cdist.ura3.sp.6.t0$rep2 <- bc.ura3.sp.6.t0$rep2
cdist.ura3.sp.6.t0$rep3 <- bc.ura3.sp.6.t0$rep3
ddd <- "URA3_SP_6_t1"
bc.ura3.sp.6.t1 <- subset(bc, desc == ddd)
head(bc.ura3.sp.6.t1)
cdist.ura3.sp.6.t1 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.6.t1)
cdist.ura3.sp.6.t1$obs <- bc.ura3.sp.6.t1$Observations
cdist.ura3.sp.6.t1$rep1 <- bc.ura3.sp.6.t1$rep1
cdist.ura3.sp.6.t1$rep2 <- bc.ura3.sp.6.t1$rep2
cdist.ura3.sp.6.t1$rep3 <- bc.ura3.sp.6.t1$rep3
ddd <- "URA3_SP_6_t3"
bc.ura3.sp.6.t3 <- subset(bc, desc == ddd)
head(bc.ura3.sp.6.t3)
cdist.ura3.sp.6.t3 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.6.t3)
cdist.ura3.sp.6.t3$obs <- bc.ura3.sp.6.t3$Observations
cdist.ura3.sp.6.t3$rep1 <- bc.ura3.sp.6.t3$rep1
cdist.ura3.sp.6.t3$rep2 <- bc.ura3.sp.6.t3$rep2
cdist.ura3.sp.6.t3$rep3 <- bc.ura3.sp.6.t3$rep3
ddd <- "URA3_SP_6_t4"
bc.ura3.sp.6.t4 <- subset(bc, desc == ddd)
head(bc.ura3.sp.6.t4)
cdist.ura3.sp.6.t4 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.6.t4)
cdist.ura3.sp.6.t4$obs <- bc.ura3.sp.6.t4$Observations
cdist.ura3.sp.6.t4$rep1 <- bc.ura3.sp.6.t4$rep1
cdist.ura3.sp.6.t4$rep2 <- bc.ura3.sp.6.t4$rep2
cdist.ura3.sp.6.t4$rep3 <- bc.ura3.sp.6.t4$rep3
ddd <- "URA3_SP_6_t5"
bc.ura3.sp.6.t5 <- subset(bc, desc == ddd)
head(bc.ura3.sp.6.t5)
cdist.ura3.sp.6.t5 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.6.t5)
cdist.ura3.sp.6.t5$obs <- bc.ura3.sp.6.t5$Observations
cdist.ura3.sp.6.t5$rep1 <- bc.ura3.sp.6.t5$rep1
cdist.ura3.sp.6.t5$rep2 <- bc.ura3.sp.6.t5$rep2
cdist.ura3.sp.6.t5$rep3 <- bc.ura3.sp.6.t5$rep3
#####

#####
ddd <- "URA3_SP_7_t0"
bc.ura3.sp.7.t0 <- subset(bc, desc == ddd)
head(bc.ura3.sp.7.t0)
cdist.ura3.sp.7.t0 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.7.t0)
cdist.ura3.sp.7.t0$obs <- bc.ura3.sp.7.t0$Observations
cdist.ura3.sp.7.t0$rep1 <- bc.ura3.sp.7.t0$rep1
cdist.ura3.sp.7.t0$rep2 <- bc.ura3.sp.7.t0$rep2
cdist.ura3.sp.7.t0$rep3 <- bc.ura3.sp.7.t0$rep3
ddd <- "URA3_SP_7_t1"
bc.ura3.sp.7.t1 <- subset(bc, desc == ddd)
head(bc.ura3.sp.7.t1)
cdist.ura3.sp.7.t1 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.7.t1)
cdist.ura3.sp.7.t1$obs <- bc.ura3.sp.7.t1$Observations
cdist.ura3.sp.7.t1$rep1 <- bc.ura3.sp.7.t1$rep1
cdist.ura3.sp.7.t1$rep2 <- bc.ura3.sp.7.t1$rep2
cdist.ura3.sp.7.t1$rep3 <- bc.ura3.sp.7.t1$rep3
ddd <- "URA3_SP_7_t2"
bc.ura3.sp.7.t2 <- subset(bc, desc == ddd)
head(bc.ura3.sp.7.t2)
cdist.ura3.sp.7.t2 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.7.t2)
cdist.ura3.sp.7.t2$obs <- bc.ura3.sp.7.t2$Observations
cdist.ura3.sp.7.t2$rep1 <- bc.ura3.sp.7.t2$rep1
cdist.ura3.sp.7.t2$rep2 <- bc.ura3.sp.7.t2$rep2
cdist.ura3.sp.7.t2$rep3 <- bc.ura3.sp.7.t2$rep3
ddd <- "URA3_SP_7_t3"
bc.ura3.sp.7.t3 <- subset(bc, desc == ddd)
head(bc.ura3.sp.7.t3)
cdist.ura3.sp.7.t3 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.7.t3)
cdist.ura3.sp.7.t3$obs <- bc.ura3.sp.7.t3$Observations
cdist.ura3.sp.7.t3$rep1 <- bc.ura3.sp.7.t3$rep1
cdist.ura3.sp.7.t3$rep2 <- bc.ura3.sp.7.t3$rep2
cdist.ura3.sp.7.t3$rep3 <- bc.ura3.sp.7.t3$rep3
ddd <- "URA3_SP_7_t4"
bc.ura3.sp.7.t4 <- subset(bc, desc == ddd)
head(bc.ura3.sp.7.t4)
cdist.ura3.sp.7.t4 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.7.t4)
cdist.ura3.sp.7.t4$obs <- bc.ura3.sp.7.t4$Observations
cdist.ura3.sp.7.t4$rep1 <- bc.ura3.sp.7.t4$rep1
cdist.ura3.sp.7.t4$rep2 <- bc.ura3.sp.7.t4$rep2
cdist.ura3.sp.7.t4$rep3 <- bc.ura3.sp.7.t4$rep3
ddd <- "URA3_SP_7_t5"
bc.ura3.sp.7.t5 <- subset(bc, desc == ddd)
head(bc.ura3.sp.7.t5)
cdist.ura3.sp.7.t5 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.7.t5)
cdist.ura3.sp.7.t5$obs <- bc.ura3.sp.7.t5$Observations
cdist.ura3.sp.7.t5$rep1 <- bc.ura3.sp.7.t5$rep1
cdist.ura3.sp.7.t5$rep2 <- bc.ura3.sp.7.t5$rep2
cdist.ura3.sp.7.t5$rep3 <- bc.ura3.sp.7.t5$rep3
ddd <- "URA3_SP_7_ta"
bc.ura3.sp.7.ta <- subset(bc, desc == ddd)
head(bc.ura3.sp.7.ta)
cdist.ura3.sp.7.ta <- subset(dist2cc, desc == ddd)
head(cdist.ura3.sp.7.ta)
cdist.ura3.sp.7.ta$obs <- bc.ura3.sp.7.ta$Observations
cdist.ura3.sp.7.ta$rep1 <- bc.ura3.sp.7.ta$rep1
cdist.ura3.sp.7.ta$rep2 <- bc.ura3.sp.7.ta$rep2
cdist.ura3.sp.7.ta$rep3 <- bc.ura3.sp.7.ta$rep3
#####

#####
ddd <- "URA3_WT_1_t0"
bc.ura3.wt.1.t0 <- subset(bc, desc == ddd)
head(bc.ura3.wt.1.t0)
cdist.ura3.wt.1.t0 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.1.t0)
cdist.ura3.wt.1.t0$obs <- bc.ura3.wt.1.t0$Observations
cdist.ura3.wt.1.t0$rep1 <- bc.ura3.wt.1.t0$rep1
cdist.ura3.wt.1.t0$rep2 <- bc.ura3.wt.1.t0$rep2
cdist.ura3.wt.1.t0$rep3 <- bc.ura3.wt.1.t0$rep3
ddd <- "URA3_WT_1_t1"
bc.ura3.wt.1.t1 <- subset(bc, desc == ddd)
head(bc.ura3.wt.1.t1)
cdist.ura3.wt.1.t1 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.1.t1)
cdist.ura3.wt.1.t1$obs <- bc.ura3.wt.1.t1$Observations
cdist.ura3.wt.1.t1$rep1 <- bc.ura3.wt.1.t1$rep1
cdist.ura3.wt.1.t1$rep2 <- bc.ura3.wt.1.t1$rep2
cdist.ura3.wt.1.t1$rep3 <- bc.ura3.wt.1.t1$rep3
ddd <- "URA3_WT_1_t2"
bc.ura3.wt.1.t2 <- subset(bc, desc == ddd)
head(bc.ura3.wt.1.t2)
cdist.ura3.wt.1.t2 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.1.t2)
cdist.ura3.wt.1.t2$obs <- bc.ura3.wt.1.t2$Observations
cdist.ura3.wt.1.t2$rep1 <- bc.ura3.wt.1.t2$rep1
cdist.ura3.wt.1.t2$rep2 <- bc.ura3.wt.1.t2$rep2
cdist.ura3.wt.1.t2$rep3 <- bc.ura3.wt.1.t2$rep3
ddd <- "URA3_WT_1_t3"
bc.ura3.wt.1.t3 <- subset(bc, desc == ddd)
head(bc.ura3.wt.1.t3)
cdist.ura3.wt.1.t3 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.1.t3)
cdist.ura3.wt.1.t3$obs <- bc.ura3.wt.1.t3$Observations
cdist.ura3.wt.1.t3$rep1 <- bc.ura3.wt.1.t3$rep1
cdist.ura3.wt.1.t3$rep2 <- bc.ura3.wt.1.t3$rep2
cdist.ura3.wt.1.t3$rep3 <- bc.ura3.wt.1.t3$rep3
ddd <- "URA3_WT_1_t5"
bc.ura3.wt.1.t5 <- subset(bc, desc == ddd)
head(bc.ura3.wt.1.t5)
cdist.ura3.wt.1.t5 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.1.t5)
cdist.ura3.wt.1.t5$obs <- bc.ura3.wt.1.t5$Observations
cdist.ura3.wt.1.t5$rep1 <- bc.ura3.wt.1.t5$rep1
cdist.ura3.wt.1.t5$rep2 <- bc.ura3.wt.1.t5$rep2
cdist.ura3.wt.1.t5$rep3 <- bc.ura3.wt.1.t5$rep3
#####

#####
ddd <- "URA3_WT_2_t1"
bc.ura3.wt.2.t1 <- subset(bc, desc == ddd)
head(bc.ura3.wt.2.t1)
cdist.ura3.wt.2.t1 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.2.t1)
cdist.ura3.wt.2.t1$obs <- bc.ura3.wt.2.t1$Observations
cdist.ura3.wt.2.t1$rep1 <- bc.ura3.wt.2.t1$rep1
cdist.ura3.wt.2.t1$rep2 <- bc.ura3.wt.2.t1$rep2
cdist.ura3.wt.2.t1$rep3 <- bc.ura3.wt.2.t1$rep3
ddd <- "URA3_WT_2_t2"
bc.ura3.wt.2.t2 <- subset(bc, desc == ddd)
head(bc.ura3.wt.2.t2)
cdist.ura3.wt.2.t2 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.2.t2)
cdist.ura3.wt.2.t2$obs <- bc.ura3.wt.2.t2$Observations
cdist.ura3.wt.2.t2$rep1 <- bc.ura3.wt.2.t2$rep1
cdist.ura3.wt.2.t2$rep2 <- bc.ura3.wt.2.t2$rep2
cdist.ura3.wt.2.t2$rep3 <- bc.ura3.wt.2.t2$rep3
ddd <- "URA3_WT_2_t3"
bc.ura3.wt.2.t3 <- subset(bc, desc == ddd)
head(bc.ura3.wt.2.t3)
cdist.ura3.wt.2.t3 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.2.t3)
cdist.ura3.wt.2.t3$obs <- bc.ura3.wt.2.t3$Observations
cdist.ura3.wt.2.t3$rep1 <- bc.ura3.wt.2.t3$rep1
cdist.ura3.wt.2.t3$rep2 <- bc.ura3.wt.2.t3$rep2
cdist.ura3.wt.2.t3$rep3 <- bc.ura3.wt.2.t3$rep3
ddd <- "URA3_WT_2_t4"
bc.ura3.wt.2.t4 <- subset(bc, desc == ddd)
head(bc.ura3.wt.2.t4)
cdist.ura3.wt.2.t4 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.2.t4)
cdist.ura3.wt.2.t4$obs <- bc.ura3.wt.2.t4$Observations
cdist.ura3.wt.2.t4$rep1 <- bc.ura3.wt.2.t4$rep1
cdist.ura3.wt.2.t4$rep2 <- bc.ura3.wt.2.t4$rep2
cdist.ura3.wt.2.t4$rep3 <- bc.ura3.wt.2.t4$rep3
#####

#####
ddd <- "URA3_WT_3_t0"
bc.ura3.wt.3.t0 <- subset(bc, desc == ddd)
head(bc.ura3.wt.3.t0)
cdist.ura3.wt.3.t0 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.3.t0)
cdist.ura3.wt.3.t0$obs <- bc.ura3.wt.3.t0$Observations
cdist.ura3.wt.3.t0$rep1 <- bc.ura3.wt.3.t0$rep1
cdist.ura3.wt.3.t0$rep2 <- bc.ura3.wt.3.t0$rep2
cdist.ura3.wt.3.t0$rep3 <- bc.ura3.wt.3.t0$rep3
ddd <- "URA3_WT_3_t1"
bc.ura3.wt.3.t1 <- subset(bc, desc == ddd)
head(bc.ura3.wt.3.t1)
cdist.ura3.wt.3.t1 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.3.t1)
cdist.ura3.wt.3.t1$obs <- bc.ura3.wt.3.t1$Observations
cdist.ura3.wt.3.t1$rep1 <- bc.ura3.wt.3.t1$rep1
cdist.ura3.wt.3.t1$rep2 <- bc.ura3.wt.3.t1$rep2
cdist.ura3.wt.3.t1$rep3 <- bc.ura3.wt.3.t1$rep3
ddd <- "URA3_WT_3_t2"
bc.ura3.wt.3.t2 <- subset(bc, desc == ddd)
head(bc.ura3.wt.3.t2)
cdist.ura3.wt.3.t2 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.3.t2)
cdist.ura3.wt.3.t2$obs <- bc.ura3.wt.3.t2$Observations
cdist.ura3.wt.3.t2$rep1 <- bc.ura3.wt.3.t2$rep1
cdist.ura3.wt.3.t2$rep2 <- bc.ura3.wt.3.t2$rep2
cdist.ura3.wt.3.t2$rep3 <- bc.ura3.wt.3.t2$rep3
ddd <- "URA3_WT_3_t3"
bc.ura3.wt.3.t3 <- subset(bc, desc == ddd)
head(bc.ura3.wt.3.t3)
cdist.ura3.wt.3.t3 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.3.t3)
cdist.ura3.wt.3.t3$obs <- bc.ura3.wt.3.t3$Observations
cdist.ura3.wt.3.t3$rep1 <- bc.ura3.wt.3.t3$rep1
cdist.ura3.wt.3.t3$rep2 <- bc.ura3.wt.3.t3$rep2
cdist.ura3.wt.3.t3$rep3 <- bc.ura3.wt.3.t3$rep3
ddd <- "URA3_WT_3_t4"
bc.ura3.wt.3.t4 <- subset(bc, desc == ddd)
head(bc.ura3.wt.3.t4)
cdist.ura3.wt.3.t4 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.3.t4)
cdist.ura3.wt.3.t4$obs <- bc.ura3.wt.3.t4$Observations
cdist.ura3.wt.3.t4$rep1 <- bc.ura3.wt.3.t4$rep1
cdist.ura3.wt.3.t4$rep2 <- bc.ura3.wt.3.t4$rep2
cdist.ura3.wt.3.t4$rep3 <- bc.ura3.wt.3.t4$rep3
ddd <- "URA3_WT_3_t5"
bc.ura3.wt.3.t5 <- subset(bc, desc == ddd)
head(bc.ura3.wt.3.t5)
cdist.ura3.wt.3.t5 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.3.t5)
cdist.ura3.wt.3.t5$obs <- bc.ura3.wt.3.t5$Observations
cdist.ura3.wt.3.t5$rep1 <- bc.ura3.wt.3.t5$rep1
cdist.ura3.wt.3.t5$rep2 <- bc.ura3.wt.3.t5$rep2
cdist.ura3.wt.3.t5$rep3 <- bc.ura3.wt.3.t5$rep3
#####

#####
ddd <- "URA3_WT_4_t0"
bc.ura3.wt.4.t0 <- subset(bc, desc == ddd)
head(bc.ura3.wt.4.t0)
cdist.ura3.wt.4.t0 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.4.t0)
cdist.ura3.wt.4.t0$obs <- bc.ura3.wt.4.t0$Observations
cdist.ura3.wt.4.t0$rep1 <- bc.ura3.wt.4.t0$rep1
cdist.ura3.wt.4.t0$rep2 <- bc.ura3.wt.4.t0$rep2
cdist.ura3.wt.4.t0$rep3 <- bc.ura3.wt.4.t0$rep3
ddd <- "URA3_WT_4_t1"
bc.ura3.wt.4.t1 <- subset(bc, desc == ddd)
head(bc.ura3.wt.4.t1)
cdist.ura3.wt.4.t1 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.4.t1)
cdist.ura3.wt.4.t1$obs <- bc.ura3.wt.4.t1$Observations
cdist.ura3.wt.4.t1$rep1 <- bc.ura3.wt.4.t1$rep1
cdist.ura3.wt.4.t1$rep2 <- bc.ura3.wt.4.t1$rep2
cdist.ura3.wt.4.t1$rep3 <- bc.ura3.wt.4.t1$rep3
ddd <- "URA3_WT_4_t2"
bc.ura3.wt.4.t2 <- subset(bc, desc == ddd)
head(bc.ura3.wt.4.t2)
cdist.ura3.wt.4.t2 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.4.t2)
cdist.ura3.wt.4.t2$obs <- bc.ura3.wt.4.t2$Observations
cdist.ura3.wt.4.t2$rep1 <- bc.ura3.wt.4.t2$rep1
cdist.ura3.wt.4.t2$rep2 <- bc.ura3.wt.4.t2$rep2
cdist.ura3.wt.4.t2$rep3 <- bc.ura3.wt.4.t2$rep3
ddd <- "URA3_WT_4_t3"
bc.ura3.wt.4.t3 <- subset(bc, desc == ddd)
head(bc.ura3.wt.4.t3)
cdist.ura3.wt.4.t3 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.4.t3)
cdist.ura3.wt.4.t3$obs <- bc.ura3.wt.4.t3$Observations
cdist.ura3.wt.4.t3$rep1 <- bc.ura3.wt.4.t3$rep1
cdist.ura3.wt.4.t3$rep2 <- bc.ura3.wt.4.t3$rep2
cdist.ura3.wt.4.t3$rep3 <- bc.ura3.wt.4.t3$rep3
ddd <- "URA3_WT_4_t4"
bc.ura3.wt.4.t4 <- subset(bc, desc == ddd)
head(bc.ura3.wt.4.t4)
cdist.ura3.wt.4.t4 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.4.t4)
cdist.ura3.wt.4.t4$obs <- bc.ura3.wt.4.t4$Observations
cdist.ura3.wt.4.t4$rep1 <- bc.ura3.wt.4.t4$rep1
cdist.ura3.wt.4.t4$rep2 <- bc.ura3.wt.4.t4$rep2
cdist.ura3.wt.4.t4$rep3 <- bc.ura3.wt.4.t4$rep3
ddd <- "URA3_WT_4_t5"
bc.ura3.wt.4.t5 <- subset(bc, desc == ddd)
head(bc.ura3.wt.4.t5)
cdist.ura3.wt.4.t5 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.4.t5)
cdist.ura3.wt.4.t5$obs <- bc.ura3.wt.4.t5$Observations
cdist.ura3.wt.4.t5$rep1 <- bc.ura3.wt.4.t5$rep1
cdist.ura3.wt.4.t5$rep2 <- bc.ura3.wt.4.t5$rep2
cdist.ura3.wt.4.t5$rep3 <- bc.ura3.wt.4.t5$rep3
#####

#####
ddd <- "URA3_WT_5_t0"
bc.ura3.wt.5.t0 <- subset(bc, desc == ddd)
head(bc.ura3.wt.5.t0)
cdist.ura3.wt.5.t0 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.5.t0)
cdist.ura3.wt.5.t0$obs <- bc.ura3.wt.5.t0$Observations
cdist.ura3.wt.5.t0$rep1 <- bc.ura3.wt.5.t0$rep1
cdist.ura3.wt.5.t0$rep2 <- bc.ura3.wt.5.t0$rep2
cdist.ura3.wt.5.t0$rep3 <- bc.ura3.wt.5.t0$rep3
ddd <- "URA3_WT_5_t1"
bc.ura3.wt.5.t1 <- subset(bc, desc == ddd)
head(bc.ura3.wt.5.t1)
cdist.ura3.wt.5.t1 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.5.t1)
cdist.ura3.wt.5.t1$obs <- bc.ura3.wt.5.t1$Observations
cdist.ura3.wt.5.t1$rep1 <- bc.ura3.wt.5.t1$rep1
cdist.ura3.wt.5.t1$rep2 <- bc.ura3.wt.5.t1$rep2
cdist.ura3.wt.5.t1$rep3 <- bc.ura3.wt.5.t1$rep3
ddd <- "URA3_WT_5_t2"
bc.ura3.wt.5.t2 <- subset(bc, desc == ddd)
head(bc.ura3.wt.5.t2)
cdist.ura3.wt.5.t2 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.5.t2)
cdist.ura3.wt.5.t2$obs <- bc.ura3.wt.5.t2$Observations
cdist.ura3.wt.5.t2$rep1 <- bc.ura3.wt.5.t2$rep1
cdist.ura3.wt.5.t2$rep2 <- bc.ura3.wt.5.t2$rep2
cdist.ura3.wt.5.t2$rep3 <- bc.ura3.wt.5.t2$rep3
ddd <- "URA3_WT_5_t3"
bc.ura3.wt.5.t3 <- subset(bc, desc == ddd)
head(bc.ura3.wt.5.t3)
cdist.ura3.wt.5.t3 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.5.t3)
cdist.ura3.wt.5.t3$obs <- bc.ura3.wt.5.t3$Observations
cdist.ura3.wt.5.t3$rep1 <- bc.ura3.wt.5.t3$rep1
cdist.ura3.wt.5.t3$rep2 <- bc.ura3.wt.5.t3$rep2
cdist.ura3.wt.5.t3$rep3 <- bc.ura3.wt.5.t3$rep3
ddd <- "URA3_WT_5_t4"
bc.ura3.wt.5.t4 <- subset(bc, desc == ddd)
head(bc.ura3.wt.5.t4)
cdist.ura3.wt.5.t4 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.5.t4)
cdist.ura3.wt.5.t4$obs <- bc.ura3.wt.5.t4$Observations
cdist.ura3.wt.5.t4$rep1 <- bc.ura3.wt.5.t4$rep1
cdist.ura3.wt.5.t4$rep2 <- bc.ura3.wt.5.t4$rep2
cdist.ura3.wt.5.t4$rep3 <- bc.ura3.wt.5.t4$rep3
ddd <- "URA3_WT_5_t5"
bc.ura3.wt.5.t5 <- subset(bc, desc == ddd)
head(bc.ura3.wt.5.t5)
cdist.ura3.wt.5.t5 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.5.t5)
cdist.ura3.wt.5.t5$obs <- bc.ura3.wt.5.t5$Observations
cdist.ura3.wt.5.t5$rep1 <- bc.ura3.wt.5.t5$rep1
cdist.ura3.wt.5.t5$rep2 <- bc.ura3.wt.5.t5$rep2
cdist.ura3.wt.5.t5$rep3 <- bc.ura3.wt.5.t5$rep3
#####

#####
ddd <- "URA3_WT_6_t0"
bc.ura3.wt.6.t0 <- subset(bc, desc == ddd)
head(bc.ura3.wt.6.t0)
cdist.ura3.wt.6.t0 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.6.t0)
cdist.ura3.wt.6.t0$obs <- bc.ura3.wt.6.t0$Observations
cdist.ura3.wt.6.t0$rep1 <- bc.ura3.wt.6.t0$rep1
cdist.ura3.wt.6.t0$rep2 <- bc.ura3.wt.6.t0$rep2
cdist.ura3.wt.6.t0$rep3 <- bc.ura3.wt.6.t0$rep3
ddd <- "URA3_WT_6_t1"
bc.ura3.wt.6.t1 <- subset(bc, desc == ddd)
head(bc.ura3.wt.6.t1)
cdist.ura3.wt.6.t1 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.6.t1)
cdist.ura3.wt.6.t1$obs <- bc.ura3.wt.6.t1$Observations
cdist.ura3.wt.6.t1$rep1 <- bc.ura3.wt.6.t1$rep1
cdist.ura3.wt.6.t1$rep2 <- bc.ura3.wt.6.t1$rep2
cdist.ura3.wt.6.t1$rep3 <- bc.ura3.wt.6.t1$rep3
ddd <- "URA3_WT_6_t3"
bc.ura3.wt.6.t3 <- subset(bc, desc == ddd)
head(bc.ura3.wt.6.t3)
cdist.ura3.wt.6.t3 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.6.t3)
cdist.ura3.wt.6.t3$obs <- bc.ura3.wt.6.t3$Observations
cdist.ura3.wt.6.t3$rep1 <- bc.ura3.wt.6.t3$rep1
cdist.ura3.wt.6.t3$rep2 <- bc.ura3.wt.6.t3$rep2
cdist.ura3.wt.6.t3$rep3 <- bc.ura3.wt.6.t3$rep3
ddd <- "URA3_WT_6_t4"
bc.ura3.wt.6.t4 <- subset(bc, desc == ddd)
head(bc.ura3.wt.6.t4)
cdist.ura3.wt.6.t4 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.6.t4)
cdist.ura3.wt.6.t4$obs <- bc.ura3.wt.6.t4$Observations
cdist.ura3.wt.6.t4$rep1 <- bc.ura3.wt.6.t4$rep1
cdist.ura3.wt.6.t4$rep2 <- bc.ura3.wt.6.t4$rep2
cdist.ura3.wt.6.t4$rep3 <- bc.ura3.wt.6.t4$rep3
ddd <- "URA3_WT_6_t5"
bc.ura3.wt.6.t5 <- subset(bc, desc == ddd)
head(bc.ura3.wt.6.t5)
cdist.ura3.wt.6.t5 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.6.t5)
cdist.ura3.wt.6.t5$obs <- bc.ura3.wt.6.t5$Observations
cdist.ura3.wt.6.t5$rep1 <- bc.ura3.wt.6.t5$rep1
cdist.ura3.wt.6.t5$rep2 <- bc.ura3.wt.6.t5$rep2
cdist.ura3.wt.6.t5$rep3 <- bc.ura3.wt.6.t5$rep3
#####

#####
ddd <- "URA3_WT_7_t0"
bc.ura3.wt.7.t0 <- subset(bc, desc == ddd)
head(bc.ura3.wt.7.t0)
cdist.ura3.wt.7.t0 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.7.t0)
cdist.ura3.wt.7.t0$obs <- bc.ura3.wt.7.t0$Observations
cdist.ura3.wt.7.t0$rep1 <- bc.ura3.wt.7.t0$rep1
cdist.ura3.wt.7.t0$rep2 <- bc.ura3.wt.7.t0$rep2
cdist.ura3.wt.7.t0$rep3 <- bc.ura3.wt.7.t0$rep3
ddd <- "URA3_WT_7_t1"
bc.ura3.wt.7.t1 <- subset(bc, desc == ddd)
head(bc.ura3.wt.7.t1)
cdist.ura3.wt.7.t1 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.7.t1)
cdist.ura3.wt.7.t1$obs <- bc.ura3.wt.7.t1$Observations
cdist.ura3.wt.7.t1$rep1 <- bc.ura3.wt.7.t1$rep1
cdist.ura3.wt.7.t1$rep2 <- bc.ura3.wt.7.t1$rep2
cdist.ura3.wt.7.t1$rep3 <- bc.ura3.wt.7.t1$rep3
ddd <- "URA3_WT_7_t2"
bc.ura3.wt.7.t2 <- subset(bc, desc == ddd)
head(bc.ura3.wt.7.t2)
cdist.ura3.wt.7.t2 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.7.t2)
cdist.ura3.wt.7.t2$obs <- bc.ura3.wt.7.t2$Observations
cdist.ura3.wt.7.t2$rep1 <- bc.ura3.wt.7.t2$rep1
cdist.ura3.wt.7.t2$rep2 <- bc.ura3.wt.7.t2$rep2
cdist.ura3.wt.7.t2$rep3 <- bc.ura3.wt.7.t2$rep3
ddd <- "URA3_WT_7_t3"
bc.ura3.wt.7.t3 <- subset(bc, desc == ddd)
head(bc.ura3.wt.7.t3)
cdist.ura3.wt.7.t3 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.7.t3)
cdist.ura3.wt.7.t3$obs <- bc.ura3.wt.7.t3$Observations
cdist.ura3.wt.7.t3$rep1 <- bc.ura3.wt.7.t3$rep1
cdist.ura3.wt.7.t3$rep2 <- bc.ura3.wt.7.t3$rep2
cdist.ura3.wt.7.t3$rep3 <- bc.ura3.wt.7.t3$rep3
ddd <- "URA3_WT_7_t4"
bc.ura3.wt.7.t4 <- subset(bc, desc == ddd)
head(bc.ura3.wt.7.t4)
cdist.ura3.wt.7.t4 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.7.t4)
cdist.ura3.wt.7.t4$obs <- bc.ura3.wt.7.t4$Observations
cdist.ura3.wt.7.t4$rep1 <- bc.ura3.wt.7.t4$rep1
cdist.ura3.wt.7.t4$rep2 <- bc.ura3.wt.7.t4$rep2
cdist.ura3.wt.7.t4$rep3 <- bc.ura3.wt.7.t4$rep3
ddd <- "URA3_WT_7_t5"
bc.ura3.wt.7.t5 <- subset(bc, desc == ddd)
head(bc.ura3.wt.7.t5)
cdist.ura3.wt.7.t5 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.7.t5)
cdist.ura3.wt.7.t5$obs <- bc.ura3.wt.7.t5$Observations
cdist.ura3.wt.7.t5$rep1 <- bc.ura3.wt.7.t5$rep1
cdist.ura3.wt.7.t5$rep2 <- bc.ura3.wt.7.t5$rep2
cdist.ura3.wt.7.t5$rep3 <- bc.ura3.wt.7.t5$rep3
#####

#####
ddd <- "URA3_WT_8_t0"
bc.ura3.wt.8.t0 <- subset(bc, desc == ddd)
head(bc.ura3.wt.8.t0)
cdist.ura3.wt.8.t0 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.8.t0)
cdist.ura3.wt.8.t0$obs <- bc.ura3.wt.8.t0$Observations
cdist.ura3.wt.8.t0$rep1 <- bc.ura3.wt.8.t0$rep1
cdist.ura3.wt.8.t0$rep2 <- bc.ura3.wt.8.t0$rep2
cdist.ura3.wt.8.t0$rep3 <- bc.ura3.wt.8.t0$rep3
ddd <- "URA3_WT_8_t1"
bc.ura3.wt.8.t1 <- subset(bc, desc == ddd)
head(bc.ura3.wt.8.t1)
cdist.ura3.wt.8.t1 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.8.t1)
cdist.ura3.wt.8.t1$obs <- bc.ura3.wt.8.t1$Observations
cdist.ura3.wt.8.t1$rep1 <- bc.ura3.wt.8.t1$rep1
cdist.ura3.wt.8.t1$rep2 <- bc.ura3.wt.8.t1$rep2
cdist.ura3.wt.8.t1$rep3 <- bc.ura3.wt.8.t1$rep3
ddd <- "URA3_WT_8_t2"
bc.ura3.wt.8.t2 <- subset(bc, desc == ddd)
head(bc.ura3.wt.8.t2)
cdist.ura3.wt.8.t2 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.8.t2)
cdist.ura3.wt.8.t2$obs <- bc.ura3.wt.8.t2$Observations
cdist.ura3.wt.8.t2$rep1 <- bc.ura3.wt.8.t2$rep1
cdist.ura3.wt.8.t2$rep2 <- bc.ura3.wt.8.t2$rep2
cdist.ura3.wt.8.t2$rep3 <- bc.ura3.wt.8.t2$rep3
ddd <- "URA3_WT_8_t3"
bc.ura3.wt.8.t3 <- subset(bc, desc == ddd)
head(bc.ura3.wt.8.t3)
cdist.ura3.wt.8.t3 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.8.t3)
cdist.ura3.wt.8.t3$obs <- bc.ura3.wt.8.t3$Observations
cdist.ura3.wt.8.t3$rep1 <- bc.ura3.wt.8.t3$rep1
cdist.ura3.wt.8.t3$rep2 <- bc.ura3.wt.8.t3$rep2
cdist.ura3.wt.8.t3$rep3 <- bc.ura3.wt.8.t3$rep3
ddd <- "URA3_WT_8_t4"
bc.ura3.wt.8.t4 <- subset(bc, desc == ddd)
head(bc.ura3.wt.8.t4)
cdist.ura3.wt.8.t4 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.8.t4)
cdist.ura3.wt.8.t4$obs <- bc.ura3.wt.8.t4$Observations
cdist.ura3.wt.8.t4$rep1 <- bc.ura3.wt.8.t4$rep1
cdist.ura3.wt.8.t4$rep2 <- bc.ura3.wt.8.t4$rep2
cdist.ura3.wt.8.t4$rep3 <- bc.ura3.wt.8.t4$rep3
ddd <- "URA3_WT_8_t5"
bc.ura3.wt.8.t5 <- subset(bc, desc == ddd)
head(bc.ura3.wt.8.t5)
cdist.ura3.wt.8.t5 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.8.t5)
cdist.ura3.wt.8.t5$obs <- bc.ura3.wt.8.t5$Observations
cdist.ura3.wt.8.t5$rep1 <- bc.ura3.wt.8.t5$rep1
cdist.ura3.wt.8.t5$rep2 <- bc.ura3.wt.8.t5$rep2
cdist.ura3.wt.8.t5$rep3 <- bc.ura3.wt.8.t5$rep3
ddd <- "URA3_WT_8_ta"
bc.ura3.wt.8.ta <- subset(bc, desc == ddd)
head(bc.ura3.wt.8.ta)
cdist.ura3.wt.8.ta <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.8.ta)
cdist.ura3.wt.8.ta$obs <- bc.ura3.wt.8.ta$Observations
cdist.ura3.wt.8.ta$rep1 <- bc.ura3.wt.8.ta$rep1
cdist.ura3.wt.8.ta$rep2 <- bc.ura3.wt.8.ta$rep2
cdist.ura3.wt.8.ta$rep3 <- bc.ura3.wt.8.ta$rep3
#####

#####
ddd <- "URA3_WT_9_t0"
bc.ura3.wt.9.t0 <- subset(bc, desc == ddd)
head(bc.ura3.wt.9.t0)
cdist.ura3.wt.9.t0 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.9.t0)
cdist.ura3.wt.9.t0$obs <- bc.ura3.wt.9.t0$Observations
cdist.ura3.wt.9.t0$rep1 <- bc.ura3.wt.9.t0$rep1
cdist.ura3.wt.9.t0$rep2 <- bc.ura3.wt.9.t0$rep2
cdist.ura3.wt.9.t0$rep3 <- bc.ura3.wt.9.t0$rep3
ddd <- "URA3_WT_9_t1"
bc.ura3.wt.9.t1 <- subset(bc, desc == ddd)
head(bc.ura3.wt.9.t1)
cdist.ura3.wt.9.t1 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.9.t1)
cdist.ura3.wt.9.t1$obs <- bc.ura3.wt.9.t1$Observations
cdist.ura3.wt.9.t1$rep1 <- bc.ura3.wt.9.t1$rep1
cdist.ura3.wt.9.t1$rep2 <- bc.ura3.wt.9.t1$rep2
cdist.ura3.wt.9.t1$rep3 <- bc.ura3.wt.9.t1$rep3
ddd <- "URA3_WT_9_t2"
bc.ura3.wt.9.t2 <- subset(bc, desc == ddd)
head(bc.ura3.wt.9.t2)
cdist.ura3.wt.9.t2 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.9.t2)
cdist.ura3.wt.9.t2$obs <- bc.ura3.wt.9.t2$Observations
cdist.ura3.wt.9.t2$rep1 <- bc.ura3.wt.9.t2$rep1
cdist.ura3.wt.9.t2$rep2 <- bc.ura3.wt.9.t2$rep2
cdist.ura3.wt.9.t2$rep3 <- bc.ura3.wt.9.t2$rep3
ddd <- "URA3_WT_9_t3"
bc.ura3.wt.9.t3 <- subset(bc, desc == ddd)
head(bc.ura3.wt.9.t3)
cdist.ura3.wt.9.t3 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.9.t3)
cdist.ura3.wt.9.t3$obs <- bc.ura3.wt.9.t3$Observations
cdist.ura3.wt.9.t3$rep1 <- bc.ura3.wt.9.t3$rep1
cdist.ura3.wt.9.t3$rep2 <- bc.ura3.wt.9.t3$rep2
cdist.ura3.wt.9.t3$rep3 <- bc.ura3.wt.9.t3$rep3
ddd <- "URA3_WT_9_t4"
bc.ura3.wt.9.t4 <- subset(bc, desc == ddd)
head(bc.ura3.wt.9.t4)
cdist.ura3.wt.9.t4 <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.9.t4)
cdist.ura3.wt.9.t4$obs <- bc.ura3.wt.9.t4$Observations
cdist.ura3.wt.9.t4$rep1 <- bc.ura3.wt.9.t4$rep1
cdist.ura3.wt.9.t4$rep2 <- bc.ura3.wt.9.t4$rep2
cdist.ura3.wt.9.t4$rep3 <- bc.ura3.wt.9.t4$rep3
ddd <- "URA3_WT_9_ta"
bc.ura3.wt.9.ta <- subset(bc, desc == ddd)
head(bc.ura3.wt.9.ta)
cdist.ura3.wt.9.ta <- subset(dist2cc, desc == ddd)
head(cdist.ura3.wt.9.ta)
cdist.ura3.wt.9.ta$obs <- bc.ura3.wt.9.ta$Observations
cdist.ura3.wt.9.ta$rep1 <- bc.ura3.wt.9.ta$rep1
cdist.ura3.wt.9.ta$rep2 <- bc.ura3.wt.9.ta$rep2
cdist.ura3.wt.9.ta$rep3 <- bc.ura3.wt.9.ta$rep3
#####


########################################
########################################



########################################
########################################


####################

distobscc <- rbind(
  cdist.het.wt.2.t0, cdist.het.wt.2.t1, cdist.het.wt.2.t2, cdist.het.wt.2.t3, cdist.het.wt.2.t4, cdist.het.wt.2.t5,
  cdist.het.wt.3.t0, cdist.het.wt.3.t1, cdist.het.wt.3.t2, cdist.het.wt.3.t3, cdist.het.wt.3.t4, cdist.het.wt.3.t5, cdist.het.wt.3.ta, 
  cdist.lys.sp.1.t0, cdist.lys.sp.1.t1, cdist.lys.sp.1.t2, cdist.lys.sp.1.t3, cdist.lys.sp.1.t4, cdist.lys.sp.1.t5, 
  cdist.lys.sp.2.t0, cdist.lys.sp.2.t1, cdist.lys.sp.2.t2, cdist.lys.sp.2.t3, cdist.lys.sp.2.t4, cdist.lys.sp.2.t5, cdist.lys.sp.2.t6, 
  cdist.lys.sp.3.t0, cdist.lys.sp.3.t1, cdist.lys.sp.3.t2, cdist.lys.sp.3.t3, cdist.lys.sp.3.t4, cdist.lys.sp.3.t5, 
  cdist.lys.wt.1.t0, cdist.lys.wt.1.t1, cdist.lys.wt.1.t2, cdist.lys.wt.1.t3, cdist.lys.wt.1.t4, cdist.lys.wt.1.t5, cdist.lys.wt.1.t6, 
  cdist.lys.wt.2.t0, cdist.lys.wt.2.t1, cdist.lys.wt.2.t2, cdist.lys.wt.2.t3, cdist.lys.wt.2.t4, 
  cdist.lys.wt.3.t0, cdist.lys.wt.3.t1, cdist.lys.wt.3.t2, cdist.lys.wt.3.t3, cdist.lys.wt.3.t5, 
  cdist.ura3.sp.1.t0, cdist.ura3.sp.1.t1, cdist.ura3.sp.1.t2, cdist.ura3.sp.1.t3, cdist.ura3.sp.1.t4, cdist.ura3.sp.1.t5, cdist.ura3.sp.1.t6, 
  cdist.ura3.sp.2.t1, cdist.ura3.sp.2.t3, cdist.ura3.sp.2.t4, cdist.ura3.sp.2.t5, 
  cdist.ura3.sp.3.t0, cdist.ura3.sp.3.t1, cdist.ura3.sp.3.t3, cdist.ura3.sp.3.t4, cdist.ura3.sp.3.t5, 
  cdist.ura3.sp.5.t1, cdist.ura3.sp.5.t2, cdist.ura3.sp.5.t3, cdist.ura3.sp.5.t4, cdist.ura3.sp.5.t5, 
  cdist.ura3.sp.6.t0, cdist.ura3.sp.6.t1, cdist.ura3.sp.6.t3, cdist.ura3.sp.6.t4, cdist.ura3.sp.6.t5, 
  cdist.ura3.sp.7.t0, cdist.ura3.sp.7.t1, cdist.ura3.sp.7.t2, cdist.ura3.sp.7.t3, cdist.ura3.sp.7.t4, cdist.ura3.sp.7.t5, cdist.ura3.sp.7.ta, 
  cdist.ura3.wt.1.t0, cdist.ura3.wt.1.t1, cdist.ura3.wt.1.t2, cdist.ura3.wt.1.t3, cdist.ura3.wt.1.t5, 
  cdist.ura3.wt.2.t1, cdist.ura3.wt.2.t2, cdist.ura3.wt.2.t3, cdist.ura3.wt.2.t4, 
  cdist.ura3.wt.3.t0, cdist.ura3.wt.3.t1, cdist.ura3.wt.3.t2, cdist.ura3.wt.3.t3, cdist.ura3.wt.3.t4, cdist.ura3.wt.3.t5, 
  cdist.ura3.wt.4.t0, cdist.ura3.wt.4.t1, cdist.ura3.wt.4.t2, cdist.ura3.wt.4.t3, cdist.ura3.wt.4.t4, cdist.ura3.wt.4.t5, 
  cdist.ura3.wt.5.t0, cdist.ura3.wt.5.t1, cdist.ura3.wt.5.t2, cdist.ura3.wt.5.t3, cdist.ura3.wt.5.t4, cdist.ura3.wt.5.t5, 
  cdist.ura3.wt.6.t0, cdist.ura3.wt.6.t1, cdist.ura3.wt.6.t3, cdist.ura3.wt.6.t4, cdist.ura3.wt.6.t5, 
  cdist.ura3.wt.7.t0, cdist.ura3.wt.7.t1, cdist.ura3.wt.7.t2, cdist.ura3.wt.7.t3, cdist.ura3.wt.7.t4, cdist.ura3.wt.7.t5, 
  cdist.ura3.wt.8.t0, cdist.ura3.wt.8.t1, cdist.ura3.wt.8.t2, cdist.ura3.wt.8.t3, cdist.ura3.wt.8.t4, cdist.ura3.wt.8.t5, cdist.ura3.wt.8.ta, 
  cdist.ura3.wt.9.t0, cdist.ura3.wt.9.t1, cdist.ura3.wt.9.t2, cdist.ura3.wt.9.t3, cdist.ura3.wt.9.t4, cdist.ura3.wt.9.ta
  )

head(distobscc)

####################
####################
head(distobscc)
dc <- distobscc
dc <- dc[ order(dc[,1], dc[,2], dc[,3], dc[,4], dc[,5], dc[,6]), ]
head(dc)


tail(dc)



remove <- c("URA3_WT_1_t0", "URA3_WT_1_t1", "URA3_WT_1_t2", "URA3_WT_1_t3", "URA3_WT_1_t5", 
            "URA3_WT_2_t1", "URA3_WT_2_t2", "URA3_WT_2_t3", "URA3_WT_2_t4", 
            "URA3_WT_7_t0", "URA3_WT_7_t1", "URA3_WT_7_t2", "URA3_WT_7_t3", "URA3_WT_7_t4", "URA3_WT_7_t5")
dc <- subset(dc, !(desc %in% remove))
dc <- subset(dc, obs %in% c("Okay", "Oay", "okay", "Okat"))
head(dc)
unique(dc$desc)


write.csv(dc, file = "obsspotrepsconfdist6exp.csv")







