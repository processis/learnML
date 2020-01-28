################################################################################
### R code from processis (2020) by Edmond and Shelly.
### Copyright 2020 Edmond and Shelly
### Web Page: http://www.processis.com
### Contact: Ms QIN (shelly@processis.org)
#
#Reference   Maxwell: 67 project miantenance data analysis
# Load raw data
#Read Maxwell 67 project data
setwd("/media/user/1907USB/2020data")
MaxwellData <- read.csv("Maxwell/67casesFeva2students.csv", header = TRUE)
# print the summary statistics to check incorrect values
summary(MaxwellData)
###################
# create new variables
#
# identify subset of cat variables 
#

###################
#
#prelim analysis
#1) histogram
require(ggplot2)
data(MaxwellData)
head(MaxwellData)
ggplot(data=MaxwellData) +geom_histogram(aes( x=time))
#2) scatter plots
ggplot(MaxwellData, aes(x= size , y= effort)) +geom_point()
