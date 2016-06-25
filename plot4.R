# set home directory, which must have data files
home <- "C:/Users/ibshi/Desktop/coursera data science/course 4 exploratory data analysis/project2"
setwd(home)

#read in files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset the coal data.  This was done by looking for the string "Coal" in Short.Name
coal_code_indices <- grep("Coal",SCC$Short.Name)
SCC_coal <- SCC[coal_code_indices,1]
NEI_coal <- NEI[NEI$SCC %in% SCC_coal,]

# tapply with year to get total emissions by year
p4data <- with(NEI_coal, tapply(Emissions,year,sum,na.rm = TRUE))

#plot4.png
png("plot4.png")

# set default size of figure, and give myself a bottom 1-inch margin for a comment
par(pin=c(4,3),omi=c(1,0,0,0))

# plot
plot(names(p4data),p4data,main="Total Emissions of PM2.5 from coal sources",
     xlab="Year", ylab = "Total PM2.5 Emissions, tons",pch = 19)

# add a comment about the figure
mtext("The figure suggests a decrease in total PM2.5 emissions from coal sources from 1999 to 2008",side=1, cex=0.8, outer=TRUE)

#close device to save file
dev.off()

