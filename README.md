#Human-Activity-Recognition-Project

##Introduction
This project is an analysis of data generously supplied by Ugulino, Carador, Vega, Velloso, Milidiu, and Fuks under the Creative Commons license (CC BY-SA).[1].  The data, available at http://groupware.les.inf.puc-rio.br/har is taken from sensors during a series of Weight Lifting Exercises.  The dataset was collected to investigate "how well" a weight lifting exercise was being performed by the wearer and consists of data from  six young health participants were asked to perform one set of 10 repetitions of the Unilateral Dumbbell Biceps Curl in five different fashions: exactly according to the specification (Class A), throwing the elbows to the front (Class B), lifting the dumbbell only halfway (Class C), lowering the dumbbell only halfway (Class D) and throwing the hips to the front (Class E).[1]  Sensors were placed as described in the diagram below.  For more information see http://groupware.les.inf.puc-rio.br/har#ixzz3ovqv1S8E

![sensor placements](http://groupware.les.inf.puc-rio.br/static/WLE/on-body-sensing-schema.png)


##Data Exploration
From the description, I assumed that the data would consist of various time series from which we would extract features.   I had also initially assumed that the test data would be time series.  What I found was that the training data was a mix of time series data and what looked like features extracted from successive time windows.  The testing data, however seemed to be just single points in a time series.  

Initially I had thought to characterize the time series with features, and initially broke the data down by user and class, however, given that the test data was only a single point, and could not be analyzed with summary features, this did not make sense. 



##Feature Evaluation
Looking at the test set, I noted that features 12-36,50-59,69-83, 87-112 and 125-150 were all NA and would not be useful for discrimination, immediately eliminating 97 of the possible 159 features.  Of these, one was a date feature, that was redundant with the timestamp.  

##References

[1] Ugulino, W.; Cardador, D.; Vega, K.; Velloso, E.; Milidiu, R.; Fuks, H. Wearable Computing: Accelerometers' Data Classification of Body Postures and Movements. Proceedings of 21st Brazilian Symposium on Artificial Intelligence. Advances in Artificial Intelligence - SBIA 2012. In: Lecture Notes in Computer Science. , pp. 52-61. Curitiba, PR: Springer Berlin / Heidelberg, 2012. ISBN 978-3-642-34458-9. DOI: 10.1007/978-3-642-34459-6_6.


Read more: http://groupware.les.inf.puc-rio.br/har#ixzz3ovk1e0qK
