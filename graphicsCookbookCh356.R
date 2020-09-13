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
library(corrplot)
corrplot(mcor)
corrplot(mcor, method="shade", shade.col=NA, tl.col="black", tl.srt=45)
# Fig 13-3
# Generate a lighter palette
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(mcor, method="shade", shade.col=NA, tl.col="black", tl.srt=45,
         col=col(200), addCoef.col="black", addcolorlabel="no", order="AOE")


# 3.1 basic bar graphs
# fig 3-2
library(gcookbook)
library(ggplot2)
str(BOD)
ggplot(BOD, aes(x=Time, y=demand)) + geom_bar(stat="identity")
ggplot(BOD, aes(x=factor(Time), y=demand)) + geom_bar(stat="identity")

# fig 3-3
ggplot(pg_mean, aes(x=group, y=weight)) +
  geom_bar(stat="identity", fill="lightblue", colour="black")

# 3.2 group bars together (p22)
# fig 3-4
library(gcookbook)
cabbage_exp
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(position="dodge")


#ch3 other
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(position="dodge", colour="black") +
  scale_fill_brewer(palette="Pastel1")
ce <- cabbage_exp[1:5, ]
ce
ggplot(ce, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(position="dodge", colour="black") +
  scale_fill_brewer(palette="Pastel1")
ggplot(diamonds, aes(x=cut)) + geom_bar()

diamonds
ggplot(diamonds, aes(x=carat)) + geom_bar()


library(gcookbook)
upc <- subset(uspopchange, rank(Change)>40)
upc
ggplot(upc, aes(x=Abb, y=Change, fill=Region)) + geom_bar(stat="identity")
ggplot(upc, aes(x=reorder(Abb, Change), y=Change, fill=Region)) +
  geom_bar(stat="identity", colour="black") +
  scale_fill_manual(values=c("#669933", "#FFCC66")) +
  xlab("State")

library(gcookbook)
csub <- subset(climate, Source=="Berkeley" & Year >= 1900)
csub$pos <- csub$Anomaly10y >= 0
csub

ggplot(csub, aes(x=Year, y=Anomaly10y, fill=pos)) +
  geom_bar(stat="identity", position="identity")
ggplot(csub, aes(x=Year, y=Anomaly10y, fill=pos)) +
  geom_bar(stat="identity", position="identity", colour="black", size=0.25) +
  scale_fill_manual(values=c("#CCEEFF", "#FFDDDD"), guide=FALSE)

library(gcookbook)
ggplot(pg_mean, aes(x=group, y=weight)) + geom_bar(stat="identity")
ggplot(pg_mean, aes(x=group, y=weight)) + geom_bar(stat="identity", width=0.5)
ggplot(pg_mean, aes(x=group, y=weight)) + geom_bar(stat="identity", width=1)
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat="identity", width=0.5, position="dodge")
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat="identity", width=0.5, position=position_dodge(0.7))

geom_bar(position="dodge")
geom_bar(width=0.9, position=position_dodge())
geom_bar(position=position_dodge(0.9))
geom_bar(width=0.9, position=position_dodge(width=0.9))

library(gcookbook)
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat="identity")

cabbage_exp

ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat="identity") +
  guides(fill=guide_legend(reverse=TRUE))

libary(plyr)
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar, order=desc(Cultivar))) +
  geom_bar(stat="identity")
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat="identity", colour="black") +
  guides(fill=guide_legend(reverse=TRUE)) +
  scale_fill_brewer(palette="Pastel1")

library(gcookbook)
library(plyr)
ce <- ddply(cabbage_exp, "Date", transform,
            percent_weight = Weight / sum(Weight) * 100)
ggplot(ce, aes(x=Date, y=percent_weight, fill=Cultivar)) +
  geom_bar(stat="identity")

cabbage_exp

ddply(cabbage_exp, "Date", transform,
      percent_weight = Weight / sum(Weight) * 100)

