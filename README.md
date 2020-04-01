# learnML
learn Machine Learning usng R
## 2020.3.26  
* try maxwell326es from Shelly Minitab output
## 2020.3.27
*new way - feizhengtai date  histogram

AnalysisTrain <- Analysis[,-(24:28)]
AnalysisPP <- preProcess(AnalysisTrain , method = "BoxCox")
AnalysisTrainTrans <- predict(AnalysisPP, AnalysisTrain)
segPP$bc$totfp
histogram(~AnalysisTrain$totfp,
          xlab = "Natural Units",
          type = "count")

histogram(~AnalysisTrainTrans$totfp,
          xlab = "Transformed Units",
          ylab = " ",
          type = "count")
segPP$bc$acorreff
histogram(~AnalysisTrain$acorreff,
          xlab = "Natural Units",
          type = "count")

histogram(~AnalysisTrainTrans$acorreff,
          xlab = "Transformed Units",
          ylab = " ",
          type = "count")
          
lm.fit=lm(acorreff ~ totfp , data=AnalysisTrainTrans)
lm.fit
summary(lm.fit)

#0330 67 ch3.5 之前所有的数据+哑变量分离数据
maxwell670330.csv

#0331 codes 0330的数据包分为train和test
ch5 67 pratice success
ch6 havs problems