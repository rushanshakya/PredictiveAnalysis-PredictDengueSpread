#load the library
library(fpp)
library(dplyr)
library(corrplot)
library(ggplot2)
library(gridExtra)
library(MASS)


#set the current working directory
setwd("C:/Users/Rusan/Desktop/School/ISQS 6349 - Predictive Analysis/Project/DengiAI")

#reading the csv files
features_train<- read.csv('dengue_features_train.csv')
labels_train <- read.csv('dengue_labels_train.csv')

##Data cleaning

#check the structure of imported datasets
str(features_train)
str(labels_train)

View(features_train)
View(labels_train)

#merge the features and labels data
training_merged <- merge(features_train,labels_train)
View(training_merged)

#check summary for the training set
summary(training_merged)

#remove week_start_date variable from the merged datafame
training <- subset(training_merged, select= -c(week_start_date))

#seperate data by cities: San Juan sj and Iquito iq
iq_training <- filter(training, city == 'iq')
View(iq_training)

sj_training <- filter(training, city == 'sj')
View(sj_training)

#Check null values
apply(training_merged, 2, function(x) 
  round(100 * (length(which(is.na(x))))/length(x) , digits = 1)) %>%
  as.data.frame() %>% `names<-`('Percent of Missing Values')

#replace NAs with the mean values
iq_training$ndvi_ne[which(is.na(iq_training$ndvi_ne))] <- mean(iq_training$ndvi_ne, na.rm=TRUE)
iq_training$ndvi_nw[which(is.na(iq_training$ndvi_nw))] <- mean(iq_training$ndvi_nw, na.rm=TRUE)
iq_training$ndvi_se[which(is.na(iq_training$ndvi_se))] <- mean(iq_training$ndvi_se, na.rm=TRUE)
iq_training$ndvi_sw[which(is.na(iq_training$ndvi_sw))] <- mean(iq_training$ndvi_sw, na.rm=TRUE)
iq_training$precipitation_amt_mm[which(is.na(iq_training$precipitation_amt_mm))] <- mean(iq_training$precipitation_amt_mm, na.rm=TRUE)
iq_training$reanalysis_air_temp_k[which(is.na(iq_training$reanalysis_air_temp_k))] <- mean(iq_training$reanalysis_air_temp_k, na.rm=TRUE)
iq_training$reanalysis_avg_temp_k[which(is.na(iq_training$reanalysis_avg_temp_k))] <- mean(iq_training$reanalysis_avg_temp_k, na.rm=TRUE)
iq_training$reanalysis_dew_point_temp_k[which(is.na(iq_training$reanalysis_dew_point_temp_k))] <- mean(iq_training$reanalysis_dew_point_temp_k, na.rm=TRUE)
iq_training$reanalysis_max_air_temp_k[which(is.na(iq_training$reanalysis_max_air_temp_k))] <- mean(iq_training$reanalysis_max_air_temp_k, na.rm=TRUE)
iq_training$reanalysis_min_air_temp_k[which(is.na(iq_training$reanalysis_min_air_temp_k))] <- mean(iq_training$reanalysis_min_air_temp_k, na.rm=TRUE)
iq_training$reanalysis_precip_amt_kg_per_m2[which(is.na(iq_training$reanalysis_precip_amt_kg_per_m2))] <- mean(iq_training$reanalysis_precip_amt_kg_per_m2, na.rm=TRUE)
iq_training$reanalysis_relative_humidity_percent[which(is.na(iq_training$reanalysis_relative_humidity_percent))] <- mean(iq_training$reanalysis_relative_humidity_percent, na.rm=TRUE)
iq_training$reanalysis_sat_precip_amt_mm[which(is.na(iq_training$reanalysis_sat_precip_amt_mm))] <- mean(iq_training$reanalysis_sat_precip_amt_mm, na.rm=TRUE)
iq_training$reanalysis_specific_humidity_g_per_kg[which(is.na(iq_training$reanalysis_specific_humidity_g_per_kg))] <- mean(iq_training$reanalysis_specific_humidity_g_per_kg, na.rm=TRUE)
iq_training$reanalysis_tdtr_k[which(is.na(iq_training$reanalysis_tdtr_k))] <- mean(iq_training$reanalysis_tdtr_k, na.rm=TRUE)
iq_training$station_avg_temp_c[which(is.na(iq_training$station_avg_temp_c))] <- mean(iq_training$station_avg_temp_c, na.rm=TRUE)
iq_training$station_diur_temp_rng_c[which(is.na(iq_training$station_diur_temp_rng_c))] <- mean(iq_training$station_diur_temp_rng_c, na.rm=TRUE)
iq_training$station_max_temp_c[which(is.na(iq_training$station_max_temp_c))] <- mean(iq_training$station_max_temp_c, na.rm=TRUE)
iq_training$station_min_temp_c[which(is.na(iq_training$station_min_temp_c))] <- mean(iq_training$station_min_temp_c, na.rm=TRUE)
iq_training$station_precip_mm[which(is.na(iq_training$station_precip_mm))] <- mean(iq_training$station_precip_mm, na.rm=TRUE)