ggplot(ce, aes(x=Date, y=percent_weight, fill=Cultivar)) +
  geom_bar(stat="identity", colour="black") +
  guides(fill=guide_legend(reverse=TRUE)) +
  scale_fill_brewer(palette="Pastel1")

library(gcookbook)
ggplot(cabbage_exp, aes(x=interaction(Date, Cultivar), y=Weight)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=Weight), vjust=1.5, colour="white")

ggplot(cabbage_exp, aes(x=interaction(Date, Cultivar), y=Weight)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=Weight), vjust=-0.2)

ggplot(cabbage_exp, aes(x=interaction(Date, Cultivar), y=Weight)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=Weight), vjust=-0.2) +
  ylim(0, max(cabbage_exp$Weight) * 1.05)

ggplot(cabbage_exp, aes(x=interaction(Date, Cultivar), y=Weight)) +
  geom_bar(stat="identity") +
  geom_text(aes(y=Weight+0.1, label=Weight))

ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat="identity", position="dodge") +
  geom_text(aes(label=Weight), vjust=1.5, colour="white",
            position=position_dodge(.9), size=3)

library(plyr)
ce <- arrange(cabbage_exp, Date, Cultivar)
ce <- ddply(ce, "Date", transform, label_y=cumsum(Weight))
ce

ggplot(ce, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat="identity") +
  geom_text(aes(y=label_y, label=Weight), vjust=1.5, colour="white")

ce <- arrange(cabbage_exp, Date, Cultivar)
ce <- ddply(ce, "Date", transform, label_y=cumsum(Weight)-0.5*Weight)
ggplot(ce, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat="identity") +
  geom_text(aes(y=label_y, label=Weight), colour="white")

ggplot(ce, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat="identity", colour="black") +
  geom_text(aes(y=label_y, label=paste(format(Weight, nsmall=2), "kg")),
            size=4) +
  guides(fill=guide_legend(reverse=TRUE)) +
  scale_fill_brewer(palette="Pastel1")

library(gcookbook)
tophit <- tophitters2001[1:25, ]
ggplot(tophit, aes(x=avg, y=name)) + geom_point()

tophit[, c("name", "lg", "avg")]
ggplot(tophit, aes(x=avg, y=reorder(name, avg))) +
  geom_point(size=3) +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour="grey60", linetype="dashed"))

ggplot(tophit, aes(x=reorder(name, avg), y=avg)) +
  geom_point(size=3) +
  theme_bw() +
  theme(axis.text.x = element_text(angle=60, hjust=1),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.major.x = element_line(colour="grey60", linetype="dashed"))

nameorder <- tophit$name[order(tophit$lg, tophit$avg)]
# Turn name into a factor, with levels in the order of nameorder
tophit$name <- factor(tophit$name, levels=nameorder)

ggplot(tophit, aes(x=avg, y=name)) +
  geom_segment(aes(yend=name), xend=0, colour="grey50") +
  geom_point(size=3, aes(colour=lg)) +
  scale_colour_brewer(palette="Set1", limits=c("NL","AL")) +
  theme_bw() +
  theme(panel.grid.major.y = element_blank(),
        legend.position=c(1, 0.55),
        legend.justification=c(1, 0.5))

ggplot(tophit, aes(x=avg, y=name)) +
  geom_segment(aes(yend=name), xend=0, colour="grey50") +
  geom_point(size=3, aes(colour=lg)) +
  scale_colour_brewer(palette="Set1", limits=c("NL","AL"), guide=FALSE) +
  theme_bw() +
  theme(panel.grid.major.y = element_blank()) +
  facet_grid(lg ~ ., scales="free_y", space="free_y")



# 15.9 (p344) change the Order of Factor Levels based on data values reorder()
# Fig 15-1
# 6.6. Make a basic box plot
# fig 6.15
library(MASS)
ggplot(birthwt, aes(x=factor(race), y=bwt)) + geom_boxplot()
birthwt

