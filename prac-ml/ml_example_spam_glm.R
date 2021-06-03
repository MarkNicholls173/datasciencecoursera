#libraries
library(caret)
library(kernlab)
library(ggplot2)

#load data & basic info
data(spam)


#split data & basic info
inTrain <- createDataPartition(y=spam$type,
                               p=0.7, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)
dim(testing)

#eda


#fit/train model
modFit <- train(type ~ .,method="glm",data=training)
print(modFit$finalModel)


#predict data
predictions <- predict(modFit, newdata = testing)

#confusionMatrix accuracy etc
confusionMatrix(predictions,testing$type)
