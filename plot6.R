# set home directory, which must have data files
home <- "C:/Users/ibshi/Desktop/coursera data science/course 4 exploratory data analysis/project2"
setwd(home)

#read in files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset the Baltimore City and Los Angeles data
Baltimore <- subset(NEI, fips == "24510")
LosAngeles <- subset(NEI, fips == "06037")

# subset the vehicle data.  
# There are short names with "Highway Veh" and also "Vehicles", so I chose to search on "Veh"
# This would leave out things like Minibikes, Snowmobiles, and Motorcycles

Veh_code_indices <- grep("Veh",SCC$Short.Name)
SCC_Veh <- SCC[Veh_code_indices,1]
Baltimore_Veh <- Baltimore[Baltimore$SCC %in% SCC_Veh,]
LosAngeles_Veh <- LosAngeles[LosAngeles$SCC %in% SCC_Veh,]

# tapply with year to get total emissions by year
p5data <- with(Baltimore_Veh, tapply(Emissions,year,sum,na.rm = TRUE))
p6data <- with(LosAngeles_Veh, tapply(Emissions,year,sum,na.rm = TRUE))

#plot6.png
png("plot6.png",width=1000,height=600)
# png("plot6.png")

# set default size of figure, and give myself a bottom and top 1-inch margin for a title and a comment
# par(pin=c(4,3),omi=c(1,0,1,0),mfrow = c(1, 2))
par(omi=c(1,0,1,0),mfrow = c(1, 2),pin=c(5,4))

# plot
plot(names(p5data),p5data,main="Baltimore City, MD",
     xlab="Year", ylab = "Total PM2.5 Emissions, tons",pch = 19)

plot(names(p6data),p6data,main="Los Angeles County, CA",
     xlab="Year", ylab = "Total PM2.5 Emissions, tons",pch = 19)

# add a comment about the figure
mtext("The figure suggests an overall decrease in total PM2.5 emissions from vehicle sources 
      in Baltimore City from 1999 to 2008, but an increase followed by a decrease in LA County.
      Not the difference in scale; fluctuations were larger in LA County.",side=1, cex=0.8, outer=TRUE)
# add an overall title
mtext("Total Emissions of PM2.5 from vehicle sources",side=3,cex=1.7, outer=TRUE)

#close device to save file
dev.off()