library(ggplot2)
library(ggmap)
map<-get_map("maryland")
ggmap(map)
ggmap(map) + geom_point(
  aes(x=longitude, y=latitude, show_guide = TRUE, colour=Median), 
  data=maryland.fatality, na.rm = T)  + 
  scale_color_gradient(low="beige", high="blue")
