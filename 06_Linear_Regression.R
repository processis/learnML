################################################################################
### R code from Applied Predictive Modeling (2013) by Kuhn and Johnson.
### Copyright 2013 Kuhn and Johnson
### Web Page: http://www.appliedpredictivemodeling.com
### Contact: Max Kuhn (mxkuhn@gmail.com)
###
### Chapter 6: Linear Regression and Its Cousins
###
### Required packages: AppliedPredictiveModeling, lattice, corrplot, pls, 
###                    elasticnet,
###
### Data used: The solubility from the AppliedPredictiveModeling package
###
### Notes:
### 1) This code is provided without warranty.
###
### 2) This code should help the user reproduce the results in the
### text. There will be differences between this code and what is is
### the computing section. For example, the computing sections show
### how the source functions work (e.g. randomForest() or plsr()),
### which were not directly used when creating the book. Also, there may be 
### syntax differences that occur over time as packages evolve. These files 
### will reflect those changes.
###
### 3) In some cases, the calculations in the book were run in 
### parallel. The sub-processes may reset the random number seed.
### Your results may slightly vary.
###
################################################################################

################################################################################
### Section 6.1 Case Study: Quantitative Structure- Activity
### Relationship Modeling

library(AppliedPredictiveModeling)
data(solubility)
names(trainingData)

library(lattice)

### Some initial plots of the data

xyplot(solTrainY ~ solTrainX$MolWeight, type = c("p", "g"),
       ylab = "Solubility (log)",
       main = "(a)",
       xlab = "Molecular Weight")
xyplot(solTrainY ~ solTrainX$NumRotBonds, type = c("p", "g"),
       ylab = "Solubility (log)",
       xlab = "Number of Rotatable Bonds")
bwplot(solTrainY ~ ifelse(solTrainX[,100] == 1, 
                          "structure present", 
                          "structure absent"),
       ylab = "Solubility (log)",
       main = "(b)",
       horizontal = FALSE)

### Find the columns that are not fingerprints (i.e. the continuous
### predictors). grep will return a list of integers corresponding to
### column names that contain the pattern "FP".

notFingerprints <- grep("FP", names(solTrainXtrans))

library(caret)
featurePlot(solTrainXtrans[, -notFingerprints],
            solTrainY,
            between = list(x = 1, y = 1),
            type = c("g", "p", "smooth"),
            labels = rep("", 2))

library(corrplot)

### We used the full namespace to call this function because the pls
### package (also used in this chapter) has a function with the same
### name.

corrplot::corrplot(cor(solTrainXtrans[, -notFingerprints]), 
                   order = "hclust", 
                   tl.cex = .8)

################################################################################
### Section 6.2 Linear Regression

### Create a control function that will be used across models. We
### create the fold assignments explicitly instead of relying on the
### random number seed being set to identical values.

set.seed(100)
indx <- createFolds(solTrainY, returnTrain = TRUE)
ctrl <- trainControl(method = "cv", index = indx)

### Linear regression model with all of the predictors. This will
### produce some warnings that a 'rank-deficient fit may be
### misleading'. This is related to the predictors being so highly
### correlated that some of the math has broken down.

set.seed(100)
lmTune0 <- train(x = solTrainXtrans, y = solTrainY,
                 method = "lm",
                 trControl = ctrl)

lmTune0                 

### And another using a set of predictors reduced by unsupervised
### filtering. We apply a filter to reduce extreme between-predictor
### correlations. Note the lack of warnings.

tooHigh <- findCorrelation(cor(solTrainXtrans), .9)
trainXfiltered <- solTrainXtrans[, -tooHigh]
testXfiltered  <-  solTestXtrans[, -tooHigh]

set.seed(100)
lmTune <- train(x = trainXfiltered, y = solTrainY,
                method = "lm",
                trControl = ctrl)

lmTune

### Save the test set results in a data frame                 
testResults <- data.frame(obs = solTestY,
                          Linear_Regression = predict(lmTune, testXfiltered))


################################################################################
### Section 6.3 Partial Least Squares

## Run PLS and PCR on solubility data and compare results
set.seed(100)
plsTune <- train(x = solTrainXtrans, y = solTrainY,
                 method = "pls",
                 tuneGrid = expand.grid(ncomp = 1:20),
                 trControl = ctrl)
plsTune

testResults$PLS <- predict(plsTune, solTestXtrans)

set.seed(100)
pcrTune <- train(x = solTrainXtrans, y = solTrainY,
                 method = "pcr",
                 tuneGrid = expand.grid(ncomp = 1:35),
                 trControl = ctrl)
pcrTune                  

plsResamples <- plsTune$results
plsResamples$Model <- "PLS"
pcrResamples <- pcrTune$results
pcrResamples$Model <- "PCR"
plsPlotData <- rbind(plsResamples, pcrResamples)

