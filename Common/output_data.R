# reformat predictions to round off to the nearest integer
# link to Date Time in a data frame

#Intermediate output - append all to one single file

fName = "dump_predictions.csv"

df.infer$count <- predict(knnTune, df.infer.testrb)
write.table(df.infer[,c("datetime", "count")], file=fName,
            append=TRUE, row.names=FALSE,quote=FALSE, col.names=F,  sep=",")


#Read the consolidated file
fName = "_4_dump_predictions.csv"
fname.path <-paste(getwd(), fName, sep="/")
output.raw<- read.csv(file=fname.path, sep=",",
                      colClasses= c("character","numeric"),col.names=c("datetime","count"))
#Anlyze the data frame

#str(output.raw)

output.raw$datetime = ymd_hms(output.raw$datetime)
output.raw$count <- floor(output.raw$count)
#Aggregate Data
output.aggr <- aggregate(count~datetime,output.raw,sum)
#head(output.aggr)
#testrb.agg <- subset(output.raw,output.raw$datetime ==ymd_hms(' 2011-01-20 01:00:00'))
#nrow(subset(output.raw,output.raw$count <1))
#nrow(output.aggr)
head(output.raw)
#output values for submission
str(df.infer) #Original Test data set
#output.aggr$count <- floor(output.aggr$count) #df.infer.testrb -->removed all redundant vars for prediction.
output.sort <- output.aggr[order(output.aggr$datetime),] 
#df.infer$count <- ifelse(df.infer$count <0, 0, df.infer$count)
write.csv(output.sort[,c("datetime", "count")], 
          file="BikeRental_predictions.csv", row.names=FALSE, quote=FALSE)

