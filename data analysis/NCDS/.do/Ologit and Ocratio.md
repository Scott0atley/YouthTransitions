

 cd "C:\Users\scott\Desktop\Stata data and do\UKDA-5566-stata\stata\stata9"
 
 merge 1:1 ncdsid using ncds4
 drop _merge

///descriptive statistics
///Main Activity from March at 16- January at 17
gen econ194=.
replace econ194=. if (ec194==-1)
replace econ194=1 if (ec194==100)
replace econ194=1 if (ec194==101)
replace econ194=1 if (ec194==110)
replace econ194=1 if (ec194==120)
replace econ194=1 if (ec194==140)
replace econ194=1 if (ec194==150)
replace econ194=2 if (ec194==200)
replace econ194=3 if (ec194==500)
replace econ194=3 if (ec194==550)
replace econ194=4 if (ec194==600)
replace econ194=5 if (ec194==700)

label define econactivity_lbl 1"Full Time Employment" 2"Part Time Employment" 3"Education" 4"Unemployment" 5"Other"
label value econ194 econactivity_lbl

tab econ194

gen econ195=.
replace econ195=. if (ec195==-1)
replace econ195=1 if (ec195==100)
replace econ195=1 if (ec195==101)
replace econ195=1 if (ec195==110)
replace econ195=1 if (ec195==120)
replace econ195=1 if (ec195==140)
replace econ195=1 if (ec195==150)
replace econ195=1 if (ec195==152)
replace econ195=2 if (ec195==200)
replace econ195=3 if (ec195==500)
replace econ195=3 if (ec195==550)
replace econ195=4 if (ec195==600)
replace econ195=5 if (ec195==700)

label value econ195 econactivity_lbl

tab econ195

gen econ196=.
replace econ196=. if (ec196==-1)
replace econ196=1 if (ec196==100)
replace econ196=1 if (ec196==101)
replace econ196=1 if (ec196==110)
replace econ196=1 if (ec196==111)
replace econ196=1 if (ec196==113)
replace econ196=1 if (ec196==120)
replace econ196=1 if (ec196==140)
replace econ196=1 if (ec196==150)
replace econ196=1 if (ec196==152)
replace econ196=2 if (ec196==200)
replace econ196=2 if (ec196==240)
replace econ196=3 if (ec196==500)
replace econ196=3 if (ec196==550)
replace econ196=4 if (ec196==600)
replace econ196=4 if (ec196==602)
replace econ196=6 if (ec196==700)
replace econ196=5 if (ec196==800)

label define econactivityy_lbl 1"Full Time Employment" 2"Part Time Employment" 3"Education" 4"Unemployment" 5"Part-Time Education" 6"Other"
label value econ196 econactivityy_lbl

tab econ196

gen econ197=.
replace econ197=. if (ec197==-1)
replace econ197=1 if (ec197==100)
replace econ197=1 if (ec197==101)
replace econ197=1 if (ec197==110)
replace econ197=1 if (ec197==111)
replace econ197=1 if (ec197==113)
replace econ197=1 if (ec197==120)
replace econ197=1 if (ec197==140)
replace econ197=1 if (ec197==150)
replace econ197=1 if (ec197==152)
replace econ197=2 if (ec197==200)
replace econ197=2 if (ec197==240)
replace econ197=3 if (ec197==500)
replace econ197=3 if (ec197==550)
replace econ197=4 if (ec197==600)
replace econ197=4 if (ec197==602)
replace econ197=6 if (ec197==700)
replace econ197=6 if (ec197==701)
replace econ197=5 if (ec197==800)

label value econ197 econactivityy_lbl

tab econ197

