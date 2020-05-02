# Larose ch1 R code (p15)
cars<- read.csv(file="/media/user/1907USB/RonGitHUB/Larose/data/cars.txt",stringsAsFactors = FALSE)
head(cars)
names(cars)
cars$weightlbs
#sub , new var
cars.rsub<- cars[1:50,]
cars.csub<-cars[,1:3]
cars.rcsub <- cars[c(1,3,5),c(2,4)]
cars.vsub <- cars[which(cars$mpg>30),] #select by logical condition
# declare new variable
weigthlbs <-cars$weightlbs
# display 6 graphs,3 top, 3 bottom
par(mfrow=c(2,3))
library(ggplot2)
# Larose ch2 R code (p39)
# read Cars and Cars2
cars<- read.csv(file="/media/user/1907USB/RonGitHUB/Larose/data/cars2.txt",stringsAsFactors = FALSE)
#handel missing data
cars.4var <- cars[,c(1,3,4,8)]
head(cars.4var)
#try R code from p40 to 45 in chinese book
#
#
#
# Larose ch3 R code (p73)
churn<- read.csv(file="/media/user/1907USB/RonGitHUB/Larose/data/churn.txt",stringsAsFactors = TRUE)
churn[1:10,]
# summary
sum.churn<-summary(churn$Churn.)
sum.churn
# bar plot of churn , p74 top
# churn vs international plan
counts<- table(churn$Churn., churn$Int.l.Plan,dnn=c("Churn","International Plan"))
counts
# plot stacked histogram
#
#
# summary table for 2 variables
sumtable <- addmargins(counts, FUN=sum)
sumtable

# sum percentage by row
row.margin<- round(prop.table(counts, margin = 1),4)*100
row.margin

# sum percentage by columns
col.margin<- round(prop.table(counts, margin = 2),4)*100
col.margin
# bar plot , p75 bottom
#
#bar plot, p76 top
# histogram
hist(churn$CustServ.Calls, 
     xlim=c(0,10),
     col="lightblue",
     ylab="Count",
     xlab="Customer Service Calls",
     main="Histogram of Cust Svc calls")
# use ggplot2 to generate bar charts , p77
ggplot() +
  geom_bar(data=churn,
            aes(x=factor(churn$CustServ.Calls),
            fill=factor(churn$Churn.)),
            position="stack") +
            scale_x_discrete("Cust Svc calls") +
            scale_y_continuous("Percent") +
            guides(fill=guide_legend((title="Churn")) +
            scale_fill_manual(values=c("blue", "red"))
            )    
ggplot() +
      geom_bar(data=churn,
      aes(x=factor(churn$CustServ.Calls),
      fill=factor(churn$Churn.)),
      position="fill") +
      scale_x_discrete("Cust Svc calls") +
      scale_y_continuous("Percent") +
      guides(fill=guide_legend((title="Churn")) +
                       scale_fill_manual(values=c("blue", "red"))
      )
# 2 sample t-test on international calls
# separate to two chunks
churn.false <- subset(churn, 
                      churn$Churn. == "False.")
churn.true <- subset(churn, 
                      churn$Churn. == "True.")
# test
t.test(churn.false$Intl.Calls, 
       churn.true$Intl.Calls)
# scatter plot matrix ***
pairs(churn$Day.Mins + churn$Day.Calls + churn$Day.Charge)
#
# corr data table , p80 top
