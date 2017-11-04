# clear all
rm(list = ls())

# libraries
library(AppliedPredictiveModeling)
library(caret)

#data
data(segmentationOriginal)

# 1. Subset the data to a training set and testing set based on the Case variable in the data set.
colnames(segmentationOriginal)
dim(segmentationOriginal)
inTrain <- segmentationOriginal$Case=="Train"
training <- segmentationOriginal[inTrain, ]
testing <- segmentationOriginal[!inTrain, ]

# 2. Set the seed to 125 and fit a CART model with the rpart method using all predictor variables and default caret settings.

## model
set.seed(125)
mod1 <- train(Class ~ ., method = "rpart", data = training)

## model chart
mod1$finalModel
library(rpart.plot)
rpart.plot(mod1$finalModel)

## predict
predict1 <- predict(mod1, training[,-3])
confusionMatrix(predict1, training[, 3])

# 3. In the final model what would be the final model prediction for cases with the following variable values:

# a. TotalIntench2 = 23,000; FiberWidthCh1 = 10; PerimStatusCh1=2
# PS

# b. TotalIntench2 = 50,000; FiberWidthCh1 = 10;VarIntenCh4 = 100
# WS

# c. TotalIntench2 = 57,000; FiberWidthCh1 = 8;VarIntenCh4 = 100
# PS

# d. FiberWidthCh1 = 8;VarIntenCh4 = 100; PerimStatusCh1=2
# Not possible
