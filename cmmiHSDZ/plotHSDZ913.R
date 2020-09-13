#2020.9.13 read HSDZ data
setwd("/media/user/1907USB/RonGitHUB/cmmiHSDZ/data") #set home dir to the data folder
# try Kuhn caret on  67MainCases..0913HSDZ..eng.csv   file
# look at the bar charts
HSDZ913 <- read.csv("0913HSDZv03engCleansed.csv", header = TRUE)
library(e1071)
library(ggplot2)
#
# reuse Lander ch7 ggplot2 code
gScatterPlotJavaSize <- ggplot(HSDZ913, aes(x = AfpDev , y = LocJavaIt))
gScatterPlotJavaSize + geom_point()
gScatterPlotJavaSize + geom_point(aes(color = Project))
gScatterPlotVueSize <- ggplot(HSDZ913, aes(x = AfpDev , y = LocVUEit))
gScatterPlotVueSize + geom_point(aes(color = Project))
