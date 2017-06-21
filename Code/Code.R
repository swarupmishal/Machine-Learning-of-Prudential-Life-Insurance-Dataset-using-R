#Install required package
install.packages("forecast")
install.packages("ade4")
install.packages("forecastHybrid")

library(forecast)
library(ade4)
library(e1071)
library(ggplot2)
library("rpart")
library("rpart.plot")

getwd()
setwd("E:/ADS/MidTerm Project")

# Read CSV into R
mydata <- read.csv(file="train.csv", header=TRUE, sep=",")
options(max.print=1000000)

#Pre-processing starts here
#Deleting columns with empty cells more than 60%
mydata$Family_Hist_3 <- NULL
mydata$Family_Hist_5 <- NULL
mydata$Medical_History_10 <- NULL
mydata$Medical_History_15 <- NULL
mydata$Medical_History_24 <- NULL
mydata$Medical_History_32 <- NULL
mydata$Id <- NULL

#Getting list of columns having missing values
mylist <- c(unlist(lapply(mydata, function(x) any(is.na(x)))))
View(mylist)

#Filling missing values with mean value for Employment_Info_1
mydata$Employment_Info_1[is.na(mydata$Employment_Info_1)] <- mean(mydata$Employment_Info_1, na.rm = T)
#Filling missing values with mean value for Employment_Info_4
mydata$Employment_Info_4[is.na(mydata$Employment_Info_4)] <- mean(mydata$Employment_Info_4, na.rm = T)
#Filling missing values with mean value for Employment_Info_6
mydata$Employment_Info_6[is.na(mydata$Employment_Info_6)] <- mean(mydata$Employment_Info_6, na.rm = T)
#Filling missing values with mean value for Insurance_History_5
mydata$Insurance_History_5[is.na(mydata$Insurance_History_5)] <- mean(mydata$Insurance_History_5, na.rm = T)
#Filling missing values with mean value for Family_Hist_2
mydata$Family_Hist_2[is.na(mydata$Family_Hist_2)] <- mean(mydata$Family_Hist_2, na.rm = T)
#Filling missing values with mean value for Family_Hist_4
mydata$Family_Hist_4[is.na(mydata$Family_Hist_4)] <- mean(mydata$Family_Hist_4, na.rm = T)
#Filling missing values with mean value for Medical_History_1
mydata$Medical_History_1[is.na(mydata$Medical_History_1)] <- mean(mydata$Medical_History_1, na.rm = T)

#Convert Categorical using 1 to C Coding
data_ctgr <- mydata[c("Medical_History_1","Product_Info_1", "Product_Info_2", "Product_Info_3", "Product_Info_5", "Product_Info_6", "Product_Info_7", "Employment_Info_2", "Employment_Info_3", "Employment_Info_5", "InsuredInfo_1", "InsuredInfo_2", "InsuredInfo_3", "InsuredInfo_4", "InsuredInfo_5", "InsuredInfo_6", "InsuredInfo_7", "Insurance_History_1", "Insurance_History_2", "Insurance_History_3", "Insurance_History_4", "Insurance_History_7", "Insurance_History_8", "Insurance_History_9", "Family_Hist_1", "Medical_History_2", "Medical_History_3", "Medical_History_4", "Medical_History_5", "Medical_History_6", "Medical_History_7", "Medical_History_8", "Medical_History_9", "Medical_History_11", "Medical_History_12", "Medical_History_13", "Medical_History_14", "Medical_History_16", "Medical_History_17", "Medical_History_18", "Medical_History_19", "Medical_History_20", "Medical_History_21", "Medical_History_22", "Medical_History_23", "Medical_History_25", "Medical_History_26", "Medical_History_27", "Medical_History_28", "Medical_History_29", "Medical_History_30", "Medical_History_31", "Medical_History_33", "Medical_History_34", "Medical_History_35", "Medical_History_36", "Medical_History_37", "Medical_History_38", "Medical_History_39", "Medical_History_40", "Medical_History_41")]
OneToCconv <- acm.disjonctif(data_ctgr)

#Prepare the data 
data_cntg <- mydata[c("Product_Info_4", "Ins_Age", "Ht", "Wt", "BMI", "Employment_Info_1", "Employment_Info_4", "Employment_Info_6", "Insurance_History_5", "Family_Hist_2", "Family_Hist_4")]
data_dummy<-mydata[c("Medical_Keyword_1","Medical_Keyword_2","Medical_Keyword_3","Medical_Keyword_4","Medical_Keyword_5","Medical_Keyword_6","Medical_Keyword_7","Medical_Keyword_8","Medical_Keyword_9","Medical_Keyword_10","Medical_Keyword_11","Medical_Keyword_12","Medical_Keyword_13","Medical_Keyword_14","Medical_Keyword_15","Medical_Keyword_16","Medical_Keyword_17","Medical_Keyword_18","Medical_Keyword_19", "Medical_Keyword_20", "Medical_Keyword_21", "Medical_Keyword_22", "Medical_Keyword_23","Medical_Keyword_24", "Medical_Keyword_25", "Medical_Keyword_26", "Medical_Keyword_27", "Medical_Keyword_28", "Medical_Keyword_29","Medical_Keyword_30", "Medical_Keyword_31", "Medical_Keyword_32", "Medical_Keyword_33","Medical_Keyword_34", "Medical_Keyword_35","Medical_Keyword_36", "Medical_Keyword_37", "Medical_Keyword_38", "Medical_Keyword_39", "Medical_Keyword_40", "Medical_Keyword_41", "Medical_Keyword_42", "Medical_Keyword_43", "Medical_Keyword_44", "Medical_Keyword_45","Medical_Keyword_46", "Medical_Keyword_47","Medical_Keyword_48")]
final_data <- data.frame(c(OneToCconv, data_cntg,data_dummy))

