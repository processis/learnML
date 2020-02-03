################################################################################
### R code from processis (2020) by Edmond and Shelly.
### Copyright 2020 Edmond and Shelly
### Web Page: http://www.processis.com
### Contact: Ms QIN (shelly@processis.org)
#
#Reference   Maxwell: 67 project miantenance data analysis
## How many cores on the machine should be used for the data
## processing. Making cores > 1 will speed things up (depending on your
## machine) but will consume more memory.
cores <- 2

if(cores > 1) {
  library(doMC)
  registerDoMC(cores)
}
# Read Maxwell 67 project raw data
#setwd("/media/user/1907USB/2020data") #use project home dir
Raw <- read.csv("maxwell67MainCasesTrainTestV10esFinal.csv", header = TRUE)
## Only read the 'Train' data set,  remove case ID
MaxwellTrain <-subset(Raw,case=="Train")
dataID<-MaxwellTrain$id
case<-MaxwellTrain$case
MaxwellTrain<-MaxwellTrain[,-(1:2)]
#
# print the summary statistics to check incorrect values
summary(MaxwellTrain)
## In many cases, missing values in factor var will be converted
## to a value of "Unk"
#MaxwellData$app <- as.character(MaxwellData$app)
#MaxwellData$app[Maxwell$app == ""] <- "Unk"
#MaxwellData$app <- factor(paste("App", MaxwellData$app, sep = ""))
#
#MaxwellData$har <- as.character(MaxwellData$har)
#MaxwellData$har[Maxwell$har == ""] <- "Unk"
#MaxwellData$har <- factor(paste("Har", MaxwellData$har, sep = ""))
#
######################
### Section 3.2 Data Transformations for Individual Predictors

## The column VarIntenCh3 measures the standard deviation of the intensity
## of the pixels in the actin filaments

max(MaxwellTrain$totfp)/min(MaxwellTrain$totfp)

library(e1071)
skewness(MaxwellTrain$totfp)

library(caret)


####
##
# apply Box Cox transformations to biased non-cat predictors
### Section 3.2 Data Transformations for Individual Predictors
library(e1071)
# skewness for on predictor
skewness(MaxwellData$totfp)
#remove the non numeric columns
segMaxwellTrain <- MaxwellTrain[,-(24:28)]
#also remove original correff , which is replaced by acorreff
segMaxwellTrain <- segMaxwellTrain[,-(1)]
skewValues<-apply(segMaxwellTrain,2,skewness)
head(skewValues)
# use these values as guide , prioritize for visualizing the distribution
histogram(~segMaxwellTrain$avetrans,
          xlab = "Natural Units",
          type = "count")
# use these values as guide , prioritize for visualizing the distribution
histogram(~segMaxwellTrain$appdef,
          xlab = "Natural Units",
          type = "count")
# use these values as guide , prioritize for visualizing the distribution
histogram(~segMaxwellTrain$ptelon,
          xlab = "Natural Units",
          type = "count")
# BoxCoxTrans auto find the approp transformation, and apply them 
library(caret)
totfpTrans<-BoxCoxTrans(segMaxwellTrain$totfp)
totfpTrans
head(MaxwellData$totfp)
predict(totfpTrans,head(segMaxwellTrain$totfp))
#
avetransTrans<-BoxCoxTrans(segMaxwellTrain$avetrans)
avetransTrans
head(segMaxwellTrain$avetrans)
predict(avetransTrans,head(segMaxwellTrain$avetrans))
#
acorreffTrans<-BoxCoxTrans(segMaxwellTrain$acorreff)
avetransTrans
head(segMaxwellTrain$acorreff)
predict(avetransTrans,head(segMaxwellTrain$acorreff))
####################
# since do not work for acorreff , and avetrans
# try following caret
############
## Use caret's preProcess function to transform for skewness
## 2020.2.2 Use caret's preProcess function to transform for skewness
segPP <- preProcess(segMaxwellTrain, method = "BoxCox")

## Apply the transformations
segMaxwellTrainTrans <- predict(segPP, segMaxwellTrain)

## Results for a single predictor
segPP$bc$totfp

histogram(~segMaxwellTrain$totfp,
          xlab = "Natural Units",
          type = "count")

histogram(~segMaxwellTrainTrans$totfp,
          xlab = "Transformed Units",
          ylab = " ",
          type = "count")

segPP$bc$acorreff

histogram(~segMaxwellTrain$acorreff,
          xlab = "Natural Units",
          type = "count")

histogram(~log(segMaxwellTrain$acorreff),
          xlab = "Log Data",
          ylab = " ",
          type = "count")

segPP$bc$avetrans

histogram(~segMaxwellTrain$avetrans,
          xlab = "Natural Units",
          type = "count")

histogram(~log(segMaxwellTrain$avetrans),
          xlab = "Log Data",
          ylab = " ",
          type = "count")
###################
# filter for near zero variance pridictors
nearZeroVar(segMaxwellTrain)
#
#filter on between predictor correlations
NoRsegMaxwellTrain <- segMaxwellTrain[,-(12:21)] #remove those incomplete r col 
NoRsegMaxwellTrain <- NoRsegMaxwellTrain[,-(7)] #remove the t column
NoRcorrelations <- cor(NoRsegMaxwellTrain)
dim(NoRcorrelations)
NoRcorrelations[1:10, 1:10]
#visualize
library(corrplot)
corrplot(NoRcorrelations , order = "hclust") 
highCorr <- findCorrelation(NoRcorrelations, cutoff = .6)
length(highCorr)
head(highCorr)
filteredNoRSegMaxwellTrain <- NoRsegMaxwellTrain[ , -highCorr]
###################END OF THE DAY 2020.2.31
# create new variables
#
# identify subset of cat variables 
#

###################
#
#prelim analysis
#1) histogram
package(ggplot2)
#data(MaxwellTrain)
head(MaxwellTrain)
ggplot(data=MaxwellTrain) +geom_histogram(aes( x=totfp))
#2) scatter plots
ggplot(MaxwellTrain, aes(x= totfp , y= acorreff)) +geom_point()

