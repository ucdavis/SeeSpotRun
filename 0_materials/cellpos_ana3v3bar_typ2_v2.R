#
##
###
library(ggplot2)
library(plyr)
library(jpeg)
library(grid)
library(xlsx)
library(gridExtra)
library(cowplot)
###

###
dir <- "/Volumes/SilverSeaGate/Archive/Work/3 Appointments/UC Davis/Shared/Research/Yeast/teto-tetr/Timecourse data/neworg/URA3/WT/Exp6/t4/8_anaprog/selections/jmip"
setwd(dir)
### 

###
fileNames <- Sys.glob("*.jpg")
fileNames

for(i in seq(1, length(fileNames), 1)){
  #i <- 1
  file <- fileNames[i]
  eee <- strsplit(file, "-")[[1]][2]
  fff <- strsplit(eee, ".jpg")[[1]][1]
  img <- readJPEG(file)
  ###
  
  ###
  pos <- read.xlsx("../URA3WT6_t4_cells_obs_xy.xlsx", sheetIndex=1, header=TRUE)
  ###
  
  ###
  ansel <- read.csv("../seltxtcomb.csv", header=TRUE)
  head(ansel)
  mf <- 1996/833
  ansel$x <- ansel$x*mf
  ansel$y <- ansel$y*mf
  ansel$y <- 1996-ansel$y
  cenansel <- ddply(ansel, c("sel", "typ"), 
                    summarise,
                    ax=mean(x, na.rm = TRUE),
                    ay=mean(y, na.rm = TRUE))
  a1se <- subset(ansel, typ=="i")
  a2se <- subset(ansel, typ=="ii")
  a1c <- subset(cenansel, typ=="i")
  a2c <- subset(cenansel, typ=="ii")
  ###
  
  pdf(paste('../multi2/test-', fff,'.pdf',sep=''), width = 6, height = 5)
  
  ###
  gg1 <- ggplot() + 
    annotation_custom(rasterGrob(img, width=1, height=1)) +
    geom_path(data=a1se, aes(x=x, y=y, group=sel), color="green3", size=0.5, alpha=0.5) +
    geom_text(data=a1c, aes(x=ax, y=ay, label=sel), color="green3", alpha=0.5) +
    geom_path(data=a2se, aes(x=x, y=y, group=sel), color="red", size=0.5, alpha=0.5) +
    geom_text(data=a2c, aes(x=ax, y=ay, label=sel), color="red", alpha=0.5) +
    geom_text(data=pos, aes(x=X, y=Y, label=Cell, color=Observations), alpha=0.5) +
    scale_x_continuous(expand=c(0,0), limits=c(0, 1996)) +
    scale_y_continuous(expand=c(0,0), limits=c(0, 1996)) +
    ylab("") +
    xlab("") +
    theme(axis.text=element_blank(), axis.ticks=element_blank()) +
    theme(plot.margin=unit(c(0.75,1,0.25,0.4), "cm")) +
    theme(aspect.ratio=1) +
    theme(axis.line=element_blank())
  #print(gg1)
  
  
  ###
  pctdf <- data.frame(frame=i, total=length(fileNames))
  pctdf$pct <- (pctdf$frame / pctdf$total) * 100
  pctdf
  
  gg2 <- ggplot(pctdf, aes(x=0, y=frame)) + 
    geom_bar(stat="identity", width=1) +
    scale_y_continuous(limits=c(0,pctdf$total)) +
    coord_flip() +
    theme(axis.title.y=element_blank(),
          axis.title.x=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank()) +
    theme(axis.line=element_blank(),
          panel.grid.major.y = element_blank(),
          panel.grid.minor.y = element_blank())
  
  #print(gg2)
  
  #grid.arrange(gg1, gg2, heights=2:1)
  ggg <- plot_grid(gg1, gg2, align = "v", nrow = 2, rel_heights = c(1/1.5, 1/15))
  print(ggg)
  
  
  dev.off()
}

  
  
  
  