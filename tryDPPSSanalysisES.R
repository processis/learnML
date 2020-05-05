# Larose ch1 R code (p15)
cars<- read.csv(file="/media/user/1907USB/RonGitHUB/Larose/data/cars.txt",stringsAsFactors = FALSE)
cov(cars[1:3])
cor(cars[1:3])
DPPSSdata <- DPPSSdata[1:60,] # remove the 61 all NA row
DPPSS.OrdinalCsub<-DPPSSdata[,c(1,2,7,8)]
DPPSS.OrdinalCsub <-DPPSS.OrdinalCsub[1:60,]
cor(DPPSS.OrdinalCsub[1:4])
cov(DPPSS.OrdinalCsub[1:4])
cor(DPPSS.OrdinalCsub$CSat,DPPSS.OrdinalCsub$FieldedVolatility,method="spearman")
cor(DPPSS.OrdinalCsub,method="pearson")
cor(DPPSS.OrdinalCsub,method="spearman")
chisq.test(DPPSSdata$Ship,DPPSSdata$Experience)
chisq.test(DPPSSdata$Ship,DPPSSdata$Language)
chisq.test(DPPSSdata$Ship,DPPSSdata$DomainExp)
#try contingency table using table
DPPSSdata$Experience<-as.factor(DPPSSdata$Experience)
DPPSSdata$Ship<-as.factor(DPPSSdata$Ship)
contingTable=table(DPPSSdata$DomainExp,DPPSSdata$Experience)
contingTable
chisq.test(ftable)#执行皮尔森卡方检验
# Ship-risk vs Language
DPPSSdata$Language<-as.factor(DPPSSdata$Language)
ftable=table(DPPSSdata$Ship,DPPSSdata$Language)
ftable
# Ship-risk vs Domain Experience
DPPSSdata$DomainExp<-as.factor(DPPSSdata$DomainExp)
ftable=table(DPPSSdata$Ship,DPPSSdata$DomainExp)
ftable
DPPSSdata$DefectsInspect<-as.factor(DPPSSdata$DefectsInspect)
ftable=table(DPPSSdata$Ship,DPPSSdata$Language,stringsAsFactors = TRUE)
ftable
#try Tabular data tests from R.in.a.Nutshell p392
#to check Ship-risk vs Experience
nrow(DPPSSdata)
Ship.vs.Experience <-table(as.factor(DPPSSdata$Ship),as.factor(as.character(DPPSSdata$Experience)))
Ship.vs.Experience
fisher.test(Ship.vs.Experience,hybrid=TRUE)
chisq.test(Ship.vs.Experience)
# try the same for Language
Ship.vs.Language <-table(as.factor(DPPSSdata$Ship),as.factor(as.character(DPPSSdata$Language)))
Ship.vs.Language
fisher.test(Ship.vs.Language,hybrid=TRUE)
chisq.test(Ship.vs.Language)
#to check DefectsInspect vs Experience
#
DefI.vs.Experience <-table(as.factor(as.character(DPPSSdata$DefectsInspect)),as.factor(as.character(DPPSSdata$Experience)))
DefI.vs.Experience
fisher.test(DefI.vs.Experience,hybrid=TRUE)
chisq.test(DefI.vs.Experience)
#2020.5.4
#rerun contingency table with 61 rows
DPPSSdata<- read.csv(file="/media/user/1907USB/RonGitHUB/data/DPPSS61data.csv",header = TRUE)
#
#example code from ? lda
Iris <- data.frame(rbind(iris3[,,1], iris3[,,2], iris3[,,3]),
                   Sp = rep(c("s","c","v"), rep(50,3)))
train <- sample(1:150, 75)
table(Iris$Sp[train])
## your answer may differ
##  c  s  v
## 22 23 30
z <- lda(Sp ~ ., Iris, prior = c(1,1,1)/3, subset = train)
predict(z, Iris[-train, ])$class
##  [1] s s s s s s s s s s s s s s s s s s s s s s s s s s s c c c
## [31] c c c c c c c v c c c c v c c c c c c c c c c c c v v v v v
## [61] v v v v v v v v v v v v v v v
(z1 <- update(z, . ~ . - Petal.W.))