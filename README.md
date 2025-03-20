# Factors Associated With Stunting Among Under-Five Children in Nigeria

## Table of Contents

1. [Project Overview](#project-overview)
2. [Data Sources](#data-sources)
3. [Tools](#tools)
4. [Data Cleaning or Preparation](#data-cleaning-or-preparation)
5. [Data Management](#data-management)
6. [Exploratory Data Analysis](#exploratory-data-analysis)
7. [Data Analysis](#data-analysis)
8. [Results or Findings](#results-or-findings)
9. [Recommendations](#recommendations)
10. [Limitations](#limitations)

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

### Data Cleaning or Preparation

In the initial data preparation we performed phase,the following tasks:

1. Looking for Variables Codes in NDHS
2. Opening of Log Book

```
log using proj.log,replace
```

3. Data Management

- Renaming of Individual Codes

```
rename hw1 child_age
rename b4 child_sex
rename m18 birth_size
```

- Renaming of Maternal Codes

```
rename v212 maternal_age
rename b11 birth_int
```

- Renaming of Community Codes

```
rename v024 region
rename v025 residence
```

- Renaming of intervening variables

```
rename v159 freq_watch_tv
rename v158 freq_list_radio
rename v157 freq_read_news
rename v467d dist_health_facility
```

- Keeping of Variables

```
keep stunt v005 v001 v002 child_age child_sex birth_size maternal_age birth_int no_under_5 level_edu wealth_index fam_size region residence freq_watch_tv freq_list_radio freq_read_news dist_health_facility
```

- Frequency Dist Table

  ```
tab1 child_age child_sex birth_size maternal_age birth_int no_under_5 level_edu wealth_index fam_size region residence freq_watch_tv freq_list_radio freq_read_news dist_health_facility
```

- Checking for number lable

```
tab freq_watch_tv,nol
tab freq_list_radio,nol
tab freq_read_news,nol
tab dist_health_facility,nol
```

- Treatment of Missing Values

```
replace birth_size=. if birth_size==8|birth_size==9
replace freq_watch_tv=. if freq_watch_tv==9
replace freq_list_radio=. if freq_list_radio==9
replace freq_read_news=. if freq_read_news==9
replace dist_health_facility=. if dist_health_facility==9
```


- Generating of Intervening Variables

```
egen media_exposure = rowmax( freq_read_news freq_list_radio freq_watch_tv )
lab def media_exposure 0 "No exposure" 1 "Low exposure" 2 "High exposure"
lab val media_exposure media_exposure
```

- Recoding of Variables

```
recode child_age(min/11=1 "<12 months")(12/23=2 "12-23 months")(24/59=3 "24-59 months"), gen(child_age2)
recode maternal_age(min/19=1 "< 20 yrs") (20/29=2 "20-29 yrs") (30/39=3 "30-39 yrs")(40/max=4 "40 yrs+"),gen(maternal_age2)
recode no_under_5(0/2=1 "<=2 (small size)")(3/6=2 "3-6(average size)")(7/max=3 ">=4(large)"), gen(num_under_5)
recode fam_size(min/3=1 "<=3(small size)")(4/6=2 "4-6(medium size)")(7/max=3 ">=7(large size)"), gen(fam_size2)
recode birth_int(min/11=1 "<12 months")(12/23=2 "12-23 months")(24/47=3 "24-47 months")(48/max=4 "48 months+"),gen(birth_int2)
```

- Applying of Weight to Dataset

```
gen wgt = v005/1000000
svyset[pw=wgt],psu(v001)strata(v002)singleunit(center)
```

### Exploratory Data Analysis

EDA involved explaining the nutrition data to answer the key questions as:

- What is the prevalence of stunting among the children aged below five years?
- What is the socio-demographic and economic characteristics of households of children aged below five years?
- What is the influence of individual, maternal, household and community level factors on stunting among under-five children?

### Data Analysis

The code of the univariate analysis includes:

- Percentage Distribution of Stunting by Individual Factors

```
tab child_age2[aw=wgt]
tab child_sex[aw=wgt]
tab birth_size[aw=wgt]
```

- Percentage Distribution of Stunting by Maternal Factors

```
tab maternal_age2[aw=wgt]
tab birth_int2[aw=wgt]
tab level_edu[aw=wgt
```
- Percentage Distribution of Stunting by Household Factors

```
tab num_under_5[aw=wgt]
tab wealth_index[aw=wgt]
tab fam_size2[aw=wgt]
```
- Percentage Distribution of Stunting by Community Factors

```
tab region[aw=wgt]
tab residence[aw=wgt]
```

The code of the bivariate analysis includes:

- Cross tabulation of stunting by individual factors

``` 
svy:tab child_age2 stunt,per obs row
svy:tab child_sex stunt,per obs col
svy:tab birth_size stunt,per obs row
```

- Cross tabulation of stunting by maternal factors

```
svy:tab maternal_age2 stunt,per obs row
svy:tab birth_int2 stunt,per obs row
svy:tab level_edu stunt,per obs row
```

- Cross tabulation of stunting by household factors

```
svy:tab num_under_5 stunt,per obs row
svy:tab wealth_index stunt,per obs row
svy:tab fam_size2 stunt,per obs row
```

- Cross tabulation of stunting by community factors

```
svy:tab region stunt,per obs row
svy:tab residence stunt,per obs row
```

The code of the multivariate analysis includes:

- Influence of Individual level factors on stunting

```
svy:logistic stunt i.child_age2 i.child_sex i.birth_size
```

- Influence of Maternal level factors on stunting

```
svy:logistic stunt i.maternal_age2 i.birth_int2
```

- Influence of Household level factors on stunting

```
svy:logistic stunt i.num_under_5 i.level_edu i.wealth_index i.fam_size2
```

- Influence of Community level factors on stunting

```
svy:logistic stunt i.region i.residence
```
- Influence of media exposure and distance to health facility on stunting

```
svy:logistic stunt i.media_exposure i.dist_health_facility
```

### Results or Findings
The analysis results are summarised as follows:

1. Age of under-five children (12-23 months) and (24-59 months) are significantly predict stunting of under-five children.
2. Being a female child significantly predict stunting.
3. Having under-five child size at birth to be average, smaller than average, very small significantly predict stunting.
4. Maternal age category of 20-29 yrs and 30-39 yrs significantly predict stunting.
5.Birth interval of 48 months and above significantly predict stunting.
6.Having highest educational attainment level as primary, secondary, tertiary significantly predict stunting.
7. Wealth index category in poorest, middle, richer, richest significantly predict stunting.
8.Regions North central, North east, North west, South east,South south,South west significantly predict stunting.
9.Residing in Urban and Rural areas significantly predict stunting.
10. Having low exposure and high exposure to mass media significantly predict stunting.
11. Not facing problems in accessing health facility significantly predict stunting.

### Data Visualizations
![STUNTING TRACKER 1](https://github.com/user-attachments/assets/1bd2d30f-61c3-4ba4-8e60-28fac231e06e)

### Recommendations
Based on the following analysis, we recommend the following actions:
- Targeted nutritional programmes in Rural areas and Northern Nigeria
- Promoting maternal education and mothers' training on child nutrition
- Improving the access to healthcare facilities
- Increasing the intensity in mass media campaign on child health
- Strengthen family planning services
- Implementing poverty alleviation programmes
- Regional development initiatives
