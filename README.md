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


## 2020.9.13
reade HSDZ913 cleansed data, 2 scatter plots
code and plots in learnML

## 2020.9.14
P值
直方图
散点图

## 2020.9.18
0914HSDZ data
P值
直方图
散点图

## 2020.10.4
TODO: 16G404 SanDisk can boot 但没有自动 连上网络
改用您 16G212 SanDisk 才可自动上网

try R, output in LinRegLab20201004es.odt
run Lander ch16, Kuhn Ch6 , Gareth ch6 codes
try to analyse Desharnais77

## 2020.10.6
成功跑完 Kuhn6 LinReg , Ridge, PLS/PCR  on DesharnaisPromise dataset
1/ ConvertDeshaData.R  to convert to solTrain and solTest data set
2/ copy Kuhn code to Kuhn6LinRegRidgePlsPcr1006.R , removed soem irrelvant code from Kuhn6

Output saved in  deshaLinRegRidgePlsPcr1006.odt
Output PNG from 1 to 7 Desha1Rplot.png  to Desha7 ...

## 2020.10.7
Best result in Kuhn 6 by logEFFORT , and Language=1 only
ConvertDeshaLang1only1007.R to read   desharaisLogEffort77kaggle.... csv   or desharnaisLog77kaggle.csv (latter Log PointsAdj as well
then run
Kuhn6LinRegRidgeLPlsPcr1006 . R as before to get results and graphs
some PNG in:   
Outputs in deshaLinRegRidPlsPcrLogEffLang1only
Outputs in deshaLinRegRidPlsPcrLogEffLogPointsLang1only

also some using Lander 16 code


##1009 
data desharnaisLogEffort77kaggleLang3.csv
code converdeshalang31009.R
result desharnaisLogEffort77kaggleLang3.odt

