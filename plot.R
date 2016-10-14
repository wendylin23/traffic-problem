library(ggplot2)
library(ggmap)
map<-get_map("maryland",maptype = "roadmap")
ggmap(map)
ggmap(map) + geom_point(
  aes(x=LONGITUD, y=LATITUDE, show_guide = TRUE, colour="red"), 
  data=maryland.fatality, na.rm = T)

baltimore.map<-get_googlemap("baltimore",maptype = "roadmap")
func<-as.factor(maryland.fatality$FUNC_SYS)
levels(func)<-c("Interstate","Principal_Arterial_free_exp","Principal Arterial_other",
                "Minor_Arterial","Major_Collector","Minor_Collector","Local",
                "Unknown1","Unknown2","Unknown3")
maryland.fatality$func<-func

#functional system effect
ggmap(map) + geom_point(
  aes(x=LONGITUD, y=LATITUDE, show_guide = TRUE,
      colour=func,fill=func), 
  data=maryland.fatality, na.rm = T)

#intersection
inter<-as.factor(maryland.fatality$TYP_INT)
maryland.fatality$inter<-inter
ggmap(map) + geom_point(
  aes(x=LONGITUD, y=LATITUDE, show_guide = TRUE,
      colour=inter,fill=inter), 
  data=maryland.fatality, na.rm = T)

#urban&rural
rural_urban<-as.factor(maryland.fatality$RUR_URB)
maryland.fatality$rural_urban<-rural_urban
ggmap(map) + geom_point(
  aes(x=LONGITUD, y=LATITUDE, show_guide = TRUE,
      colour=rural_urban,fill=rural_urban), 
  data=maryland.fatality, na.rm = T)