sj_training$ndvi_ne[which(is.na(sj_training$ndvi_ne))] <- mean(sj_training$ndvi_ne, na.rm=TRUE)
sj_training$ndvi_nw[which(is.na(sj_training$ndvi_nw))] <- mean(sj_training$ndvi_nw, na.rm=TRUE)
sj_training$ndvi_se[which(is.na(sj_training$ndvi_se))] <- mean(sj_training$ndvi_se, na.rm=TRUE)
sj_training$ndvi_sw[which(is.na(sj_training$ndvi_sw))] <- mean(sj_training$ndvi_sw, na.rm=TRUE)
sj_training$precipitation_amt_mm[which(is.na(sj_training$precipitation_amt_mm))] <- mean(sj_training$precipitation_amt_mm, na.rm=TRUE)
sj_training$reanalysis_air_temp_k[which(is.na(sj_training$reanalysis_air_temp_k))] <- mean(sj_training$reanalysis_air_temp_k, na.rm=TRUE)
sj_training$reanalysis_avg_temp_k[which(is.na(sj_training$reanalysis_avg_temp_k))] <- mean(sj_training$reanalysis_avg_temp_k, na.rm=TRUE)
sj_training$reanalysis_dew_point_temp_k[which(is.na(sj_training$reanalysis_dew_point_temp_k))] <- mean(sj_training$reanalysis_dew_point_temp_k, na.rm=TRUE)
sj_training$reanalysis_max_air_temp_k[which(is.na(sj_training$reanalysis_max_air_temp_k))] <- mean(sj_training$reanalysis_max_air_temp_k, na.rm=TRUE)
sj_training$reanalysis_min_air_temp_k[which(is.na(sj_training$reanalysis_min_air_temp_k))] <- mean(sj_training$reanalysis_min_air_temp_k, na.rm=TRUE)
sj_training$reanalysis_precip_amt_kg_per_m2[which(is.na(sj_training$reanalysis_precip_amt_kg_per_m2))] <- mean(sj_training$reanalysis_precip_amt_kg_per_m2, na.rm=TRUE)
sj_training$reanalysis_relative_humidity_percent[which(is.na(sj_training$reanalysis_relative_humidity_percent))] <- mean(sj_training$reanalysis_relative_humidity_percent, na.rm=TRUE)
sj_training$reanalysis_sat_precip_amt_mm[which(is.na(sj_training$reanalysis_sat_precip_amt_mm))] <- mean(sj_training$reanalysis_sat_precip_amt_mm, na.rm=TRUE)
sj_training$reanalysis_specific_humidity_g_per_kg[which(is.na(sj_training$reanalysis_specific_humidity_g_per_kg))] <- mean(sj_training$reanalysis_specific_humidity_g_per_kg, na.rm=TRUE)
sj_training$reanalysis_tdtr_k[which(is.na(sj_training$reanalysis_tdtr_k))] <- mean(sj_training$reanalysis_tdtr_k, na.rm=TRUE)
sj_training$station_avg_temp_c[which(is.na(sj_training$station_avg_temp_c))] <- mean(sj_training$station_avg_temp_c, na.rm=TRUE)
sj_training$station_diur_temp_rng_c[which(is.na(sj_training$station_diur_temp_rng_c))] <- mean(sj_training$station_diur_temp_rng_c, na.rm=TRUE)
sj_training$station_max_temp_c[which(is.na(sj_training$station_max_temp_c))] <- mean(sj_training$station_max_temp_c, na.rm=TRUE)
sj_training$station_min_temp_c[which(is.na(sj_training$station_min_temp_c))] <- mean(sj_training$station_min_temp_c, na.rm=TRUE)
sj_training$station_precip_mm[which(is.na(sj_training$station_precip_mm))] <- mean(sj_training$station_precip_mm, na.rm=TRUE)

