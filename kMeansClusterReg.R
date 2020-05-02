# try k means clustered regression approach by Nagpal (2013)
#Read Promise Desharnais data
setwd("/media/user/1907USB/2020data")
Desharn77Data <- read.csv("PromiseData/Desharnais(77).csv", header = TRUE)
head(Desharn77Data)
summary(Desharn77Data$Effort)