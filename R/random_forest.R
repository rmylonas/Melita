
library(randomForest)

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
DM.part <- DM[ grep("(S_[0-9]+_SLO)", rownames(DM), perl=TRUE), ]


# get the conditions 
trait <- sapply(rownames(DM.part),function(x){
	one <- strsplit(x,"_")[[1]][2]
})
trait <- factor(trait)

# run randomForest on the data
forest <- randomForest(DM.part, trait, importance=TRUE)
print(levels(trait))
print(forest)

# look at most important variables
best <- head(order(importance(forest), decreasing=TRUE), n=815)

# construct table with best results
hit.table <- data.frame(ChemSpiderID=chemSpiderId[best], compound=compound[best], pcgroup=pcgroup[best], adduct=adduct[best], isotopes=isotopes[best], mz=mz[best], rt=rt[best], t(DM.part[,best]))


# write the table
write.table(hit.table, file="/tmp/a.csv", sep=",")