gen econ198=.
replace econ198=. if (ec198==-1)
replace econ198=1 if (ec198==100)
replace econ198=1 if (ec198==101)
replace econ198=1 if (ec198==110)
replace econ198=1 if (ec198==111)
replace econ198=1 if (ec198==113)
replace econ198=1 if (ec198==114)
replace econ198=1 if (ec198==120)
replace econ198=1 if (ec198==121)
replace econ198=1 if (ec198==130)
replace econ198=1 if (ec198==140)
replace econ198=1 if (ec198==150)
replace econ198=1 if (ec198==152)
replace econ198=2 if (ec198==200)
replace econ198=2 if (ec198==201)
replace econ198=2 if (ec198==220)
replace econ198=6 if (ec198==300)
replace econ198=6 if (ec198==400)
replace econ198=3 if (ec198==500)
replace econ198=3 if (ec198==550)
replace econ198=4 if (ec198==600)
replace econ198=4 if (ec198==601)
replace econ198=4 if (ec198==602)
replace econ198=6 if (ec198==700)
replace econ198=6 if (ec198==701)
replace econ198=5 if (ec198==800)

label value econ198 econactivityy_lbl

tab econ198

gen econ199=.
replace econ199=. if (ec199==-1)
replace econ199=1 if (ec199==100)
replace econ199=1 if (ec199==101)
replace econ199=1 if (ec199==110)
replace econ199=1 if (ec199==111)
replace econ199=1 if (ec199==113)
replace econ199=1 if (ec199==114)
replace econ199=1 if (ec199==120)
replace econ199=1 if (ec199==121)
replace econ199=1 if (ec199==130)
replace econ199=1 if (ec199==131)
replace econ199=1 if (ec199==140)
replace econ199=1 if (ec199==150)
replace econ199=1 if (ec199==152)
replace econ199=2 if (ec199==200)
replace econ199=2 if (ec199==201)
replace econ199=2 if (ec199==220)
replace econ199=6 if (ec199==300)
replace econ199=6 if (ec199==400)
replace econ199=3 if (ec199==500)
replace econ199=3 if (ec199==550)
replace econ199=4 if (ec199==600)
replace econ199=4 if (ec199==601)
replace econ199=4 if (ec199==602)
replace econ199=6 if (ec199==700)
replace econ199=6 if (ec199==701)
replace econ199=5 if (ec199==800)

label value econ199 econactivityy_lbl

tab econ199

gen econ200=.
replace econ200=. if (ec200==-1)
replace econ200=1 if (ec200==100)
replace econ200=1 if (ec200==101)
replace econ200=1 if (ec200==110)
replace econ200=1 if (ec200==111)
replace econ200=1 if (ec200==113)
replace econ200=1 if (ec200==114)
replace econ200=1 if (ec200==120)
replace econ200=1 if (ec200==121)
replace econ200=1 if (ec200==130)
replace econ200=1 if (ec200==131)
replace econ200=1 if (ec200==140)
replace econ200=1 if (ec200==141)
replace econ200=1 if (ec200==150)
replace econ200=1 if (ec200==152)
replace econ200=2 if (ec200==200)
replace econ200=2 if (ec200==201)
replace econ200=2 if (ec200==220)
replace econ200=6 if (ec200==300)
replace econ200=6 if (ec200==400)
replace econ200=3 if (ec200==500)
replace econ200=3 if (ec200==550)
replace econ200=4 if (ec200==600)
replace econ200=4 if (ec200==601)
replace econ200=4 if (ec200==602)
replace econ200=6 if (ec200==700)
replace econ200=6 if (ec200==701)
replace econ200=5 if (ec200==800)

label value econ200 econactivityy_lbl

tab econ200

