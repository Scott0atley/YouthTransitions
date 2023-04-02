// Chapter One - NCDS Descriptive Data, Modelling Economic Activity, Handling Missing Data //

// CHANGE LOG FROM V1:
// 1) REMOVED RACE FROM MODELS
// 2) RE-CODED ECONOMIC ACTIVITY VARIABLE FOR STATISTICAL POWER REASONS 
// 3) RE-CODED NS-SEC DUE TO CODING ERROR IN PREVIOUS VERSION
// 4) RETURNED RGSC TO ITS FULL FORM
// 5) REMOVED AUXILLARY VARIABLES IN IMPUTATION TO MAKE THIS CONVERGE
// 6) CHANGED ATMEANS MARGINS GRAPH NAMES
// 7) CHANGED NUMBER OF IMPUTATIONS FROM 50 TO 100 DUE TO LACK OF STABILISATION OVER TIME

cd "D:\Stata data and do\NCDS\Occupation Codes\UKDA-7023-stata9\stata9"
use "D:\Stata data and do\NCDS\Occupation Codes\UKDA-7023-stata9\stata9\ncds2_occupation_coding_father"

cd "D:\Stata data and do\NCDS\NCDS Sweep 16\stata\stata11"

rename NCDSID ncdsid
  
merge 1:1 ncdsid using ncds0123
drop _merge

cd "D:\Stata data and do\NCDS\NCDS Sweep 23\stata\stata9"

merge 1:1 ncdsid using ncds4
drop _merge



// The Economic Activity Variable is coded from the economic activity of month 201 from the NCDS Sweep 23. This translates to September 1974, in other words, the first month since end of mandatory schooling where O-level results are released. //

tab ec201 

gen econ201a=.
replace econ201a=. if (ec201==.)
replace econ201a=. if (ec201==-1)
replace econ201a=1 if (ec201==100)
replace econ201a=1 if (ec201==101)
replace econ201a=7 if (ec201==110)
replace econ201a=7 if (ec201==111)
replace econ201a=7 if (ec201==113)
replace econ201a=7 if (ec201==114)
replace econ201a=7 if (ec201==120)
replace econ201a=7 if (ec201==121)
replace econ201a=7 if (ec201==130)
replace econ201a=7 if (ec201==131)
replace econ201a=7 if (ec201==140)
replace econ201a=7 if (ec201==141)
replace econ201a=7 if (ec201==150)
replace econ201a=7 if (ec201==152)
replace econ201a=2 if (ec201==200)
replace econ201a=2 if (ec201==201)
replace econ201a=7 if (ec201==220)
replace econ201a=7 if (ec201==300)
replace econ201a=7 if (ec201==400)
replace econ201a=3 if (ec201==500)
replace econ201a=4 if (ec201==550)
replace econ201a=5 if (ec201==600)
replace econ201a=5 if (ec201==601)
replace econ201a=5 if (ec201==602)
replace econ201a=6 if (ec201==700)
replace econ201a=6 if (ec201==701)
replace econ201a=3 if (ec201==800)

label define econactivity_lbl 1"Full Time Employment" 2"Part Time Employment" 3"Education" 4"School" 5"Unemployment" 6"Out of Labour Force" 7"Training/Apprenticeships" 
label value econ201a econactivity_lbl

tab econ201a

// Three categories stand out for low observation sizes. PT Employment will be collapsed into FT Employment. Unemployment and OLF will be collapsed into one category //

gen econ201=.
replace econ201=1 if (econ201a==1)
replace econ201=1 if (econ201a==2)
replace econ201=2 if (econ201a==3)
replace econ201=3 if (econ201a==4)
replace econ201=5 if (econ201a==5)
replace econ201=5 if (econ201a==6)
replace econ201=4 if (econ201a==7)


label define econ_lbl 1"Employment" 2"Post-Schooling Education" 3"School" 4"Training/Apprenticeships" 5"Unemployment and OLF"
label value econ201 econ_lbl

tab econ201


// This variable is a count varaible of the number of O-levels the individual acheived at school. This will serve as our Educational Attainment varaible //

