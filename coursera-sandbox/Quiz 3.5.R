# clear all
rm(list = ls())

# libraries
library(ElemStatLearn)
library(caret)
data(vowel.train)
data(vowel.test)

# Set the variable y to be a factor variable in both the training and test set. 

train <- as.data.frame(vowel.train)
test <- as.data.frame(vowel.test)

train$y <- as.factor(train$y)
test$y <- as.factor(test$y)


#Then set the seed to 33833. 

set.seed(33833)

# Fit a random forest predictor relating the factor variable y to the remaining variables.

mod1 <- train(y ~ ., data = train, method="rf")

# Read about variable importance in random forests here: http://www.stat.berkeley.edu/~breiman/RandomForests/cc_home.htm#ooberr The caret package uses by default the Gini importance.

plot(varImp(mod1))

# library(randomForest)
# modvowel <- randomForest(y ~ ., data = vowel.train)
# varImpPlot(modvowel)
