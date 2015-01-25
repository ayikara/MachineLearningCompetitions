#Get the hours from the Date Time.
#Our inference is that the hour of the day is critical for the bike rental.

train.raw$useHour <- hour(ymd_hms(train.raw$datetime))
train.raw$useMonth <- month(ymd_hms(train.raw$datetime))
train.raw$useYear <- year(ymd_hms(train.raw$datetime))
train.raw$useDay <- day(ymd_hms(train.raw$datetime))
train.raw$yearDay <- yday(ymd_hms(train.raw$datetime))
train.raw$datetime = ymd_hms(train.raw$datetime)
train.raw$season = as.factor(train.raw$season)
train.raw$weather = as.factor(train.raw$weather)
#train.raw$useHour = as.factor(train.raw$useHour)
#train.raw$useMonth = as.factor(train.raw$useMonth)
#train.raw$useDay = as.factor(train.raw$useDay)
#str(train.raw)

test.raw$useHour <- hour(ymd_hms(test.raw$datetime))
test.raw$useMonth <- month(ymd_hms(test.raw$datetime))
test.raw$useYear <- year(ymd_hms(test.raw$datetime))
test.raw$useDay <- day(ymd_hms(test.raw$datetime))
test.raw$yearDay <- yday(ymd_hms(test.raw$datetime))
test.raw$datetime = ymd_hms(test.raw$datetime)
test.raw$season = as.factor(test.raw$season)
test.raw$weather = as.factor(test.raw$weather)
#test.raw$useHour = as.factor(test.raw$useHour)
#test.raw$useMonth = as.factor(test.raw$useMonth)
#test.raw$useDay = as.factor(test.raw$useDay)
#str(df.infer)






