gen olevel=.
replace olevel=0 if (n4655==2)
replace olevel=1 if (n4656==1)
replace olevel=2 if (n4656==2)
replace olevel=3 if (n4656==3)
replace olevel=4 if (n4656==4)
replace olevel=5 if (n4656==5)
replace olevel=6 if (n4656==6)
replace olevel=7 if (n4656==7)
replace olevel=8 if (n4656==8)
replace olevel=9 if (n4656==9)

label define olevel_lbl 0"0" 1"1" 2"2" 3"3" 4"4" 5"5" 6"6" 7"7" 8"8" 9"9 or More"
label value olevel olevel_lbl

// The decision was made to convert the count variable into a binary variable for two reasons. The first follows a decent chunk of literature on education that uses a binary measure for GCSEs. The second more practical reason is that sample sizes were too low or had zero responses for too many categories when conducting analysis. 

gen obin=.
replace obin=0 if (olevel==0)
replace obin=0 if (olevel==1)
replace obin=0 if (olevel==2)
replace obin=0 if (olevel==3)
replace obin=0 if (olevel==4)
replace obin=1 if (olevel==5)
replace obin=1 if (olevel==6)
replace obin=1 if (olevel==7)
replace obin=1 if (olevel==8)
replace obin=1 if (olevel==9)

label define obin_lbl 0"<5 O-Levels" 1">5 O-Levels"
label value obin obin_lbl

// This is the Sex Variable //

gen sex=. 
replace sex=0 if (n622_4==2)
replace sex=1 if (n622_4==1)

label define sex_lbl 0"Female" 1"Male"
label value sex sex_lbl

// This is the Race Variable. (This uses data from Sweeps0-3)//

gen race=.
replace race=0 if (n2017==1)
replace race=1 if (n2017==2)
replace race=1 if (n2017==3)
replace race=1 if (n2017==4)
replace race=1 if (n2017==5)
replace race=1 if (n2017==6)

label define race_lbl 0"White" 1"Non-White"
label value race race_lbl

tab race 

tab race econ201

// For the proposed model, the sample of race is too sparse to produce any useful results or even be used as an appropriate control. Therefore it is dropped from analysis //

// This is a variable for Housing Tenure (This uses data from Sweeps0-3)//

gen tenure=. 
replace tenure=0 if (n1152==1)
replace tenure=1 if (n1152==2)
replace tenure=1 if (n1152==3)
replace tenure=1 if (n1152==4)
replace tenure=1 if (n1152==5)
replace tenure=1 if (n1152==6)

label define tenure_lbl 0"Own Home" 1"Don't Own Home"
label value tenure tenure_lbl

// This is a varaible for Father's Social Class NS-SEC //
gen nssec=. 
replace nssec=1 if (N2SNSSEC==2)
replace nssec=1 if (N2SNSSEC==3.1)
replace nssec=1 if (N2SNSSEC==3.2)
replace nssec=1 if (N2SNSSEC==3.3)
replace nssec=1 if (N2SNSSEC==4.1)
replace nssec=1 if (N2SNSSEC==4.2)
replace nssec=1 if (N2SNSSEC==4.3)
replace nssec=2 if (N2SNSSEC==5)
replace nssec=2 if (N2SNSSEC==7.1)
replace nssec=2 if (N2SNSSEC==7.2)
replace nssec=2 if (N2SNSSEC==7.3)
replace nssec=2 if (N2SNSSEC==7.4)
replace nssec=3 if (N2SNSSEC==8.1)
replace nssec=4 if (N2SNSSEC==9.1)
replace nssec=4 if (N2SNSSEC==9.2)
replace nssec=5 if (N2SNSSEC==10)
replace nssec=5 if (N2SNSSEC==11.1)
replace nssec=5 if (N2SNSSEC==11.2)
replace nssec=6 if (N2SNSSEC==12.1)
replace nssec=6 if (N2SNSSEC==12.2)
replace nssec=6 if (N2SNSSEC==12.3)
replace nssec=6 if (N2SNSSEC==12.4)
replace nssec=6 if (N2SNSSEC==12.5)
replace nssec=6 if (N2SNSSEC==12.6)
replace nssec=6 if (N2SNSSEC==12.7)
replace nssec=7 if (N2SNSSEC==13.1)
replace nssec=7 if (N2SNSSEC==13.2)
replace nssec=7 if (N2SNSSEC==13.3)
replace nssec=7 if (N2SNSSEC==13.4)
replace nssec=7 if (N2SNSSEC==13.5)

