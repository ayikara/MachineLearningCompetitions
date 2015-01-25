require(ggplot2)
require(lubridate)
#str(df.analyz)
df.fertile <- df.train
df.fertile$useHour <- hour(ymd_hms(df.fertile$datetime))
df.fertile$useMonth <- month(ymd_hms(df.fertile$datetime))
df.fertile$useYear <- year(ymd_hms(df.fertile$datetime))
df.fertile$useDay <- day(ymd_hms(df.fertile$datetime))
df.fertile$yearDay <- yday(ymd_hms(df.fertile$datetime))

#df.analyz <- df.fertile[,c("datetime", "useHour","useDay","useMonth","useYear","count")]
df.analyz <- df.fertile



#summary(df.analyz$useYear)
#str(df.analyz2011)
#Separate the two years
df.analyz2011 <-df.analyz[df.analyz$useYear=='2011',]
df.analyz2012 <-df.analyz[df.analyz$useYear==2012,]


df.Jan2011 <-df.analyz2011[df.analyz2011$useMonth=='3',]
df.Jan2011Holiday <- subset(df.Jan2011, holiday ==1)
df.Jan2011Wkday <- subset(df.Jan2011, workingday ==1)
df.Jan2011Wkend <- subset(df.Jan2011, workingday ==0 & holiday==0)
unique(df.Jan2011Holiday$useDay)
unique(df.Jan2011Wkday$useDay)
unique(df.Jan2011Wkend$useDay)

#Plots line graphs
df.Jan2011Sub <- subset(df.Jan2011, useDay >= 7 & useDay <= 13,select=c(useDay, useHour,registered,casual))
df.Jan2011Sub <- subset(df.Jan2011, useDay == 7  ,select=c(useDay, useHour,registered,casual))
df.Jan2011Sub <- subset(df.Jan2011, yearDay == 68  ,select=c(useDay, useHour,registered,casual))
df.Jan2011Sub$useDay <- as.factor(df.Jan2011Sub$useDay)
str(df.Jan2011Sub)

ggplot(df.Jan2011Sub, aes(useHour,casual)) + geom_line(aes(colour = useDay))
ggplot(df.Jan2011Sub, aes(useHour,registered)) + geom_line(aes(colour = useDay))

#Plot monthly mean values
ag<-setNames(aggregate(df.analyz2011$count~df.analyz2011$useMonth,df.analyz2011,sum),c('useMonth','count'))
agc<-setNames(aggregate(df.analyz2011$casual~df.analyz2011$useMonth,df.analyz2011,sum),c('useMonth','casual'))
agr<-setNames(aggregate(df.analyz2011$registered~df.analyz2011$useMonth,df.analyz2011,sum),c('useMonth','registered'))
ag$registered <- agr$registered
ag$casual <- agc$casual
str(ag)

# Stacked Bar Plot with Colors and Legend
colours <- c("red", "orange", "blue", "yellow")
barplot(as.matrix(ag), main="My Barchart", ylab = "Numbers", cex.lab = 1.5, cex.main = 1.4, beside=TRUE, col=colours)


#Plot daily mean values
ad<-setNames(aggregate(df.analyz2011$count~df.analyz2011$yearDay,df.analyz2011,sum),c('useDay','count'))
adc<-setNames(aggregate(df.analyz2011$casual~df.analyz2011$yearDay,df.analyz2011,sum),c('useDay','casual'))
adr<-setNames(aggregate(df.analyz2011$registered~df.analyz2011$yearDay,df.analyz2011,sum),c('useDay','registered'))
ad$registered <- adr$registered
ad$casual <- adc$casual
str(ad)
ad1 <- subset(ad, useDay >= 1 & useDay <= 19,select=c(count, registered,casual))
ad2 <- subset(ad, useDay >= 32 & useDay <= 50,select=c(count, registered,casual))
ad3 <- subset(ad, useDay >= 60 & useDay <= 78,select=c(count, registered,casual))
ad4 <- subset(ad, useDay >= 91 & useDay <= 109,select=c(count, registered,casual))
ad5 <- subset(ad, useDay >= 121 & useDay <= 139,select=c(count, registered,casual))
ad6 <- subset(ad, useDay >= 152 & useDay <= 170,select=c(count, registered,casual))
ad7 <- subset(ad, useDay >= 182 & useDay <= 200,select=c(count, registered,casual))
ad8 <- subset(ad, useDay >= 213 & useDay <= 231,select=c(count, registered,casual))
ad9 <- subset(ad, useDay >= 244 & useDay <= 262,select=c(count, registered,casual))
ad10 <- subset(ad, useDay >= 274 & useDay <= 292,select=c(count, registered,casual))
ad11 <- subset(ad, useDay >= 305 & useDay <= 323,select=c(count, registered,casual))
ad12 <- subset(ad, useDay >= 335 & useDay <= 353,select=c(count, registered,casual))

# Stacked Bar Plot with Colors and Legend
colours <- c("red", "orange", "blue", "yellow")
barplot(as.matrix(ad12), main="My Barchart", ylab = "Numbers", cex.lab = 1.5, cex.main = 1.4, beside=TRUE, col=colours)

anz <- subset(df.analyz2011, yearDay ==341)

#This is not working
#df.Jan2011Sub <- df.Jan2011[df.Jan2011$useDay==c(10:12),]

#df.analyz2011$tstamp = ymd_hms(df.analyz2011$datetime)
#plot(count~tstamp, data = df.analyz2011[df.analyz2011$useMonth==1,])
#cor(df.analyz$count,df.analyz$useHour)
#aggregate(df.analyz$count~df.analyz$useMonth,df.analyz,mean)


#result <- reshape(as, v.names=c("count","registered",'casual'), idvar="id", timevar="group", direction="wide")