#check null values
apply(sj_training, 2, function(x) 
  round(100 * (length(which(is.na(x))))/length(x) , digits = 1)) %>%
  as.data.frame() %>% `names<-`('Percent of Missing Values')

apply(sj_training, 2, function(x) 
  round(100 * (length(which(is.na(x))))/length(x) , digits = 1)) %>%
  as.data.frame() %>% `names<-`('Percent of Missing Values')

###Data Visualization

#look for correlation beween numeric variables
sj_training[sapply(sj_training,is.numeric)] %>% 
  dplyr::select(-year) %>%
  cor(use = 'pairwise.complete.obs') -> sj_cor

iq_training[sapply(iq_training,is.numeric)] %>% 
  dplyr::select(-year) %>%
  cor(use = 'pairwise.complete.obs') -> iq_cor

#visualizing using the correaltion plot
corrplot(iq_cor, type="full", method ="color", title = "Iquitos' correlatoin plot", mar=c(0,0,1,0), tl.cex= 0.8, outline= T, tl.col="indianred4")
corrplot(sj_cor, type="full", method ="color", title = "San Juans' correlatoin plot", mar=c(0,0,1,0), tl.cex= 0.8, outline= T, tl.col="indianred4")

# see the correlations as barplot
View(sj_cor)
sort(sj_cor[22,-22]) %>%  
  as.data.frame %>% 
  `names<-`('correlation') %>%
  ggplot(aes(x = reorder(row.names(.), -correlation), y = correlation, fill = correlation)) + 
  geom_bar(stat='identity', colour = 'black') + scale_fill_continuous(guide = FALSE) + scale_y_continuous(limits =  c(-.15,.25)) +
  labs(title = 'San Jose\n Correlations', x = NULL, y = NULL) + coord_flip() -> cor1

# can use ncol(M1) instead of 21 to generalize the code
sort(iq_cor[22,-22]) %>%  
  as.data.frame %>% 
  `names<-`('correlation') %>%
  ggplot(aes(x = reorder(row.names(.), -correlation), y = correlation, fill = correlation)) + 
  geom_bar(stat='identity', colour = 'black') + scale_fill_continuous(guide = FALSE) + scale_y_continuous(limits =  c(-.15,.25)) +
  labs(title = 'Iquitos\n Correlations', x = NULL, y = NULL) + coord_flip() -> cor2

#show correlation barplot in grid
grid.arrange(cor1, cor2, nrow = 1)

#Boxplots
iq_training %>% select(total_cases, reanalysis_specific_humidity_g_per_kg,  
                         reanalysis_dew_point_temp_k,
                         station_max_temp_c,
                         reanalysis_max_air_temp_k,
                         weekofyear,
                         reanalysis_tdtr_k) -> selvar1
selvar1 %>% select(total_cases, reanalysis_specific_humidity_g_per_kg,station_max_temp_c,reanalysis_tdtr_k) %>% boxplot(ylim=c(0,60), las=2)
selvar1 %>% select(reanalysis_dew_point_temp_k,reanalysis_max_air_temp_k) %>% boxplot(las=2)


sj_training %>% select(total_cases, reanalysis_specific_humidity_g_per_kg,  
                       reanalysis_dew_point_temp_k,
                       station_max_temp_c,
                       reanalysis_max_air_temp_k,
                       weekofyear,
                       reanalysis_tdtr_k) -> selvar2
selvar2 %>% select(total_cases, reanalysis_specific_humidity_g_per_kg,station_max_temp_c,reanalysis_tdtr_k) %>% boxplot(ylim=c(0,100), las=2)
selvar2 %>% select(reanalysis_dew_point_temp_k,reanalysis_max_air_temp_k) %>% boxplot(las=2)

##Predictive Analysis

#Multiple Linear Regression

#San Juan
sj.model1 <- glm(total_cases~ reanalysis_specific_humidity_g_per_kg + 
                reanalysis_dew_point_temp_k  + 
                #reanalysis_relative_humidity_percent +
                #station_min_temp_c + 
                #reanalysis_min_air_temp_k + 
                #reanalysis_avg_temp_k + 
                #station_min_temp_c +
                #reanalysis_air_temp_k +
                station_max_temp_c + 
                #reanalysis_max_air_temp_k +
                #station_avg_temp_c +
                #weekofyear +
                reanalysis_tdtr_k, 
              data=sj_training)