gen econ201=.
replace econ201=. if (ec201==-1)
replace econ201=1 if (ec201==100)
replace econ201=1 if (ec201==101)
replace econ201=1 if (ec201==110)
replace econ201=1 if (ec201==111)
replace econ201=1 if (ec201==113)
replace econ201=1 if (ec201==114)
replace econ201=1 if (ec201==120)
replace econ201=1 if (ec201==121)
replace econ201=1 if (ec201==130)
replace econ201=1 if (ec201==131)
replace econ201=1 if (ec201==140)
replace econ201=1 if (ec201==141)
replace econ201=1 if (ec201==150)
replace econ201=1 if (ec201==152)
replace econ201=2 if (ec201==200)
replace econ201=2 if (ec201==201)
replace econ201=2 if (ec201==220)
replace econ201=6 if (ec201==300)
replace econ201=6 if (ec201==400)
replace econ201=3 if (ec201==500)
replace econ201=3 if (ec201==550)
replace econ201=4 if (ec201==600)
replace econ201=4 if (ec201==601)
replace econ201=4 if (ec201==602)
replace econ201=6 if (ec201==700)
replace econ201=6 if (ec201==701)
replace econ201=5 if (ec201==800)

label value econ201 econactivityy_lbl

tab econ201

gen econ202=.
replace econ202=. if (ec202==-1)
replace econ202=1 if (ec202==100)
replace econ202=1 if (ec202==101)
replace econ202=1 if (ec202==110)
replace econ202=1 if (ec202==111)
replace econ202=1 if (ec202==113)
replace econ202=1 if (ec202==114)
replace econ202=1 if (ec202==120)
replace econ202=1 if (ec202==121)
replace econ202=1 if (ec202==130)
replace econ202=1 if (ec202==131)
replace econ202=1 if (ec202==140)
replace econ202=1 if (ec202==141)
replace econ202=1 if (ec202==150)
replace econ202=1 if (ec202==152)
replace econ202=2 if (ec202==200)
replace econ202=2 if (ec202==201)
replace econ202=2 if (ec202==220)
replace econ202=6 if (ec202==300)
replace econ202=6 if (ec202==400)
replace econ202=3 if (ec202==500)
replace econ202=3 if (ec202==550)
replace econ202=4 if (ec202==600)
replace econ202=4 if (ec202==601)
replace econ202=4 if (ec202==602)
replace econ202=4 if (ec202==603)
replace econ202=6 if (ec202==700)
replace econ202=6 if (ec202==701)
replace econ202=5 if (ec202==800)

label value econ202 econactivityy_lbl

tab econ202

gen econ203=.
replace econ203=. if (ec203==-1)
replace econ203=1 if (ec203==100)
replace econ203=1 if (ec203==101)
replace econ203=1 if (ec203==110)
replace econ203=1 if (ec203==111)
replace econ203=1 if (ec203==113)
replace econ203=1 if (ec203==114)
replace econ203=1 if (ec203==120)
replace econ203=1 if (ec203==121)
replace econ203=1 if (ec203==130)
replace econ203=1 if (ec203==131)
replace econ203=1 if (ec203==140)
replace econ203=1 if (ec203==141)
replace econ203=1 if (ec203==150)
replace econ203=1 if (ec203==152)
replace econ203=2 if (ec203==200)
replace econ203=2 if (ec203==201)
replace econ203=2 if (ec203==220)
replace econ203=6 if (ec203==300)
replace econ203=6 if (ec203==400)
replace econ203=3 if (ec203==500)
replace econ203=3 if (ec203==550)
replace econ203=4 if (ec203==600)
replace econ203=4 if (ec203==601)
replace econ203=4 if (ec203==602)
replace econ203=6 if (ec203==700)
replace econ203=6 if (ec203==701)
replace econ203=5 if (ec203==800)

label value econ203 econactivityy_lbl

tab econ203

