#  use Lander Chapter 16 housing multi lin regression to run desha
# convert desha variables to housing variable names
# bin size increase from 10 to 100, otherwise plots too fine
### run  ConvertDesha2housing R program , so do not read original housing csv

head(deshaTrain)
deshaTrain$Language=as.factor(deshaTrain$Language)
ggplot(deshaTrain, aes (x = Effort)) +
  geom_histogram(binwidth = 0.1) + labs(x = "Effort")
ggplot(deshaTrain, aes(x = Effort, fill = Language)) +
  geom_histogram(binwidth = 0.1) + labs(x = "Effort")
ggplot(deshaTrain, aes(x = Effort, fill = Language)) +
  geom_histogram(binwidth = 0.1) + labs(x = "Effort") +
  facet_wrap(~Language)
ggplot(deshaTrain,aes(x = Entities)) + geom_histogram()
ggplot(deshaTrain, aes(x = Transactions)) + geom_histogram()
ggplot(housing[housing$Units < 1000,],
       aes(x = SqFt)) + geom_histogram()
ggplot(housing[housing$Units < 1000, ],
       aes(x = Units)) + geom_histogram()
ggplot(deshaTrain, aes(x = PointsNonAdjust, y = Effort)) + geom_point()
ggplot(deshaTrain, aes(x = Entities, y = Effort)) + geom_point()
#  determine the number of buildings with 1000 or more units
#sum(housing$Units >= 1000)
#  Remove buildings with 1000 or more units
#housing <- housing[housing$Units < 1000, ]
#  plot value per sqft against sq feet
ggplot(deshaTrain, aes(x = PointsNonAdjust, y = Effort)) + geom_point()
ggplot(deshaTrain, aes(x = log(PointsNonAdjust), y = Effort)) + geom_point()
ggplot(deshaTrain, aes(x = PointsNonAdjust, y = log(Effort))) + geom_point()
ggplot(deshaTrain, aes(x = log(PointsNonAdjust), y = log(Effort))) + geom_point()
#
ggplot(deshaTrain, aes(x = log(Entities), y = Effort)) + geom_point()
ggplot(deshaTrain, aes(x = Entities, y = log(Effort))) + geom_point()
ggplot(deshaTrain, aes(x = log(Entities), y = Effort)) + geom_point()
ggplot(deshaTrain, aes(x = log(Entities), y = log(Effort))) + geom_point()
#
ggplot(deshaTrain, aes(x = log(Transactions), y = Effort)) + geom_point()
ggplot(deshaTrain, aes(x = Transactions, y = log(Effort))) + geom_point()
ggplot(deshaTrain, aes(x = log(Transactions), y = Effort)) + geom_point()
ggplot(deshaTrain, aes(x = log(Transactions), y = log(Effort))) + geom_point()

#  plot valueperSqFt against number of units
ggplot(housing, aes(x = Units, y= ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x = log(Units), y = ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x = Units, y = log(ValuePerSqFt))) + geom_point()
ggplot(housing, aes(x = log(Units), y = log(ValuePerSqFt)))+ geom_point()
deshaLog1 <- lm(Effort ~ PointsAjust+Transactions + Entities, data = deshaTrain)
summary(deshaLog1)
deshaLog1$coefficients
coef(deshaLog1)
require(coefplot)
coefplot(deshaLog1)
house2 <- lm(ValuePerSqFt ~ Units*SqFt + Boro, data = housing)
house3 <- lm(ValuePerSqFt ~ Units:SqFt + Boro, data = housing)
house2$coefficients
house3$coefficients
coefplot(house2)
coefplot(house3)
house4 <- lm(ValuePerSqFt ~ SqFt*Units*Income, housing)
house4$coefficients
house5 <- lm(ValuePerSqFt ~ Class * Boro, housing)
house5$coefficients
house6 <- lm(ValuePerSqFt ~ I(SqFt/Units) + Boro, housing)
house6$coefficients
house7 <- lm(ValuePerSqFt ~ (Units + SqFt)^2, housing)
house7$coefficients
house8 <- lm(ValuePerSqFt ~Units* SqFt, housing)
house8$coefficients
house9 <- lm(ValuePerSqFt ~ I(Units+SqFt)^2, housing)
house9$coefficients
#  also from the coefplot package
multiplot(house1, house2, house3)