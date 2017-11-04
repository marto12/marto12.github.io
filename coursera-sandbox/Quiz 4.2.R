# clear all
rm(list=ls())

# load
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)

# data
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)

# train test
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# Set the seed to 62433
set.seed(62433)


# Predict diagnosis with all the other variables using a random forest ("rf"), boosted trees ("gbm") and linear discriminant analysis ("lda") model. 

trainRF <- train(diagnosis~.,data=training,method="rf")
trainBoosted <- train(diagnosis~.,data=training,method="gbm")
trainLDA <- train(diagnosis~.,data=training,method="lda")

# Stack the predictions together using random forests ("rf"). 
predictRF <- predict(trainRF, testing)
predictBoosted <- predict(trainBoosted, testing)
predictLDA <- predict(trainLDA, testing)

comboDF <- data.frame(predictRF,predictBoosted,predictLDA,diagnosis=testing$diagnosis)
trainComboRF <- train(diagnosis~.,data=comboDF,method="rf")
predictComboRF <- predict(trainComboRF, comboDF)


# What is the resulting accuracy on the test set? Is it better or worse than each of the individual predictions?

confusionMatrix(predictRF, testing$diagnosis)$overall[1]
confusionMatrix(predictBoosted, testing$diagnosis)$overall[1]
confusionMatrix(predictLDA, testing$diagnosis)$overall[1]
confusionMatrix(predictComboRF, testing$diagnosis)$overall[1]


