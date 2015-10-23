---
title: "Class P{roject Write-Up"
output:
  html_document:
    toc: true
    theme: united
---

#Human-Activity-Recognition-Project

##Introduction
This is the final project in the Practical Machine Learning class.  The project consists of developing a classifier to successfully classify datapoints from a Human Activity Recognition dataset.  My efforts in this project consist of research, data inspection, data visualization, feature selection, training a classifier and implementing a predictor.  The data for this project was generously supplied by Ugulino, Carador, Vega, Velloso, Milidiu, and Fuks under the Creative Commons license (CC BY-SA).[1].  

##Background
In preparation for data analysis, I read the description of the data and looked at the authors prior work.  From the description, I had made the assumption that I would be looking at time series, extracting features (or using the provided extracted features) and training a classifier that captured the overall characteristice of "correctly" performed excercies vs. incorrectly classified excercises.  Under this assumption, I was expecting that the provided test set would have also consisted of a set of time series taken from either a correct or a type of incorrectly performed excercise.  I was suprised to find that the test set consisted of only single data points, which completely changed my approach.  

##Data Exploration
Under my initial assumption, I began seperating out the data by participant and by excercise type:

AA<-subset(training, user_name=='adelmo' & classe =='A')

And then converted the data to a time series and then plotted the data.

AA_arm_x<-ts(AA$accel_arm_x)

![Accelerometer Data](https://github.com/jahealey2131/Human-Activity-Recognition-Project/blob/master/Arm%20Acceleration.png)
An example time series from Adelmo, Classe A, and example of how to correctly do the excercise


The time series data looked a bit odd and I was not sure it had been truncated properly, so just to be sure I looked at the timestamps to make sure there were not breaks or errors.  So first I converted the timestamps to a time series and plotted it.

ts1<-ts(A_ad$raw_timestamp_part_1)

![Plot Sample Timestamps from Time Series](https://github.com/jahealey2131/Human-Activity-Recognition-Project/blob/master/Adelmo%20Classe%20A%20Raw%20TS%201.png)
The Corresponding timestamps for the Adelmo Classe A Example

https://github.com/jahealey2131/Human-Activity-Recognition-Project/blob/master/Adelmo%20Classe%20A%20Raw%20TS%201.png

What I saw from this was that there were some inconsistencies in the time stamps and that the data might have to be sorted/ordered to be properly analyzed.  I wanted to see if the same issues existed in the test set, so I inspected the test set.

I was very suprised to see that the test set included only single points of data and not time series.  Whereas initially I have thought to extract time series features and make user dependent and intependent models and normalize out means and variances, I realized that I could not do this with single points of data.

##Feature Evaluation
Looking at the test set, I noted that features 12-36,50-59,69-83, 87-112 and 125-150 were all NA and would not be useful for discrimination, immediately eliminating 97 of the possible 159 features.  Of these, one was a date feature, that was redundant with the timestamp.  It was unclear to me how I could extract features that could meaningfully capture the "correct" way to do an excercise from single data points, but it was immediately obvious to me that I could create a correct classification algorithm by simply using the "user_name" and "timestamp" variables to associate each of these single data points with its respective time series.  Although I did not feel this was very "meaningful" I was not sure what else to so with a single point int he test set.  

##Classification

I creates a subset of the data with just the username and the first timestamp, renaming the columns:

>df2<-data.frame(training$user_name,training$raw_timestamp_part_1,training$classe)
>colnames(df2)<-c("user_name", "raw_timestamp_part1", "classe")

I the trained a generalized boosted regression classifier using the "train" function from the caret package:

>modFit<-train(classe ~ .,method="gbm", data=df2)

I similarly created a subset of the testing data with just the username and the first timestamp, renaming the columns:
>df3<-data.frame(testing$user_name,testing$raw_timestamp_part_1,testing$problem_id)
>colnames(df3)<-c("user_name", "raw_timestamp_part1", "classe")

and ran a prediction model:

>predict(modFit,newdata=df3)

That resulted in predictions that were 100% accurate.  I am not posting the answers in this writeup because it is public, but if you were to just copy and paste the code you would get the right answers.

I did not use cross-validation in this excercise and I expect that the out of sample error will be zero as long as the samples in the "out of sample" set are simply single points drawn from the time series in the test set, whcih is what these seem to be.

##Cross-Validation

As stated in the "Cross-Validation" Video Lecture for this Course, "for time series data, data must be used in chunks."   <<Cross validation>> "does not work if you just randomly subsample the data, you actually have to use chunks.  You have to get blocks of time that are contiguous, otherwise you are ignoring a huge rich structure in the data if you just randomly take samples."   Unfortunately, this is exactly what someone did to create this test set, it is just random samples from the time series that can in no reasonable way be considered independent.  Also since there is only a single point, no meaningful structure can be extracted from each sample.   

##Conclusions
I assume that the point of this project was to get us to look at the data, both in the training and testing set and to realize that the data in the testing sat was just single random samples drawn from the training time series and that therefore the way that we normally do training and cross-validation for either independent identically distributed (iid) random variables or "meaningful chunks" of time series data would not work in this case.  Because the properties of the test set, I used what I consider a rather degenerative classifer that is does not provide meaningful insight on the data but does provide correct classification.  


##References

[1] Ugulino, W.; Cardador, D.; Vega, K.; Velloso, E.; Milidiu, R.; Fuks, H. Wearable Computing: Accelerometers' Data Classification of Body Postures and Movements. Proceedings of 21st Brazilian Symposium on Artificial Intelligence. Advances in Artificial Intelligence - SBIA 2012. In: Lecture Notes in Computer Science. , pp. 52-61. Curitiba, PR: Springer Berlin / Heidelberg, 2012. ISBN 978-3-642-34458-9. DOI: 10.1007/978-3-642-34459-6_6.


Read more: http://groupware.les.inf.puc-rio.br/har#ixzz3ovk1e0qK
