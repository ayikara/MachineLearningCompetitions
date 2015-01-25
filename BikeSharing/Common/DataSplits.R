## split training data into train batch and test batch
df.fertile = subset(train.raw, workingday ==1)
df.infer = subset(test.raw, workingday ==1)
#str(df.fertile)
#nrow(df.infer)


set.seed(23)
#Registered
#training.rows <- createDataPartition(df.fertile$registered,p = 0.8, list = FALSE)
#Casual
training.rows <- createDataPartition(df.fertile$casual,p = 0.8, list = FALSE)

train.batch <- df.fertile[training.rows, ]
test.batch <- df.fertile[-training.rows, ]
#str(train.batch)

#drops <- c("datetime","temp","atemp","humidity","windspeed","useYear","yearDay","casual","count")
#drops <- c("yearDay","useYear","workingday","holiday","temp","humidity","casual","count")
#Registered
drops <- c("datetime","holiday","workingday","temp","humidity","windspeed","casual","count","useYear","useDay","yearDay")
#Casual
#drops <- c("datetime","holiday","workingday","temp","humidity","windspeed","registered","count","useYear","useDay","yearDay")

train.testrbX = train.batch[,!(names(train.batch) %in% drops)]
test.testrbX = test.batch[,!(names(test.batch) %in% drops)]
df.infer.testrb <-  df.infer[,!(names(df.infer) %in% drops)]

#To caluclate RMSE need to modify this
#str(train.testrbX)
#str(test.testrbX)
#str(df.infer.testrb)
#str(train.testrbY)

#drops <- c("registered")
#train.testrbX = train.testrbX[,!(names(train.testrbX) %in% drops)]
#test.testrbX = test.testrbX[,!(names(test.testrbX) %in% drops)]
