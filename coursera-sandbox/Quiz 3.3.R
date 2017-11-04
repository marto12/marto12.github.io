# clear all
rm(list = ls())

# libraries
library(pgmm)
library(caret)
library(rpart.plot)

#data
data(olive)
olive = olive[,-1]

#train model
mod1 <- train(data=olive, Area ~ ., method="rpart")

## model analysis
mod1$finalModel
rpart.plot(mod1$finalModel)

#new data
newdata = as.data.frame(t(colMeans(olive)))

## predict
predict1 <- predict(mod1, newdata[,-1])
predictions <- as.data.frame(predict1)

confusionMatrix(predict1, olive[, 1])

olive[, 1]
