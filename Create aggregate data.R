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
setwd('C:/Data Accelerator/2015 data/Aggregated data')
#Load rectangle data
rect5 <- read.csv("UK rectangle landings 2016.csv", header=TRUE, sep=",")
rect4 <- read.csv("UK rectangle landings 2015.csv", header=TRUE, sep=",")
rect3 <- read.csv("UK rectangle landings 2014.csv", header=TRUE, sep=",")
rect2 <- read.csv("UK rectangle landings 2013.csv", header=TRUE, sep=",")
rect1 <- read.csv("UK rectangle landings 2012.csv", header=TRUE, sep=",")

rect <- rbind(rect5, rect4, rect3, rect2, rect1)

#Rename columns
colnames(rect)<- c("Year", "Month", "VessNat","FAOArea","ICESDiv","Rect","LG",
                   "GearCat","SpeciesCode","SpeciesName","SpeciesPub","SpeciesGroup",
                   "LiveWeightT","LandedWeightT","ValueGBP")

mapData<- aggregate(cbind(rect$LiveWeightT,rect$ValueGBP) , 
          by = list(rect$Year, 
                    rect$Rect, 
                    rect$SpeciesPub), sum)

write.csv(mapData, "mapData_2012_2016.csv", row.names=FALSE)