xyplot(RMSE ~ ncomp,
       data = plsPlotData,
       #aspect = 1,
       xlab = "# Components",
       ylab = "RMSE (Cross-Validation)",
       auto.key = list(columns = 2),
       groups = Model,
       type = c("o", "g"))

plsImp <- varImp(plsTune, scale = FALSE)
plot(plsImp, top = 25, scales = list(y = list(cex = .95)))

################################################################################
### Section 6.4 Penalized Models

## The text used the elasticnet to obtain a ridge regression model.
## There is now a simple ridge regression method.

ridgeGrid <- expand.grid(lambda = seq(0, .1, length = 15))

set.seed(100)
ridgeTune <- train(x = solTrainXtrans, y = solTrainY,
                   method = "ridge",
                   tuneGrid = ridgeGrid,
                   trControl = ctrl,
                   preProc = c("center", "scale"))
ridgeTune

print(update(plot(ridgeTune), xlab = "Penalty"))


enetGrid <- expand.grid(lambda = c(0, 0.01, .1), 
                        fraction = seq(.05, 1, length = 20))
set.seed(100)
enetTune <- train(x = solTrainXtrans, y = solTrainY,
                  method = "enet",
                  tuneGrid = enetGrid,
                  trControl = ctrl,
                  preProc = c("center", "scale"))
enetTune

plot(enetTune)

testResults$Enet <- predict(enetTune, solTestXtrans)

################################################################################
### Session Information

sessionInfo()

q("no")


#ch6 shu
library(MASS)
library(ggplot2)
library(pls)
library(caret)
library(AppliedPredictiveModeling)
data(solubility)
names(trainingData)
ls(pattern="solT")


set.seed(2)
sample(names(solTrainX),8)

trainingData<-solTrainXtrans
trainingData$Solubility<-solTrainY


lmfitallpredictors<-lm(Solubility~.,data=trainingData)
summary(lmfitallpredictors)

lmpredl<-predict(lmfitallpredictors,solTestXtrans)
head(lmpredl)
lmvalues1<-data.frame(obs=solTrainY,pred=lmpredl)
defaultSummary(lmvalues1)

rlmlmfitallpredictors<-lm(Solubility~.,data=trainingData)
ctrl<-trainControl(method="cv",number=10)
set.seed(100)
lmfit1<-train(x=solTrainXtrans,y=solTestY,
              method="lm",trControl=ctrl)

xyplot(solTrainY~predice(lmfit1),
       type=c("p","g"),
       xlab="predicted",y="observed")

xyplot(resid(lmfit1)~predice(lmfit1),
       type=c("p","g"),
       xlab="predicted",y="residuals")

corThresh<-.9
tooHigh<-findCorrelation(cor(solTrainXtrans),corThresh)
corrPred<-names(solTrainXtrans)[tooHigh]
trainfiltered<-solTrainXtrans[,-tooHigh]

set.seed(100)
lmfiltered<-train(trainXfiltered,solTrainY,method="lm",
                  trControl=ctrl)
lmfiltered

set.seed(100)
rlmPCA<-train(solTrainXtrans,solTrainY,
              method="rlm",
              preProcess = "pca",
              trControl = ctrl)
rlmPCA

plsFit<-plsr(Solubility~.,data=trainingData)
predict(plsFit,solTestXtrans[1:5],ncomp=1:2)

set.seed(100)
plsTune<-train(solTrainXtrans,solTrainY,
               method="pls",
               tuneLength = 20,
               trControl = ctrl,
               preProc=c("center","scale"))

ridgeModel<-enet(x=as.matrix(solTrainXtrans),
                 y=solTrainY,lambda=0.01)

ridgePred<-predict(ridgeModel,newx=as.matrix(solTestXtrans),
                   s=1,mode="fraction",
                   type="fit")
head(ridgePred)

ridgeGrid

ridgeGrid <- expand.grid(lambda = seq(0, .1, length = 15))

set.seed(100)
ridgeTune <- train(x = solTrainXtrans, y = solTrainY,
                   method = "ridge",
                   tuneGrid = ridgeGrid,
                   trControl = ctrl,
                   preProc = c("center", "scale"))

enetModel<-enet(x=as.matrix(solTrainXtrans),
                y=solTrainY,
                lambda=0.01,normalize=TRUE)

enetPred<-predict(enetModel,newx=as.matrix(solTrainXtrans),
                  s=.1,mode="fraction",
                  type="fit")

names(enetPred)

head(enetPred$fit)

enetCoef<-predict(enetModel,newx=as.matrix(solTestXtrans),
                  s=.1,mode="fraction",
                  type="coefficients")

tail(enetCoef$coefficients)

enetGrid <- expand.grid(lambda = c(0, 0.01, .1), 
                        fraction = seq(.05, 1, length = 20))
set.seed(100)
enetTune <- train(x = solTrainXtrans, y = solTrainY,
                  method = "enet",
                  tuneGrid = enetGrid,
                  trControl = ctrl,
                  preProc = c("center", "scale"))
enetTune

plot(enetTune)