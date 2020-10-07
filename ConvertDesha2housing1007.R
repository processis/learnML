# Read Desharnais77 public dataset from promise uottawa repository
desharnais <- read.table("housingCocomo.csv",
                         sep = ",", header = TRUE)
desha <- subset(desharnais,Project!=38)
# continue to remove 38 , 44, 66, 75 because not enough data in these projects
desha <- subset(desha,Project!=44)
desha <- subset(desha,Project!=66)
desha <- subset(desha,Project!=75)
#   has to specify as numeric
desha$Neighborhood<-as.factor(desha$Neighborhood)
### remove first column Project 
desha <- desha[,c(2:8,10:12)]
housing=desha