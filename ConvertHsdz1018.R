# Read HSDZ dataset, check overall relationship
hsdz <- read.table("HSDZ1018es1.csv",
                         sep = ",", header = TRUE)
#keep only the summary overall data for each project
fix(hsdz)
hsdzSummary <- subset(hsdz,Number!=27)
# continue to remove 38 , 44, 66, 75 because not enough data in these projects
hsdzSummary <- subset(hsdzSummary,Number!=25)
hsdzSummary <- subset(hsdzSummary,Number!=23)
hsdzSummary <- subset(hsdzSummary,Number!=22)
hsdzSummary <- subset(hsdzSummary,Number!=21)
hsdzSummary <- subset(hsdzSummary,Number!=18)
hsdzSummary <- subset(hsdzSummary,Number!=17)
hsdzSummary <- subset(hsdzSummary,Number!=16)
hsdzSummary <- subset(hsdzSummary,Number!=14)
hsdzSummary <- subset(hsdzSummary,Number!=13)
hsdzSummary <- subset(hsdzSummary,Number!=12)
hsdzSummary <- subset(hsdzSummary,Number!=11)
hsdzSummary <- subset(hsdzSummary,Number!=10)
hsdzSummary <- subset(hsdzSummary,Number!=8)
hsdzSummary <- subset(hsdzSummary,Number!=7)
hsdzSummary <- subset(hsdzSummary,Number!=6)
hsdzSummary <- subset(hsdzSummary,Number!=4)
hsdzSummary <- subset(hsdzSummary,Number!=3)
hsdzSummary <- subset(hsdzSummary,Number!=1)
# hsdzSummary <- hsdzSummary[,c(2:10)]
solTrainXtrans <- data.frame(DataQual = hsdzSummary$DataQual.)
solTrainXtrans$FpAppTot <- hsdzSummary$FpAppTot
solTrainXtrans$EnhAdjFac <- hsdzSummary$EnhAdjFac
solTrainXtrans$TestCasesTotal <- hsdzSummary$TestCasesTotal
solTrainXtrans$CCI <- hsdzSummary$CCI
solTrainXtrans$TestCasesTotal <- hsdzSummary$TestCasesTotal
solTrainXtrans$SumOfBugCount <- hsdzSummary$dSumOfBugCount
solTrainY = hsdzSummary$LocJavaTotal
solTrainX = solTrainXtrans
#
#
### because ? in some fields under these columns 
#   has to specify as numeric
desha$TeamExp<-as.numeric(desha$TeamExp)
desha$ManagerExp<-as.numeric(desha$ManagerExp)
# Keep only Project+Effor + 8 independent var, remove project, yearEnd, PointsNnAdjust
desha <- desha[,c(1,2,3,(5:8),(10:12))]
### randomly keep 6 project rows , remaining 71 rows, keep as Training set
deshaTrain <- subset(desha,Project!=69)
deshaTrain <- subset(deshaTrain,Project!=72)
deshaTrain <- subset(deshaTrain,Project!=73)
deshaTrain <- subset(deshaTrain,Project!=74)
deshaTrain <- subset(deshaTrain,Project!=70)
deshaTrain <- subset(deshaTrain,Project!=71)
### keep the 6 rows in Test dataset
deshaTest <- subset(desha,Project>68 & Project <75)
### remove first column Project from both Train and Test sets
deshaTrain <- deshaTrain[,c(2:10)]
deshaTest <- deshaTest[,c(2:10)]
deshaTrainY = deshaTrain$Effort
deshaTestY = deshaTest$Effort
#remove Effort from X set
deshaTrainX = deshaTrain[,c(1:3,5:9)]
deshaTestX = deshaTest[,c(1:3,5:9)]
solTestY = deshaTestY
solTrainY = deshaTrainY
solTrainX = deshaTrainX
solTestX = deshaTestX
solTrainXtrans = deshaTrainX
solTestXtrans = deshaTestX
###
#
#
deshaLog1 <- lm(Effort ~ PointsAjust+Transactions + Entities, data = deshaTrain)
summary(deshaLog1)
deshaLog1$coefficients
coef(deshaLog1)
require(coefplot)
coefplot(deshaLog1)