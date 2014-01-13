
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
DM.part <- DM[ grep("(S_[0-9]+_SLO)|QC", rownames(DM), perl=TRUE), ]


