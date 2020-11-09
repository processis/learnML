##desha lm
library(MASS)


housing <- read.table("desharnaisLogEffort77kaggleLang3housingtrainV11.10.csv",
                      sep = ",", header = TRUE,
                      stringsAsFactors = FALSE)
#housing$Language <- as.factor(housing$Language)

lm.fit=lm(LogEffort ~ LogPtsAjust,data=housing)
lm.fit
summary(lm.fit)
confint(lm.fit)
predict(lm.fit,data.frame(LogPtsAjust=(c(5,10,15))),
        interval="prediction")


lm.fit=lm(LogEffort ~ LogPtsAjust+Entities,data=housing)
lm.fit
summary(lm.fit)
lm.fit=lm(LogEffort ~ LogPtsAjust+Entities+Adjustment,data=housing)
lm.fit
summary(lm.fit)
lm.fit=lm(LogEffort ~ LogPtsAjust+Entities+Adjustment+YearEnd,data=housing)
lm.fit

lm.fit=lm(LogEffort~.,data=housing)
lm.fit
summary(lm.fit)

lm.fit=lm(LogEffort~.-Effort,data=housing)
lm.fit
summary(lm.fit)


######HSDZ-DATA:HSJXV4.csv######
HSDZ <- read.table("HSJXV4.csv",
                      sep = ",", header = TRUE,
                      stringsAsFactors = FALSE)
names(HSDZ)
HSDZ$PRO <- as.factor(HSDZ$PRO)
#HSDZ$project <- as.factor(HSDZ$project)

lm.fit1=lm(GYHCSQXMD ~ CCI,data=HSDZ)
lm.fit1
summary(lm.fit1)
summary(lm.fit1)$r.sq
summary(lm.fit1)$sigm

lm.fit=lm(GYHCSQXMD ~ CCI+PRO,data=HSDZ)
#lm.fit=lm(GYHCSQXMD ~ CCI+project,data=HSDZ)
lm.fit
summary(lm.fit)
confint(lm.fit)

lm.fit2=lm(GYHCSQXMD ~ CCI+PRO+YY.GND,data=HSDZ)
lm.fit2
summary(lm.fit2)
summary(lm.fit2)$r.sq
summary(lm.fit2)$sigm

lm.fit=lm(GYHCSQXMD ~ CCI+PRO+YY.GND+DD.SCL,data=HSDZ)
lm.fit
summary(lm.fit)
summary(lm.fit)$r.sq
summary(lm.fit)$sigm

lm.fit=lm(GYHCSQXMD ~ CCI+PRO+YY.GND+DD.SCL+DMXHL.Java,data=HSDZ)
lm.fit

lm.fit=lm(GYHCSQXMD ~ CCI+PRO+YY.GND+DD.SCL+DMXHL.Java+
            CSMD,data=HSDZ)
lm.fit

lm.fit=lm(GYHCSQXMD ~ CCI+PRO+YY.GND+DD.SCL+DMXHL.Java+
            CSMD+CSQXL,data=HSDZ)
lm.fit

lm.fit=lm(GYHCSQXMD ~ CCI+PRO+YY.GND+DD.SCL+DMXHL.Java+
            CSMD+CSQXL+GYHCSQXMD,data=HSDZ)
lm.fit

lm.fit3=lm(GYHCSQXMD ~ CCI+YY.GND,data=HSDZ)
lm.fit3
summary(lm.fit3)
summary(lm.fit3)$r.sq
summary(lm.fit3)$sigm
#anova(lm.fit1,lm.fit2)
anova(lm.fit1,lm.fit2)
anova(lm.fit3,lm.fit2)
anova(lm.fit1,lm.fit3)

#lm.fit=lm(GYHCSQXMD ~ CSQXL+CSMD+CCI+DMXHL.Java,data=HSDZ)
#lm.fit