#Linear Regression
#Apply PCA for dimensionality reduction
final_pca_data <- prcomp(final_data)
summary(final_pca_data)

#Pick 95% of variance of data using PCA
final_pca_data_trimmed <- data.frame(final_pca_data$x[,1:116])

#Append Response variable to the dataset
pcaYVar <- data.frame(c(final_pca_data_trimmed, original_data[c("Response")]))
pcaYVar$Response<-as.numeric(pcaYVar$Response)

#Divide given dataset to test and train
train <-pcaYVar[1:49382,]
test <- pcaYVar[49383:59382,]

#Applying Linear Regression
lm_model <-lm(Response ~., data =train)

summary(lm_model)

#Predict Response Variable
pred <- predict(lm_model, test)

#Calculate accuracy
accuracy(pred,test$Response)

#Plot response distribution for test and train
qplot(Response, data=test, geom="density", alpha=I(.5), fill="density",
                   main="Distribution of Response on test data", xlab="Response", 
                   ylab="Density")
qplot(Response, data=train, geom="density", alpha=I(.5), 
      main="Distribution of Response on train data", xlab="Response", 
      ylab="Density")

---------------------------------------------------------------------------------------------
#SVM Regression
  
#Calculating PCA for final consolidated data.
final_pca_data <- prcomp(final_data)

#Examining the data for summary.
summary(final_pca_data)

#After manual observing PCA Components, We decided to take first 75 PCA Components showing 90% Cumulative proportion of Variance.
final_pca_data_trimmed <- data.frame(final_pca_data$x[,1:75])
#Concatenated the final data frame with response column.
pcaYVar <- data.frame(c(final_pca_data_trimmed, mydata[c("Response")]))

#As Response is numeric, we made it as numeric.
pcaYVar$Response<-as.numeric(pcaYVar$Response)

# Divided the data with train data and test data keeping last 10000 records for test data.
train<-pcaYVar[1:49382,]
test<-pcaYVar[49383:59382,]

#Tuning SVM for finding best parameters for all possible 4 kernels.
obj<-tune(svm, Response~.,kernel ="radial", data= train, ranges=list(gamma=10^(-2:2), cost=10^(-2:2)))
summary(obj)

obj1<-tune(svm, Response~.,kernel ="linear", data= train, ranges=list(cost=10^(-2:2)))
summary(obj1)

obj2<-tune(svm, Response~.,kernel ="sigmoid", data= train, ranges=list(gamma=10^(-2:2), cost=10^(-2:2)))
summary(obj2)

obj3<-tune(svm, Response~.,kernel ="polynomial", data= train, ranges=list(gamma=10^(-2:2), cost=10^(-2:2)))
summary(obj3)

#Applying SVM with the best parameters we found after tuning. 
model1 = svm(Response ~ ., kernel = "radial", cost =1 ,gamma=0.01, data = train, scale = F)

# Predicting the Values using model created using SVM.
predictions <-  predict(model1, test[-76])

#Validating accuracy of predicted results.
accuracy(predictions,test$Response)

-------------------------------------------------------------------------------------------------------
# Decision Tree
  
pcaYVar <- data.frame(c(final_data, mydata[c("Response")]))
pcaYVar$Response<-as.numeric(pcaYVar$Response)

#Divide the given dataset
train<-pcaYVar[1:49382,]
test<-pcaYVar[49383:59382,]

#Generate the Decision Tree Regresssion
mytree <- rpart(Response ~ .,data = train, method = "anova", control=rpart.control(cp=0.01))
summary(mytree) # detailed summary of splits
printcp(mytree) # display the results 
plotcp(mytree) # visualize cross-validation results
prp(mytree)

#Predict the Response Variable
myprediction <- predict(mytree, test)
View(round(myprediction))

#Calculate accuracy
accuracy(myprediction,test$Response)

vector_id <- c(49383:59382)
mysolution <- data.frame(Id = vector_id, response = myprediction)

#Writing the output file
write.csv(mysolution, file = "D:/Spring 2017/ADS//Midterm Project/decision_tree_solution.csv",row.names=FALSE)
