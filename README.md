

#Human-Activity-Recognition-Project

##Introduction
This is the final project in the Practical Machine Learning class.  The project consists of developing a classifier to successfully classify datapoints from a Human Activity Recognition dataset.  My efforts in this project consist of research, data inspection, data visualization, feature selection, training a classifier and implementing a predictor.  The data for this project was generously supplied by Ugulino, Carador, Vega, Velloso, Milidiu, and Fuks under the Creative Commons license (CC BY-SA).[1].  

##Background
In preparation for data analysis, I read the description of the data and looked at the authors prior work.  From the description, I had made the assumption that I would be looking at time series, extracting features (or using the provided extracted features) and training a classifier that captured the overall characteristice of "correctly" performed excercies vs. incorrectly classified excercises.  Under this assumption, I was expecting that the provided test set would have also consisted of a set of time series taken from either a correct or a type of incorrectly performed excercise.  I was suprised to find that the test set consisted of only single data points, which completely changed my approach.  

##Data Exploration
Under my initial assumption, I began seperating out the data by participant and by excercise type:

```{r, eval=FALSE}
AA<-subset(training, user_name=='adelmo' & classe =='A')
```

And then converted the data to a time series and then plotted the data.
```{r, eval=FALSE}
AA_arm_x<-ts(AA$accel_arm_x)
```

![Accelerometer Data](https://github.com/jahealey2131/Human-Activity-Recognition-Project/blob/master/Arm%20Acceleration.png)

**An example time series from Adelmo, Classe A, and example of how to correctly do the excercise** 


The time series data looked a bit odd and I was not sure it had been truncated properly, so just to be sure I looked at the timestamps to make sure there were not breaks or errors.  So first I converted the timestamps to a time series and plotted it.

ts1<-ts(A_ad$raw_timestamp_part_1)

![Plot Sample Timestamps from Time Series](https://github.com/jahealey2131/Human-Activity-Recognition-Project/blob/master/Adelmo%20Classe%20A%20Raw%20TS%201.png)

**The Corresponding timestamps for the Adelmo Classe A Example**


What I saw from this was that there were some inconsistencies in the time stamps and that the data might have to be sorted/ordered to be properly analyzed.  I wanted to see if the same issues existed in the test set, so I inspected the test set.

I was very suprised to see that the test set included only single points of data and not time series.  Whereas initially I have thought to extract time series features and make user dependent and intependent models and normalize out means and variances, I realized that I could not do this with single points of data.

##Feature Evaluation
Looking at the test set, I noted that features 12-36,50-59,69-83, 87-112 and 125-150 were all NA and would not be useful for discrimination, immediately eliminating 97 of the possible 159 features.  Of these, one was a date feature, that was redundant with the timestamp.  It was unclear to me how I could extract features that could meaningfully capture the "correct" way to do an excercise from single data points, however I hypothesized that I could create a correct classification algorithm by simply using the "user_name" and "timestamp" variables to associate each of these single data points with its respective time series.  After carefully rereading the instructions for this assignment to confirm tha tI could in fact use any of the variables I wanted for the classifier, I chose to build and a model with thee two features.

#Building the Model

First, I created a subset of the data with just the username and the first timestamp variable "raw_timestamp_part1", renaming the columns:

>df2<-data.frame(training$user_name,training$raw_timestamp_part_1,training$classe)
>colnames(df2)<-c("user_name", "raw_timestamp_part1", "classe")

I then decided to try a generalized boosting model from the caret package, using the test set and cross-validation.  

##Cross-Validation

As stated in the "Cross-Validation" Video Lecture for this Course, "for time series data, data must be used in chunks."   Cross validation "does not work if you just randomly subsample the data, you actually have to use chunks.  You have to get blocks of time that are contiguous, otherwise you are ignoring a huge rich structure in the data if you just randomly take samples."   Unfortunately, this is exactly what someone did to create this test set, it is just random samples from the time series that can in no reasonable way be considered independent.  Despite this, I performed cross-validation anyway to confirm the performance of my hypothesized model.

To mimic what I saw in the test set, I used a "20 random sample" model for cross validation.  I first chose a random sample of twenty indices, extracted them from the training set to create the set for cross-validation, then trained the  gerneralized boosting model on the remaining points, using the "train" function from the caret package:

  a<-sample(1:19622, 20)
  twenty_set<-(subtrain[a,])
  rest_set<-(subtrain[-a,])
  modFit<-train(classe ~ .,method="gbm", data=rest_set)
  cv_pred<-predict(modFit,newdata=twenty_set)
  accuracy<-sum(cv_pred==twenty_set$classe)

I did this ten times resulting in the following values for accuracy: 20/20, 20/20, 20/20, 20/20, 20/20, 20/20, 19/20, 20/20, 20/20,20/20.  Overall and average accuracy of 99.5%.  I was satisfied with this as a result and decided not to modify the algorithm.

##Testing

I then used identical preprocessing on the testing data and created a subset with just the username and the first timestamp, renaming the columns:

>df3<-data.frame(testing$user_name,testing$raw_timestamp_part_1,testing$problem_id)
>colnames(df3)<-c("user_name", "raw_timestamp_part1", "classe")

and ran a prediction model:

>predict(modFit,newdata=df3)

and generated 20 text files with a single capital letter for each of the values of the prediction and submitted them via the course website.  The results was 20/20 correct.

##Conclusions
In conclusion, I was not very satisfied with this problem as a "machine learning" problem and would have preferred to see meaningful chunks of time series data in the test set, however, it was a valuable lesson in data exploration. In real life, most of the problems for "practical" machine learning are problems around trying to understand the problem, so in this sense this excercise reflected the real world all too accuracely.  Also, under my assumption for how the test set was drawn, this problem could have been better solved with a two level an "case" statement (case user="carlito", case timestamp is in range "x2-x3") than a machine learning algorithm.         


##References

[1] Ugulino, W.; Cardador, D.; Vega, K.; Velloso, E.; Milidiu, R.; Fuks, H. Wearable Computing: Accelerometers' Data Classification of Body Postures and Movements. Proceedings of 21st Brazilian Symposium on Artificial Intelligence. Advances in Artificial Intelligence - SBIA 2012. In: Lecture Notes in Computer Science. , pp. 52-61. Curitiba, PR: Springer Berlin / Heidelberg, 2012. ISBN 978-3-642-34458-9. DOI: 10.1007/978-3-642-34459-6_6.


Read more: http://groupware.les.inf.puc-rio.br/har#ixzz3ovk1e0qK

