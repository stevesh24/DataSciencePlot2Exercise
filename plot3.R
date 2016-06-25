# set home directory, which must have data files
home <- "C:/Users/ibshi/Desktop/coursera data science/course 4 exploratory data analysis/project2"
setwd(home)

#load ggplot2 and plyr and gridExtra
library(ggplot2)
library(plyr)
library(gridExtra)

#read in files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset the Baltimore City data
Baltimore <- subset(NEI, fips == "24510")

# tapply with year and type
p3data_matrix <- with(Baltimore, tapply(Emissions,list(year,type),sum,na.rm = TRUE))

#change to data frame with plyr and adply
p3data <- adply(p3data_matrix,1,c)

#change column name to Year, take dashes out of names (qplot is not liking the dashes)
names(p3data) <- c("Year","NONROAD","NONPOINT","ONROAD","POINT")

#create the plots
p1 <- ggplot(p3data, aes(Year,NONROAD)) + geom_point() + theme(plot.title=element_text(size=10)) + 
  labs(x = "Year", y = "Total PM2.5 Emissions, tons") + labs(title="NonRoad Emissions, Baltimore City")
p2 <- ggplot(p3data, aes(Year,NONPOINT)) + geom_point() + theme(plot.title=element_text(size=10)) + 
  labs(x = "Year", y = "Total PM2.5 Emissions, tons") + labs(title="NonPoint Emissions, Baltimore City")
p3 <- ggplot(p3data, aes(Year,ONROAD)) + geom_point() + theme(plot.title=element_text(size=10))+ 
  labs(x = "Year", y = "Total PM2.5 Emissions, tons") + labs(title="OnRoad Emissions, Baltimore City")
p4 <- ggplot(p3data, aes(Year,POINT)) + geom_point() + theme(plot.title=element_text(size=10))+ 
  labs(x = "Year", y = "Total PM2.5 Emissions, tons") + labs(title="Point Emissions, Baltimore City")

# create final plot as a grid of p1 to p4, using grid.arrange in gridExtra
finalplot <- grid.arrange(p1,p2,p3,p4,ncol=2, nrow =2)

# save final plot to plot3.png
ggsave("plot3.png",plot = finalplot)

# The figure seems to show decreases for PM2.5 for all types of emissions, except for Point Emissions


