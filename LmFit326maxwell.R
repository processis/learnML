## read minitab processed Maxwell67 data   2020.3.26
SwMainCost=read.csv("Maxwell326es.CSV")
# simple linear regression , Gareth 3.6.2
lm.fit=lm(ln.acorreff. ~ ln.totfp. , data=SwMainCost)
lm.fit
summary(lm.fit)
names(lm.fit)
coef(lm.fit)
confint(lm.fit)
#predict func to produce confid intervals and predict intervals, given ln.totfp.
predict(lm.fit,data.frame(ln.totfp. = c(3,5,7)),interval="confidence")
predict(lm.fit,data.frame(ln.totfp. = c(3,5,7)),interval="prediction")
#plot with least sq regression line
attach(SwMainCost)
plot(ln.totfp.,ln.acorreff.)
abline(lm.fit)
abline(lm.fit,lwd=3,col="red") #3times bold, in red
plot(ln.totfp.,ln.acorreff.,pch=20) # diff plotting symbol
plot(ln.totfp.,ln.acorreff.,pch="+") # diff plotting symbol
plot(1:20,1:20,pch=1:20) #fun
# 3.6.2 multiple linear regression
lm.fit=lm(ln.acorreff. ~ ln.totfp. + pjcl, data=SwMainCost)
lm.fit
summary(lm.fit)
coef(lm.fit)
confint(lm.fit)
# library(car) 
# vif(lm.fit)
#try non linear transform of predictor 3.6.5
lm.fit2=lm(ln.acorreff.~ln.totfp.+I(ln.totfp.^2))
summary(lm.fit2)
# use anova to check if quadratic fit (fit2) is better
attach(SwMainCost)
lm.fit=(ln.acorreff. ~ ln.totfp.)
summary(lm.fit)
anova ( lm.fit,lm.fit2)
# P so big 1.8, so no difference