summary(sj.model1)

# plot sj
sj_training$LRfitted <- predict(sj.model1, sj_training, type = 'response')
head(sj_training)
str(sj_training)
sj_train <- mutate(sj_training, index = as.numeric(row.names(sj_training)))

ggplot(sj_train, aes(x = index)) + ggtitle("San Jose") +
  geom_line(aes(y = total_cases, colour = "total_cases")) + 
  geom_line(aes(y = LRfitted, colour = "LRfitted"))

#Iquitos
iq.model1 <- glm(total_cases~ reanalysis_specific_humidity_g_per_kg + 
                reanalysis_dew_point_temp_k, 
              #reanalysis_relative_humidity_percent +
              #station_min_temp_c, 
              #reanalysis_min_air_temp_k + 
              #reanalysis_avg_temp_k + 
              #station_min_temp_c +
              #reanalysis_air_temp_k +
              #station_max_temp_c, 
              #reanalysis_max_air_temp_k +
              #station_avg_temp_c +
              #weekofyear,
              #reanalysis_tdtr_k, 
              data=iq_training)
summary(iq.model1)

#plot iq
iq_training$LRfitted <- predict(iq.model1, iq_training, type = 'response')
head(iq_training)
str(iq_training)

iq_train <- mutate(iq_training, index = as.numeric(row.names(iq_training)))

ggplot(iq_train, aes(x = index)) + ggtitle("Iquitos") +
  geom_line(aes(y = total_cases, colour = "total_cases")) + 
  geom_line(aes(y = LRfitted, colour = "LRfitted"))

#Negative Binomial Regression

sj.model2 <- glm.nb(total_cases~ reanalysis_specific_humidity_g_per_kg + 
                   reanalysis_dew_point_temp_k  + 
                   #reanalysis_relative_humidity_percent +
                   #station_min_temp_c + 
                   #reanalysis_min_air_temp_k + 
                   #reanalysis_avg_temp_k + 
                   #station_min_temp_c +
                   #reanalysis_air_temp_k +
                   station_max_temp_c + 
                   #reanalysis_max_air_temp_k +
                   #station_avg_temp_c +
                   weekofyear +
                   reanalysis_tdtr_k, 
                 data=sj_training)
summary(sj.model2)

# plot sj
sj_train$NBfitted <- predict(sj.model2, sj_training, type = 'response')
head(sj_train)
str(sj_train)

ggplot(sj_train, aes(x = index)) + ggtitle("San Jose") +
  geom_line(aes(y = total_cases, colour = "total_cases")) + 
  geom_line(aes(y = NBfitted, colour = "NBfitted"))

iq.model2 <- glm.nb(total_cases~ reanalysis_specific_humidity_g_per_kg + 
                 reanalysis_dew_point_temp_k,
                 #reanalysis_relative_humidity_percent +
                 #reanalysis_min_air_temp_k + 
                 #reanalysis_avg_temp_k + 
                 #station_min_temp_c,
                 #reanalysis_air_temp_k +
                 #reanalysis_max_air_temp_k +
                 #station_avg_temp_c +
                 #weekofyear +
                 #reanalysis_tdtr_k +
                 #station_max_temp_c , 
                 data=iq_training)
summary(iq.model2)

# plot iq
iq_train$NBfitted <- predict(iq.model2, iq_training, type = 'response')
tail(iq_train)
str(iq_train)

ggplot(iq_train, aes(x = index)) + ggtitle("Iquitos") +
  geom_line(aes(y = total_cases, colour = "total_cases")) + 
  geom_line(aes(y = NBfitted, colour = "NBfitted"))

#residuals
plot(sj.model2)
plot(iq.model2)

##Linear regression with time series

#selecting the regressors for times series analysis

 sj_training %>% dplyr:: select(total_cases, reanalysis_specific_humidity_g_per_kg, 
                                  reanalysis_dew_point_temp_k,
                                  station_max_temp_c,
                                  reanalysis_tdtr_k) -> ts_sj_training
 
 iq_training %>% dplyr:: select(total_cases, reanalysis_specific_humidity_g_per_kg, 
                                reanalysis_dew_point_temp_k) -> ts_iq_training

#Create time series objects  
ts_sj <- ts(ts_sj_training, frequency=52, start=c(1990,18))
plot(ts_sj)
Acf(ts_sj)

ts_iq <- ts(ts_iq_training, frequency=52, start=c(1990,18))
plot(ts_iq)
Acf(ts_iq)

