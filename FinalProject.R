#class project

setwd('C:/Users/jahealey/Documents/RStudio')
install.packages('caret')
library(caret)

training<-read.csv("pml-training.csv")
testing<-read.csv("pml-testing.csv")

subtrain<-data.frame(training$user_name,training$raw_timestamp_part_1,training$classe)
colnames(subtrain)<-c("user_name", "raw_timestamp_part1", "classe")


modFit<-train(classe ~ .,method="gbm", data=subtrain)
subtest<-data.frame(testing$user_name,testing$raw_timestamp_part_1,testing$problem_id)
colnames(subtest)<-c("user_name", "raw_timestamp_part1", "classe")

predict(modFit,newdata=subtest)
#B A B A A E D B A A B C B A E E A B B B

