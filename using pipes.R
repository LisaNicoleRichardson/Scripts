library(magrittr)
library(dplyr)

xlim1<- range(mapData$Longitude[mapData$Species=="Bass"])
ylim1<- range(mapData$Latitude[mapData$Species=="Bass"])
byx = 1
byy = 0.5

 {mapData %>%
  filter( Species %in% sp[grep(paste(sp[c(1,2)], collapse="|"),sp)] & Year %in% c("2013", "2014", "2015", "2016")) %>%
  group_by( Year, Rect, Latitude, Longitude) %>%
  summarize(QtyT = sum(QtyT), ValGBP = sum(ValGBP)) %>%
  ungroup()} -> t

  
  t[[1]] ->y
#trying to solve current error (data must be of vector type)  as.vector(t) ->y

  
t[[4]] -> lo
t[[3]] -> la
t[[5]] -> q
  # as.list(mapData) %>%
  # list2env(mapData, envir= .GlobalEnv) 

colour_scale <- c("mistyrose", "lightpink2", "orangered", "red2", "red4" )
annual_breaks_landings<- seq(0,10000, by = 10000/5)
make.multigrid(lo, la, q, y, byx, byy, xlim1, ylim1 ) -> landings_grid_q

par(mfrow= c(1,5))
for(s in names(landings_grid_q)) {
  basemap(xlim1, ylim1, axes = FALSE, xlab= "", ylab = "", col = "grey", bg = "white")
  draw.rect()
  draw.grid(landings_grid_q[[s]], annual_breaks_landings, col=colour_scale)
  }
  
 # select(Year) ->Y ;  select(latitude)->La 
 # select(longitude)->Lo %>%
 # select(QtyT)-> qt
  
 

 

  
  
  
  