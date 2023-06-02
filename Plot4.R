NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
coalc <- grepl("coal", SCC$EI.Sector, ignore.case = TRUE)
SCC_coalc <- SCC[coalc,]
coalc_NEI <- merge(NEI, SCC_coalc, by = "SCC")
coalc_sum <- tapply(coalc_NEI$Emissions, coalc_NEI$year, sum)
coalc_sum <- as.data.frame(coalc_sum)
names(coalc_sum)[1] <- "Emissions"
rownames(coalc_sum) <- c(1:4)
coalc_sum$Year <- c(1999, 2002, 2005, 2008)
library(ggplot2)
png("plot4.png")
ggplot(coalc_sum, aes(x = Year, y = Emissions)) + geom_line() + geom_point() + xlab("Year") + ylab("Total PM.25 Emissions (tons)") + ggtitle("Total PM2.5 Emissions from Coal Combustion-Related Sources by Year")
dev.off()