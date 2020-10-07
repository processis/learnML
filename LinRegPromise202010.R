######
#  try to reproduce Tran results on desharnais and NASA93
#  2020.10.5
getwd()
# Read Desharnais77 and NASA93 public dataset from promise uottawa repository
desharnais <- read.table("DesharnaisPromise.csv",
                         sep = ",", header = TRUE)
nasa <- read.table("cocomonasa_2dataLog.csv",
                   sep = ",", header = TRUE)
head(nasa)
fix(nasa)
nasa.sum<-nasa[,c("equivphyskloc","LogSize","act_effort","LogEffort")]
summary(nasa.sum)
head(desharnais)
desha <- subset(desharnais,Project!=38)
# continue to remove 38 , 44, 66, 75 because not enough data in these projects
desha <- subset(desha,Project!=44)
desha <- subset(desha,Project!=66)
desha <- subset(desha,Project!=75)
fix(desha)
desha$TeamExp<-as.numeric(desha$TeamExp)
desha$ManagerExp<-as.numeric(desha$ManagerExp)
summary(desha)
# write.csv(desha, file = "DeshaPromise77")
# Keep only Effor + 8 independent var, remove project, yearEnd, PointsNnAdjust
desha <- desha[,c(2,3,5:10,12)]
### randomly keep 7 project rows for final checking
write.csv(desha, file = "DeshaPromiseTrain")
# randomly remove 7 rows , keep them as test set later
deshaTrain <- read.table("DeshaPromiseTrain.csv",
                         sep = ",", header = TRUE)
deshaTest <- read.table("DeshaPromiseTest.csv",
                         sep = ",", header = TRUE)
#Apply Kuhn Ch6 Lin Reg to these 1+8 Desha dataset
#remove the first numbering column (x), Effort as Y , remaining as X
deshaTrain <- deshaTrain[,c(2:10)]
deshaTest <- deshaTest[,c(2:10)]
deshaTrainY = deshaTrain$Effort
deshaTestY = deshaTest$Effort
deshaTrainX = deshaTrain[,c(1,2,3,5,6,7,8,9)]
deshaTestX = deshaTest[,c(1,2,3,5,6,7,8,9)]
library(AppliedPredictiveModeling)
### Some initial plots of the data
xyplot(deshaTrainY ~ deshaTrainX$PointsAdjust, type = c("p", "g"),ylab = "Effort",main = "(a)",xlab = "Size (FP)")
xyplot(deshaTrainY ~ deshaTrainX$Entities, type = c("p", "g"),ylab = "Effort",main = "(a)",xlab = "Entities")
xyplot(deshaTrainY ~ deshaTrainX$Transactions, type = c("p", "g"),ylab = "Effort",main = "(a)",xlab = "Trans")
library(corrplot)
corrplot::corrplot(cor(deshaTrainX),order = "hclust", tl.cex = .8)
# Linear regression
library(caret)
set.seed(100)
indx <- createFolds(deshaTrainY, returnTrain = TRUE)
ctrl <- trainControl(method = "cv", index = indx)
set.seed(100)
lmTune0 <- train(x = deshaTrainX, y = deshaTrainY,
                 method = "lm",
                 trControl = ctrl)
lmTune0 
tooHigh <- findCorrelation(cor(deshaTrainX), .8)
deshaTrainXfiltered <- deshaTrainX[, -tooHigh]
deshaTestXfiltered  <-  deshaTestX[, -tooHigh]
set.seed(100)
lmTune <- train(x = deshaTrainXfiltered, y = deshaTrainY,
                 method = "lm",
                 trControl = ctrl)
lmTune
### Save the test set results in a data frame 
testResults <- data.frame(obs = deshaTestY,
                          Linear_Regression = predict(lmTune, deshaTestXfiltered))
### Section 6.4 Penalized Models
ridgeGrid <- expand.grid(lambda = seq(0, .1, length = 15))
set.seed(100)
ridgeTune <- train(x = deshaTrainX, y = deshaTrainY,
                   method = "ridge",
                   tuneGrid = ridgeGrid,
                   trControl = ctrl,
                   preProc = c("center", "scale"))
ridgeTune
print(update(plot(ridgeTune), xlab = "Penalty"))
enetGrid <- expand.grid(lambda = c(0, 0.01, .1), 
                        fraction = seq(.05, 1, length = 20))
set.seed(100)
enetTune <- train(x = deshaTrainX, y = deshaTrainY,
                  method = "enet",
                  tuneGrid = enetGrid,
                  trControl = ctrl,
                  preProc = c("center", "scale"))
enetTune
plot(enetTune)
TestResults$Enet <- predict(enetTune, deshaTestX)


