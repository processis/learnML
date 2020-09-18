HSDZ914 <- read.csv("0914HSDZ.csv", header = TRUE)
library(e1071)
library(ggplot2)
#
#数据分析
summary(HSDZ914)
#P值
names(HSDZ914)
fix(HSDZ914)
x <- HSDZ914$AfpDev
y <- HSDZ914$ManDayIt
cor(x,y,method="pearson")
cor(x,y,method="spearman")
cor(x,y,method="kendall")
y <- HSDZ914$LnJavaIt
cor(x,y,method="pearson")
y <- HSDZ914$X.1
cor(x,y,method="pearson")
y <- HSDZ914$LnJavaIt
cor(x,y,method="pearson")
y <- HSDZ914$LocJavaIt
cor(x,y,method="pearson")
y <- HSDZ914$LocVUEit
cor(x,y,method="pearson")
y <- HSDZ914$TestCasesTotal
cor(x,y,method="pearson")
y <- HSDZ914$DefectCount
cor(x,y,method="pearson")
y <- HSDZ914$ButRate
cor(x,y,method="pearson")

#直方图
library(graphics)
hist(HSDZ914$AfpDev)
hist(HSDZ914$ManDayIt)
hist(HSDZ914$LnJavaIt)
hist(HSDZ914$LocVUEit)
hist(HSDZ914$LocJavaIt)
hist(HSDZ914$TestCasesTotal)
hist(HSDZ914$DefectCount)
hist(HSDZ914$ButRate)





# reuse Lander ch7 ggplot2 code
gScatterPlotJavaSize <- ggplot(HSDZ914, aes(x = AfpDev , y = LocJavaIt))
gScatterPlotJavaSize + geom_point()
gScatterPlotJavaSize + geom_point(aes(color = Project))
gScatterPlotVueSize <- ggplot(HSDZ914, aes(x = AfpDev , y = ManDayIt))
gScatterPlotVueSize + geom_point(aes(color = Project))

gScatterPlotVueSize <- ggplot(HSDZ914, aes(x = AfpDev , y = LnJavaIt))
gScatterPlotVueSize + geom_point(aes(color = Project))


gScatterPlotVueSize <- ggplot(HSDZ914, aes(x = AfpDev , y = LocVUEit))
gScatterPlotVueSize + geom_point(aes(color = Project))

gScatterPlotVueSize <- ggplot(HSDZ914, aes(x = AfpDev , y = TestCasesTotal))
gScatterPlotVueSize + geom_point(aes(color = Project))

gScatterPlotVueSize <- ggplot(HSDZ914, aes(x = AfpDev , y = DefectCount))
gScatterPlotVueSize + geom_point(aes(color = Project))