gen econ204=.
replace econ204=. if (ec204==-1)
replace econ204=1 if (ec204==100)
replace econ204=1 if (ec204==101)
replace econ204=1 if (ec204==110)
replace econ204=1 if (ec204==111)
replace econ204=1 if (ec204==113)
replace econ204=1 if (ec204==114)
replace econ204=1 if (ec204==120)
replace econ204=1 if (ec204==121)
replace econ204=1 if (ec204==130)
replace econ204=1 if (ec204==131)
replace econ204=1 if (ec204==140)
replace econ204=1 if (ec204==141)
replace econ204=1 if (ec204==150)
replace econ204=1 if (ec204==152)
replace econ204=2 if (ec204==200)
replace econ204=2 if (ec204==201)
replace econ204=2 if (ec204==220)
replace econ204=6 if (ec204==300)
replace econ204=6 if (ec204==400)
replace econ204=3 if (ec204==500)
replace econ204=3 if (ec204==550)
replace econ204=4 if (ec204==600)
replace econ204=4 if (ec204==602)
replace econ204=6 if (ec204==700)
replace econ204=6 if (ec204==701)
replace econ204=5 if (ec204==800)

label value econ204 econactivityy_lbl

tab econ204


///Regression: number of o-level passes 
gen ocat=.
replace ocat=1 if (n1701==0)
replace ocat=2 if (n1701==1)
replace ocat=2 if (n1701==2)
replace ocat=2 if (n1701==3)
replace ocat=2 if (n1701==4)
replace ocat=3 if (n1701==5)
replace ocat=3 if (n1701==6)
replace ocat=3 if (n1701==7)
replace ocat=3 if (n1701==8)
replace ocat=3 if (n1701==9)
replace ocat=3 if (n1701==10)
replace ocat=3 if (n1701==11)
replace ocat=3 if (n1701==12)

label define ocat_lbl 1"Zero" 2"1-4" 3"5+"
label value ocat ocat_lbl

gen sex=.
replace sex=0 if (n622==1)
replace sex=1 if (n622==2)

label define sex_lbl 0"Male" 1"Female"
label value sex sex_lbl

gen ethnic=.
replace ethnic=0 if (n2017==1)
replace ethnic=1 if (n2017==2)
replace ethnic=2 if (n2017==3)
replace ethnic=3 if (n2017==4)
replace ethnic=3 if (n2017==5)
replace ethnic=3 if (n2017==6)

label define ethnic_lbl 0"White" 1"Black" 2"Indian-Pakistan" 3"Other" 
label value ethnic ethnic_lbl 

gen fclass=.
replace fclass=1 if (n2384==1)
replace fclass=2 if (n2384==2)
replace fclass=3 if (n2384==3)
replace fclass=3 if (n2384==4)
replace fclass=4 if (n2384==5)
replace fclass=4 if (n2384==6)
replace fclass=5 if (n2384==7)



label define fclass_lbl 1"I" 2"II" 3"III" 4"IV" 5"V" 
label value fclass fclass_lbl

gen fman=.

replace fman=0 if (n1737==1)
replace fman=1 if (n1737==2)

label define fman_lbl 0"Non-Manual" 1"Manual" 
label value fman fman_lbl

gen lea=.
replace lea=1 if (n2102==1)
replace lea=2 if (n2102==2)
replace lea=3 if (n2102==3)
replace lea=4 if (n2102==4)
replace lea=5 if (n2102==5)
replace lea=5 if (n2102==6)
replace lea=5 if (n2102==7)
replace lea=5 if (n2102==8)
replace lea=5 if (n2102==9)
replace lea=5 if (n2102==10)

label define lea_lbl 1"Comprehensive" 2"Grammar" 3"Secondary Modern" 4"Technical" 5"Other" 
label values lea lea_lbl

gen freem=.
replace freem=0 if (n2440==1)
replace freem=1 if (n2440==2)

label define freem_lbl 0"Yes" 1"No"
label value freem freem_lbl

///Descriptive Stats

tab ocat

tab ocat sex, chi2

tab ocat ethnic, chi2

tab ocat lea, chi2

tab ocat fclass, chi2

tab ocat fman, chi2

tab ocat freem, chi2

summarize ocat sex ethnic lea fclass fman freem, detail

///Ologit and Continuation Ratio Model
ologit ocat i.lea
ologit ocat i.lea sex i.ethnic i.fclass fman freem 
outreg2 using regression.doc, replace ctitle(Ologit Model 1)
listcoef, std

