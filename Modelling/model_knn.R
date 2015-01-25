
set.seed(100)
fitControl <- trainControl(## 10-fold CV
  method = "repeatedcv",
  number = 10,
  ## repeated ten times
  repeats = 10)


set.seed(100)
knnTune <- train(registered ~., data = train.testrbX,
                 method = "knn",
                 preProc = c("center", "scale"),
                 tuneGrid = data.frame(k = 1:15),
                 trControl = fitControl)

plot(knnTune)

obsvA  <-test.testrbX[,c("registered")]
#obsvA  <-test.testrbX[,c("casual")]
predA  <- predict(knnTune, test.testrbX)
RMSE(predA,obsvA)



#output values for submission
str(df.infer)
df.infer$cnt <- predict(knnTune, df.infer[, names(knnDescr)])

write.csv(df.infer[,c("datetime", "cnt")], 
          file="BikeRental_predictions.csv", row.names=FALSE, quote=FALSE)
