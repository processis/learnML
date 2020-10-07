

# Read Desharnais77 public dataset from promise uottawa repository
desharnais <- read.table("desharnaisLogEffort77kaggle.csv",
                         sep = ",", header = TRUE)
desha <- subset(desharnais,Project!=38)
# continue to remove 38 , 44, 66, 75 because not enough data in these projects
desha <- subset(desha,Project!=44)
desha <- subset(desha,Project!=66)
desha <- subset(desha,Project!=75)
desha <- subset(desha,Language==1)
desha <- desha[,c(1:11)] # remove the Lang col which is now always 1
### because ? in some fields under these columns 
#   has to specify as numeric
desha$TeamExp<-as.numeric(desha$TeamExp)
desha$ManagerExp<-as.numeric(desha$ManagerExp)
# Keep only Project+Effor + 8 independent var, remove project, yearEnd, PointsNnAdjust
desha <- desha[,c(1,2,3,(5:8),(10:11))]
### randomly keep 4 project rows , remaining 71 rows, keep as Training set
deshaTrain <- subset(desha,Project!=1)
deshaTrain <- subset(deshaTrain,Project!=2)
deshaTrain <- subset(deshaTrain,Project!=3)
deshaTrain <- subset(deshaTrain,Project!=4)
#deshaTrain <- subset(deshaTrain,Project!=70)
#deshaTrain <- subset(deshaTrain,Project!=71)
### keep the 6 rows in Test dataset
deshaTest <- subset(desha,Project < 5)
### remove first column Project from both Train and Test sets
deshaTrain <- deshaTrain[,c(2:9)]
deshaTest <- deshaTest[,c(2:9)]
deshaTrainY = deshaTrain$Effort
deshaTestY = deshaTest$Effort
#remove Effort from X set
deshaTrainX = deshaTrain[,c(1:3,5:8)]
deshaTestX = deshaTest[,c(1:3,5:8)]
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