label define nssec_lbl 1"Higher managerial, administrative and professional occupations" 2"Lower managerial, administrative and professional occupations" 3"Intermediate occupations" 4"Small employers and own account workers" 5"Lower supervisory and technical occupations" 6"Semi-routine occupations" 7"Routine occupations"
label value nssec nssec_lbl

// This is a varaible for Father's Social Class CAMSIS //

rename N2SCMSIS camsis

// This is a variable for Father's Social Class RGSC //

gen rgsc=.
replace rgsc=1 if (N2SRGSC==1)
replace rgsc=2 if (N2SRGSC==2)
replace rgsc=3 if (N2SRGSC==3.1)
replace rgsc=4 if (N2SRGSC==3.2)
replace rgsc=5 if (N2SRGSC==4)
replace rgsc=6 if (N2SRGSC==5)

label define rgsc_lbl 1"Professional" 2"Managerial and Technical" 3"Skilled non-manual" 4"Skilled manual" 5"Partly skilled" 6"Unskilled"
label value rgsc rgsc_lbl


tab nssec

tab camsis

tab rgsc

save ncds4_chapter_one_v2, replace

// Descriptive Statistics and Tables - Complete Case Analysis //

keep if !missing(econ201, obin, sex, tenure, nssec, rgsc, camsis)

count

collect clear

table (var) (), statistic(fvfrequency econ201 obin sex tenure nssec rgsc) ///
					statistic(fvpercent econ201 obin sex tenure nssec rgsc) ///
					statistic(mean camsis) ///  
					statistic(sd camsis) 
					
collect remap result[fvfrequency mean] = Col[1 1] 
	collect remap result[fvpercent sd] = Col[2 2]
    
collect get resname = "Mean", tag(Col[1] var[mylabel]) 
	collect get resname = "SD", tag(Col[2] var[mylabel])
    
collect get empty = "  ", tag(Col[1] var[empty]) 
	collect get empty = "  ", tag(Col[2] var[empty])
    
