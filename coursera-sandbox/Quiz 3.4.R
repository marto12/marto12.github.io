# clear all
rm(list = ls())

# libraries
library(caret)
library(rpart.plot)
library(ElemStatLearn)

# data
data(SAheart)
set.seed(8484)

# test and train
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
trainSA$chd <- as.factor(trainSA$chd)
testSA = SAheart[-train,]
testSA$chd <- as.factor(testSA$chd)

# model
set.seed(13234)
mod1 <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl, 
                 data = trainSA, method = "glm", family = "binomial")

# model analysis
mod1$finalModel
#plot(mod1$finalModel)

# predict on test
predictTest <- predict(mod1, testSA[,-10])
confusionMatrix(predictTest, testSA[, 10])

# predict on train
predictTrain <- predict(mod1, trainSA[,-10])
confusionMatrix(predictTrain, trainSA[, 10])


# missclassification rate function
missClass = function(values, prediction) {
  sum(((prediction > 0.5) * 1) != values) / length(values)
}

#calculate missclassification rate
trainMiss <- missClass(as.numeric(predictTrain), as.numeric(trainSA[, 10]))
testMiss <- missClass(as.numeric(predictTest), as.numeric(testSA[, 10]))

trainMiss
testMiss

