# try Linear Regressions on COCOMO Desharnais data
# first retry Gareth , Khun , Lander , Matloff ...
# 2020.10.4
#
#
#  Lander Chapter 16
getwd()
setwd("/media/user/1907USB/RonGitHUB/learnML")
getwd()
housing <- read.table("housing.csv",
                      sep = ",", header = TRUE,
                      stringsAsFactors = FALSE)
names(housing) <- c("Neighborhood", "Class", "Units", "YearBuilt",
                    "SqFt", "Income", "IncomePerSqFt","Expense",
                    "ExpensePerSqFt","NetIncome", "Value",
                    "ValuePerSqFt", "Boro")
head(housing)
ggplot(housing, aes (x = ValuePerSqFt)) +
  geom_histogram(binwidth = 100) + labs(x = "Value per Square Foot")
ggplot(housing, aes(x = ValuePerSqFt, fill = Boro)) +
  geom_histogram(binwidth = 100) + labs(x = "Value Per Square Foot")
ggplot(housing, aes(x = ValuePerSqFt, fill = Boro)) +
  geom_histogram(binwidth = 100) + labs(x = "Value per Square Foot") +
  facet_wrap(~Boro)
ggplot(housing,aes(x = SqFt)) + geom_histogram()
ggplot(housing, aes(x = Units)) + geom_histogram()
ggplot(housing[housing$Units < 1000,],
       aes(x = SqFt)) + geom_histogram()
ggplot(housing[housing$Units < 1000, ],
       aes(x = Units)) + geom_histogram()
ggplot(housing, aes(x = SqFt, y = ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x = Units, y = ValuePerSqFt)) + geom_point()
#  determine the number of buildings with 1000 or more units
sum(housing$Units >= 1000)
#  Remove buildings with 1000 or more units
housing <- housing[housing$Units < 1000, ]
#  plot value per sqft against sq feet
ggplot(housing, aes(x = SqFt, y = ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x = log(SqFt), y = ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x = SqFt, y = log(ValuePerSqFt))) + geom_point()
ggplot(housing, aes(x = log(SqFt), y = log(ValuePerSqFt))) + geom_point()
#  plot valueperSqFt against number of units
ggplot(housing, aes(x = Units, y= ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x = log(Units), y = ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x = Units, y = log(ValuePerSqFt))) + geom_point()
ggplot(housing, aes(x = log(Units), y = log(ValuePerSqFt)))+ geom_point()
house1 <- lm(ValuePerSqFt ~ Units+SqFt + Boro, data = housing)
summary(house1)
house1$coefficients
coef(house1)
require(coefplot)
coefplot(house1)
house2 <- lm(ValuePerSqFt ~ Units*SqFt + Boro, data = housing)
house3 <- lm(ValuePerSqFt ~ Units:SqFt + Boro, data = housing)
house2$coefficients
house3$coefficients
coefplot(house2)
coefplot(house3)
house4 <- lm(ValuePerSqFt ~ SqFt*Units*Income, housing)
house4$coefficients
house5 <- lm(ValuePerSqFt ~ Class * Boro, housing)
house5$coefficients
house6 <- lm(ValuePerSqFt ~ I(SqFt/Units) + Boro, housing)
house6$coefficients
house7 <- lm(ValuePerSqFt ~ (Units + SqFt)^2, housing)
house7$coefficients
house8 <- lm(ValuePerSqFt ~Units* SqFt, housing)
house8$coefficients
house9 <- lm(ValuePerSqFt ~ I(Units+SqFt)^2, housing)
house9$coefficients
#  also from the coefplot package
multiplot(house1, house2, house3)
#  http://www.jaredlander.com/data/housingNEW,csv for new data/
housingNew <- read.table("housingNew.csv",
                         sep = ",", header = TRUE,
                         stringsAsFactors = FALSE)
housePredict <- predict(house1, newdata = housingNew, se.fit = TRUE,
                        interval = "prediction", level = 0.95)
head(housePredict$fit)
head(housePredict$se.fit)
# complete Lander Chapter16 run
# Read Desharnais77 and NASA93 public dataset from promise uottawa repository
desharnais <- read.table("desharnais77.csv",
                         sep = ",", header = TRUE)
nasa <- read.table("cocomonasa_2.csv",
                         sep = ",", header = TRUE)
#try Kuhn ch6 Linear Regression and cousins
library(AppliedPredictiveModeling)
data(solubility)

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
### Find the columns that are not fingerprints  , column names that contain the pattern "FP".

notFingerprints <- grep("FP", names(solTrainXtrans))
library(caret)
featurePlot(solTrainXtrans[, -notFingerprints],
            solTrainY,
            between = list(x = 1, y = 1),
            type = c("g", "p", "smooth"),
            labels = rep("", 2))