count
	collect get n = `r(N)', tag(Col[2] var[n])
	
collect layout (var[1.econ201 2.econ201 3.econ201 4.econ201 5.econ201 ///
					0.obin 1.obin ///
					0.sex 1.sex  ///
					0.race 1.race  ///
					0.tenure 1.tenure ///
					1.nssec 2.nssec 3.nssec 4.nssec 5.nssec 6.nssec 7.nssec ///
					1.rgsc 2.rgsc 3.rgsc 4.rgsc 5.rgsc 6.rgsc ///
					empty mylabel ///
					camsis ///
					empty n]) (Col[1 2])

collect label levels Col 1 "n" 2 "%"
					
collect style header Col, title(hide)

collect style header var[empty mylabel], level(hide)
collect style row stack, nobinder

collect style cell var[econ201 obin sex tenure nssec rgsc]#Col[1], nformat(%6.0fc) 
collect style cell var[econ201 obin sex tenure nssec rgsc]#Col[2], nformat(%6.2f) sformat("%s%%") 	
collect style cell var[camsis], nformat(%6.2f)

collect style cell border_block[item row-header], border(top, pattern(nil)) 

collect title "Table 1: Descriptive Statistics for Economic Activity"

collect note "Data Source: NCDS"

collect preview

collect export "Table1.docx", replace


collect clear

table ( econ201 ) ( sex ) ( obin ), statistic(rawpercent)

collect export "Table2.docx", replace
	

// Now we start with a null model and a full model in mlogit form - Complete Case Analysis. Prior to this I gather statistics on the goodness-of-fit summaries for explanatory variables and econ201. This includes Deviance, Changing in Deviance, d.f, and R2. //

quietly mlogit econ201

fitstat

quietly mlogit econ201 i.obin

fitstat

quietly mlogit econ201 i.sex

fitstat

quietly mlogit econ201 i.tenure

fitstat

quietly mlogit econ201 i.nssec

fitstat

// Now do the same with each variable added sequentially //

quietly mlogit econ201

fitstat

quietly mlogit econ201 i.obin

fitstat

quietly mlogit econ201 i.obin i.sex

fitstat

quietly mlogit econ201 i.obin i.sex i.tenure

fitstat

quietly mlogit econ201 i.obin i.sex i.tenure i.nssec 

fitstat


// NS-SEC Model (command qv isn't working look into) //

mlogit econ201 i.obin i.sex i.tenure i.nssec

collect clear

collect label levels colname obin "Educational Attainment", modify
collect label levels colname sex "Sex", modify
collect label levels colname tenure "Tenure", modify
collect label levels colname nssec "NS-SEC", modify


collect label levels etable_depvar 1 "Coef. (SE)", modify
etable, replace cstat(_r_b, nformat(%4.2f))  ///
	cstat(_r_se, nformat(%6.2f))  ///
	showstars showstarsnote  ///
	stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
	mstat(N) mstat(aic) mstat(bic) mstat(r2_a) ///
	title("Table 1.7: Complete Case Analysis of Multiple Logistic Regression Model of Economic Activity") ///
	titlestyles(font(Arial Narrow, size(14) bold)) ///
	note("Data Source: NCDS") ///
	notestyles(font(Helvetica, size(12) italic)) ///
	export("EA1.docx", replace)
	
fitstat

mlogit econ201 i.obin i.sex i.tenure i.nssec

set scheme s1color, permanent 
margins nssec, atmeans predict(outcome(1))
marginsplot, name(emean)
margins nssec, atmeans predict(outcome(2))
marginsplot, name(smean)
margins nssec, atmeans predict(outcome(3))
marginsplot, name(edmean)
margins nssec, atmeans predict(outcome(4))
marginsplot, name(tmean)
margins nssec, atmeans predict(outcome(5))
marginsplot, name(umean)
	
graph combine emean smean edmean tmean umean, ycommon

quietly mlogit econ201 obin sex tenure nssec

mlogtest, lr wald hausman

// Liklihood Ratio Test - The hypothesis that all the coefficients associated with educational attainment, sex, race, tenure, and NS-SEC are simultaneously equal to 0 can be rejected at the 0.01 level. Wald test concurs with these findings. A Hausman test of IIA is conducted and finds that three of the economic activity categories do not violate the IIA assumption, with the other three categories producing negative results indicating that there is also no violation (refer to Long and Freese 2006). //

quietly mlogit econ201 i.obin i.sex i.tenure i.nssec

margins, dydx(*) post


collect clear

collect label levels colname obin "Educational Attainment", modify
collect label levels colname sex "Sex", modify
collect label levels colname tenure "Tenure", modify
collect label levels colname nssec "NS-SEC", modify


collect label levels etable_depvar 1 "Coef. (SE)", modify
etable, replace cstat(_r_b, nformat(%4.2f))  ///
	cstat(_r_se, nformat(%6.2f))  ///
	showstars showstarsnote  ///
	stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
	mstat(N) mstat(aic) mstat(bic) mstat(r2_a) ///
	title("Table xxx:Average marginal effects on the probability of Economic Activity") ///
	titlestyles(font(Arial Narrow, size(14) bold)) ///
	note("Data Source: NCDS") ///
	notestyles(font(Arial Narrow, size(10) italic)) ///
	export("marginal1.docx", replace)


// CAMSIS - complete case analysis (Need to re-do tables) //

// conduct correlation tests between different class measures //

tab nssec rgsc, chi2

anova camsis nssec

// Add these to deviance tables in the appendix for camsis and rgsc //
quietly mlogit econ201 camsis

fitstat

quietly mlogit econ201 i.obin i.sex i.tenure camsis 

fitstat


// CAMSIS //

mlogit econ201 i.obin i.sex i.tenure camsis

collect clear

collect label levels colname obin "Educational Attainment", modify
collect label levels colname sex "Sex", modify
collect label levels colname tenure "Tenure", modify
collect label levels colname camsis "CAMSIS", modify


collect label levels etable_depvar 1 "Coef. (SE)", modify
etable, replace cstat(_r_b, nformat(%4.2f))  ///
	cstat(_r_se, nformat(%6.2f))  ///
	showstars showstarsnote  ///
	stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
	mstat(N) mstat(aic) mstat(bic) mstat(r2_a) ///
	title("Table 1: Multiple Logistic Regression Model of Economic Activity") ///
	titlestyles(font(Arial Narrow, size(14) bold)) ///
	note("Data Source: NCDS") ///
	notestyles(font(Arial Narrow, size(10) italic)) ///
	export("EA2.docx", replace)
	
	fitstat
	
graph combine cemean csmean cedmean ctmean cumean, ycommon
	
// Goodness-of-fit statistics for CAMSIS //
quietly mlogit econ201 obin sex tenure camsis

mlogtest, lr wald hausman
	
// create table of marginal effects //

quietly mlogit econ201 i.obin i.sex i.tenure camsis

margins, dydx(*) post


collect clear

collect label levels colname obin "Educational Attainment", modify
collect label levels colname sex "Sex", modify
collect label levels colname tenure "Tenure", modify
collect label levels colname nssec "CAMSIS", modify


collect label levels etable_depvar 1 "Coef. (SE)", modify
etable, replace cstat(_r_b, nformat(%4.2f))  ///
	cstat(_r_se, nformat(%6.2f))  ///
	showstars showstarsnote  ///
	stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
	mstat(N) mstat(aic) mstat(bic) mstat(r2_a) ///
	title("Table xxx:Average marginal effects on the probability of Economic Activity") ///
	titlestyles(font(Arial Narrow, size(14) bold)) ///
	note("Data Source: NCDS") ///
	notestyles(font(Arial Narrow, size(10) italic)) ///
	export("marginal2.docx", replace)


// RGSC - complete case analysis (Need to re-do tables)//

// Add these to deviance tables in the appendix for camsis and rsimple //
quietly mlogit econ201 i.rgsc

fitstat

quietly mlogit econ201 i.obin i.sex i.tenure i.rgsc 

fitstat

// Goodness-of-fit for RGSC //

quietly mlogit econ201 obin sex tenure rgsc

mlogtest, lr wald hausman

// RGSC //

mlogit econ201 i.obin i.sex i.tenure i.rgsc


collect clear

collect label levels colname obin "Educational Attainment", modify
collect label levels colname sex "Sex", modify
collect label levels colname tenure "Tenure", modify
collect label levels colname camsis "RGSC", modify


collect label levels etable_depvar 1 "Coef. (SE)", modify
etable, replace cstat(_r_b, nformat(%4.2f))  ///
	cstat(_r_se, nformat(%6.2f))  ///
	showstars showstarsnote  ///
	stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
	mstat(N) mstat(aic) mstat(bic) mstat(r2_a) ///
	title("Table 1: Multiple Logistic Regression Model of Economic Activity") ///
	titlestyles(font(Arial Narrow, size(14) bold)) ///
	note("Data Source: NCDS") ///
	notestyles(font(Arial Narrow, size(10) italic)) ///
	export("EA3.docx", replace)
	
fitstat

quietly mlogit econ201 obin sex tenure rgsc

mlogtest, lr wald hausman


// create table of marginal effects //

quietly mlogit econ201 i.obin i.sex i.tenure i.rgsc

margins, dydx(*) post


collect clear

collect label levels colname obin "Educational Attainment", modify
collect label levels colname sex "Sex", modify
collect label levels colname tenure "Tenure", modify
collect label levels colname nssec "RGSC", modify


collect label levels etable_depvar 1 "Coef. (SE)", modify
etable, replace cstat(_r_b, nformat(%4.2f))  ///
	cstat(_r_se, nformat(%6.2f))  ///
	showstars showstarsnote  ///
	stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
	mstat(N) mstat(aic) mstat(bic) mstat(r2_a) ///
	title("Table xxx:Average marginal effects on the probability of Economic Activity") ///
	titlestyles(font(Arial Narrow, size(14) bold)) ///
	note("Data Source: NCDS") ///
	notestyles(font(Arial Narrow, size(10) italic)) ///
	export("marginal3.docx", replace)

	
	
	
	
// Save Data and move on to multiple imputation //

save ncds4_complete_chapter_analysis_v2, replace

// Missing Data //

use "D:\Stata data and do\NCDS\NCDS Sweep 23\stata\stata9\ncds4_chapter_one_v2"

// Remove dead + attrition people from dataset - this variable is the outcome of tracing and interview for Sweep 23, 12537 individuals completed or partially completed the 23 Sweep. All else either died, refused, migrated etc and should not be included in the imputation //

drop if missing(n4118)

misstable summarize econ201 obin sex tenure nssec camsis rgsc 

misstable patterns econ201 obin sex tenure nssec camsis rgsc

// 67, 17, 13, 2, <1...

quietly mlogit econ201 i.obin i.sex i.tenure i.nssec camsis i.rgsc 

gen cc= e(sample)

foreach var in camsis {
	tabstat `var', by(cc) stat(n mean sd)
}

