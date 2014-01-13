library('PCA')

# clear workspace
rm(list=ls())

# load data
load("/Users/romanmylonas/FEM/melita/pipeline_dicembre2013/sample_neg/result.RData")


# prepare dataresult
nr.samples <- dim(result$PeakTable)[2]
DM <- t(result$PeakTable[,8:nr.samples])
rt <- result$PeakTable[,"rt"]
mz <- result$PeakTable[,"mz"]
pcgroup <- result$PeakTable[,"pcgroup"]
adduct <- result$PeakTable[,"adduct"]
isotopes <- result$PeakTable[,"isotopes"]
chemSpiderId <- result$PeakTable[,"ChemSpiderID"]
compound <- result$PeakTable[,"compound"]


# let's only look at Slovenia and South
DM.slo <- DM[ grep("(S_[0-9]+_SLO)|QC", rownames(DM), perl=TRUE), ]

# or italy and south
DM.it <- DM[ grep("(S_[0-9]+_RP)|QC", rownames(DM), perl=TRUE), ]

# choose what you want to see detailed (DM.it or DM.slo)
DM.part <- DM.slo

# prepare PCA
mypca <- PCA(scale(DM.part))

# prepare coloring
# set colors
mycol <- rep(1,times=nrow(DM.part))
mycol[grep("QC", rownames(DM.part))] <- "black"
mycol[grep("NLR", rownames(DM.part))] <- "red"
mycol[grep("PFLR", rownames(DM.part))] <- "green"
mycol[grep("VLR", rownames(DM.part))] <- "blue"

scoreplot(mypca, col=mycol)
legend("bottomright", c('QC', 'NLR', 'PFLR', 'VLR'), pch=rep(1, 4), col=c("black", "red", "green", "blue"))

# identify(scores(mypca)[,1],scores(mypca)[,2],labels=rownames(DM.part))
pairs(scores(mypca)[,1:4], col = mycol)



