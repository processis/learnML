# Read Desharnais77 public dataset from promise uottawa repository
desharnais <- read.table("DesharnaisPromise.csv",
                         sep = ",", header = TRUE)
desha <- subset(desharnais,Project!=38)
# continue to remove 38 , 44, 66, 75 because not enough data in these projects
desha <- subset(desha,Project!=44)
desha <- subset(desha,Project!=66)
desha <- subset(desha,Project!=75)
### because ? in some fields under these columns 
#   has to specify as numeric
desha$TeamExp<-as.numeric(desha$TeamExp)
desha$ManagerExp<-as.numeric(desha$ManagerExp)
# Keep only Project+Effor + 8 independent var, remove project, yearEnd, PointsNnAdjust
desha <- desha[,c(1,2,3,5:10,12)]
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