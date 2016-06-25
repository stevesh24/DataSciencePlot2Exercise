# set home directory, which must have data files
home <- "C:/Users/ibshi/Desktop/coursera data science/course 4 exploratory data analysis/project2"
setwd(home)

#read in files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset the Baltimore City data
Baltimore <- subset(NEI, fips == "24510")

#plot2.png
png("plot2.png")

# tapply with year to get total emissions by year
p2data <- with(Baltimore, tapply(Emissions,year,sum,na.rm = TRUE))

# set default size of figure, and give myself a bottom 1-inch margin for a comment
par(pin=c(4,3),omi=c(1,0,0,0))

# plot
plot(names(p2data),p2data,main="Total Emissions of PM2.5 from Baltimore City, MD",
     xlab="Year", ylab = "Total PM2.5 Emissions, tons",pch = 19)

# add a comment about the figure
mtext("The figure suggests a decrease in total PM2.5 emissions in Baltimore City, MD \nfrom 1999 to 2002 and 2008, but with a raise from 2002 to 2005",side=1, cex=0.8, outer=TRUE)

#close device to save file
dev.off()
