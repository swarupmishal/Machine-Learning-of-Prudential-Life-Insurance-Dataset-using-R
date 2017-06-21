# Prudential Life Insurance Assessment Data (Kaggle)

![alt text](https://github.com/swarupmishal/Data-Science-Using-R/blob/master/Extras/front_page.png)

# What exactly the Data is?
In a one-click shopping world with on-demand everything, the life insurance application process is antiquated. Customers provide extensive information to identify risk classification and eligibility, including scheduling medical exams, a process that takes an average of 30 days.

The result? People are turned off. That’s why only 40% of U.S. households own individual life insurance. Prudential wants to make it quicker and less labor intensive for new and existing customers to get a quote while maintaining privacy boundaries.

By developing a predictive model that accurately classifies risk using a more automated approach, you can greatly impact public perception of the industry.

The results will help Prudential better understand the predictive power of the data points in the existing assessment, enabling us to significantly streamline the process.

In this dataset, you are provided over a hundred variables describing attributes of life insurance applicants. The task is to predict the "Response" variable for each Id in the test set. "Response" is an ordinal measure of risk that has 8 levels.

###### File descriptions

train.csv - the training set, contains the Response values

test.csv - the test set, you must predict the Response variable for all rows in this file

# How can one obtain the Data?
One can download the dataset using the following link:
https://www.kaggle.com/c/prudential-life-insurance-assessment/download/sample_submission.csv.zip

# How is the Data stored?
### Data fields

###### Variable	Description
Id	A unique identifier associated with an application.

Product_Info_1-7	A set of normalized variables relating to the product applied for

Ins_Age	Normalized age of applicant

Ht	Normalized height of applicant

Wt	Normalized weight of applicant

BMI	Normalized BMI of applicant

Employment_Info_1-6	A set of normalized variables relating to the employment history of the applicant.

InsuredInfo_1-6	A set of normalized variables providing information about the applicant.

Insurance_History_1-9	A set of normalized variables relating to the insurance history of the applicant.

Family_Hist_1-5	A set of normalized variables relating to the family history of the applicant.

Medical_History_1-41	A set of normalized variables relating to the medical history of the applicant.

Medical_Keyword_1-48	A set of dummy variables relating to the presence of/absence of a medical keyword being associated with the 
application.

Response	This is the target variable, an ordinal variable relating to the final decision associated with an application.

# How have we tackeled the problem.
Build linear regression, decision tree regression, and SVM regression models using the training data and then report the performance on the test data using the performance criteria as described in the site. Convert the categorical variables to their numerical representations using 0-to-C transformation. Fill in missing values of a column using 0, min, max, median, or average of the column.

### Pre-Processing
###### Pre-processing forms a major part of the data prediction which is done over a number of stages:
1. Handling Missing Values – 
    a. Deleted Columns – Missing values for a column over 60%
    b. Replace Missing values : Continuous Variables – average/mean value of column
2. 1 to C coding – Categorical -> Numerical
3. Normalization – Already normalized.
4. Dimensionality Reduction – Applied Principal Component Analysis

### Predict the response using different Regression techniques:
1. Linear Regression 
2. Support Vector Machine Regression 
3. Decision Tree Regression 

### Individual Accuracies:




# Predicted Output
[View the CSV file here](https://github.com/swarupmishal/Data-Science-Using-R/blob/master/Outputs/decision_tree_solution.csv)