library(corrplot)
corrplot::corrplot(cor(solTrainXtrans[, -notFingerprints]), 
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
###
###GRETH cH6 Linear model selection and regularization
### 6.5  Subset selection - best , stepwise
library(ISLR)
fix (Hitters)
names(Hitters)
dim(Hitters)
sum(is.na(Hitters$Salary))
Hitters=na.omit(Hitters)
dim(Hitters)
sum(is.na(Hitters))

library(leaps)
regfit.full=regsubsets(Salary~.,Hitters)
summary(regfit.full)
regfit.full=regsubsets(Salary~.,data=Hitters,nvmax=19)
reg.summary=summary(regfit.full)
names(reg.summary)
reg.summary$rsq
reg.summary$cp
reg.summary$bic
par(mfrow=c(2,2))
plot(reg.summary$rss,xlab="Number of Variables",ylab="RSS",type="l")
plot(reg.summary$adjr2,xlab="Number of Variables",ylab="Adjusted RSq",type="l")
which.max(reg.summary$adjr2)
points(11,reg.summary$adjr2[11], col="red", cex=2, pch=20)
plot(reg.summary$cp,xlab="Number of Variables",ylab="Cp",type="l")
which.min(reg.summary$cp)
points(10,reg.summary$cp[10], col="red", cex=2, pch=20)
which.min(reg.summary$bic)
plot(reg.summary$bic,xlab="Number of Variables",ylab="BIC",type="l")
points(6,reg.summary$bic[6], col="red", cex=2, pch=20)
plot(regfit.full,scale="r2")
plot(regfit.full,scale="adjr2")
plot(regfit.full,scale="Cp")
plot(regfit.full,scale="bic")
coef(regfit.full,6)
#forward and backward stepwise
regfit.fwd=regsubsets(Salary~.,data=Hitters,nvmax=19,method="forward")
summary(regfit.fwd)
regfit.bwd=regsubsets(Salary~.,data=Hitters,nvmax=19,method="backward")
summary(regfit.bwd)
#check coef of full, fwd, bwd
coef(regfit.full,7)
coef(regfit.fwd,7)
coef(regfit.bwd,7)
# use cross  validation to choose among models
set.seed(1)
train=sample(c(TRUE,FALSE), nrow(Hitters), rep=TRUE)
test=(!train)
#apply to training set
regfit.best=regsubsets(Salary~.,data=Hitters[train,],nvmax=19)
test.mat=model.matrix(Salary~.,data=Hitters[test,])
val.errors=rep(NA,19)
for (i in 1:19){
    coefi=coef(regfit.best, id=i)
    pred=test.mat[,names(coefi)]%*%coefi
    val.errors[i]=mean((Hitters$Salary[test]-pred)^2)
}
val.errors
which.min(val.errors)
coef(regfit.best,10)
#write our own predict meth
predict.regsubsets=function(object,newdata, id,...){
  form=as.formula(object$call[[2]])
  mat=model.matrix(form,newdata)
  coefi=coef(object,id=id)
  xvars=names(coefi)
  mat[,xvars]%*%coefi
}
regfit.best=regsubsets(Salary~.,data=Hitters,nvmax=19)
coef(regfit.best,10)
#
k=10
set.seed(1)
folds=sample(1:k,nrow(Hitters),replace=TRUE)
cv.errors=matrix(NA,k,19, dimnames=list(NULL, paste(1:19)))
#
for(j in 1:k){
  best.fit=regsubsets(Salary~.,data=Hitters[folds!=j,], nvmax = 19)
  for (i in 1:19){
    pred=predict(best.fit,Hitters[folds==j,],id=i)
    cv.errors[j,i]=mean( (Hitters$Salary[folds==j]-pred)^2)
  }
}
mean.cv.errors=apply(cv.errors,2, mean)
mean.cv.errors
par(mfrow=c(1,1))
plot(mean.cv.errors,type='b')
reg.best=regsubsets(Salary~.,data=Hitters, nvmax=19)
coef(reg.best,11)
###Ridge Regression
## library(glmnet)  cannot find in 3.5.2
x=model.matrix(Salary~.,Hitters)[,-1]
y=Hitters$Salary
y.test=y[test]
## PCR
library(pls)
set.seed(2)
pcr.fit=pcr(Salary~., data=Hitters , scale=TRUE, validation="CV")
summary(pcr.fit)
validationplot(pcr.fit,val.type="MSEP")
# perform PCR on training data
set.seed(1)
pcr.fit=pcr(Salary~., data=Hitters, subset = train,scale=TRUE, validation="CV")
validationplot(pcr.fit,val.type="MSEP")
pcr.pred=predict(pcr.fit,x[test,],ncomp=7)
mean((pcr.pred-y.test)^2)
# ? 140344 instead of 96556 from book
pcr.fit=pcr(y~x,scale=TRUE,ncomp=7)
summary(pcr.fit)
### PLS
set.seed(1)
pls.fit=plsr(Salary~., data=Hitters, subset=train,scale=TRUE,validation ="CV")
summary(pls.fit)
#why xy dimension are 134 , instead of 131 from the book ?
pls.pred=predict(pls.fit,x[test,],ncomp = 2)
mean((pls.pred - y.test)^2)
# why get 155849 , instead of 101417 from book
pls.fit=plsr(Salary~., data=Hitters, scale=TRUE , ncomp=2)
summary(pls.fit)
### Session Information

sessionInfo()
