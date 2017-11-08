library(mapplots)
library(data.table)
library(geo)
library(shapefiles)
library(lattice)
library(latticeExtra)
library(ggplot2)
library(reshape)
library(reshape2)
library(plyr)
library(memisc)
library(xlsx)

#Set working directory to raw data location
#Raw data is rectangle leve data published annually as part of Sea Fisheries Statistics
setwd('~/Scripts')
#Load rectangle data
rect5 <- read.csv("UK rectangle landings 2016.csv", skip=1, header=FALSE, sep=",")
rect4 <- read.csv("UK rectangle landings 2015.csv", skip=1, header=FALSE, sep=",")
rect3 <- read.csv("UK rectangle landings 2014.csv", skip=1, header=FALSE, sep=",")
rect2 <- read.csv("UK rectangle landings 2013.csv", skip=1, header=FALSE, sep=",")
rect1 <- read.csv("UK rectangle landings 2012.csv", skip=1, header=FALSE, sep=",")

rect <- rbind(rect5, rect4, rect3, rect2, rect1)

#Rename columns
colnames(rect)<- c("Year", "Month", "VessNat","FAOArea","ICESDiv","Rect","LG",
                   "GearCat","SpeciesCode","SpeciesName","SpeciesPub","SpeciesGroup",
                   "LiveWeightT","LandedWeightT","ValueGBP")

mapData<- aggregate(cbind(rect$LiveWeightT,rect$ValueGBP) , 
          by = list(rect$Year, 
                    rect$Rect, 
                    rect$SpeciesPub,
                    rect$LG,
                    rect$GearCat,
                    rect$VessNat), sum)

#Create map data
colnames(mapData)<- c("Year","Rect","Species","Length","Gear","VessNat","QtyT","ValGBP")
mapData <- as.data.table(mapData)
mapData <- mapData[!(mapData$Rect =="UNK"),]
mapData <- mapData[!(mapData$Rect =="00Z5"),]
mapData <- mapData[!(mapData$Rect =="00Z6"),]
mapData[, Latitude := ir2d(mapData[,Rect])[1]]
mapData[, Longitude := ir2d(mapData[,Rect])[2]]
mapData<- mapData[order(Year),]

write.csv(mapData, "mapData_2012_2016.csv", row.names=FALSE)