predict sdlogit dlogit alogit 
label var sdlogit "Pr(SD)"
label var dlogit "Pr(D)"
label var alogit "Pr(SA)"
dotplot sdlogit dlogit alogit, ylabel(0(0.25)0.75)

ologit ocat i.lea sex i.ethnic i.fclass i.fman i.freem 
margins, at(fman=0) post
est store NonManual

ologit ocat i.lea sex i.ethnic i.fclass fman freem 
margins, at(fman=1) post
est store Manual

coefplot (NonManual, color(eltblue)) (Manual, color(red*1.2)), recast(bar) barw(0.2) vertical yline(0) ylab(0(0.1)0.5) ciopts(recast(rcap)) color(gs8)

xi: ocratio ocat i.lea
xi: ocratio ocat i.lea, eform

xi: ocratio ocat i.lea sex i.ethnic i.fclass fman freem 
xi: ocratio ocat i.lea sex i.ethnic i.fclass fman freem, eform


///Patterns of Missing Data
misstable summarize ocat sex ethnic fclass lea fman freem
misstable patterns ocat sex ethnic fclass lea fman freem, freq
///To investigate which variables are predictive of missingness in the ethnicity
///variable we first define a binary variable which indicates whether the parental
///occupation variable is observed (=1) or missing (=0)
gen ethnictest=(ethnic!=.)
///Next we fit a logistic regression model for the variable n2017test, with sex as covatiate
xi: logistic ethnictest sex
///No evidence (p=0.6355) that missingness of ethnicity is related to sex of the person 

///Next we fit a logistic regression model with ethnicity and freem class as covariate 
xi: logistic ethnictest freem
///at this point we can say there is strong evidence against ethnicity being MCAR, because we have found a variable which is predictive of missingness

///next we fit a logistic regression model with fclass as a categorical covariate 
xi: logistic ethnictest i.fclass
///strong evidence fathers class is related to this probability. All other class categories are less likely to have ethnicity observered relative to I class respondents. 

///Now we conclude by fitting a logistic regression with all covariates 
xi: logistic ethnictest sex i.fclass i.lea fman freem i.ocat
///some evidence that the missing values in ethnicity varible are independetly associcated with the porbability of some categoires of class and lea. Conditional on all else, there is no evidence that sex, fman, freem, or some categories in class and lea is associated with this proabbility. we have found evidence that the missing values in the ethnicity varaibe are not MCAR (missing completely at random)

///three assumptions. 1) data on ethnicity are MAR given freem and fclass. 2) data on ethnicity are MNAR dependent on some categories within fclass and lea. 3) data on ethnicity are MNAR, but given the underlying covaraites the porbability of them being missing still depends on fclass. 

///complete records analysis
xi: ologit ocat i.lea sex i.ethnic i.fclass fman freem 
///considering the imporvement in the predictive power of the model 
xi: logistic ethnictest i.lea sex i.fclass i.fman i.freem
///summarize the predictive value of the model by estiamting the area under the receiver operating curve (AUC) this measure ranges from 0.5 (corresppnding to no preducvitve power) to 1 (perfect prediction)
lroc
///next we add ocat to the model
xi: logistic ethnictest i.lea sex i.fclass i.fman i.freem i.ocat
lroc
///the ROC curve has increased by a very small amount. This shows that oct is not very predictive of missingess of ethnicity even after accounting for all else. Ocat is not assoicated with these variables. These results indicate that we should not be wary regarding the validity of the complete record analysis. The results do not and cannot disporve the assumption needed for complete records anlsyis to be valid. 

///Multiple imputation 
mi set flong
mi register imputed ocat lea sex ethnic fclass fman freem
///because we have missing data in a mixture of continuos and categorical data, the chained equations apporach is attractive
mi impute chained (ologit) ocat lea sex ethnic fclass fman freem, add(5) rseed(5741) augment

mi estimate: ologit ocat i.lea sex i.ethnic i.fclass fman freem

