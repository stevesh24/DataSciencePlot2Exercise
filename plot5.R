# set home directory, which must have data files
home <- "C:/Users/ibshi/Desktop/coursera data science/course 4 exploratory data analysis/project2"
setwd(home)

#read in files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset the Baltimore City data
Baltimore <- subset(NEI, fips == "24510")

# subset the vehicle data.  
# There are short names with "Highway Veh" and also "Vehicles", so I chose to search on "Veh"
# This would leave out things like Minibikes, Snowmobiles, and Motorcycles

Veh_code_indices <- grep("Veh",SCC$Short.Name)
SCC_Veh <- SCC[Veh_code_indices,1]
Baltimore_Veh <- Baltimore[Baltimore$SCC %in% SCC_Veh,]

# tapply with year to get total emissions by year
p5data <- with(Baltimore_Veh, tapply(Emissions,year,sum,na.rm = TRUE))

#plot5.png
png("plot5.png")

# set default size of figure, and give myself a bottom 1-inch margin for a comment
par(pin=c(4,3),omi=c(1,0,0,0))

# plot
plot(names(p5data),p5data,main="Total Emissions of PM2.5 from vehicle sources in Baltimore City, MD",
     xlab="Year", ylab = "Total PM2.5 Emissions, tons",pch = 19)

# add a comment about the figure
mtext("The figure suggests a decrease in total PM2.5 emissions from vehicle sources \nin Baltimore City from 1999 to 2008",side=1, cex=0.8, outer=TRUE)

#close device to save file
dev.off()