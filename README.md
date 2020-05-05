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

##2020.04.03
最初的数据：Maxwell67MainCasesTrainTestV10esFinal.CSV
新增变量后的数据：67MainCasesAnalysis3.30(2cust).CSV
R的代码：67练习.R
minitab结果过程与截图：max67操作步骤及结果.docx
wiki词条：ma中Maxweill 67 minitab步骤

## 2020.5.2
tried larose ch 2 3 code on cars , cars2 , churn
try DPPSS cov(failed, due to ordinal), chisq.test similar result

## 2020.5.3
tried graphicsCookbookCh356.R -> Shelly , please complete...

## 2020.5.5
try Kuhn caret using dummy var to find the multi var LR for Maxwell 67data from
67MainCasesAnalysis202005dummyVar



