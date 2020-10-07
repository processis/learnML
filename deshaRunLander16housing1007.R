#  use Lander Chapter 16 housing multi lin regression to run desha
# convert desha variables to housing variable names
# bin size increase from 10 to 100, otherwise plots too fine
### run  ConvertDesha2housing R program , so do not read original housing csv
#housing <- read.table("housing.csv",
#                      sep = ",", header = TRUE,
#                      stringsAsFactors = FALSE)
#names(housing) <- c("Neighborhood", "Class", "Units", "YearBuilt",
#                    "SqFt", "Income", "IncomePerSqFt","Expense",
#                    "ExpensePerSqFt","NetIncome", "Value",
#                    "ValuePerSqFt", "Boro")
head(housing)
ggplot(housing, aes (x = ValuePerSqFt)) +
  geom_histogram(binwidth = 100) + labs(x = "Value per Square Foot")
ggplot(housing, aes(x = ValuePerSqFt, fill = Boro)) +
  geom_histogram(binwidth = 100) + labs(x = "Value Per Square Foot")
ggplot(housing, aes(x = ValuePerSqFt, fill = Boro)) +
  geom_histogram(binwidth = 100) + labs(x = "Value per Square Foot") +
  facet_wrap(~Boro)
ggplot(housing,aes(x = SqFt)) + geom_histogram()
ggplot(housing, aes(x = Units)) + geom_histogram()
ggplot(housing[housing$Units < 1000,],
       aes(x = SqFt)) + geom_histogram()
ggplot(housing[housing$Units < 1000, ],
       aes(x = Units)) + geom_histogram()
ggplot(housing, aes(x = SqFt, y = ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x = Units, y = ValuePerSqFt)) + geom_point()
#  determine the number of buildings with 1000 or more units
#sum(housing$Units >= 1000)
#  Remove buildings with 1000 or more units
#housing <- housing[housing$Units < 1000, ]
#  plot value per sqft against sq feet
ggplot(housing, aes(x = SqFt, y = ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x = log(SqFt), y = ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x = SqFt, y = log(ValuePerSqFt))) + geom_point()
ggplot(housing, aes(x = log(SqFt), y = log(ValuePerSqFt))) + geom_point()
#  plot valueperSqFt against number of units
ggplot(housing, aes(x = Units, y= ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x = log(Units), y = ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x = Units, y = log(ValuePerSqFt))) + geom_point()
ggplot(housing, aes(x = log(Units), y = log(ValuePerSqFt)))+ geom_point()
house1 <- lm(ValuePerSqFt ~ Units+SqFt + Boro, data = housing)
summary(house1)
house1$coefficients
coef(house1)
require(coefplot)
coefplot(house1)
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