# Read Desharnais77 public dataset from promise uottawa repository
desharnais <- read.table("Hitters.csv",
                         sep = ",", header = TRUE)
desha <- subset(desharnais,Project!=38)
# continue to remove 38 , 44, 66, 75 because not enough data in these projects
desha <- subset(desha,Project!=44)
desha <- subset(desha,Project!=66)
desha <- subset(desha,Project!=75)
# Keep only Project+Effor + 8 independent var, remove project, yearEnd, PointsNnAdjust
desha <- desha[,c(1,2,3,5:10,12)]
### remove first column Project from desha
desha <- desha[,c(2:10)]
Hitters = desha