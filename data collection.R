library(foreign)
library(readxl)
library(dplyr)
library(stringr)

folder.name<-"/Users/wendylin/Documents/AD/data/FARS2013NationalDBF/"
file.name<-"accident.dbf"
accident.2013<-read.dbf(paste0(folder.name,file.name),as.is = FALSE)

gis.folder.name<-"/Users/wendylin/Documents/AD/Project/Statewide_TMS_Segments/"
gis.file.name<-"Statewide_TMS_Segments.dbf"
gis<-read.dbf(paste0(gis.folder.name,gis.file.name),as.is = FALSE)

folder<-"/Users/wendylin/Documents/AD/data/"
file<-"useful.RData"
load(paste0(folder,file))
fatality<-data.frame(useful.data)
maryland.fatality<-fatality[fatality$STATE==24,]

county.file<-"GLCs_for_the_USA_and_DC.xlsx"
county.data<-read_excel(paste0(folder,county.file),sheet = 1,skip=1)
md.county<-county.data[county.data$`State Abbreviation`=="MD",]

gis$COUNTY_DES <- toupper(as.character(gis$COUNTY_DES))
md.county.uniform<-md.county[as.numeric(md.county$`County Code`) %in% 
                               unique(maryland.fatality$COUNTY),]
md.county.uniform$`City Name/County Name`<-gsub("[[:punct:]]", "", 
                                                md.county.uniform$`City Name/County Name`)
md.county.name<-md.county.uniform[md.county.uniform$`City Name/County Name` %in% 
                                    as.character(unique(gis$COUNTY_DES)),]
combine.md.county.name<-md.county.name[is.na(md.county.name$`City Code`),]

for(i in 1:nrow(gis))
{
  gis$new_county_id[i]<-combine.md.county.name[gis[i,]$COUNTY_DES==
                                          combine.md.county.name$`City Name/County Name`,]$`County Code`
}
gis$new_county_id<-as.numeric(gis$new_county_id)

#collect 2006-2014 data
folder.name<-"/Users/wendylin/Documents/AD/data/"
add.name<-"FARS"
year<-seq(2006,2014,by=1)
pos.file.name<-"[Aa][Cc][Cc][Ii][Dd][Ee][Nn][Tt][:punct:][Dd][Bb][Ff]"
accident_fatal<-list()
for(i in 1:length(year))
{
  files<-list.files(paste0(folder.name,add.name,year[i]))
  file.name<-files[str_detect(files,pos.file.name)]
  accident_fatal[[i]]<-read.dbf(paste0(folder.name,add.name,year[i],"/",file.name),as.is = FALSE)
}
maryland.fatal<-sapply(accident_fatal,)