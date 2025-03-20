/***************
FACTOS ASSOCIATED WITH STUNTING AMONG UNDER-FIVE CHILDREN IN NIGERIA
OREKUNRIN IBRAHIM ABIMBOLA 
DSS/2018/052 *****/

set maxvar 32000
set more off
pwd
cd "C:\Users\DELL\Desktop\Directory"
use 2NGKRPR-nutrition

/*Looking for Variables Codes in NDHS*/

/*Individual Variables*/
lookfor child age
lookfor child sex
lookfor birth size

/* Maternal Variables*/
lookfor maternal age
lookfor birth interval

/*Household Variables*/
lookfor number of under five
lookfor mothers level of education
lookfor wealth index
lookfor family size 

/*Community Variables*/
lookfor region
lookfor place of residence

/* Intervening Vriables*/
lookfor frequency of watching television
lookfor frequency of listening to radio
lookfor frequency of reading newspaper or magazine
lookfor distance to health facility

/*Opening of Log Book*/
log using proj.log,replace

/*Data Management*/

/*Renaming of Individual Codes*/
rename hw1 child_age
rename b4 child_sex
rename m18 birth_size

/*Renaming of Maternal Codes*/
rename v212 maternal_age
rename b11 birth_int

/*Renaming of Household Codes*/
rename v137 no_under_5
rename v106 level_edu
rename v190 wealth_index
rename v136 fam_size

/*Renaming of Community Codes*/
rename v024 region
rename v025 residence

/* Renaming of intervening variables*/
rename v159 freq_watch_tv
rename v158 freq_list_radio
rename v157 freq_read_news
rename v467d dist_health_facility

/*Keeping of Variables*/
keep stunt v005 v001 v002 child_age child_sex birth_size maternal_age birth_int no_under_5 level_edu wealth_index fam_size region residence freq_watch_tv freq_list_radio freq_read_news dist_health_facility

/*Frequency Dist Table*/
tab1 child_age child_sex birth_size maternal_age birth_int no_under_5 level_edu wealth_index fam_size region residence freq_watch_tv freq_list_radio freq_read_news dist_health_facility

/* Checking for number lable*/
tab freq_watch_tv,nol
tab freq_list_radio,nol
tab freq_read_news,nol
tab dist_health_facility,nol

/*Treatment of Missing Values*/
replace birth_size=. if birth_size==8|birth_size==9
replace freq_watch_tv=. if freq_watch_tv==9
replace freq_list_radio=. if freq_list_radio==9
replace freq_read_news=. if freq_read_news==9
replace dist_health_facility=. if dist_health_facility==9

/*Generating of Intervening Variables*/
egen media_exposure = rowmax( freq_read_news freq_list_radio freq_watch_tv )
lab def media_exposure 0 "No exposure" 1 "Low exposure" 2 "High exposure"
lab val media_exposure media_exposure

/*Recoding of Variables*/
recode child_age(min/11=1 "<12 months")(12/23=2 "12-23 months")(24/59=3 "24-59 months"), gen(child_age2)
recode maternal_age(min/19=1 "< 20 yrs") (20/29=2 "20-29 yrs") (30/39=3 "30-39 yrs")(40/max=4 "40 yrs+"),gen(maternal_age2)
recode no_under_5(0/2=1 "<=2 (small size)")(3/6=2 "3-6(average size)")(7/max=3 ">=4(large)"), gen(num_under_5)
recode fam_size(min/3=1 "<=3(small size)")(4/6=2 "4-6(medium size)")(7/max=3 ">=7(large size)"), gen(fam_size2)
recode birth_int(min/11=1 "<12 months")(12/23=2 "12-23 months")(24/47=3 "24-47 months")(48/max=4 "48 months+"),gen(birth_int2)

/*Applying of Weight to Dataset*/
/* Apply weigth to Data*/
gen wgt = v005/1000000
svyset[pw=wgt],psu(v001)strata(v002)singleunit(center)

/*Data Analysis*/
/*Univariate Analysis*/

/*Percentage Distribution by Child Age*/
tab child_age2[aw=wgt]
/*Percentage Distribution by Child Sex*/
tab child_sex[aw=wgt]
/*Percentage Distribution by Birth Size*/
tab birth_size[aw=wgt]
/*Percentage Distribution by Maternal Age*/
tab maternal_age2[aw=wgt]
/*Percentage Distribution by Birth Interval*/
tab birth_int2[aw=wgt]
/*Percentage Distribution of Number of Under-Five Children in a Household*/
tab num_under_5[aw=wgt]
/*Percentage Distribution of Level of Education*/
tab level_edu[aw=wgt]
/*Percentage Distribution of Wealth Index*/
tab wealth_index[aw=wgt]
/*Percentage Distribution of Family Size*/
tab fam_size2[aw=wgt]
/*Percentage Distribution of Region*/
tab region[aw=wgt]
/*Percentage Distribution of Residence*/
tab residence[aw=wgt]

/*Bivariate Analysis*/

/*Cross Tabulation of Stunting by Child Age*/
svy:tab child_age2 stunt,per obs row
/*Cross Tabulation of Stunting by Child Sex*/
svy:tab child_sex stunt,per obs col
/*Cross Tabulation of Stunting by Birth Size*/
svy:tab birth_size stunt,per obs row
/*Cross Tabulation of Stunting by Maternal Age*/
svy:tab maternal_age2 stunt,per obs row
/*Cross Tabulation of Stunting by Birth Interval*/
svy:tab birth_int2 stunt,per obs row
/*Cross Tabulation of Stunting by Number of Under-Five Children in a Household*/
svy:tab num_under_5 stunt,per obs row
/*Cross Tabulation of Stunting by Level of Education*/
svy:tab level_edu stunt,per obs row
/*Cross Tabulation of Stunting by Wealth Index*/
svy:tab wealth_index stunt,per obs row
/*Cross Tabulation of Stunting by Family Size*/
svy:tab fam_size2 stunt,per obs row
/*Cross Tabulation of Stunting by Region*/
svy:tab region stunt,per obs row
/*Cross Tabulation of Stunting by Residence*/
svy:tab residence stunt,per obs row

/*Multivariate Analysis*/

/*Binary Logistic Regression Analysis of Influence of Individual Level Factors on Stunting*/
svy:logistic stunt i.child_age2 i.child_sex i.birth_size
/*Binary Logistic Regression Analysis of Influence of Maternal Level Factors on Stunting*/
svy:logistic stunt i.maternal_age2 i.birth_int2
/*Binary Logistic Regression Analysis of Influence of Household Level Factors on Stunting*/
svy:logistic stunt i.num_under_5 i.level_edu i.wealth_index i.fam_size2
/*Binary Logistic Regression Analysis of Influence of Community Level Factors on Stunting*/
svy:logistic stunt i.region i.residence
/*Binary Logistic Regression Analysis of Selected Intervening Factors on Stunting*/ 
svy:logistic stunt i.media_exposure i.dist_health_facility
