# clear
rm(list=ls())

# load
set.seed(3523)
library(AppliedPredictiveModeling)

# data
data(concrete)

# train and test
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

# Set the seed to 233 fit a lasso model to predict Compressive Strength. 
set.seed(233)
trainLasso = train(data=training, CompressiveStrength~.,method="lasso")

# Which variable is the last coefficient to be set to zero as the penalty increases? (Hint: it may be useful to look up ?plot.enet).
library(elasticnet)
plot.enet(trainLasso$finalModel, use.color=TRUE, xvar = "penalty")
