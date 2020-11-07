# Read Desharnais77 public dataset from promise uottawa repository
desharnais <- read.table("deshRandomFrShelly1106.csv",
                         sep = ",", header = TRUE)
desha <- subset(desharnais,Project!=76)
# continue to remove incomplete rows, bottom up, because not enough data in these projects
desha <- subset(desha,Project!=67)
desha <- subset(desha,Project!=45)
desha <- subset(desha,Project!=40)
desha <- subset(desha,Language1==1)
desha <- desha[,c(1:13)] 
### because ? in some fields under these columns 
#   has to specify as numeric
desha$TeamExp<-as.numeric(desha$TeamExp)
desha$ManagerExp<-as.numeric(desha$ManagerExp)
# Keep only Project+Effor + 8 independent var, rremove yearEnd, PointsNnAdjust, Lang3 
desha <- desha[,c(1,2,3,(5:8),(11:13))]
### randomly keep 4 project rows , remaining 71 rows, keep as Training set
deshaTrain <- subset(desha,Project!=1)
deshaTrain <- subset(deshaTrain,Project!=2)
deshaTrain <- subset(deshaTrain,Project!=3)
deshaTrain <- subset(deshaTrain,Project!=4)
deshaTrain <- subset(deshaTrain,Project!=5)
deshaTrain <- subset(deshaTrain,Project!=6)
### keep the 4 rows in Test dataset
deshaTest <- subset(desha,Project < 7)
### remove first column Project and Lang1 Lang2 from both Train and Test sets
deshaTrain <- deshaTrain[,c(2:8)]
deshaTest <- deshaTest[,c(2:8)]
deshaTrainY = deshaTrain$Effort
deshaTestY = deshaTest$Effort
#remove Effort from X set
deshaTrainX = deshaTrain[,c(1:3,5:7)]
deshaTestX = deshaTest[,c(1:3,5:7)]
swEngTestY = deshaTestY
swEngTrainY = deshaTrainY
swEngTrainX = deshaTrainX
swEngTestX = deshaTestX
swEngTrainXtrans = deshaTrainX
swEngTestXtrans = deshaTestX
###
#
#
deshaLog1 <- lm(Effort ~ PointsAjust+Transactions + Entities, data = deshaTrain)
summary(deshaLog1)
deshaLog1$coefficients
coef(deshaLog1)
require(coefplot)
coefplot(deshaLog1)