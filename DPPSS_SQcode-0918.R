
#第四章使用的数据表放在这里参考
library(ISLR)
names(Smarket)
fix(Smarket)

#读入数据 DPPSSdata.csv
DPPSSdata=read.csv("DPPSSdata.csv")
DPPSSdata1=read.csv("DPPSSdataV01-0918.csv")
fix(DPPSSdata)
fix(DPPSSdata1)
names(DPPSSdata)
names(DPPSSdata1)
summary(DPPSSdata)
summary(DPPSSdata1)
summary(DPPSSdata$Language)
summary(DPPSSdata$FormalUnitTest)

#条形图 直方图等

barplot(table(DPPSSdata1$Language),main="Machine Language",names=c("C","C++","JAVA"))
barplot(table(DPPSSdata1$DevPlatform),main="DevPlatform",names=c("Windows","Unix","Linux"))
hist(DPPSSdata1$Maint)#必须为数值

##散点图
library(graphics)
a <- DPPSSdata1$Turnover
b <- DPPSSdata1$CSat
plot(a,b)

#简单线性回归分析
a <- DPPSSdata1$ChangedPriorityReqs
b <- DPPSSdata1$D.KSLOC
c<-DPPSSdata1$Test.internal
d<-DPPSSdata1$Test.outside
e<-DPPSSdata1$Test.user
#lm.fit=lm(r1~r2,data=Analysis1)
lm.fit=lm(b~c +d +e +a)
lm.fit
summary(lm.fit)
plot(lm.fit)
#下面这条语句会输出P值和标准误以及R2和F统计量
summary(lm.fit)
#给定X值来预测Y值，下语句显示出置信区间和预测区间
predict(lm.fit,data.frame(r2=(c(5,10,15))), interval="confidence")
predict(lm.fit,data.frame(r2=(c(5,10,15))), interval="prediction")
#散点图,注意这边散点图的XY和lm的XY相反
plot(b,a)

#变量间两两关系矩阵
cor(DPPSSdata1)#必须为数值

#计算表中数值列Spearman Kendall Pearson
x <- DPPSSdata1[,c("Fielded Volatility","Maint","Turnover","Req Volatility%","Parts %","D/KSLOC","Customer Beta Test?","ChangedPriorityReqs")]

y <- DPPSSdata1[,c("Ship","CSa","SchedOntime","ReUse","DefectsInspect","DefectsTest","FieldedVolatility","Maint","Experience","DomainExp",
                  "Language","DevPlatform","Turnover","ReqVolatility","Parts ","FormalUnitTest","IntegrationTest","SystemTest","UserTrials","BudgetLoss","ScheduleAchievement","DKSLOC",
                  "CustomerBetaTest","TesterType","ChangedPriorityReqs")]

x <- DPPSSdata1$CSat
y <- DPPSSdata1$Ship
z<-DPPSSdata1$Maint
w<-DPPSSdata1$FieldedVolatility
cor(x,y,method="pearson")
cor(z,w,method="spearman")
cor(x,y,method="kendall")

attach(DPPSSdata)
plot(DPPSSdata$CSat)

#皮尔森卡方检验
library(stats)
ftable=table(DPPSSdata1$DefectsInspect,DPPSSdata1$Experience)
ftable
mosaicplot(ftable)#绘制列联表的马赛克图
chisq.test(ftable)#执行皮尔森卡方检验

#单因素方差分析
boxplot(DPPSSdata$Ship~factor(DPPSSdata$CSat))
oneway.test(DPPSSdata$Ship~factor(DPPSSdata$CSat))
DPPSSdata.aov=aov(DPPSSdata$Ship~factor(DPPSSdata$CSat))
summary(DPPSSdata.aov)
model.tables(DPPSSdata.aov,"means")
DPPSSdata_posthoc=TukeyHSD(DPPSSdata.aov)
DPPSSdata_posthoc

#双因素方差分析
par(mfrow=c(1,2))
boxplot(DPPSSdata$Ship~factor(DPPSSdata$CSat),subset=(DPPSSdata$CustomerBetaTest==0))
boxplot(DPPSSdata$Ship~factor(DPPSSdata$CSat),subset=(DPPSSdata$CustomerBetaTest==1))
par(mfrow=c(1,1))
boxplot(DPPSSdata$Ship~factor(DPPSSdata$CSat)*factor(DPPSSdata$CustomerBetaTest))
interaction.plot(DPPSSdata$Ship,DPPSSdata$CSat,DPPSSdata$CustomerBetaTest,
                 type="b",col=c(1:3),leg.bty = "o",leg.bg = "beige",
                 lwd=2,pch=c(18,24,22))
DPPSSdata_anova2=aov(DPPSSdata$Ship~factor(DPPSSdata$CSat)*factor(DPPSSdata$CustomerBetaTest))
summary(DPPSSdata_anova2)
TukeyHSD(DPPSSdata_anova2)
par(mfrow=c(1,2))
plot(TukeyHSD(DPPSSdata_anova2))


