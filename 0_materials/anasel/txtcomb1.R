#
##
###
dir <- "/Volumes/SilverSeaGate/Archive/Work/3 Appointments/UC Davis/Shared/Research/Yeast/teto-tetr/Timecourse data/neworg/URA3/WT/Exp6/t4/8_anaprog/selections/anasel"
setwd(dir)
##
#
##
fileNames <- Sys.glob("*.txt")
fileNames

ifelse(length(fileNames)==0, "",
for(i in seq(1,length(fileNames),1)){
  file <- fileNames[i]
  fi <- strsplit(file, "-")[[1]][1]
  eenn <- strsplit(file, "-")[[1]][2]
  typ <- strsplit(eenn, ".txt")[[1]][1]
  txt <- read.table(file)
  head(txt)
  txt$sel <- fi
  txt$typ <- typ
  head(txt)
  colnames(txt) <- c("x", "y", "sel", "typ")
  write.csv(txt, paste(fi,"x.csv",sep=""), row.names=F)
})
##
#
##
multiplefiles <- list.files(path = dir, pattern = "x.csv")
multiplefiles
tex <- do.call("rbind", lapply(multiplefiles, read.csv, header = TRUE))
head(tex)

ifelse(length(fileNames)==0, 
       {
         x <- ""
         y <- ""
         sel <- ""
         typ <- ""
         tex <- data.frame(x, y, sel, typ)
         tex
         write.csv(tex, paste("../seltxtcomb.csv",sep=""), row.names=F)
       },
       {
         write.csv(tex, paste("../seltxtcomb.csv",sep=""), row.names=F)
       })