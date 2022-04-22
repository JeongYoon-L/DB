install.packages("ggplot2")
install.packages("ggmap")
library(ggmap)

ggmap(get_map(location='south korea', zoom=7))

wifi <- read.csv("Region_case.csv", header=T, as.is=T)

ggmap(map) + geom_point(data=Region_case, aes(x=lon, y=lat, color=label))
ggmap(map) + geom_point(data=Region_Case, aes(x=lon, y=lat, color=1Â÷°¨¿°))
ggmap(map) + geom_point(data=Region_case, aes(x=lon, y=lat, color=NÂ÷°¨¿°))
