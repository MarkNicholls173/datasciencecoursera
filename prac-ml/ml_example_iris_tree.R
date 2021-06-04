#libraries
library(caret)
library(ggplot2)
library(rpart)

#load data & basic info
data(iris)
names(iris)
table(iris$Species)

#split data & basic info
inTrain <- createDataPartition(y=iris$Species,
                               p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
dim(training)
dim(testing)

#eda
qplot(Petal.Width,Sepal.Width,colour=Species,data=training)

#fit/train model
modFit <- train(Species ~ .,method="rpart",data=training)
print(modFit$finalModel)

#predict data
predict(modFit, newdata = testing)

#confusionMatrix accuracy etc
confusionMatrixInTr(testing$Species, predict(modFit, newdata = testing))
