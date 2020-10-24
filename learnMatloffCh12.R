#Matloff 1.20.1
library(freqparcoord)
ls('package:freqparcoord')
help(package=freqparcoord)
vignette()
#1.6 Baseball Players gain weight as they age?
data(mlb)
head(mlb)
#cal mean weight for each Height 
muhats <- tapply(mlb$Weight,mlb$Height, mean)
muhats
tapply(mlb$Weight,mlb$Height, length)
tapply(mlb$Weight,mlb$Height, sd)
#1.6.3
plot(67:83, muhats)
#parametric form
lmout <- lm(mlb$Weight ~ mlb$Height)
lmout
#superimpose the fitted line to original figure
abline(coef=coef(lmout))
coef(lmout)
# use matrixtimes-matrix op to obtain estimate value of mu(72)
coef(lmout) %*% c(1,72)
#can form a confidence interval  too, for 95% level will be
tmp <- c(1,72)
sqrt(tmp %*% vcov(lmout) %*% tmp)
###
# 1.9.1 multipredictor Linear Models
#
lm(mlb$Weight~ mlb$Height + mlb$Age)
lm(Weight ~ ., data=mlb[,4:6])
# 2.5 closer look at lm() output
lmout <- lm(mlb$Weight~ mlb$Height + mlb$Age)
summary(lmout)
# 2.13.2  multivariate normal distribution family
library(MASS)
mu <- c(1,1)
sig <- rbind(c(1,0.5) , c(0.5,1))
sig
x<- mvrnorm(n=100, mu=mu , Sigma = sig)
head(x)
mean(abs(x[,1] - x[,2]))
cov(x)
# 2.13.3 more details of 'lm'  Objects
lmout <- lm(Weight ~Height + Age, data=mlb)
names (lmout)
lmout$model
str(lmout$model)

