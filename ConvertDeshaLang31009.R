# Read Desharnais77 public dataset from promise uottawa repository
desharnais <- read.table("desharnaisLogEffort77kaggleLang3.csv",
                         sep = ",", header = TRUE)

desha <- subset(desharnais,Project!=38)
# 0< continue to remove 38 , 44, 66, 75 because not enough data in these projects
desha <- subset(desha,Project!=44)
desha <- subset(desha,Project!=66)
desha <- subset(desha,Project!=75)

#has to specify as numeric
desha$TeamExp<-as.numeric(desha$TeamExp)
desha$ManagerExp<-as.numeric(desha$ManagerExp)

# Keep only Project+Effor + 8 independent var, remove project, yearEnd, PointsNnAdjust
desha <- desha[,c(1,2,3,(5:8),(10:13))]
### randomly keep 4 project rows , remaining 71 rows, keep as Training set
deshaTrain <- subset(desha,Project!=1)
deshaTrain <- subset(deshaTrain,Project!=2)
deshaTrain <- subset(deshaTrain,Project!=3)
deshaTrain <- subset(deshaTrain,Project!=4)
deshaTrain <- subset(deshaTrain,Project!=5)
deshaTrain <- subset(deshaTrain,Project!=6)
### keep the 6 rows in Test dataset
deshaTest <- subset(desha,Project < 7)

### remove first column Project from both Train and Test sets
deshaTrain <- deshaTrain[,c(2:11)]
deshaTest <- deshaTest[,c(2:11)]
deshaTrainY = deshaTrain$Effort
deshaTestY = deshaTest$Effort

#remove Effort from X set
deshaTrainX = deshaTrain[,c(1:3,5:10)]
deshaTestX = deshaTest[,c(1:3,5:10)]

solTestY = deshaTestY
solTrainY = deshaTrainY
solTrainX = deshaTrainX
solTestX = deshaTestX
solTrainXtrans = deshaTrainX
solTestXtrans = deshaTestX


######CH6 linear regression and cousins
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
corrplot::corrplot(cor(solTrainXtrans), 
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


########

library(caret)
set.seed(100)
indx <- createFolds(solTrainY, returnTrain = TRUE)
ctrl <- trainControl(method = "cv", index = indx)

### Section 7.3 Support Vector Machines

## In a recent update to caret, the method to estimate the
## sigma parameter was slightly changed. These results will
## slightly differ from the text for that reason.

set.seed(100)
svmRTune <- train(x = solTrainXtrans, y = solTrainY,
                  method = "svmRadial",
                  preProc = c("center", "scale"),
                  tuneLength = 14,
                  trControl = ctrl)
svmRTune
plot(svmRTune, scales = list(x = list(log = 2)))                 

svmGrid <- expand.grid(degree = 1:2, 
                       scale = c(0.01, 0.005, 0.001), 
                       C = 2^(-2:5))

set.seed(100)
svmPTune <- train(x = solTrainXtrans, y = solTrainY,
                  method = "svmPoly",
                  preProc = c("center", "scale"),
                  tuneGrid = svmGrid,
                  trControl = ctrl)

svmPTune

plot(svmPTune, 
     scales = list(x = list(log = 2), 
                   between = list(x = .5, y = 1)))                 

testResults$SVMr <- predict(svmRTune, solTestXtrans)
testResults$SVMp <- predict(svmPTune, solTestXtrans)

 View(testResults)

 ### Section 7.2 Multivariate Adaptive Regression Splines
 
 set.seed(100)
 marsTune <- train(x = solTrainXtrans, y = solTrainY,
                   method = "earth",
                   tuneGrid = expand.grid(degree = 1, nprune = 2:38),
                   trControl = ctrl)
 marsTune
 
 plot(marsTune)
 
 testResults$MARS <- predict(marsTune, solTestXtrans)
 
 marsImp <- varImp(marsTune, scale = FALSE)
 plot(marsImp, top = 25)

 View(testResults)

 
 ##########ch8########
 ### Section 8.5 Random Forests
 
 mtryGrid <- data.frame(mtry = floor(seq(10, ncol(solTrainXtrans), length = 10)))
 ### Tune the model using cross-validation
 set.seed(100)
 rfTune <- train(x = solTrainXtrans, y = solTrainY,
                 method = "rf",
                 tuneGrid = mtryGrid,
                 ntree = 1000,
                 importance = TRUE,
                 trControl = ctrl)
 rfTune
 
 testResults$RF <- predict(rfTune, solTestXtrans)
 
 plot(rfTune)
 
 rfImp <- varImp(rfTune, scale = FALSE)
 rfImp
 ### Section 8.7 Cubist
 
 cbGrid <- expand.grid(committees = c(1:10, 20, 50, 75, 100), 
                       neighbors = c(0, 1, 5, 9))
 
 set.seed(100)
 cubistTune <- train(solTrainXtrans, solTrainY,
                     "cubist",
                     tuneGrid = cbGrid,
                     trControl = ctrl)
 cubistTune
 
 plot(cubistTune, auto.key = list(columns = 4, lines = TRUE))
 
 cbImp <- varImp(cubistTune, scale = FALSE)
 cbImp
 
 testResults$CUBIST <- predict(cubistTune, solTestXtrans)
 
 View(testResults)
 
