#2020.5.5
setwd("/media/user/1907USB/RonGitHUB/data") #set home dir to the data folder
# try Kuhn caret on  67MainCases..202005DummyVar.csv   file
# look at the bar charts
MaxwellWdummyVar <- read.csv("67MainCasesAnalysis202005dummyVar.csv", header = TRUE)
# apply Box Cox transformations to biased non-cat predictors
### Section 3.2 Data Transformations for Individual Predictors
library(e1071)
# skewness for on predictor
skewness(MaxwellWdummyVar$totfp)
histogram(~MaxwellWdummyVar$totfp,
          xlab = "Natural Units"
          )
skewness(MaxwellWdummyVar$ln.totfp.)
histogram(~MaxwellWdummyVar$ln.totfp.,
          xlab = "Natural log totfp"
)
histogram(~MaxwellWdummyVar$acorreff,
          xlab = "Natural Units"
)
histogram(~MaxwellWdummyVar$ln.acorreff.,
          xlab = "Natural Log acorreff"
)
histogram(~MaxwellWdummyVar$boxcoxcorreff,
          xlab = "boxcoxcorreff"
)
histogram(~MaxwellWdummyVar$boxcoxtotpf,
          xlab = "boxcoxtotpf"
)
### Some initial plots of the data

xyplot(MaxwellWdummyVar$ln.acorreff. ~ MaxwellWdummyVar$boxcoxtotpf, type = c("p", "g"),
       ylab = "Corr Eff (log)",
       main = "(a)",
       xlab = "Total fp (log)")
# simple linear regression on single var
lm.fit = lm(ln.acorreff.  ~ boxcoxtotpf , data = MaxwellWdummyVar)
lm.fit
summary(lm.fit)
### Section 6.2 Linear Regression
### Create a control function that will be used across models. We
### create the fold assignments explicitly instead of relying on the
### random number seed being set to identical values.
MaxwellWdummyVar<- MaxwellWdummyVar[1:67,] # remove the 68 69 ... all NA row
#
MaxwellTrainY <-MaxwellWdummyVar$ln.acorreff.
set.seed(100)
indx <- createFolds(MaxwellTrainY, returnTrain = TRUE)
ctrl <- trainControl(method = "cv", index = indx)
MaxwellWdummyVar<- MaxwellWdummyVar[,c(7,9,11,12,13,14,17,19,20)] 
### Linear regression model with all of the predictors. This will
### produce some warnings that a 'rank-deficient fit may be
### misleading'. This is related to the predictors being so highly
### correlated that some of the math has broken down.

set.seed(100)
lmTune0 <- train(x = MaxwellWdummyVar, y = MaxwellTrainY,
                 method = "lm",
                 trControl = ctrl)

lmTune0  