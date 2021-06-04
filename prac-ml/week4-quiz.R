# week 4 quiz

# q1 using old package

# skipping

# q2

library(caret)
library(gbm)
library(AppliedPredictiveModeling)

set.seed(3433)

data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)

mod_rf <- train(diagnosis ~ ., data = training, method = "rf")
mod_gbm <- train(diagnosis ~ ., data = training, method = "gbm")
mod_lda <- train(diagnosis ~ ., data = training, method = "lda")

pred_rf <- predict(mod_rf, testing)
pred_gbm <- predict(mod_gbm, testing)
pred_lda <- predict(mod_lda, testing)

confusionMatrix(pred_rf, testing$diagnosis)
confusionMatrix(pred_gbm, testing$diagnosis)
confusionMatrix(pred_lda, testing$diagnosis)

predDF <- data.frame(pred_rf, pred_gbm, pred_lda, diagnosis = testing$diagnosis)

mod_ensem <- train(diagnosis ~ ., data = predDF, method = "rf")
pred_ensem <- predict(mod_ensem, predDF)

confusionMatrix(pred_ensem, testing$diagnosis)

#  ANS: Stacked Accuracy: 0.80 is better than all three other methods

# q 3

set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

###

set.seed(233)

mod_lasso <- train(CompressiveStrength ~ ., data = concrete, method = "lasso")

library(elasticnet)

plot.enet(mod_lasso$finalModel, xvar = "penalty", use.color = T)

# ANS Cement

# q 4
library(lubridate)

url <- "https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv"
destfile = "gaData.csv"
curl::curl_download(url, destfile = destfile)
dat <- read.csv(destfile)

training = dat[year(dat$date) < 2012,]

testing = dat[(year(dat$date)) > 2011,]

tstrain = ts(training$visitsTumblr)

library(forecast)

mod_bats <- bats(tstrain)

fc_bats <- forecast(mod_bats, level = 95, h = dim(testing)[1])

mean(fc_bats$lower < testing$visitsTumblr & testing$visitsTumblr < fc_bats$upper)

# ans = 96% (0.96) 

# q 5

set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[inTrain,]
testing = concrete[-inTrain,]

##

set.seed(325)
library(e1071)
mod_svm <- svm(CompressiveStrength ~ ., data = training)
pred_svm <- predict(mod_svm, newdata = testing)
accuracy(pred_svm, testing$CompressiveStrength)