#Logistic Regression
library(tree)
library(ISLR)
cor(DPPSSdata)
cor(DPPSSdata[,-26])
#请求执行逻辑斯蒂回归 （Language三种分类变量）
glm.fit=glm(CSat~Parts,data=DPPSSdata,family=binomial)
glm.fit=glm(CSat~Maint+Turnover+ChangedPriorityReqs,data=DPPSSdata,family=binomial)
summary(glm.fit)
#获取拟合线性系数的模型
coef(glm.fit)
summary(glm.fit)$coef
summary(glm.fit)$coef[,4]
glm.probs=predict(glm.fit,type="response")
glm.probs[1:10]
contrasts(DPPSSdata$Language)
#按照glm.probs来分C++ C Java
#先将所有数据都为C
glm.pred=rep("C",60)
#然后根据glm.probs值来分 C C++ JAVA
glm.prod[glm.probs>.5]="JAVA"#看表看不出这一类关系
table(glm.pred,DPPSSdata$Language)
mean(glm.pred==DPPSSdata$Language)

#FormalUnitTest 两种分类变量
glm.fit=glm(FormalUnitTest~Maint+Turnover+ChangedPriorityReqs,data=DPPSSdata,family=binomial)
summary(glm.fit)
coef(glm.fit)
summary(glm.fit)$coef
summary(glm.fit)$coef[,4]
glm.probs=predict(glm.fit,type="response")
glm.probs[1:10]
contrasts(DPPSSdata$FormalUnitTest)
glm.pred=rep("Y",60)
glm.pred[glm.probs>.5]="N"#看表看不出这一类关系
table(glm.pred)
mean(glm.pred)

#另一种逻辑斯蒂
library(ggplot2)
logit.fit <- glm(Language ~ Maint + Turnover,
                 family = binomial(link = 'logit'),
                 data = DPPSSdata)
logit.predictions <- ifelse(predict(logit.fit) > 0, 1, 2)
mean(with(DPPSSdata, logit.predictions == Language))
mean(with(DPPSSdata, 0 == Language))
library(e1071)
svm.fit <- svm(logit.predictions ~ Maint + Turnover, data = DPPSSdata)
svm.predictions <- ifelse(predict(svm.fit) > 0, 1, 2)
mean(with(df, svm.predictions == logit.predictions))
DPPSSdata1<- cbind(DPPSSdata,
           data.frame(Logit = ifelse(predict(logit.fit) > 0, 1, 2),
                      SVM = ifelse(predict(svm.fit) > 0, 1, 2)))
library('reshape')
library('ggplot2')
predictions<- melt(DPPSSdata, id.vars = c('Maint', 'logit.predictions'))
ggplot(predictions, aes(x = Maint, y = Turnover, color = factor(value))) +
  geom_point() +
  facet_grid(variable ~ .)


#LDA线性判别分析
library(MASS)
lda.fit=lda(Language~Maint+Turnover+ChangedPriorityReqs,data=DPPSSdata)
lda.fit
plot(lda.fit)
lda.pred=predict(lda.fit)
names(lda.pred)
lda.class=lda.pred$class
table(lda.class)#C++ 0 ?


#QDA
qda.fit=qda(Language~Maint+Turnover+ChangedPriorityReqs,data=DPPSSdata)
qda.fit
qda.class=predict(qda.fit)$class
table(qda.class)
#mean(qda.class==DPPSSdata)

#KNN


#SVM
library('e1071')
svm.fit <- svm(Language ~ Maint + Turnover, data = DPPSSdata)
svm.predictions <- ifelse(predict(svm.fit) > 0, 1, 0)
mean(with(DPPSSdata, svm.predictions == Language))
library("reshape")
DPPSSdata1 <- cbind(DPPSSdata,
            data.frame(Logit = ifelse(predict(logit.fit) > 0, 1, 2),
                       SVM = ifelse(predict(svm.fit) > 0, 1, 0)))
predictions <- melt(DPPSSdata, id.vars = c('Maint', 'Turnover'))






######ch3 DPPSS

DPPSSdata=read.csv("DPPSSdata.csv")
DPPSSdata1=read.csv("DPPSSdata1.csv")
fix(DPPSSdata)
fix(DPPSSdata1)
names(DPPSSdata)
names(DPPSSdata1)
summary(DPPSSdata)
summary(DPPSSdata1)

apropos("confusion")
RSiteSearch("confusion",restrict="functions")
library(AppliedPredictiveModeling)

segDppss<-subset(DPPSSdata1,BudgetLoss=="1")
segDppss1<-subset(DPPSSdata,BudgetLoss=="1")
DcellID<-segDppss$Tur1over

ReUse<-segDppss$ReUse
Ship<-segDppss$Ship
segDppss<-segDppss[,-(1:3)]

DstatusColNum<-grep("Status",names(segDppss))
DstatusColNum
segDppss<-segDppss[,-DstatusColNum]

library(e1071)
skewness(segDppss$La1guage)

skewValues<-apply(segDppss,2,skewness)
head(skewValues)

library(caret)
DCh1AreaTrans<-BoxCoxTrans(segDppss$SchedOntime)
DCh1AreaTrans

head(segDppss$SchedOntime)
predict(DCh1AreaTrans,head(segDppss$SchedOntime))

DpcaObject<-prcomp(segDppss,center=TRUE)
DpercentVariance<-DpcaObject$sd~2/sum(DpcaObject$sd~2)*100
DpercentVariance[1:3]

head(DpcaObject$x[,1:5])
head(DpcaObject$Maint[,1:3])


Dtrans<-preProcess(segDppss,method=c("BoxCox","center","scale","pca"))
Dtrans

Dtransformed<-predict(Dtrans,segDppss)
head(Dtransformed[,1:5])

nearZeroVar(segDppss)
Dcorrelations<-cor(segDppss)
dim(Dcorrelations)

Dcorrelations[1:4,1:4]

library(corrplot)
corrplot(Dcorrelations,order="hclust")