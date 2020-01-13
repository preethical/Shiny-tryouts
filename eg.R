library(reshape2)
library(ggplot2)
library(tidyr)
timeseries <- read.csv("sector-specific-state-aggregate-expenditure-2013-14-actuals-to-2016-17-budget-estimates.csv", header = TRUE)
timeseries  <- timeseries[!grepl("Revenue Expenditure as % of Total Sector Expenditure", timeseries$Indicators),]
timeseries  <- timeseries[!grepl("Per Capita Expenditure on Sector", timeseries$Indicators),] 
timeseries <- timeseries[!grepl("Total Sector Expenditure as % of State Budget", timeseries$Indicators),]
timeseries  <- timeseries[!grepl("Capital Expenditure", timeseries$Indicators),]
timeseries <- timeseries[,c("Sectors",colnames(timeseries)[grep("Assam", colnames(timeseries))])]
timeseries <- timeseries[,c("Sectors",colnames(timeseries)[grep("Budget", colnames(timeseries))])]
timeseries$Sectors <- substring(timeseries$Sectors, 4)
timeseries_melt <- melt(timeseries)
timeseries_melt<- separate(data = timeseries_melt, col = variable, into = c("State", "Year1, Year2", "type1","type2"), sep = "\\.")
timeseries_melt$year <- paste(timeseries_melt$`Year1, Year2`,timeseries_melt$type1,sep="-")
timeseries_melt[,c("Year1, Year2", "type1", "type2")] <- list(NULL)

##timeseries_melt <- unite(data = timeseries_melt, col = "Sectors", Sectors:Indicators, remove = TRUE)
plot1 <- ggplot (data = timeseries_melt,aes(x = year, y=value, color = Sectors, group = Sectors)) + 
  geom_line(size=1)+ geom_point(size=3)+scale_y_continuous(labels = scales::comma)+ 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+ 
  ggtitle("Figure 1: Plot of Sectorwise budget in Assam from 2014 to 2018") + 
  xlab("year") + ylab("Budget in lakhs")+
  guides(size = FALSE)+
  theme(plot.margin = margin(2,.8,2,.8, "cm"), plot.background = element_rect(fill = "darkgrey"))

print(plot1)

library(reshape2)
library(ggplot2)
library(tidyr)

timeseries <- read.csv("sector-specific-state-aggregate-expenditure-2013-14-actuals-to-2016-17-budget-estimates.csv", header = TRUE)
timeseries  <- timeseries[!grepl("Revenue Expenditure as % of Total Sector Expenditure", timeseries$Indicators),]
timeseries  <- timeseries[!grepl("Per Capita Expenditure on Sector", timeseries$Indicators),] 
timeseries <- timeseries[!grepl("Total Sector Expenditure as % of State Budget", timeseries$Indicators),]
timeseries  <- timeseries[!grepl("Capital Expenditure", timeseries$Indicators),]
##timeseries <- timeseries[,c("Sectors",colnames(timeseries)[grep("Assam|Gujarat|Karnataka|Kerala|", colnames(timeseries))])]
timeseries <- timeseries[,c("Sectors",colnames(timeseries)[grep("Budget", colnames(timeseries))])]
timeseries$Sectors <- substring(timeseries$Sectors, 4)
timeseries_melt <- melt(timeseries)
timeseries_melt<- separate(data = timeseries_melt,into = c("Year1","Year2","Type1","type2"), col = variable, sep = "\\.")
timeseries_melt[, c("an.2014.15..Budget.Estimates.")] <- list(NULL)
timeseries_melt$year <- paste(timeseries_melt$Type1,timeseries_melt$type2,sep="-")
timeseries_melt[, c("Type1","type2")] <- list(NULL)
timeseries_melt$Year2 <- as.numeric(timeseries_melt$Year2)
timeseries_melt$year <- paste(timeseries_melt$Year2,timeseries_melt$year,sep="-")
timeseries_melt[, c("Year2")] <- list(NULL)


print(plot1)
