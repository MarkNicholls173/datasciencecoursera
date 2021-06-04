### week 3 quiz

## q1

library(AppliedPredictiveModeling)
data("segmentationOriginal")
library(caret)

set.seed(125)

inTrain <- createDataPartition(y =segmentationOriginal$Cell, 
                               p = 0.7, list = FALSE)

training <- segmentationOriginal[segmentationOriginal$Case == "Train",]                               
testing <- segmentationOriginal[segmentationOriginal$Case == "Test",] 



str(training[c(-1,-2)])

modFit <- train(Class ~ ., data = training[c(-1, -2)], method = "rpart")

print(modFit$finalModel)

newdata1 <- data.frame(TotalIntench2 = 23000,
                       FiberWidthCh1 = 10,
                       PerimStatusCh1 = 2)

predict(modFit, newdata = newdata1)
#Error in eval(predvars, data, env) : object 'Cell' not found

newdata2 <- data.frame(TotalIntench2 = 50000,
                       FiberWidthCh1 = 10,
                       VarIntenCh4 = 100)

predict(modFit, newdata = newdata2)


TotalIntenCh2 <- c(23000,50000,57000,NA)
FiberWidthCh1 <- c(10,10,8,8)
VarIntenCh4 <- c(NA,100,100,100)
PerimStatusCh1 <- c(2,NA,NA,2)
test_data <- data.frame(matrix(data = 0, 
                               nrow = 4, 
                               ncol = length(names(segmentationOriginal))