#San Juan
sj.model3 <- forecast::tslm(total_cases~ reanalysis_specific_humidity_g_per_kg + 
                            reanalysis_dew_point_temp_k +
                            station_max_temp_c +
                            reanalysis_tdtr_k, data=ts_sj)
summary(sj.model3)

# evalute for autocorrelation
checkresiduals(sj.model3)
dwtest(sj.model3, alt="two.sided")
bgtest(sj.model3, 10)

#plotting actual vs predicted
sj_train$TSLMfitted <- predict(sj.model3, sj_training, type = 'response')
head(sj_train)
str(sj_train)

ggplot(sj_train, aes(x = index)) + ggtitle("San Jose") +
  geom_line(aes(y = total_cases, colour = "total_cases")) + 
  geom_line(aes(y = TSLMfitted, colour = "TSLMfitted"))

#Iquitos
iq.model3 <- forecast::tslm(total_cases~ reanalysis_specific_humidity_g_per_kg + 
                              reanalysis_dew_point_temp_k, data=ts_iq)
summary(iq.model3)

# evalute for autocorrelation
checkresiduals(iq.model3)
dwtest(iq.model3, alt="two.sided")
bgtest(iq.model3, 10)

#plotting actual vs predicted
iq_train$TSLMfitted <- predict(iq.model3, iq_training, type = 'response')
head(iq_train)
str(iq_train)

ggplot(iq_train, aes(x = index)) + ggtitle("Iquitos") +
  geom_line(aes(y = total_cases, colour = "total_cases")) + 
  geom_line(aes(y = TSLMfitted, colour = "TSLMfitted"))

##ARIMA

View(ts_sj)
head(ts_iq)
ts_sj[,2:5]

#fit ARIMA model
sj.model4 <- auto.arima(ts_sj[,1], xreg=ts_sj[,2:5])
summary(sj.model4)

iq.model4 <- auto.arima(ts_iq[,1], xreg=ts_iq[,2:3])
summary(iq.model4)

#plotting actual vs predicted for San Juan
autoplot(ts_sj[,'total_cases'], series="Actual") +
  forecast::autolayer(fitted(sj.model4), series="Fitted") +
  ylab("total_cases") +
  ggtitle("San Juan") +
  guides(colour=guide_legend(title=" "))

#plotting actual vs predicted for Iquitos
autoplot(ts_iq[,'total_cases'], series="Actual") +
  forecast::autolayer(fitted(iq.model4), series="Fitted") +
  ylab("total_cases") +
  ggtitle("Iquitos") +
  guides(colour=guide_legend(title=" "))

#check residuals
checkresiduals(sj.model4)
checkresiduals(iq.model4)

#compare ARIMA residuals vs Linear Regression
cbind("Regression Errors" = residuals(sj.model4, type="regression"),
      "ARIMA errors" = residuals(sj.model4, type="innovation")) %>%
  autoplot(facets=TRUE) + ggtitle("San Juan")

cbind("Regression Errors" = residuals(iq.model4, type="regression"),
      "ARIMA errors" = residuals(iq.model4, type="innovation")) %>%
  autoplot(facets=TRUE) + ggtitle("Iquitos")

#submitting ARIMA forecast
tests <- read.csv('dengue_features_test.csv')
str(tests)
sj_test <- dplyr::filter(tests, city=='sj')
iq_test <- dplyr::filter(tests, city=='iq')
View(sj_test)

sj_test %>% dplyr::select(reanalysis_specific_humidity_g_per_kg, 
                          reanalysis_dew_point_temp_k, station_max_temp_c, reanalysis_tdtr_k) -> xreg1
str(xreg1)

iq_test %>% dplyr:: select(reanalysis_specific_humidity_g_per_kg, 
                           reanalysis_dew_point_temp_k) -> xreg2
str(xreg2)

sj_test$predicted <- round(forecast(sj.model4, xreg=xreg1)$mean)
iq_test$predicted <- round(forecast(iq.model4, xreg=xreg2)$mean)

write.csv(sj_test, 'sj_test.csv', row.names = FALSE)
write.csv(iq_test, 'iq_test.csv', row.names= FALSE)

dengu <- read.csv('sj_test.csv')
View(dengu)
submission <- read.csv('submission_format.csv')
View(submission)
predictions <- inner_join(submission, dengu)
View(predictions)

write.csv(predictions, 'predictions.csv', row.names = FALSE)
