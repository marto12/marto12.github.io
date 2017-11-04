library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)

library(rpart)
library(ggplot2)
#library(rattle)

training<-segmentationOriginal[segmentationOriginal$Case=="Train",]
testing<-segmentationOriginal[segmentationOriginal$Case=="Test",]

set.seed(125)
model<-train(Class ~ .,
             data = training, 
             method = "rpart")


library(rpart.plot)
rpart.plot(model$finalModel)