# fig 6.17
ggplot(birthwt, aes(x=factor(race), y=bwt)) + geom_boxplot(width=.5)
ggplot(birthwt, aes(x=factor(race), y=bwt)) +
  geom_boxplot(outlier.size=1.5, outlier.shape=21)
ggplot(birthwt, aes(x=1, y=bwt)) + geom_boxplot() +
  scale_x_continuous(breaks=NULL) +
  theme(axis.title.x = element_blank())

# 6.8. add Means to a box plot
# fig 6.20
library(MASS)
ggplot(birthwt, aes(x=factor(race), y=bwt)) + geom_boxplot() +
  stat_summary(fun.y="mean", geom="point", shape=23, size=3, fill="white")

#
# 5.1 make a basic scatter plot (p73)
# fig 5-1
library(gcookbook)
# List the two columns we'll use
heightweight[, c("ageYear", "heightIn")]
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point(shape=21)
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point(size=1.5)

#  5.2 group data points by shape or color
# Fig 5-4
library(gcookbook)
# Show the three columns we'll use
heightweight[, c("sex", "ageYear", "heightIn")]
ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=sex)) + geom_point()
ggplot(heightweight, aes(x=ageYear, y=heightIn, shape=sex)) + geom_point()
ggplot(heightweight, aes(x=ageYear, y=heightIn, shape=sex, colour=sex)) +
  geom_point()
ggplot(heightweight, aes(x=ageYear, y=heightIn, shape=sex, colour=sex)) +
  geom_point() +
  scale_shape_manual(values=c(1,2)) +
  scale_colour_brewer(palette="Set1")

# 5.4 map continuous variable to color or size
# fig 5-9 
library(gcookbook)
heightweight[, c("sex", "ageYear", "heightIn", "weightLb")]
ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=weightLb)) + geom_point()
ggplot(heightweight, aes(x=ageYear, y=heightIn, size=weightLb)) + geom_point()

ggplot(heightweight, aes(x=weightLb, y=heightIn, fill=ageYear)) +
  geom_point(shape=21, size=2.5) +
  scale_fill_gradient(low="black", high="white")

# Using guide_legend() will result in a discrete legend instead of a colorbar
ggplot(heightweight, aes(x=weightLb, y=heightIn, fill=ageYear)) +
  geom_point(shape=21, size=2.5) +
  scale_fill_gradient(low="black", high="white", breaks=12:17,
                      guide=guide_legend())

ggplot(heightweight, aes(x=ageYear, y=heightIn, size=weightLb, colour=sex)) +
  geom_point(alpha=.5) +
  scale_size_area() +
  # Make area proportional to numeric value
  scale_colour_brewer(palette="Set1")


# 5.5 deal with overplotting (p84)

# Fig 5-13
sp <- ggplot(diamonds, aes(x=carat, y=price))
sp + geom_point()
sp + geom_point(alpha=.1)
sp + geom_point(alpha=.01)
# Fig 5-14
sp + stat_bin2d()
sp + stat_bin2d(bins=50) +
  scale_fill_gradient(low="lightblue", high="red", limits=c(0, 6000))
library(hexbin)
sp + stat_binhex() +
  scale_fill_gradient(low="lightblue", high="red",
                      limits=c(0, 8000))
# Fig 5-15
sp + stat_binhex() +
  scale_fill_gradient(low="lightblue", high="red",
                      breaks=c(0, 250, 500, 1000, 2000, 4000, 6000),
                      limits=c(0, 6000))

sp1 <- ggplot(ChickWeight, aes(x=Time, y=weight))
sp1 + geom_point()
sp1 + geom_point(position="jitter")
# Could also use geom_jitter(), which is equivalent
sp1 + geom_point(position=position_jitter(width=.5, height=0))
# Fig 5-17
sp1 + geom_boxplot(aes(group=Time))

