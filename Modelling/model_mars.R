
#Multivariate Adaptive Regression Splines


set.seed(100)
fitControl <- trainControl(## 10-fold CV
  method = "repeatedcv",
  number = 10,
  ## repeated ten times
  repeats = 10)
#tGrid = expand.grid(.degree = 1:2, .nprune = 1:4) #This works
tGrid = expand.grid(.degree = 1:2, .nprune = 1:7) #Need adjust tuning parameters based on number of variables.
#class(tGrid)
set.seed(100)
marsTune <- train(x = train.testrbX, y = train.testrbY,
                  method = "earth",
			            tuneGrid = tGrid,
                  trControl = fitControl)
modelVars <-varImp(marsTune, value ="gcv")#The varImp tracks changes in model statistics
#rm(marsTune)

plot(marsTune)
str(train.testrbX)
str(test.testrbX)

test.testrbX$count <- predict(marsTune, test.testrbX)

obsv <- data.frame(test.testrbY)
str(test.testrbX)
obsvA  <-c(obsv[,1])
predA <- c(test.testrbX[,8]) #Need to adjust the index
RMSE(predA,obsvA)

#output values for submission
str(df.infer) #Original Test data set
df.infer$count <- round(predict(marsTune, df.infer.testrb)) #df.infer.testrb -->removed all redundant vars for prediction.
#df.infer$count <- ifelse(df.infer$count <0, 0, df.infer$count)
write.csv(df.infer[,c("datetime", "count")], 
          file="BikeRental_predictions.csv", row.names=FALSE, quote=FALSE)