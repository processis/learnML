#  Lander Chapter 16
housing <- read.table("desharnaisLogEffort77kaggleLang3housingtrainV11.10.csv",
    sep = ",", header = TRUE,
    stringsAsFactors = FALSE)
#names(housing) <- c("Neighborhood", "Class", "Units", "YearBuilt",
#                    "SqFt", "Income", "IncomePerSqFt","Expense",
#                    "ExpensePerSqFt","NetIncome", "Value",
#                    "ValuePerSqFt", "Boro")
head(housing)
library(ggplot2)
housing$Language <- as.factor(housing$Language)
ggplot(housing, aes (x = Effort)) +
    geom_histogram(binwidth = 0.10) + labs(x = "Log Effort")
ggplot(housing, aes(x = Effort, fill = Language)) +
    geom_histogram(binwidth = 0.10) + labs(x = "Log Effort")
ggplot(housing, aes(x = Effort, fill = Language)) +
    geom_histogram(binwidth = 0.10) + labs(x = "Log Effort") +
    facet_wrap(~Language)
ggplot(housing,aes(x = PointsAjust)) + geom_histogram()
ggplot(housing, aes(x = Transactions)) + geom_histogram()
#ggplot(housing[housing$Units < 1000,],
#    aes(x = SqFt)) + geom_histogram()
#ggplot(housing[housing$Units < 1000, ],
#    aes(x = Units)) + geom_histogram()
#ggplot(housing, aes(x = SqFt, y = ValuePerSqFt)) + geom_point()
#ggplot(housing, aes(x = Units, y = ValuePerSqFt)) + geom_point()
#  determine the number of buildings with 1000 or more units
#sum(housing$Units >= 1000)
#  Remove buildings with 1000 or more units
#housing <- housing[housing$Units < 1000, ]
#  plot value per sqft against sq feet
#ggplot(housing, aes(x = SqFt, y = ValuePerSqFt)) + geom_point()
#ggplot(housing, aes(x = log(SqFt), y = ValuePerSqFt)) + geom_point()
#ggplot(housing, aes(x = SqFt, y = log(ValuePerSqFt))) + geom_point()
#ggplot(housing, aes(x = log(SqFt), y = log(ValuePerSqFt))) + geom_point()
#  plot valueperSqFt against number of units
#ggplot(housing, aes(x = Units, y= ValuePerSqFt)) + geom_point()
#ggplot(housing, aes(x = log(Units), y = ValuePerSqFt)) + geom_point()
#ggplot(housing, aes(x = Units, y = log(ValuePerSqFt))) + geom_point()
#ggplot(housing, aes(x = log(Units), y = log(ValuePerSqFt)))+ geom_point()
house1 <- lm(Effort ~ PointsAjust+Length+Entities + Language, data = housing)
summary(house1)
house1$coefficients
coef(house1)
require(coefplot)
coefplot(house1)
#house2 <- lm(ValuePerSqFt ~ Units*SqFt + Boro, data = housing)
#house3 <- lm(ValuePerSqFt ~ Units:SqFt + Boro, data = housing)
#house2$coefficients
#house3$coefficients
#coefplot(house2)
#coefplot(house3)
#house4 <- lm(ValuePerSqFt ~ SqFt*Units*Income, housing)
#house4$coefficients
house5 <- lm(Effort ~ Transactions * Language, housing)
house5$coefficients
#house6 <- lm(ValuePerSqFt ~ I(SqFt/Units) + Boro, housing)
#house6$coefficients
#house7 <- lm(ValuePerSqFt ~ (Units + SqFt)^2, housing)
#house7$coefficients
#house8 <- lm(ValuePerSqFt ~Units* SqFt, housing)
#house8$coefficients
#house9 <- lm(ValuePerSqFt ~ I(Units+SqFt)^2, housing)
#house9$coefficients
#  also from the coefplot package
#multiplot(house1, house2, house3)


#  http://www.jaredlander.com/data/housingNEW,csv for new data/
housingNew <- read.table("desharnaisLogEffort77kaggleLang3housingtestV11.10.csv",
    sep = ",", header = TRUE,
    stringsAsFactors = FALSE)
housingNew$Language <- as.factor(housingNew$Language)


#housingNew <- subset(housing,Project < 7)
housePredict <- predict(house1, newdata = housingNew, se.fit = TRUE,
                        interval = "prediction", level = 0.95)
head(housePredict$fit)
head(housePredict$se.fit)
housePredict <- predict(house5, newdata = housingNew, se.fit = TRUE,
                        interval = "prediction", level = 0.95)
head(housePredict$fit)
head(housePredict$se.fit)