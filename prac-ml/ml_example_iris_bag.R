## NOT WORKING

#libraries
library(caret)
library(ggplot2)

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
modFit <- train(Species ~ .,method="bag",data=training, metric = "Accuracy")
print(modFit$finalModel)

#predict data
predict(modFit, newdata = testing)

#confusionMatrix accuracy etc
confusionMatrix(testing$Species, predict(modFit, newdata = testing))