foreach var in econ201 obin sex tenure nssec rgsc {
	tab `var' cc, col
}

// Re-coding auxilliary variables for non-response at Sweep 3 using the Handling Missing Data NCDS Guide //

tab n0region

gen acatnn0region = n0region
replace acatnn0region=. if (acatnn0region==-2)
replace acatnn0region=0 if (acatnn0region==1)
replace acatnn0region=1 if (acatnn0region==2)
replace acatnn0region=1 if (acatnn0region==3)
replace acatnn0region=1 if (acatnn0region==4)
replace acatnn0region=1 if (acatnn0region==5)
replace acatnn0region=1 if (acatnn0region==6)
replace acatnn0region=1 if (acatnn0region==7)
replace acatnn0region=1 if (acatnn0region==8)
replace acatnn0region=1 if (acatnn0region==9)
replace acatnn0region=1 if (acatnn0region==10)
replace acatnn0region=1 if (acatnn0region==11)

tab acatnn0region 

tab n99

gen bconnn99 = n99
replace bconnn99=. if (bconnn99==-1)
replace bconnn99=0 if (bconnn99==1)
replace bconnn99=1 if (bconnn99==2)
replace bconnn99=1 if (bconnn99==3)
replace bconnn99=1 if (bconnn99==4)
replace bconnn99=1 if (bconnn99==5)
replace bconnn99=1 if (bconnn99==6)
replace bconnn99=1 if (bconnn99==7)
replace bconnn99=1 if (bconnn99==8)
replace bconnn99=1 if (bconnn99==9)
replace bconnn99=1 if (bconnn99==10)
replace bconnn99=1 if (bconnn99==11)
replace bconnn99=1 if (bconnn99==12)
replace bconnn99=1 if (bconnn99==13)
replace bconnn99=1 if (bconnn99==14)

tab bconnn99

tab n197

gen maw5 = n197
replace maw5=. if (maw5==-1)
replace maw5=0 if (maw5==1)
replace maw5=1 if (maw5==2)
replace maw5=1 if (maw5==3)
replace maw5=1 if (maw5==4)

tab maw5

tab n512

gen aconnn512 = n512
replace aconnn512=. if (aconnn512==-1)
replace aconnn512=0 if (aconnn512==1)
replace aconnn512=1 if (aconnn512==2)
replace aconnn512=1 if (aconnn512==3)
replace aconnn512=1 if (aconnn512==4)
replace aconnn512=1 if (aconnn512==5)
replace aconnn512=1 if (aconnn512==6)

tab aconnn512

tab n236

gen acatnn236 = n236
replace acatnn236=. if (n236==-1)

tab acatnn236

tab n95

gen bcatnn95 = n95
replace bcatnn95=. if (bcatnn95==-1)
replace bcatnn95=0 if (bcatnn95==1)
replace bcatnn95=0 if (bcatnn95==2)
replace bcatnn95=0 if (bcatnn95==3)
replace bcatnn95=0 if (bcatnn95==4)
replace bcatnn95=1 if (bcatnn95==5)
replace bcatnn95=1 if (bcatnn95==6)
replace bcatnn95=1 if (bcatnn95==7)
replace bcatnn95=1 if (bcatnn95==8)
replace bcatnn95=1 if (bcatnn95==9)
replace bcatnn95=1 if (bcatnn95==10)
replace bcatnn95=1 if (bcatnn95==11)
replace bcatnn95=1 if (bcatnn95==12)
replace bcatnn95=1 if (bcatnn95==13)
replace bcatnn95=1 if (bcatnn95==14)
replace bcatnn95=1 if (bcatnn95==15)
replace bcatnn95=1 if (bcatnn95==16)
replace bcatnn95=1 if (bcatnn95==17)
replace bcatnn95=1 if (bcatnn95==18)
replace bcatnn95=1 if (bcatnn95==19)
replace bcatnn95=1 if (bcatnn95==20)
replace bcatnn95=1 if (bcatnn95==21)
replace bcatnn95=1 if (bcatnn95==22)

tab bcatnn95

pca n90 n457 n1840 n92
gen CogAbil7= e(sample)

tab CogAbil7

tab n180

gen DadNeverReads = n180
replace DadNeverReads=. if (DadNeverReads==-1)
replace DadNeverReads=0 if (DadNeverReads==1)
replace DadNeverReads=1 if (DadNeverReads==2)
replace DadNeverReads=1 if (DadNeverReads==3)
replace DadNeverReads=1 if (DadNeverReads==4)

tab DadNeverReads

tab n1434

gen ccatnn1434 = n1434
replace ccatnn1434=. if (ccatnn1434==-1)
replace ccatnn1434=0 if (ccatnn1434==1)
replace ccatnn1434=1 if (ccatnn1434==2)
replace ccatnn1434=1 if (ccatnn1434==3)
replace ccatnn1434=1 if (ccatnn1434==4)
replace ccatnn1434=1 if (ccatnn1434==5)
replace ccatnn1434=1 if (ccatnn1434==6)
replace ccatnn1434=1 if (ccatnn1434==7)
replace ccatnn1434=1 if (ccatnn1434==8)
replace ccatnn1434=1 if (ccatnn1434==9)

tab ccatnn1434

tab n1150

gen ccatnn1150 = n1150
replace ccatnn1150=. if (ccatnn1150==-1)
replace ccatnn1150=0 if (ccatnn1150==1)
replace ccatnn1150=0 if (ccatnn1150==2)
replace ccatnn1150=0 if (ccatnn1150==3)
replace ccatnn1150=1 if (ccatnn1150==4)
replace ccatnn1150=1 if (ccatnn1150==5)
replace ccatnn1150=1 if (ccatnn1150==6)
replace ccatnn1150=1 if (ccatnn1150==7)
replace ccatnn1150=1 if (ccatnn1150==8)
replace ccatnn1150=1 if (ccatnn1150==9)

tab ccatnn1150

pca n914 n917
gen genability11= e(sample)

tab genability11

tab n204

gen toilet = n204
replace toilet=. if (toilet==-1)
replace toilet=. if (toilet==1)
replace toilet=0 if (toilet==2)
replace toilet=1 if (toilet==3)
replace toilet=1 if (toilet==4)

tab toilet

gen itoilet = n205
replace itoilet=. if (itoilet==-1)
replace itoilet=. if (itoilet==1)
replace itoilet=0 if (itoilet==2)
replace itoilet=1 if (itoilet==3)
replace itoilet=1 if (itoilet==4)

tab itoilet

gen otoilet = n206
replace otoilet=. if (otoilet==-1)
replace otoilet=. if (otoilet==1)
replace otoilet=0 if (otoilet==2)
replace otoilet=1 if (otoilet==3)
replace otoilet=1 if (otoilet==4)

tab otoilet

gen cooking = n207
replace cooking=. if (cooking==-1)
replace cooking=. if (cooking==1)
replace cooking=0 if (cooking==2)
replace cooking=1 if (cooking==3)
replace cooking=1 if (cooking==4)

tab cooking

gen water = n208
replace water=. if (water==-1)
replace water=. if (water==1)
replace water=0 if (water==2)
replace water=1 if (water==3)
replace water=1 if (water==4)

tab water

gen garden = n209
replace garden=. if (garden==-1)
replace garden=. if (garden==1)
replace garden=0 if (garden==2)
replace garden=1 if (garden==3)
replace garden=1 if (garden==4)

tab garden

tab n2492

gen dconnn2492 = n2492
replace dconnn2492=. if (dconnn2492==-1)
replace dconnn2492=0 if (dconnn2492==0)
replace dconnn2492=1 if (dconnn2492==1)
replace dconnn2492=1 if (dconnn2492==2)
replace dconnn2492=1 if (dconnn2492==3)
replace dconnn2492=1 if (dconnn2492==4)
replace dconnn2492=1 if (dconnn2492==5)
replace dconnn2492=1 if (dconnn2492==6)
replace dconnn2492=1 if (dconnn2492==7)
replace dconnn2492=1 if (dconnn2492==8)
replace dconnn2492=1 if (dconnn2492==9)

tab dconnn2492

tab n2825

gen dconnage16dv46 = n2825
replace dconnage16dv46=. if(dconnage16dv46==-1)
replace dconnage16dv46=0 if(dconnage16dv46==1)
replace dconnage16dv46=1 if(dconnage16dv46==2)
replace dconnage16dv46=1 if(dconnage16dv46==3)
replace dconnage16dv46=1 if(dconnage16dv46==4)
replace dconnage16dv46=1 if(dconnage16dv46==5)
replace dconnage16dv46=1 if(dconnage16dv46==6)

tab dconnage16dv46

// Auxilliary Varaibles Derived Missingness, the p value threshold is p<0.001 //

foreach var in acatnn0region bconnn99 maw5 aconnn512 acatnn236 bcatnn95 CogAbil7 DadNeverReads ccatnn1434 ccatnn1150 genability11 toilet itoilet otoilet cooking water garden dconnn2492 dconnage16dv46{
	regress econ201 `var'
	testparm `var'
}

// from this aconnn512, acatnn236, toilet, itoilet, water, dconnage16dv46 are associated with econ201 with p<0.001 //

// Setting and Imputing the Data //
mi set wide

mi register imputed econ201 obin sex tenure nssec aconnn512 acatnn236 toilet itoilet water dconnage16dv46
tab _mi_miss

mi impute chained ///
///
(logit, augment) obin sex tenure water toilet itoilet aconnn512 dconnage16dv46 ///
///
(mlogit, augment) econ201 nssec ///
///
, rseed(12346) dots force add(100) burnin(20) savetrace(MI_test_trace, replace)

//For convergence reasons acatnn236 had to be dropped from imputation models //

save missing_ncds_v2, replace

cd "D:\Stata data and do\NCDS\NCDS Sweep 23\stata\stata9"
use "D:\Stata data and do\NCDS\NCDS Sweep 23\stata\stata9\MI_test_trace"

pause on

foreach var in econ201 obin tenure water toilet itoilet aconnn512 dconnage16dv46 nssec {
	xtline `var'_mean, t(iter) i(m) overlay legend(off) name(graph1, replace)
	xtline `var'_sd, t(iter) i(m) overlay legend(off) name(graph2, replace)
	graph combine graph1 graph2, xcommon cols(1)
	pause
}

pause off

save MI_test_trace, replace

use "D:\Stata data and do\NCDS\NCDS Sweep 23\stata\stata9\missing_ncds_v2"

// Checking Imputed Values //

foreach var of varlist econ201 obin sex tenure nssec aconnn512 acatnn236 toilet itoilet water dconnage16dv46 {
	tab1 `var'  _1_`var' _2_`var' _3_`var' _4_`var' _5_`var'
}

// The categorical variables all have relatively similar distribution compared to the imputed and observed values //

// Fitting and comparing imputed model to complete case analysis model //

mi estimate, post dots: mlogit econ201 i.obin i.sex i.tenure i.nssec 

collect clear

collect label levels colname obin "Educational Attainment", modify
collect label levels colname sex "Sex", modify
collect label levels colname tenure "Tenure", modify
collect label levels colname nssec "NS-SEC", modify


collect label levels etable_depvar 1 "Coef. (SE)", modify
etable, replace cstat(_r_b, nformat(%4.2f))  ///
	cstat(_r_se, nformat(%6.2f))  ///
	showstars showstarsnote  ///
	stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
	mstat(N) mstat(aic) mstat(bic) mstat(r2_a) ///
	title("Table 2.2: Complete Case Analysis of Multiple Logistic Regression Model of Economic Activity") ///
	titlestyles(font(Arial Narrow, size(14) bold)) ///
	note("Data Source: NCDS") ///
	notestyles(font(Arial Narrow, size(10) italic)) ///
	export("imputed1.docx", replace)

// Checking the analysis models //

mi estimate, post vartable nocitable 

	
mi estimate, post dftable nocitable 

// Save //

save missing_ncds_v2, replace

