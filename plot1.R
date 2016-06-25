# set home directory, which must have data files
home <- "C:/Users/ibshi/Desktop/coursera data science/course 4 exploratory data analysis/project2"
setwd(home)

#read in files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# tapply with year to get total emissions by year
p1data <- with(NEI, tapply(Emissions,year,sum,na.rm = TRUE))

#plot1.png
png("plot1.png")

# set default size of figure, and give myself a bottom 1-inch margin for a comment
par(pin=c(4,3),omi=c(1,0,0,0))

# plot
plot(names(p1data),p1data,main="Total Emissions of PM2.5 from all sources",
     xlab="Year", ylab = "Total PM2.5 Emissions, tons",pch = 19)

# add a comment about the figure
mtext("The figure suggests a decrease in total PM2.5 emissions from all sources from 1999 to 2008",side=1, cex=0.8, outer=TRUE)

#close device to save file
dev.off()

