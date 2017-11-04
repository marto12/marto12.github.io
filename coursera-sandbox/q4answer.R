rm(list=ls())

library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]


IL_col_idx <- grep("^[Ii][Ll].*", names(training))
suppressMessages(library(dplyr))
new_training <- training[, c(names(training)[IL_col_idx], "diagnosis")]
names(new_training)

IL_col_idx <- grep("^[Ii][Ll].*", names(testing))
suppressMessages(library(dplyr))
new_testing <- testing[, c(names(testing)[IL_col_idx], "diagnosis")]
names(new_testing)

# compute the model with non_pca predictors
non_pca_model <- train(diagnosis ~ ., data=new_training, method="glm")
# apply the non pca model on the testing set and check the accuracy
non_pca_result <- confusionMatrix(new_testing[, 13], predict(non_pca_model, new_testing[, -13]))
non_pca_result

# perform PCA extraction on the new training and testing sets
pc_training_obj <- preProcess(new_training[, -13], method=c('center', 'scale', 'pca'), thresh=0.8)
pc_training_preds <- predict(pc_training_obj, new_training[, -13])
pc_testing_preds <- predict(pc_training_obj, new_testing[, -13])
# compute the model with pca predictors
pca_model <- train(y=new_training$diagnosis, x=pc_training_preds, method="glm")
# apply the PCA model on the testing set
pca_result <- confusionMatrix(new_testing[, 13], predict(pca_model, pc_testing_preds))
pca_result


