# clear
rm(list = ls())

# load
library(lubridate) # For year() function below

# data
dat = read.csv("Git/marto12.github.io/coursera-sandbox/gaData.csv")

# train and test
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

# Fit a model using the bats() function in the forecast package to the training time series. 
library(forecast)
trainBats <- bats(tstrain)
fcast <- forecast(trainBats, level = 95, h = dim(testing)[1])
plot(fcast)

# Then forecast this model for the remaining time points. For how many of the testing points is the true value within the 95% prediction interval bounds?
sum(fcast$lower < testing$visitsTumblr & testing$visitsTumblr < fcast$upper) / 
  dim(testing)[1]
