#Random Forest
library(caret)
set.seed(100)
indx <- createFolds(train.testrbY, returnTrain = TRUE)
ctrl <- trainControl(method = "cv", index = indx)

#mtryGrid <- data.frame(mtry = floor(seq(10, ncol(train.testrbX),length = 10)))
from =2
to = ceiling(ncol(train.testrbX)/2)
by =1
mtryGrid <- data.frame(mtry = floor(seq(from=from, to=to, by=by)))



### Tune the model using cross-validation
set.seed(100)
#rfTune <- train(x = train.testrbX, y = train.testrbY,
rfTune <- train(registered ~ .,data = train.testrbX,
                method = "rf",
                tuneGrid = mtryGrid,
                ntree = 1000,
                importance = TRUE,
                trControl = ctrl)
rfTune

plot(rfTune)

rfImp <- varImp(rfTune, scale = FALSE)
rfImp

test.testrbX$count <- predict(rfTune, test.testrbX)
obsv <- data.frame(test.testrbY)
str(test.testrbX)
obsvA  <-c(obsv[,1])
predA <- c(test.testrbX[,9])
RMSE(predA,obsvA)