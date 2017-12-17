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

The figure below shows the Boxplot of our dependent and  independent variables at Iquitos city.  Starting from the left of our figure, we have total_cases, reanalysis_specific_humidity_g_per_kg, station_max_temp_c, reanalysis_tdtr_k, reanalysis_dew_point_temp_k and reanalysis_max_air_temp_k variables. We can see that total_cases is right skewed. Reanalysis_specific_humidity_g_per_kg looks slightly left skewed. Station_max_temp_c looks like it is normally distributed. Reanalysis_tdtr_k looks like it is left skewed.   Reanalysis_dew_point_temp_k looks like it is right skewed and reanalysis_max_air_temp_k variable looks like it is normally distributed.  
![10](https://user-images.githubusercontent.com/5343403/34076168-c2837bb6-e2a2-11e7-80e6-7b67400c4ade.png)  
Box-plot for Iquitos.  

![11](https://user-images.githubusercontent.com/5343403/34076169-c48bd732-e2a2-11e7-8bc8-2ff268db5891.PNG)  
Box-plot for San Juan.  
From above figure, we can see that total_cases is right skewed. Reanalysis_specific_humidity_g_per_kg, Station_max_temp_c, and Reanalysis_tdtr_k looks like it is normally distributed. Reanalysis_dew_point_temp_k looks like it is right skewed and reanalysis_max_air_temp_k variable looks like it is normally distributed.  

![12](https://user-images.githubusercontent.com/5343403/34076170-c681c6d2-e2a2-11e7-8e36-90dfbfbf0014.PNG)  
Time plot for San Juan variables: total_cases, reanalysis_specific_humidity_g_per_kg, reanalysis_dew_point_temp_k, station_max_temp_c and reanalysis_tdtr_k.  
From above figure, we can observe that all our variables have strong seasonality. We cannot see any trend in our data. We can also see that all our variables except total_cases look stationary.  

![13](https://user-images.githubusercontent.com/5343403/34076171-c8ae91b0-e2a2-11e7-8897-33b880ffa387.PNG)  
Time series for Iquitos variables: total_cases, reanalysis_specific_humidity_g_per_kg, and reanalysis_dew_point_temp_k.  
From above figure, we can see some strong seasonality in our variables. We cannot see any trend in our data set. We can also see that all our variables except total_cases look stationary.  

![14](https://user-images.githubusercontent.com/5343403/34076172-ca3398e6-e2a2-11e7-8909-9b6c86ee24ea.PNG)  
ACF plot for San Juan Dengi variables.  
From the above figure, we can see that there is positive correlation between the lags of each of our predictor variables. We might have to take some transformations with the data when we use these predictors in our time series models. We can also see some seasonality within the variables.  

![15](https://user-images.githubusercontent.com/5343403/34076173-cbcae5a6-e2a2-11e7-8f3d-54fac57500fb.PNG)  
ACF plot for Iquitos Dengi variables.  
From the above figure, we can see that there is positive autocorrelation within the lags of each of our predictor variables. We can also see some seasonality in the plots for all our predictor variables.  

### Predictive Analysis
#### Negative Binomial Regression
We used the Negative Binomial Regression from the MASS package.  
We found that, for the Negative Binomial Regression, only reanalysis_specific_humidity_g_oer_kg and reanalysis_dew_point_temp_k independent variables were significant variables for both our cities. Station_max_temp_c and weekofyear, and reanalysis_tdtr_k independent variables were only significant for San Juan.  

We started with twelve variables for each of our two cities to fit a negative binomial regression model. But we ended up with just five independent variables for San Juan and 2 independent variable for Iquitos.  

For San Juan, our AIC with the model came up to be 8304.6 and our model had an overall significance level of about 2%.  
Next, we fitted our model for Iquitos. We only had 2 independent variable that were significant to our model. Our model had a AIC score of 3134.1 and our over all significance level for our model was 8%.  
![16](https://user-images.githubusercontent.com/5343403/34076204-329f3722-e2a4-11e7-9687-72df3b7ec10b.png)  
Plot of Actual vs Predicted values (Negative Binomial Regression).  
From above figure, we can see that our predicted values do not perfectly match our actual values. Even Though, our model does predict the seasonality of data with respect to the actual data, we can see that in some cases the predicted values exceeded the actual values most of the time. There is still room for improvement on our model for San Juan.  
![17](https://user-images.githubusercontent.com/5343403/34076205-36a03ace-e2a4-11e7-8f1e-768417a24674.png)  
Plot of Actual vs Predicted values  (Negative Binomial Regression).  
From above figure, we can see that our predicted values do not perfectly match our actual values. Even Though, our model does predict the seasonality of data with respect to the actual data, we can see that in some cases the predicted values exceeded the actual values most of the time. There is still room for improvement on our model for Iquitos.  
#### Linear Regression with Time Series Data
For Linear Regression with Times Series Data for San Juan, we took reanalysis_specific_humidity_g_per_kg, reanalysis_dew_point_temp_k, station_max_temp_c and reanalysis_tdtr_k as our independent predictor variables based on the predictor variables for San Juan from our Negative Binomial Regression model.  
We can see that our Adjusted R^2 for our model is 0.05994. Our F-statistics looks significant.  
For Iquitos data, we took reanalysis_specific_humidity_g_per_kg and reanalysis_dew_point_temp_k to predict total_cases, based on our results from our Negative Binomial Regression model.  
![18](https://user-images.githubusercontent.com/5343403/34076206-38d0dcae-e2a4-11e7-9c77-4508bbf608fa.png)  
Time Series Actual vs Predicted (San Juan).  
![19](https://user-images.githubusercontent.com/5343403/34076207-3abc3662-e2a4-11e7-8e78-97f6c09ebf64.png)  
Time Series actual vs predicted (Iquitos).  
From above Figure, we can see that our predicted values were not able to truly capture the variation with our actual data movements. Our predicted values did capture the seasonality present in the actual data. There are still some room for improving our models.  
#### ARIMA
As discussed, we have used ARIMA with exogenous variables (Dynamic Regression), for San Juan we use reanalysis_specific_humidity_g_per_kg, reanalysis_dew_point_temp_k, station_max_temp_c and reanalysis_tdtr_k as our independent predictor variables. For Iquitos, we use reanalysis_specific_humidity_g_per_kg and reanalysis_dew_point_temp_k as our independent predictor variable. We use total_cases as our dependent variable for both San Juan and Iquitos.  

![20](https://user-images.githubusercontent.com/5343403/34076265-0b1230c2-e2a6-11e7-9a1f-9d883ccd6948.png)  
Fitted vs actual values for San Juan.  
From the above figure, we can see that our fitted value almost perfectly fit well with our actual values for San Juan.  
![21](https://user-images.githubusercontent.com/5343403/34076266-0b286978-e2a6-11e7-917e-c62068f76139.png)  
Fitted vs actual for Iquitos.  
From the above figure we can see that our fitted values capture the actual values of our model.  

### Discussion and Recommendation
#### Residual Diagnostics for Negative Binomial Regression Model
##### San Juan
![22](https://user-images.githubusercontent.com/5343403/34076267-0b3fbb14-e2a6-11e7-8bd9-7915738a3693.png)  
Residuals vs Fitted values for San Juan.  
Residual vs Fitted Values plot show that there is some observable pattern, i.e. we can see some heteroscedasticity in our residuals.  The variance of the residuals is not constant.  

![23](https://user-images.githubusercontent.com/5343403/34076268-0b5a177a-e2a6-11e7-9d6f-c28ada0537fc.png)  
Q-q plot for San Juan.  
The Q-Q plot shows that we can see that the residuals data are not normally distributed, and we may have an outlier in our data.  

![24](https://user-images.githubusercontent.com/5343403/34076269-0b729a48-e2a6-11e7-8d14-a1c0f424edd5.png)  
Predicted values vs Standard Residuals.  
There are some patterns in this graph, suggesting heteroscedasticity in our residuals.  

![25](https://user-images.githubusercontent.com/5343403/34076270-0b89d01e-e2a6-11e7-8b82-8edc34d4d0de.png)  
Leverage plot for San Juan.  
We can see that all the residuals are within the Cook’s distance.  
##### Iquitos
![26](https://user-images.githubusercontent.com/5343403/34076271-0ba174da-e2a6-11e7-85d9-0b30dd167fb9.png)  
Residuals vs fitted values for Iquitos.  
Residual vs Fitted Values plot show that there is some observable pattern, i.e. we can see some heteroscedasticity in our residuals.  The variance of the residuals is not constant.  

![27](https://user-images.githubusercontent.com/5343403/34076256-0a356278-e2a6-11e7-81c4-7fda9b2af76a.png)  
Q-q plot for Iquitos.  
From the q-q plot we can see that our residual data is not normally distributed.  

![28](https://user-images.githubusercontent.com/5343403/34076257-0a4ca316-e2a6-11e7-8e96-1af0333894b7.png)  
Predicted values vs Standard Residuals for Iquitos.  
It shows that there are some patterns in this graph, suggesting heteroscedasticity in our residuals.  

![29](https://user-images.githubusercontent.com/5343403/34076258-0a61acf2-e2a6-11e7-97c5-0121639b483a.png)  
Leverage plot for Iquitos.  
For this graph, we can see that all our residuals are within the Cook’s distance.  
#### Residual diagnostics for Linear Regression with Time Series Data
![30](https://user-images.githubusercontent.com/5343403/34076259-0a784bba-e2a6-11e7-8ec0-fb4894ad706e.png)  
Residual Diagnostics for San Juan.  
From the above figure we can see that our residuals don’t have constant variance. We can also see from the Acf plot that our residuals are autocorrelated, meaning that there is information left in the residuals which should be used in computing forecasts. We can also see that our residuals are not normally distributed.  

![31](https://user-images.githubusercontent.com/5343403/34076260-0a8f73d0-e2a6-11e7-9522-9a6b287265dc.png)  
Residual Diagnostics for Iquitos.  
From above figure, we can see that our residuals do have have constant variance. We can also see that the residuals are highly autocorrelated. This means that there is information left in the residuals which should be used in computing forecasts. Also, we can see that the residuals are not normally distributed.  
#### Residual diagnostics for ARIMA model with exogenous variables
![32](https://user-images.githubusercontent.com/5343403/34076261-0ab69ba4-e2a6-11e7-9e67-d82508dcd775.png)  
Regression errors and ARIMA errors from the fitted model.  
The residuals of the ARIMA model should look like white noise. Our residuals do not perfectly look like white noise. Our model had a regression component and an ARIMA component.  

![33](https://user-images.githubusercontent.com/5343403/34076262-0acddfda-e2a6-11e7-8897-9d3d9dcfc116.png)  
Residual diagnostics for ARIMA model for San Juan.  
When we look at our residuals, we can see that the residuals are not white noise. Ther are some lags in our ACF plot are well outside our critical values. There was a lag within the first few lags that went outside our critical point. Our residual almost normally distributed. The AIC score for our ARIMA model is more than that for Negative Binomial model.  

![34](https://user-images.githubusercontent.com/5343403/34076263-0ae46dcc-e2a6-11e7-9993-4a121e111281.png)  
Regression errors and ARIMA errors from the fitted model.  
We can see that our residuals for our ARIMA model is not a perfect white noise. Our ARIMA had a regression component and a ARIMA component.  

![35](https://user-images.githubusercontent.com/5343403/34076264-0afb3e8a-e2a6-11e7-8dba-a762f9424152.png)  
Residual diagnostics for ARIMA model for Iquitos.  
From the above figure, we can see that our residual are not white noise. The leading lag for our model was well outside our critical value. Our residuals were somewhat normally distributed with some values reaching far at the corners.  



