#try Kuhn ch6 Linear Regression and cousins
library(AppliedPredictiveModeling)

library(lattice)
### Some initial plots of the data

xyplot(solTrainY ~ solTrainX$Entities, type = c("p", "g"),
       ylab = "Effort",
       main = "(a)",
       xlab = "Entities")
xyplot(solTrainY ~ solTrainX$Transactions, type = c("p", "g"),
       ylab = "Effort",
       xlab = "Trans")

library(caret)
library(corrplot)
#look at both X and Y variables, so look at deshaTrain instead of solTrainXtrans
corrplot::corrplot(cor(deshaTrain), 
                   order = "hclust", 
                   tl.cex = .8)

### Section 6.2 Linear Regression
set.seed(100)
indx <- createFolds(solTrainY, returnTrain = TRUE)
ctrl <- trainControl(method = "cv", index = indx)
set.seed(100)
lmTune0 <- train(x = solTrainXtrans, y = solTrainY,
                 method = "lm",
                 trControl = ctrl)

lmTune0   

tooHigh <- findCorrelation(cor(solTrainXtrans), .8)
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

### Section 6.4 Penalized Models
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
### Section 6.3 Partial Least Squares

## Run PLS and PCR on solubility data and compare results
# removed tune grid ncomp =... to use default , max number of components
set.seed(100)
plsTune <- train(x = solTrainXtrans, y = solTrainY,
                 method = "pls",
                 trControl = ctrl)
plsTune

testResults$PLS <- predict(plsTune, solTestXtrans)

set.seed(100)
pcrTune <- train(x = solTrainXtrans, y = solTrainY,
                 method = "pcr",
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
###
################################################################################
write.table(testResults,file="testResultsLmPlsPcr.csv",sep=",") # output testResults.csv
### Session Information0