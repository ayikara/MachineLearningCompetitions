#Multivariate Adaptive Regression Splines
library(caret)
set.seed(100)
indx <- createFolds(train.testrbY, returnTrain = TRUE)
ctrl <- trainControl(method = "cv", index = indx)
fitControl <- trainControl(## 10-fold CV
  method = "repeatedcv",
  number = 10,
  ## repeated ten times
  repeats = 10)
set.seed(100)
gbmGrid <- expand.grid(interaction.depth = seq(1, 7, by = 2),
                       n.trees = seq(100, 1000, by = 50),
                       shrinkage = c(0.01, 0.1))


set.seed(100)
gbmTune <- train(registered ~ .,data = train.testrbX,
                 method = "gbm",
                 tuneGrid = gbmGrid,
                 trControl = fitControl,
                 verbose = FALSE)

ogbmTune <- train(x = train.testrbX, y = train.testrbY,
                 method = "gbm",
                 #tuneGrid = gbmGrid,
                 trControl = fitControl,
                 verbose = FALSE)
gbmTune

plot(gbmTune, auto.key = list(columns = 4, lines = TRUE))

gbmImp <- varImp(gbmTune, scale = FALSE)
gbmImp

str(test.testrbX)
test.testrbX$count <- predict(gbmTune, test.testrbX)
obsv <- data.frame(test.testrbY)
str(test.testrbX)
obsvA  <-c(obsv[,1])
predA <- c(test.testrbX[,9])
RMSE(predA,obsvA)

#output values for submission
str(df.infer) #Original Test data set
df.infer$count <- round(predict(gbmTune, df.infer.testrb)) #df.infer.testrb -->removed all redundant vars for prediction.
df.infer$count <- ifelse(df.infer$count <0, 0, df.infer$count)
write.csv(df.infer[,c("datetime", "count")], 
          file="BikeRental_predictions.csv", row.names=FALSE, quote=FALSE)