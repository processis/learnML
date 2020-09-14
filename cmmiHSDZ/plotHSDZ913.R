#2020.9.13 read HSDZ data
setwd("/media/user/1907USB/RonGitHUB/cmmiHSDZ/data") #set home dir to the data folder
# try Kuhn caret on  67MainCases..0913HSDZ..eng.csv   file
# look at the bar charts
HSDZ913 <- read.csv("0913HSDZv03engCleansed.csv", header = TRUE)
library(e1071)
library(ggplot2)
#
#数据分析
summary(HSDZ913)

#P值
names(HSDZ913)
fix(HSDZ913)
x <- HSDZ913$AfpDev
y <- HSDZ913$ManDayIt
cor(x,y,method="pearson")
cor(x,y,method="spearman")
cor(x,y,method="kendall")
y <- HSDZ913$LnJavaIt
cor(x,y,method="pearson")
y <- HSDZ913$X.1
cor(x,y,method="pearson")
y <- HSDZ913$LnJavaIt
cor(x,y,method="pearson")
y <- HSDZ913$LocJavaIt
cor(x,y,method="pearson")
y <- HSDZ913$LocVUEit
cor(x,y,method="pearson")
y <- HSDZ913$TestCasesTotal
cor(x,y,method="pearson")
y <- HSDZ913$DefectCount
cor(x,y,method="pearson")
y <- HSDZ913$ButRate
cor(x,y,method="pearson")

#直方图
library(graphics)
hist(HSDZ913$AfpDev)
hist(HSDZ913$ManDayIt)
hist(HSDZ913$LnJavaIt)
hist(HSDZ913$X.1)
hist(HSDZ913$LocVUEit)
hist(HSDZ913$LocJavaIt)
hist(HSDZ913$TestCasesTotal)
hist(HSDZ913$DefectCount)
hist(HSDZ913$ButRate)





# reuse Lander ch7 ggplot2 code
gScatterPlotJavaSize <- ggplot(HSDZ913, aes(x = AfpDev , y = LocJavaIt))
gScatterPlotJavaSize + geom_point()
gScatterPlotJavaSize + geom_point(aes(color = Project))
gScatterPlotVueSize <- ggplot(HSDZ913, aes(x = AfpDev , y = ManDayIt))
gScatterPlotVueSize + geom_point(aes(color = Project))

gScatterPlotVueSize <- ggplot(HSDZ913, aes(x = AfpDev , y = LnJavaIt))
gScatterPlotVueSize + geom_point(aes(color = Project))

gScatterPlotVueSize <- ggplot(HSDZ913, aes(x = AfpDev , y = X.1))
gScatterPlotVueSize + geom_point(aes(color = Project))

gScatterPlotVueSize <- ggplot(HSDZ913, aes(x = AfpDev , y = LocVUEit))
gScatterPlotVueSize + geom_point(aes(color = Project))

gScatterPlotVueSize <- ggplot(HSDZ913, aes(x = AfpDev , y = TestCasesTotal))
gScatterPlotVueSize + geom_point(aes(color = Project))

gScatterPlotVueSize <- ggplot(HSDZ913, aes(x = AfpDev , y = DefectCount))
gScatterPlotVueSize + geom_point(aes(color = Project))
