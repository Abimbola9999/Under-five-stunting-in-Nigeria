# Factors Associated With Stunting Among Under-Five Children in Nigeria

### Project Overview

Stunting, a major indicator of chronic malnutrition, remains a significant public health concern in Nigeria, affecting the growth, development, and long-term well-being of children. This study aims to examine the factors associated with stunting among under-five children in Nigeria using data from the Nigeria Demographic and Health Survey (NDHS). The research explores the influence of individual, maternal, household, and community-level determinants on childhood stunting. Through statistical analysis in Stata, key risk factors such as maternal education, socioeconomic status, healthcare access, and regional disparities are assessed. Findings from this study will provide evidence-based recommendations to inform policies and interventions aimed at reducing child malnutrition in Nigeria.

### Data Sources

NGKRPR-nutrition: This study utilized the kids recode secondary data that was obtained as part of the 2018 Nigeria and Demographic Health Survey (NDHS), the dataset captured the variable stunt which gives reveals the child nutrtional status based on the height for age zscore.

### Tools

- Stata : Data Cleaning
- Stata : Data Analysis
- Excel : Charts
- Power bi : Visualization
- Microsoft Word : Writing reports and findings

### Data Cleaning/Preparation

In the initial data preparation we performed phase,the following tasks:
1. Looking for Variables Codes in NDHS
2. Opening of Log Book
3. Data Management
- Renaming of Variables
- Keeping of Variables
- Frequency Dist Table
- Checking for number lable
- Treatment of Missing Values
- Generating of Intervening Variables
- Recoding of Variables
- Applying of Weight to Dataset

### Exploratory Data Analysis
EDA involved explaining the nutrition data to answer the key questions as:

- What is the prevalence of stunting among the children aged below five years?
- What is the socio-demographic and economic characteristics of households of children aged below five years?
- What is the influence of individual, maternal, household and community level factors on stunting among under-five children?

### Data Analysis
The code of the univariate analysis includes:
```Percentage Distribution of Stunting by Individual Factors
tab child_age2[aw=wgt]
tab child_sex[aw=wgt]
tab birth_size[aw=wgt]
```
```Percentage Distribution of Stunting by Maternal Factors
tab maternal_age2[aw=wgt]
tab birth_int2[aw=wgt]
tab level_edu[aw=wgt
```
```Percentage Distribution of Stunting by Household Factors
tab num_under_5[aw=wgt]
tab wealth_index[aw=wgt]
tab fam_size2[aw=wgt]
```
```Percentage Distribution of Stunting by Community Factors
tab region[aw=wgt]
tab residence[aw=wgt]
```
The code of the bivariate analysis includes:
``` Cross tabulation of stunting by individual factors
svy:tab child_age2 stunt,per obs row
svy:tab child_sex stunt,per obs col
svy:tab birth_size stunt,per obs row
``` 
```Cross tabulation of stunting by maternal factors
svy:tab maternal_age2 stunt,per obs row
svy:tab birth_int2 stunt,per obs row
svy:tab level_edu stunt,per obs row
```
```Cross tabulation of stunting by household factors
svy:tab num_under_5 stunt,per obs row
svy:tab wealth_index stunt,per obs row
svy:tab fam_size2 stunt,per obs row
```
```Cross tabulation of stunting by community factors
svy:tab region stunt,per obs row
svy:tab residence stunt,per obs row
```
The code of the multivariate analysis includes:
```Influence of Individual level factors on stunting
svy:logistic stunt i.child_age2 i.child_sex i.birth_size
```
```Influence of Maternal level factors on stunting
svy:logistic stunt i.maternal_age2 i.birth_int2
```
```Influence of Household level factors on stunting
svy:logistic stunt i.num_under_5 i.level_edu i.wealth_index i.fam_size2
```
```Influence of Community level factors on stunting
svy:logistic stunt i.region i.residence
```
```Influence of media exposure and distance to health facility
svy:logistic stunt i.media_exposure i.dist_health_facility
```
### Results/Findings
The analysis results are summarised as follows:

### Data Visualizations


### Recommendations
Based on the following analysis, we recommend the following actions:
- Targeted nutritional programmes in Rural areas and Northern Nigeria
- Promoting maternal education and mothers' training on child nutrition
- Improving the access to healthcare facilities
- Increasing the intensity in mass media campaign on child health
- Strengthen family planning services
- Implementing poverty alleviation programmes
- Regional development initiatives