# 5.6 add fitted regression model lines (p89)
# Fig 5-18
library(gcookbook)
sp <- ggplot(heightweight, aes(x=ageYear, y=heightIn))
sp + geom_point() + stat_smooth(method=lm)
# 99% confidence region
sp + geom_point() + stat_smooth(method=lm, level=0.99)
# No confidence region
sp + geom_point() + stat_smooth(method=lm, se=FALSE)
sp + geom_point(colour="grey60") +
  stat_smooth(method=lm, se=FALSE, colour="black")

# fig 5-19
sp + geom_point(colour="grey60") + stat_smooth()
sp + geom_point(colour="grey60") + stat_smooth(method=loess)

# Fig 5-20
library(MASS)
b <- biopsy
b$classn[b$class=="benign"]<- 0
b$classn[b$class=="malignant"] <- 1
ggplot(b, aes(x=V1, y=classn)) +
  geom_point(position=position_jitter(width=0.3, height=0.06), alpha=0.4,
             shape=21, size=1.5) +
  stat_smooth(method=glm, family=binomial)

# Fig 5-21
sps <- ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=sex)) +
  geom_point() +
  scale_colour_brewer(palette="Set1")
sps + geom_smooth()

sps + geom_smooth(method=lm, se=FALSE, fullrange=TRUE)
# Fig 5-22
library(gcookbook) # For the data set
model <- lm(heightIn ~ ageYear + I(ageYear^2), heightweight)
model
xmin <- min(heightweight$ageYear)
xmax <- max(heightweight$ageYear)
predicted <- data.frame(ageYear=seq(xmin, xmax, length.out=100))
predicted$heightIn <- predict(model, predicted)
predicted
sp <- ggplot(heightweight, aes(x=ageYear, y=heightIn)) +
  geom_point(colour="grey40")
sp + geom_line(data=predicted, size=1)

# Given a model, predict values of yvar from xvar
# This supports one predictor and one predicted variable
# xrange: If NULL, determine the x range from the model object. If a vector with
#
two numbers, use those as the min and max of the prediction range.
# samples: Number of samples across the x range.
# ...: Further arguments to be passed to predict()
predictvals <- function(model, xvar, yvar, xrange=NULL, samples=100, ...) {
  # If xrange isn't passed in, determine xrange from the models.
  # Different ways of extracting the x range, depending on model type
  if (is.null(xrange)) {
    if (any(class(model) %in% c("lm", "glm")))
      xrange <- range(model$model[[xvar]])
    else if (any(class(model) %in% "loess"))
      xrange <- range(model$x)
  }
  newdata <- data.frame(x = seq(xrange[1], xrange[2], length.out = samples))
  names(newdata) <- xvar
  newdata[[yvar]] <- predict(model, newdata = newdata, ...)
  newdata
}

modlinear <- lm(heightIn ~ ageYear, heightweight)
modloess<- loess(heightIn ~ ageYear, heightweight)

lm_predicted<- predictvals(modlinear, "ageYear", "heightIn")
loess_predicted <- predictvals(modloess, "ageYear", "heightIn")
sp + geom_line(data=lm_predicted, colour="red", size=.8) +
  geom_line(data=loess_predicted, colour="blue", size=.8)

# Fig 5-23
library(MASS) # For the data set
b <- biopsy
b$classn[b$class=="benign"]<- 0
b$classn[b$class=="malignant"] <- 1
fitlogistic <- glm(classn ~ V1, b, family=binomial)
# Get predicted values
glm_predicted <- predictvals(fitlogistic, "V1", "classn", type="response")
ggplot(b, aes(x=V1, y=classn)) +
  geom_point(position=position_jitter(width=.3, height=.08), alpha=0.4,
             shape=21, size=1.5) +
  geom_line(data=glm_predicted, colour="#1177FF", size=1)

# Fig 5-24
make_model <- function(data) {
  lm(heightIn ~ ageYear, data)
}
library(gcookbook) # For the data set
library(plyr)
models <- dlply(heightweight, "sex", .fun = make_model)
models
predvals <- ldply(models, .fun=predictvals, xvar="ageYear", yvar="heightIn")
predvals
ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=sex)) +
  geom_point() + geom_line(data=predvals)
