## DengAl: Predicting Disease Spread
For this project we used Negative Binomial Regression, Regression with Time Series, and ARIMA with regression variables to predict the Dengue virus spread.

dengue.R is our main R file which contains all our prediction algorithms, our data cleaning steps, and our data visualizaition steps. DengAI.docx is our report that we created for this project. dengue_features_train.csv, dengue_labels_train.csv, and dengue_features_test.csv is our training data and our test data for this project respectively. We got all our data from www.drivendata.org  
Dengue fever or dengue is a virus spread through mosquito bites. This virus present itself in the form of fever, headaches, vomiting, nausea and in some cases it can lead to death. Since this illness is carried by mosquitos it is heavily dependent in tropical and subtropical climates. By forecasting the spread of this disease the health agencies can better organize their preventive measures such as vaccination and provide information to the public about this illness.  

Our goal is to predict the total_cases label for each (city, year, weekofyear) in the test set. There are two cities, San Juan and Iquitos, with test data for each city spanning 5 and 3 years respectively. We will make one submission that contains predictions for both cities. The data for each city have been concatenated along with a city column indicating the source: sj for San Juan and iq for Iquitos. The test set is a pure future hold-out, meaning the test data are sequential and non-overlapping with any of the training data. Throughout, missing values have been filled as NaNs.  

### Data Mining/Cleaning
The Dengi data was collected from drivendata.org. The data includes environmental data  from San Juan, Puerto Rico and Iquitos, Peru. The data was collected from various U.S. Federal Government agencies—from the Centers for Disease Control,  Prevention to the National Oceanic and Atmospheric Administration in the U.S. Department of Commerce.  

The data is provided in two different datasets the “dengue_features_train”, and the “dengue_labels_train”.  
The first dataset contains daily climate information, precipitation, vegetation index and climate forecasts for both, San Juan and Iquito.  
The second dataset contains four variables regarding the time of diagnosed cases of dengue fever for both cities.  

Both datasets contain information about two different cities it is necessary to divide them according to a single city in order to generate a dengue fever forecast per city. In other words it is necessary to divide “training_features” into “sj_trian_features” and “iq_train_features” as well as the given data frame “training_labels” into “sj_train_labels” and “iq_train_labels” to separate the values of each city; preparing the data for forecasting.  
The next step is to check if any of the variables contain null values.  
There are several values missing for each variable.  
Climate factors directly influence the vegetation index of a location. Looking at the plots for the vegetation index for San Juan and Iquitos we can see that some of the values are missing from these time series.  

![1](https://user-images.githubusercontent.com/5343403/34076077-6722b856-e2a0-11e7-83f4-568f9e0000fe.png)  
There are missing values throughout the San Juan time series. The most noticeable gap of information is in the beginning of 200 and as the series gets close to the 900 mark.

![2](https://user-images.githubusercontent.com/5343403/34076078-6aca1486-e2a0-11e7-85d3-03d70e77606b.png)  
In order to have a more complete dataset we have replaced the null values for the vegetation index (VI) with the average VI throughout the series (without considering null entries).  

![3](https://user-images.githubusercontent.com/5343403/34076079-6cd741e0-e2a0-11e7-94df-d912cd176746.png)  
San Juan’s vegetation index over time.  
![4](https://user-images.githubusercontent.com/5343403/34076080-6ea0764a-e2a0-11e7-80ad-174db67766a2.png)  
Iquitos’ vegetation index over time.  
The time series regarding the vegetation index for both cities are now continuous.  
### Data Visualization  
Analysing the way the data behaves can give us an insight into what variables are needed for an accurate forecast as well as how what to expect from the forecast model. Visualizing the datasets “sj_train_labels” and “iq_train_labels” we can see the pattern of dengue fever cases over time.  
![5](https://user-images.githubusercontent.com/5343403/34076083-72968f64-e2a0-11e7-8224-8db5a682de44.png)   
The data starts on the 1990s and continues on until 2008. Dengue fever cases have steadily declined since the 90s.  

![6](https://user-images.githubusercontent.com/5343403/34076084-759c4a96-e2a0-11e7-8cff-82f8a830d007.png)  
For the city of Iquitos the time of the collected data ranges from 2000s to 2010. Iquitos also projects a decreasing pattern over time.
The next visualizations correspond to the datasets containing the features of San Juan and Iquitos with the addition of the column “total_cases” from the labels datasets.  
The addition of this variable will enable us to calculate its correlation with the features of each city. We look into the correlation between the variables because we want to understand the relationship between each of the variables with total_cases variables.  

![7](https://user-images.githubusercontent.com/5343403/34076085-77e9a4c4-e2a0-11e7-9167-71f2a8740e1f.png)  
Looking into the correlation plot, we can see that the total_cases at San Juan is showing positive correlation with most of our climate variable, mostly the temperature data.  

![8](https://user-images.githubusercontent.com/5343403/34076087-79b997f0-e2a0-11e7-838e-33f2613d35b9.png)  
Looking into our correlation plot for Iquitos city, we can still find positive correlation between our total_cases variable and most of our climate variable, with strong correlations with our temperature data. Looking into the correlation between the various variables gives us better understanding of our model.  

![9](https://user-images.githubusercontent.com/5343403/34076088-7b9c10ca-e2a0-11e7-81e2-6d63397154a4.png)  
From the above figure, we can observe that reanalysis_specific_humidity_g_per_kg and reanalysis_dew_point_temp_k are most strongly correlated with Total_cases variable.
Also,  relative_humidity_percent, station_min_temp_c, reanalysis_min_air_temp_k, and station_average_temp_c has positive correlation with total_cases. Also, reanalysis_tdtrk_k shows the some negative correlation with total_cases variable.  


