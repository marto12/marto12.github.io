library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1], size = dim(SAheart)[1] / 2, replace = F)
trainSA = SAheart[train,]
trainSA$chd <- as.factor(trainSA$chd)
testSA = SAheart[-train,]
testSA$chd <- as.factor(testSA$chd)


missClass = function(values, prediction){sum(((prediction > 0.5) * 1) != values) / length(values)}

set.seed(13234)
modelSA <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl, 
                 data = trainSA, method = "glm", family = "binomial")

missClass(as.numeric(testSA$chd), as.numeric(predict(modelSA, newdata = testSA)))

missClass(as.numeric(trainSA$chd), as.numeric(predict(modelSA, newdata = trainSA)))
