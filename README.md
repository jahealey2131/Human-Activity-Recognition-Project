#Human-Activity-Recognition-Project

##Introduction
This is the final project in the Practical Machine Learning class.  The project consists of developing a classifier to successfully classify datapoints from a Human Activity Recognition dataset.  My efforts in this project consist of research, data inspection, data visualization, feature selection, training a classifier and implementing a predictor.  The data for this project was generously supplied by Ugulino, Carador, Vega, Velloso, Milidiu, and Fuks under the Creative Commons license (CC BY-SA).[1].  

##Background
In preparation for data analysis, I read the description of the data and looked at the authors prior work.  From the description, I had made the assumption that I would be looking at time series, extracting features (or using the provided extracted features) and training a classifier that captured the overall characteristice of "correctly" performed excercies vs. incorrectly classified excercises.  Under this assumption, I was expecting that the provided test set would have also consisted of a set of time series taken from either a correct or a type of incorrectly performed excercise.  I was suprised to find that the test set consisted of only single data points, which completely changed my approach.  

##Data Exploration
Under my initial assumption, I began seperating out the data by participant and by excercise type:

e.g. > AA<-subset(training, user_name=='adelmo' & classe =='A')

e.g. > AA_arm_x<-ts(AA$accel_arm_x)

ts1<-ts(A_ad$raw_timestamp_part_1)

ts1<-ts(A_ad$raw_timestamp_part_1)

From the description, I assumed that the data would consist of various time series from which we would extract features.   I had also initially assumed that the test data would be time series.  What I found was that the training data was a mix of time series data and what looked like features extracted from successive time windows.  The testing data, however seemed to be just single points in a time series.  

Initially I had thought to characterize the time series with features, and initially broke the data down by user and class, however, given that the test data was only a single point, and could not be analyzed with summary features, this did not make sense. 



##Feature Evaluation
Looking at the test set, I noted that features 12-36,50-59,69-83, 87-112 and 125-150 were all NA and would not be useful for discrimination, immediately eliminating 97 of the possible 159 features.  Of these, one was a date feature, that was redundant with the timestamp.  

##References

[1] Ugulino, W.; Cardador, D.; Vega, K.; Velloso, E.; Milidiu, R.; Fuks, H. Wearable Computing: Accelerometers' Data Classification of Body Postures and Movements. Proceedings of 21st Brazilian Symposium on Artificial Intelligence. Advances in Artificial Intelligence - SBIA 2012. In: Lecture Notes in Computer Science. , pp. 52-61. Curitiba, PR: Springer Berlin / Heidelberg, 2012. ISBN 978-3-642-34458-9. DOI: 10.1007/978-3-642-34459-6_6.


Read more: http://groupware.les.inf.puc-rio.br/har#ixzz3ovk1e0qK
