# load packages
library(caret)
library(kernlab)
# load data
data(spam)
# create train and test sets
inTrain <- createDataPartition(y=spam$type, p=0.75, list = FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
# fit model
set.seed(1234)
modelFit <- train(type ~., data=training, method="glm")

# # get dimensions
# dim(training)
# dim(spam)
# # cross validation on testing set
# set.seed(32323)
# folds <- createFolds(y=spam$type, k=10, list=TRUE, returnTrain = TRUE)
# head(folds)
# sapply(folds, length)
# # whats in fold 1 and 2?
# folds[[1]][1:10]
# folds[[2]][1:10]
# # 