# clear all 
rm(list = ls())

# load
library(ElemStatLearn)
library(caret)

# data
data(vowel.train)
data(vowel.test)

# Set the variable y to be a factor variable in both the training and test set. 
vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)

#Then set the seed to 33833. 
set.seed(33833)

# Fit (1) a random forest predictor relating the factor variable y to the remaining variables 
mod_rf <- train(y ~ ., data = vowel.train, method = "rf")

# (2) a boosted predictor using the "gbm" method. Fit these both with the train() command in the caret package.

mod_gbm <- train(y ~ ., data = vowel.train, method = "gbm")

pred_rf <- predict(mod_rf, vowel.test)
pred_gbm <- predict(mod_gbm, vowel.test)

# What are the accuracies for the two approaches on the test data set? 
confusionMatrix(pred_rf, vowel.test$y)$overall[1]
confusionMatrix(pred_gbm, vowel.test$y)$overall[1]

# What is the accuracy among the test set samples where the two methods agree?

predDF <- data.frame(pred_rf, pred_gbm, y = vowel.test$y)

sum(pred_rf[predDF$pred_rf == predDF$pred_gbm] == predDF$y[predDF$pred_rf == predDF$pred_gbm]) / sum(predDF$pred_rf == predDF$pred_gbm)
