# clear all
rm(list=ls())
# load packages
library(ISLR)
library(ggplot2)
library(caret)
library(Hmisc) # for cut2 
library(dplyr)
# load data
data(Wage)
summary(Wage)
# set test and train
inTrain <- createDataPartition(y=Wage$wage,p=0.7, list=FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
dim(training)
dim(testing)
# plots
qplot(age,wage,data=training, colour=education) + 
  geom_smooth(method=lm,formula=y~x)
# cut continuous into factors
cutWage <- cut2(training$wage,g=3)
table(cutWage)
# create tables
table(cutWage, training$jobclass) %>% prop.table(1)
# density plots
qplot(wage, data=training, geom = "density", colour=race)
