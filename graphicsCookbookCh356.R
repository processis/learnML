# R graphics cookbook chang Ch13 corrplot
cars<- read.csv(file="/media/user/1907USB/RonGitHUB/Larose/data/cars.txt",stringsAsFactors = FALSE)
head(cars)
cars.columsub <- cars[,1:4] # select only first 4 columns
columsubcor <- cor(cars.columsub)
#print , round to 2 digits
round(columsubcor,digits=2)
library(corrplot)
corrplot(columsubcor)
#generate a lighter palette  
#
# p269 R code
# Fig 13-2
# Fig 13-3
# 3.1 basic bar graphs
# fig 3-2
# fig 3-3
# 3.2 group bars together (p22)
# fig 3-4
# 15.9 (p344) change the Order of Factor Levels based on data values reorder()
# Fig 15-1
# 6.6. Make a basic box plot
# fig 6.15
# fig 6.17
# 6.8. add Means to a box plot
# fig 6.20
#
# 5.1 make a basic scatter plot (p73)
# fig 5-1
#  5.2 group data points by shape or color
# Fig 5-4
# 5.4 map continuous variable to color or size
# fig 5-9 
# 5.5 deal with overplotting (p84)
# Fig 5-13
# Fig 5-14
# Fig 5-15
# Fig 5-17
# 5.6 add fitted regression model lines (p89)
# Fig 5-18
# fig 5-19
# Fig 5-20
# Fig 5-21
# Fig 5-22
# Fig 5-23
# Fig 5-24

