

/*==============================================================================
							1: Handling Missing Data
==============================================================================*/


use"$workingdata/merge_master_v1.dta", clear

gen regional= gor_dv
replace regional=. if region<0

tab hhsize 
gen hsize=. 
replace hsize=0 if hhsize>=1 & hhsize <=4 
replace hsize=1 if hhsize>=5 & hhsize <=14

tab hhtype
gen htype=. 
replace htype= 0 if hhtype>=1 & hhtype<=2 | hhtype>=7 & hhtype<=8
replace htype=1 if hhtype>=3 & hhtype<=6

tab lkmove
gen lmove=. 
replace lmove=0 if lkmove==1
replace lmove=1 if lkmove==2

tab smoker
gen smoke=. 
replace smoke=0 if smoker==1 
replace smoke=1 if smoker==2

tab lactf
gen drink=. 
replace drink=0 if lactf==5
replace drink=1 if lactf>=1 & lactf<=4

logit $full

gen cc= e(sample)

foreach var in econ obin female tenure nssec {
	tab `var' cc, col
}

foreach var in regional hsize htype lmove smoker drink{
	logit econ `var'
	testparm `var'
}	

*drop drink, keep rest for aux


/*==============================================================================
							2: Multiple Imputation
==============================================================================*/

misstable summarize econ obin female tenure nssec s_cohort

misstable patterns econ obin female tenure nssec s_cohort


cd"$workingdata"

mi set flong

mi svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)

mi register imputed econ obin female tenure nssec s_cohort hsize htype lmove smoke

capture mi stset, clear 

mi impute chained ///
///
(logit, augment) obin female tenure econ ///
///
(mlogit, augment) nssec s_cohort ///
///
, rseed(12345) dots force add(40) burnin(20) savetrace(MI_test_trace_v1, replace)

cd"$workingdata" 

* Transform Variables for cohort interactions... 


drop obinc* sexc* tenurec* nssecsynth* 
lab drop obinc obinc2 obinc3 sexc sexc2 sexc3 tenurec tenurec2 tenurec3 nssecsynth1 nssecsynth2 nssecsynth3


gen obinc=.
replace obinc=0 if (obin==0 & s_cohort==1)
replace obinc=0 if (s_cohort==2)
replace obinc=0 if (s_cohort==3)
replace obinc=1 if (obin==1 & s_cohort==1)

lab def obinc 1"Five or More GCSEs 1991/1999" 0"Less than Five GCSEs 1991/1999"
lab val obinc obinc

gen obinc2=.
replace obinc2=0 if (obin==0 & s_cohort==2)
replace obinc2=0 if (s_cohort==1)
replace obinc2=0 if (s_cohort==3)
replace obinc2=1 if (obin==1 & s_cohort==2)

lab def obinc2 1"Five or More GCSEs 2000/2009" 0"Less than Five GCSEs 2000/2009"
lab val obinc2 obinc2

gen obinc3=.
replace obinc3=0 if (obin==0 & s_cohort==3)
replace obinc3=0 if (s_cohort==1)
replace obinc3=0 if (s_cohort==2)
replace obinc3=1 if (obin==1 & s_cohort==3)

lab def obinc3 1"Five or More GCSEs 2010/2013" 0"Less than Five GCSEs 2010/2013"
lab val obinc3 obinc3

gen sexc=.
replace sexc=0 if (female==0 & s_cohort==1)
replace sexc=0 if (s_cohort==2)
replace sexc=0 if (s_cohort==3)
replace sexc=1 if (female==1 & s_cohort==1)

lab def sexc 1"Female 1991/1999" 0"Male 1991/1999"
lab val sexc sexc

gen sexc2=.
replace sexc2=0 if (female==0 & s_cohort==2)
replace sexc2=0 if (s_cohort==1)
replace sexc2=0 if (s_cohort==3)
replace sexc2=1 if (female==1 & s_cohort==2)

lab def sexc2 1"Female 2000/2009" 0"Male 2000/2009"
lab val sexc2 sexc2

gen sexc3=.
replace sexc3=0 if (female==0 & s_cohort==3)
replace sexc3=0 if (s_cohort==1)
replace sexc3=0 if (s_cohort==2)
replace sexc3=1 if (female==1 & s_cohort==3)

lab def sexc3 1"Female 2010/2013" 0"Male 2010/2013"
lab val sexc3 sexc3

gen tenurec=.
replace tenurec=0 if (tenure==0 & s_cohort==1)
replace tenurec=0 if (s_cohort==2)
replace tenurec=0 if (s_cohort==3)
replace tenurec=1 if (tenure==1 & s_cohort==1)

lab def tenurec 1"Own Home 1991/1999" 0"Don't Own Home 1991/1999"
lab val tenurec tenurec

gen tenurec2=.
replace tenurec2=0 if (tenure==0 & s_cohort==2)
replace tenurec2=0 if (s_cohort==1)
replace tenurec2=0 if (s_cohort==3)
replace tenurec2=1 if (tenure==1 & s_cohort==2)

lab def tenurec2 1"Own Home 2000/2009" 0"Don't Own Home 2000/2009"
lab val tenurec2 tenurec2

gen tenurec3=.
replace tenurec3=0 if (tenure==0 & s_cohort==3)
replace tenurec3=0 if (s_cohort==1)
replace tenurec3=0 if (s_cohort==2)
replace tenurec3=1 if (tenure==1 & s_cohort==3)

lab def tenurec3 1"Own Home 2010/2013" 0"Don't Own Home 2010/2013"
lab val tenurec3 tenurec3


gen nssecsynth1=.
replace nssecsynth1=0 if (s_cohort==2)
replace nssecsynth1=0 if (s_cohort==3)
replace nssecsynth1=0 if (s_cohort==1 & nssec==3)
replace nssecsynth1=1 if (s_cohort==1 & nssec==1)
replace nssecsynth1=2 if (s_cohort==1 & nssec==2)
replace nssecsynth1=3 if (s_cohort==1 & nssec==4)
replace nssecsynth1=4 if (s_cohort==1 & nssec==5)
replace nssecsynth1=5 if (s_cohort==1 & nssec==6)
replace nssecsynth1=6 if (s_cohort==1 & nssec==7)
replace nssecsynth1=7 if (s_cohort==1 & nssec==8)

lab def nssecsynth1 1"1.1 Large employers and higher managerial occupations 1991/1999" 2"1.2 Higher professional occupations 1991/1999" 3"3 Intermediate occupations 1991/1999" 4"4 Small employers and own account workers 1991/1999" 5"5 Lower supervisory and technical occupations 1991/1999" 6"6 Semi-routine occupations 1991/1999" 7"7 Routine occupations 1991/1999" 0"2 Lower managerial and professional occupations 1991/1999"
lab val nssecsynth1 nssecsynth1


gen nssecsynth2=.
replace nssecsynth2=0 if (s_cohort==1)
replace nssecsynth2=0 if (s_cohort==3)
replace nssecsynth2=0 if (s_cohort==2 & nssec==3)
replace nssecsynth2=1 if (s_cohort==2 & nssec==1)
replace nssecsynth2=2 if (s_cohort==2 & nssec==2)
replace nssecsynth2=3 if (s_cohort==2 & nssec==4)
replace nssecsynth2=4 if (s_cohort==2 & nssec==5)
replace nssecsynth2=5 if (s_cohort==2 & nssec==6)
replace nssecsynth2=6 if (s_cohort==2 & nssec==7)
replace nssecsynth2=7 if (s_cohort==2 & nssec==8)

lab def nssecsynth2 1"1.1 Large employers and higher managerial occupations 2000/2009" 2"1.2 Higher professional occupations 2000/2009" 3"3 Intermediate occupations 2000/2009" 4"4 Small employers and own account workers 2000/2009" 5"5 Lower supervisory and technical occupations 2000/2009" 6"6 Semi-routine occupations 2000/2009" 7"7 Routine occupations 2000/2009" 0"2 Lower managerial and professional occupations 2000/2009"
lab val nssecsynth2 nssecsynth2

gen nssecsynth3=.
replace nssecsynth3=0 if (s_cohort==1)
replace nssecsynth3=0 if (s_cohort==2)
replace nssecsynth3=0 if (s_cohort==3 & nssec==3)
replace nssecsynth3=1 if (s_cohort==3 & nssec==1)
replace nssecsynth3=2 if (s_cohort==3 & nssec==2)
replace nssecsynth3=3 if (s_cohort==3 & nssec==4)
replace nssecsynth3=4 if (s_cohort==3 & nssec==5)
replace nssecsynth3=5 if (s_cohort==3 & nssec==6)
replace nssecsynth3=6 if (s_cohort==3 & nssec==7)
replace nssecsynth3=7 if (s_cohort==3 & nssec==8)

lab def nssecsynth3 1"1.1 Large employers and higher managerial occupations 2010/2013" 2"1.2 Higher professional occupations 2010/2013" 3"3 Intermediate occupations 2010/2013" 4"4 Small employers and own account workers 2010/2013" 5"5 Lower supervisory and technical occupations 2010/2013" 6"6 Semi-routine occupations 2010/2013" 7"7 Routine occupations 2010/2013" 0"2 Lower managerial and professional occupations 2010/2013"
lab val nssecsynth3 nssecsynth3



* save data
save synthmi.dta, replace 

mi estimate, post dots: logit econ i.obinc i.obinc2 i.obinc3 i.sexc i.sexc2 i.sexc3 i.tenurec i.tenurec2 i.tenurec3 i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.s_cohort

etable, append

mimrgns, dydx(*) predict(pr)

mi estimate, post dots: svy: logit econ i.obinc i.obinc2 i.obinc3 i.sexc i.sexc2 i.sexc3 i.tenurec i.tenurec2 i.tenurec3 ib(0).nssecsynth1 ib(0).nssecsynth2 ib(0).nssecsynth3 i.s_cohort

etable, append 

mimrgns, dydx(*) predict(pr)

cd"$out_fld"

collect style showbase all 

collect label levels etable_depvar 1 "CRA Weighted Model" ///
								   2 "CRA Weighted Margins Model" ///
								   3 "MI Unweighted" ///
								   4 "MI Weighted", modify
collect style cell, font(Book Antiqua)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f)) ///
cstat(_r_se, nformat(%6.2f)) ///
showstars showstarsnote ///
stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
mstat(N) mstat(aic) mstat(bic) mstat(r2_a) ///
title("Complete Records Analysis of Youth's First Transition using BHPS and UKHLS Samples") ///
titlestyles(font(Book Antiqua, size(12) bold)) ///
note("Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Unweighted N="REDACTED".") ///
notestyles(font(Book Antiqua, size(8) italic)) ///
export("imputed_ukhls_model_v1.docx", replace) 


* Graphs
mi estimate, post dots: svy: logit econ i.obinc i.obinc2 i.obinc3 i.sexc i.sexc2 i.sexc3 i.tenurec i.tenurec2 i.tenurec3 ib(0).nssecsynth1 ib(0).nssecsynth2 ib(0).nssecsynth3 i.s_cohort

mimrgns, predict(pr) dydx(nssecsynth1) 

cd"$out_fld"

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

gen llb=A[1,2] if _n==1
gen llc=A[1,3] if _n==3
gen lld=A[1,4] if _n==5
gen lle=A[1,5] if _n==7
gen llf=A[1,6] if _n==9
gen llg=A[1,7] if _n==11
gen llh=A[1,8] if _n==13
egen lowerbound = rowtotal(llb llc lld lle llf llg llh)
replace lowerbound=. if (lowerbound==0)

gen ulb=A[2,2] if _n==1
gen ulc=A[2,3] if _n==3
gen uld=A[2,4] if _n==5
gen ule=A[2,5] if _n==7
gen ulf=A[2,6] if _n==9
gen ulg=A[2,7] if _n==11
gen ulh=A[2,8] if _n==13
egen upperbound = rowtotal(ulb ulc uld ule ulf ulg ulh)
replace upperbound=. if (upperbound==0)


gen beta=(lowerbound+upperbound)/2

gen grouping=_n if _n==1
replace grouping=_n if _n==3
replace grouping=_n if _n==5
replace grouping=_n if _n==7
replace grouping=_n if _n==9
replace grouping=_n if _n==11
replace grouping=_n if _n==13
label variable grouping "NS-SEC"
label define region 1 "1.1" 3 "1.2" 5 "3" 7 "4" 9 "5" 11 "6" 13 "7"
label value grouping region

graph twoway scatter beta grouping, symbol(Oh) mcolor(red) ///
|| rspike upperbound lowerbound grouping, vert lcolor(red)  /// 
xlabel(1 3 5 7 9 11 13, valuelabel alternate ) ///
name(ukhlsnssecdydxa, replace) ///
saving(ukhlsnssecdydxa, replace)

mimrgns, predict(pr) dydx(nssecsynth2) 

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

gen llbb=A[1,2] if _n==1
gen llcb=A[1,3] if _n==3
gen lldb=A[1,4] if _n==5
gen lleb=A[1,5] if _n==7
gen llfb=A[1,6] if _n==9
gen llgb=A[1,7] if _n==11
gen llhb=A[1,8] if _n==13
egen lowerboundb = rowtotal(llbb llcb lldb lleb llfb llgb llhb)
replace lowerboundb=. if (lowerboundb==0)

gen ulbb=A[2,2] if _n==1
gen ulcb=A[2,3] if _n==3
gen uldb=A[2,4] if _n==5
gen uleb=A[2,5] if _n==7
gen ulfb=A[2,6] if _n==9
gen ulgb=A[2,7] if _n==11
gen ulhb=A[2,8] if _n==13
egen upperboundb = rowtotal(ulbb ulcb uldb uleb ulfb ulgb ulhb)
replace upperboundb=. if (upperboundb==0)


gen betab=(lowerboundb+upperboundb)/2

gen groupingb=_n if _n==1
replace groupingb=_n if _n==3
replace groupingb=_n if _n==5
replace groupingb=_n if _n==7
replace groupingb=_n if _n==9
replace groupingb=_n if _n==11
replace groupingb=_n if _n==13
label variable groupingb "NS-SEC"
label define regionb 1 "1.1" 3 "1.2" 5 "3" 7 "4" 9 "5" 11 "6" 13 "7"
label value groupingb regionb

graph twoway scatter betab groupingb, symbol(Oh) mcolor(red) ///
|| rspike upperboundb lowerboundb groupingb, vert lcolor(red)  /// 
xlabel(1 3 5 7 9 11 13, valuelabel alternate ) ///
name(ukhlsnssecdydxb, replace) ///
saving(ukhlsnssecdydxb, replace)

mimrgns, predict(pr) dydx(nssecsynth3) 

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

gen llbc=A[1,2] if _n==1
gen llcc=A[1,3] if _n==3
gen lldc=A[1,4] if _n==5
gen llec=A[1,5] if _n==7
gen llfc=A[1,6] if _n==9
gen llgc=A[1,7] if _n==11
gen llhc=A[1,8] if _n==13
egen lowerboundc = rowtotal(llbc llcc lldc llec llfc llgc llhc)
replace lowerboundc=. if (lowerboundc==0)

gen ulbc=A[2,2] if _n==1
gen ulcc=A[2,3] if _n==3
gen uldc=A[2,4] if _n==5
gen ulec=A[2,5] if _n==7
gen ulfc=A[2,6] if _n==9
gen ulgc=A[2,7] if _n==11
gen ulhc=A[2,8] if _n==13
egen upperboundc = rowtotal(ulbc ulcc uldc ulec ulfc ulgc ulhc)
replace upperboundc=. if (upperboundc==0)


gen betac=(lowerboundc+upperboundc)/2

gen groupingc=_n if _n==1
replace groupingc=_n if _n==3
replace groupingc=_n if _n==5
replace groupingc=_n if _n==7
replace groupingc=_n if _n==9
replace groupingc=_n if _n==11
replace groupingc=_n if _n==13
label variable groupingc "NS-SEC"
label define regionc 1 "1.1" 3 "1.2" 5 "3" 7 "4" 9 "5" 11 "6" 13 "7"
label value groupingc regionc

graph twoway scatter betac groupingc, symbol(Oh) mcolor(red) ///
|| rspike upperboundc lowerboundc groupingc, vert lcolor(red)  /// 
xlabel(1 3 5 7 9 11 13, valuelabel alternate ) ///
name(ukhlsnssecdydxc, replace) ///
saving(ukhlsnssecdydxc, replace)

* Add jitter to the x-values and apply fixed offset
gen jitter1 = grouping + runiform() * 0.1 - 0.05 - 0.30 // Shift slightly to the left
gen jitter2 = groupingc + runiform() * 0.1 - 0.05 + 0.30 // Shift slightly to the right

graph twoway (scatter beta jitter1, msymbol(oh) mcolor(navy) lcolor(navy)) ///
             || (rspike upperbound lowerbound jitter1, vert fcolor(navy%100) lcolor(navy%100)) ///
             || (scatter betab groupingb, msymbol(dh) mcolor(maroon) lcolor(maroon)) ///
             || (rspike upperboundb lowerboundb groupingb, vert fcolor(maroon%100) lcolor(maroon%100)) ///
			 || (scatter betac jitter2, msymbol(th) mcolor(green) lcolor(green)) ///
             || (rspike upperboundc lowerboundc jitter2, vert fcolor(green%100) lcolor(green%100)) ///
             , xlabel(1"1.1" 3"1.2" 5"3" 7"4" 9"5" 11"6" 13"7", valuelabel labsize(vsmall)) ///
			 ylabel(, labsize(vsmall)) ///
             legend(off) ///
             xtitle("NS-SEC", size(vsmall)) ///
             ytitle("Continuing Schooling", size(vsmall)) ///
             title("AMEs", size(vsmall)) ///
             name(nssecdydxbcombimp, replace) ///
             saving(nssecdydxbcombimp, replace)
			 
graph export "nssecdydxbcombimp.png", width(6000) replace

qui do "${do_fld}/synthmarginsgraphsettings.do"	

mi estimate, post dots: svy: logit econ i.obin#i.s_cohort i.female#i.s_cohort i.tenure#i.s_cohort ib(3).nssec#i.s_cohort i.s_cohort

mimrgns s_cohort, predict(pr) at(nssec=(1 2 3 4 5 6 7 8)) atmeans cmdmargins

mplotoffset, offset(0.2) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(navy) lcolor(navy))  ///
plot2(msymbol(dh) mcolor(maroon) lcolor(maroon))  ///
plot3(msymbol(th) mcolor(green) lcolor(green))  ///
title("Predictive Margins", size(vsmall)) ///
xtitle("NS-SEC", size(vsmall)) ///
ytitle("Continuing Schooling", size(vsmall)) ///
xlabel(1 "1.1" 2 "1.2" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7", labsize(vsmall)) ///
ylabel( , labsize(vsmall)) ///
name(nssecpredcombimp, replace)

graph export "nssecpredcombimp.png", width(6000) replace


graph combine nssecdydxbcombimp nssecpredcombimp, ///
col(1) iscale(0.75) ///
title("Imputed Predictive and Average Marginal Effects of NS-SEC on Continuing Schooling by Synthetic Cohorts", size(vsmall)) ///
caption("Educational Attainment, Sex, Housing Tenure, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Unweighted N="REDACTED". Reference Category NS-SEC 2 for AMEs", size(vsmall)) ///
ycommon ///
name(nsseccombimp, replace)

cd"$out_fld"

graph combine nssecpredcomb nssecpredcombimp nssecdydxbcomb nssecdydxbcombimp , ///
title("Predictive and Average Marginal Effects of NS-SEC on Continuing Schooling by Cohorts", size(vsmall)) ///
subtitle("CRA (left) versus MI (right) models", size(vsmall)) ///
caption("Educational Attainment, Sex, Housing Tenure, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Weighted N="REDACTED". Reference Category NS-SEC 2 for AMEs", size(vsmall)) ///
ycommon 

graph export "nssecmarginscombukhlsimp.png", width(6000) replace



mimrgns s_cohort, predict(pr) at(obin=(0 1)) atmeans vsquish cmdmargins

mplotoffset, offset(0.20) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh)) ///
plot2(msymbol(dh)) ///
plot3(msymbol(th)) ///
    title("Predictive Margins of Educational Attainment on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Unweighted N="REDACTED".", size(vsmall)) ///
    xtitle("Educational Attainment", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "<5 GCSEs" 1 "≥5 GCSEs", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(obincombcohortukhlsimp, replace) ///
	saving(obincombcohortukhlsimp, replace)
	
graph export "obincombcohortukhlsimp.png", width(6000) replace

graph combine obinpredcomb.gph obincombcohortukhlsimp , ///
title("Predictive and Average Marginal Effects of Educational Attainment on Continuing Schooling by Cohorts", size(vsmall)) ///
subtitle("CRA (left) versus MI (right) models", size(vsmall)) ///
caption("NS-SEC, Sex, Housing Tenure, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Weighted N="REDACTED".", size(vsmall)) ///
ycommon 

graph export "obinmarginscombukhlsimp.png", width(6000) replace


mimrgns s_cohort, predict(pr) at(female=(0 1)) atmeans vsquish cmdmargins

mplotoffset, offset(0.20) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh)) ///
plot2(msymbol(dh)) ///
plot3(msymbol(th)) ///
    title("Predictive Margins of Sex on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Unweighted N="REDACTED".", size(vsmall)) ///
    xtitle("Sex", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "Male" 1 "Female", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(sexpredcohortukhlsimp, replace) ///
	saving(sexpredcohortukhlsimp, replace)
	
graph export "sexpredcohortukhlsimp.png", width(6000) replace

graph combine sexpredcomb.gph sexpredcohortukhlsimp , ///
title("Predictive and Average Marginal Effects of Sex on Continuing Schooling by Cohorts", size(vsmall)) ///
subtitle("CRA (left) versus MI (right) models", size(vsmall)) ///
caption("NS-SEC, Educational Attainment, Housing Tenure, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Weighted N="REDACTED".", size(vsmall)) ///
ycommon 

graph export "sexmarginscombukhlsimp.png", width(6000) replace

mimrgns s_cohort, predict(pr) at(tenure=(0 1)) atmeans vsquish cmdmargins

mplotoffset, offset(0.20) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh)) ///
plot2(msymbol(dh)) ///
plot3(msymbol(th)) ///
    title("Predictive Margins of tenure on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Unweighted N="REDACTED".", size(vsmall)) ///
    xtitle("Housing Tenure", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "Don't Own Home" 1 "Own Home", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(tenurepredcohortukhlsomp, replace) ///
	saving(tenurepredcohortukhlsomp, replace)
	
graph export "tenurepredcohortukhlsomp.png", width(6000) replace


graph combine tenurepredcomb.gph tenurepredcohortukhlsomp , ///
title("Predictive and Average Marginal Effects of Housing Tenure on Continuing Schooling by Cohorts", size(vsmall)) ///
subtitle("CRA (left) versus MI (right) models", size(vsmall)) ///
caption("NS-SEC, Educational Attainment, Sex, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Weighted N="REDACTED".", size(vsmall)) ///
ycommon 

graph export "tenuremarginscombukhlsimp.png", width(6000) replace


mi estimate, post dots: svy: logit econ i.obinc i.obinc2 i.obinc3 i.sexc i.sexc2 i.sexc3 i.tenurec i.tenurec2 i.tenurec3 ib(0).nssecsynth1 ib(0).nssecsynth2 ib(0).nssecsynth3 i.s_cohort

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

drop ll* lowerbound* upperbound* beta*

gen lla=0 if _n==5
gen llb=A[1,20] if _n==1
gen llc=A[1,21] if _n==3
gen lld=A[1,22] if _n==7
gen lle=A[1,23] if _n==9
gen llf=A[1,24] if _n==11
gen llg=A[1,25] if _n==13
gen llh=A[1,26] if _n==15
egen lowerbound = rowtotal(lla llb llc lld lle llf llg llh)

gen ula=0 if _n==5
gen ulb=A[2,20] if _n==1
gen ulc=A[2,21] if _n==3
gen uld=A[2,22] if _n==7
gen ule=A[2,23] if _n==9
gen ulf=A[2,24] if _n==11
gen ulg=A[2,25] if _n==13
gen ulh=A[2,26] if _n==15
egen upperbound = rowtotal(ula ulb ulc uld ule ulf ulg ulh)

gen beta=(lowerbound+upperbound)/2

drop ll* ul* 

gen llb=A[1,28] if _n==1
gen llc=A[1,29] if _n==3
gen lld=A[1,30] if _n==7
gen lle=A[1,31] if _n==9
gen llf=A[1,32] if _n==11
gen llg=A[1,33] if _n==13
gen llh=A[1,34] if _n==15
egen lowerbound2 = rowtotal(llb llc lld lle llf llg llh)

gen ulb=A[2,28] if _n==1
gen ulc=A[2,29] if _n==3
gen uld=A[2,30] if _n==7
gen ule=A[2,31] if _n==9
gen ulf=A[2,32] if _n==11
gen ulg=A[2,33] if _n==13
gen ulh=A[2,34] if _n==15
egen upperbound2 = rowtotal(ulb ulc uld ule ulf ulg ulh)

gen beta2=(lowerbound2+upperbound2)/2

drop ll* ul* 

gen llb=A[1,36] if _n==1
gen llc=A[1,37] if _n==3
gen lld=A[1,38] if _n==7
gen lle=A[1,39] if _n==9
gen llf=A[1,40] if _n==11
gen llg=A[1,41] if _n==13
gen llh=A[1,42] if _n==15
egen lowerbound3 = rowtotal(llb llc lld lle llf llg llh)

gen ulb=A[2,36] if _n==1
gen ulc=A[2,37] if _n==3
gen uld=A[2,38] if _n==7
gen ule=A[2,39] if _n==9
gen ulf=A[2,40] if _n==11
gen ulg=A[2,41] if _n==13
gen ulh=A[2,42] if _n==15
egen upperbound3 = rowtotal(ulb ulc uld ule ulf ulg ulh)

gen beta3=(lowerbound3+upperbound3)/2

gen groupingall=_n if _n==5
replace groupingall=_n if _n==1
replace groupingall=_n if _n==3
replace groupingall=_n if _n==7
replace groupingall=_n if _n==9
replace groupingall=_n if _n==11
replace groupingall=_n if _n==13
replace groupingall=_n if _n==15
label variable groupingall "Class"
label define regionsall 1 "1.1" 3 "1.2" 5 "2" 7 "3" 9 "4" 11 "5" 13 "6" 15 "7"
label value groupingall regionsall

graph twoway scatter beta groupingall ///
|| rspike upperbound lowerbound groupingall, vert   /// 
xlabel(1 3 5 7 9 11 13 15, valuelabel alternate )

* Add jitter to the x-values and apply fixed offset
gen jitter1b = groupingall + runiform() * 0.1 - 0.30 // Shift slightly to the left
gen jitter2b = groupingall + runiform() * 0.1 - 0.15 
gen jitter3b = groupingall + runiform() * 0.1 


qui do "${do_fld}/synthmarginsgraphsettings.do"	

graph twoway (scatter beta jitter1b, symbol(oh) mcolor(navy) lcolor(navy) legend(label(1 "Cohort 3"))) || rspike upperbound lowerbound jitter1b, vert fcolor(navy%100) lcolor(navy%100) lwidth(thin) || /// 
(scatter beta2 jitter2b, msymbol(dh) mcolor(maroon) lcolor(maroon) legend(label(3 "Cohort 4"))) || rspike upperbound2 lowerbound2 jitter2b, vert fcolor(maroon%100) lcolor(maroon%100) lwidth(thin) ///
|| (scatter beta3 jitter3b, msymbol(th) mcolor(green) lcolor(green) legend(label(5 "Cohort 5"))) || rspike upperbound3 lowerbound3 jitter3b, vert fcolor(green%100) lcolor(green%100) lwidth(thin) ///
title("Log odds of Continuing Schooling versus Not by Parental NS-SEC", size(small) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(small) color(black)) ///
note("Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Weighted N="REDACTED".", size(vsmall) color(black)) ///
caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall) color(black)) ///
xtitle("NS-SEC", size(small)) ///
xla(1"1.1" 3"1.2" 5"2" 7"3" 9"4" 11"5" 13"6" 15"7", valuelabel ) name(nsseccoef2, replace)

graph combine nsseccoef1 nsseccoef2 , ///
title("Predictive and Average Marginal Effects of Housing Tenure on Continuing Schooling by Cohorts", size(vsmall)) ///
subtitle("CRA (left) versus MI (right) models", size(vsmall)) ///
caption("NS-SEC, Educational Attainment, Sex, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Weighted N="REDACTED".", size(vsmall)) ///
ycommon 

graph export "tenuremarginscombukhlsimp.png", width(6000) replace