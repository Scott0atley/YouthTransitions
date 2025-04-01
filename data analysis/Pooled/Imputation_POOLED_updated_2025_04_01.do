

/*====================================================================
                        1: Imputation
====================================================================*/
clear

use "$dta_fld/merge_cra_pooled_v1"

keep econbin obin sex tenure nssec obinc obinc2 obinc3 obinc4 obinc5 sexc sexc2 sexc3 sexc4 sexc5 tenurec tenurec2 tenurec3 tenurec4 tenurec5 nssecncds nssecbcs nssecsynth1 nssecsynth2 nssecsynth3 cohort strata psu id combined_adult_xw


logit econbin i.obinc i.obinc2 i.obinc3 i.obinc4 i.obinc5 i.sexc i.sexc2 i.sexc3 i.sexc4 i.sexc5 i.tenurec i.tenurec2 i.tenurec3 i.tenurec4 i.tenurec5 i.nssecncds i.nssecbcs i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.cohort

etable 

margins , dydx(*) post

etable, append

replace strata=3126 if cohort==0 | cohort==1 

replace combined_adult_xw=1 if strata==3126

replace psu= 4250 + _n if cohort==0 | cohort==1 

svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)

svy: logit econbin i.obinc i.obinc2 i.obinc3 i.obinc4 i.obinc5 i.sexc i.sexc2 i.sexc3 i.sexc4 i.sexc5 i.tenurec i.tenurec2 i.tenurec3 i.tenurec4 i.tenurec5 i.nssecncds i.nssecbcs i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.cohort

etable, append

margins , dydx(*) post

etable, append

* Weighted Pooled Analysis 

cd "$out_fld"

collect style showbase all

collect label levels etable_depvar 1 "CRA Pooled Model" ///
										2 "CRA Pooled Margins" ///
										3 "CRA Pooled Weighted Model" ///
										4 "CRA Pooled Weighted Margins", modify

collect style cell, font(Book Antiqua)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Unweighted Complete Records Anaylsis versus Weighted Model Investigating young persons first transition") ///
		titlestyles(font(Book Antiqua, size(14) bold)) ///
		note("Data Source: NCDS, BCS, BHPS & UKHLS N= "REDACTED"") ///
		notestyles(font(Book Antiqua, size(8) italic)) ///
		export("craversusweightedcrapooledanalysis.docx", replace)  

svy: logit econbin i.obinc i.obinc2 i.obinc3 i.obinc4 i.obinc5 i.sexc i.sexc2 i.sexc3 i.sexc4 i.sexc5 i.tenurec i.tenurec2 i.tenurec3 i.tenurec4 i.tenurec5 i.nssecncds i.nssecbcs i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.cohort

qv i.nssecncds 
qv i.nssecbcs
qv i.nssecsynth1 
qv i.nssecsynth2 
qv i.nssecsynth3
qv i.cohort 
		
* Imputation 
clear

use "$dta_fld/merge_impute_pooled_v1"

keep econbin obin sex tenure nssec cohort parity breast mage med fed strata psu id combined_adult_xw


mi set flong

replace strata="REDACTED" if cohort==0 | cohort==1 

replace combined_adult_xw=1 if strata=="REDACTED"

replace psu= "REDACTED" + _n if cohort==0 | cohort==1 

mi svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)

mi register imputed econbin obin sex tenure nssec cohort parity breast mage med fed
tab _mi_miss


misstable summarize econbin obin sex tenure nssec cohort
misstable patterns econbin obin sex tenure nssec cohort

mi xtset, clear

capture mi stset, clear 

cd "$dta_fld"

mi impute chained ///
///
(logit, augment) econbin obin sex tenure breast ///
///
(ologit, augment) med fed mage parity ///
///
(mlogit, augment) nssec cohort ///
///
if cohort==1, rseed(12346) dots force add(260) burnin(20) savetrace(subsample_testimpute, replace) 

save merged_cohort_impute_logit.dta, replace

gen obinc=.
replace obinc=0 if (obin==0 & cohort==0)
replace obinc=0 if (cohort==1)
replace obinc=0 if (cohort==2)
replace obinc=0 if (cohort==3)
replace obinc=0 if (cohort==4)
replace obinc=1 if (obin==1 & cohort==0)

gen obinc2=.
replace obinc2=0 if (obin==0 & cohort==1)
replace obinc2=0 if (cohort==0)
replace obinc2=0 if (cohort==2)
replace obinc2=0 if (cohort==3)
replace obinc2=0 if (cohort==4)
replace obinc2=1 if (obin==1 & cohort==1)

gen obinc3=.
replace obinc3=0 if (obin==0 & cohort==2)
replace obinc3=0 if (cohort==0)
replace obinc3=0 if (cohort==1)
replace obinc3=0 if (cohort==3)
replace obinc3=0 if (cohort==4)
replace obinc3=1 if (obin==1 & cohort==2)

gen obinc4=.
replace obinc4=0 if (obin==0 & cohort==3)
replace obinc4=0 if (cohort==0)
replace obinc4=0 if (cohort==1)
replace obinc4=0 if (cohort==2)
replace obinc4=0 if (cohort==4)
replace obinc4=1 if (obin==1 & cohort==3)

gen obinc5=.
replace obinc5=0 if (obin==0 & cohort==4)
replace obinc5=0 if (cohort==0)
replace obinc5=0 if (cohort==1)
replace obinc5=0 if (cohort==2)
replace obinc5=0 if (cohort==3)
replace obinc5=1 if (obin==1 & cohort==4)

gen sexc=.
replace sexc=0 if (sex==0 & cohort==0)
replace sexc=0 if (cohort==1)
replace sexc=0 if (cohort==2)
replace sexc=0 if (cohort==3)
replace sexc=0 if (cohort==4)
replace sexc=1 if (sex==1 & cohort==0)

gen sexc2=.
replace sexc2=0 if (sex==0 & cohort==1)
replace sexc2=0 if (cohort==0)
replace sexc2=0 if (cohort==2)
replace sexc2=0 if (cohort==3)
replace sexc2=0 if (cohort==4)
replace sexc2=1 if (sex==1 & cohort==1)

gen sexc3=.
replace sexc3=0 if (sex==0 & cohort==2)
replace sexc3=0 if (cohort==0)
replace sexc3=0 if (cohort==1)
replace sexc3=0 if (cohort==3)
replace sexc3=0 if (cohort==4)
replace sexc3=1 if (sex==1 & cohort==2)

gen sexc4=.
replace sexc4=0 if (sex==0 & cohort==3)
replace sexc4=0 if (cohort==0)
replace sexc4=0 if (cohort==1)
replace sexc4=0 if (cohort==2)
replace sexc4=0 if (cohort==4)
replace sexc4=1 if (sex==1 & cohort==3)

gen sexc5=.
replace sexc5=0 if (sex==0 & cohort==4)
replace sexc5=0 if (cohort==0)
replace sexc5=0 if (cohort==1)
replace sexc5=0 if (cohort==2)
replace sexc5=0 if (cohort==3)
replace sexc5=1 if (sex==1 & cohort==4)

gen tenurec=.
replace tenurec=0 if (tenure==0 & cohort==0)
replace tenurec=0 if (cohort==1)
replace tenurec=0 if (cohort==2)
replace tenurec=0 if (cohort==3)
replace tenurec=0 if (cohort==4)
replace tenurec=1 if (tenure==1 & cohort==0)

gen tenurec2=.
replace tenurec2=0 if (tenure==0 & cohort==1)
replace tenurec2=0 if (cohort==0)
replace tenurec2=0 if (cohort==2)
replace tenurec2=0 if (cohort==3)
replace tenurec2=0 if (cohort==4)
replace tenurec2=1 if (tenure==1 & cohort==1)

gen tenurec3=.
replace tenurec3=0 if (tenure==0 & cohort==2)
replace tenurec3=0 if (cohort==0)
replace tenurec3=0 if (cohort==1)
replace tenurec3=0 if (cohort==3)
replace tenurec3=0 if (cohort==4)
replace tenurec3=1 if (tenure==1 & cohort==2)

gen tenurec4=.
replace tenurec4=0 if (tenure==0 & cohort==3)
replace tenurec4=0 if (cohort==0)
replace tenurec4=0 if (cohort==1)
replace tenurec4=0 if (cohort==2)
replace tenurec4=0 if (cohort==4)
replace tenurec4=1 if (tenure==1 & cohort==3)

gen tenurec5=.
replace tenurec5=0 if (tenure==0 & cohort==4)
replace tenurec5=0 if (cohort==0)
replace tenurec5=0 if (cohort==1)
replace tenurec5=0 if (cohort==2)
replace tenurec5=0 if (cohort==3)
replace tenurec5=1 if (tenure==1 & cohort==4)

gen nssecncds=.
replace nssecncds=0 if (cohort==1)
replace nssecncds=0 if (cohort==2)
replace nssecncds=0 if (cohort==3)
replace nssecncds=0 if (cohort==4)
replace nssecncds=0 if (cohort==0 & nssec==3)
replace nssecncds=1 if (cohort==0 & nssec==1)
replace nssecncds=2 if (cohort==0 & nssec==2)
replace nssecncds=3 if (cohort==0 & nssec==4)
replace nssecncds=4 if (cohort==0 & nssec==5)
replace nssecncds=5 if (cohort==0 & nssec==6)
replace nssecncds=6 if (cohort==0 & nssec==7)
replace nssecncds=7 if (cohort==0 & nssec==8)

gen nssecbcs=.
replace nssecbcs=0 if (cohort==0)
replace nssecbcs=0 if (cohort==2)
replace nssecbcs=0 if (cohort==3)
replace nssecbcs=0 if (cohort==4)
replace nssecbcs=0 if (cohort==1 & nssec==3)
replace nssecbcs=1 if (cohort==1 & nssec==1)
replace nssecbcs=2 if (cohort==1 & nssec==2)
replace nssecbcs=3 if (cohort==1 & nssec==4)
replace nssecbcs=4 if (cohort==1 & nssec==5)
replace nssecbcs=5 if (cohort==1 & nssec==6)
replace nssecbcs=6 if (cohort==1 & nssec==7)
replace nssecbcs=7 if (cohort==1 & nssec==8)

gen nssecsynth1=.
replace nssecsynth1=0 if (cohort==0)
replace nssecsynth1=0 if (cohort==1)
replace nssecsynth1=0 if (cohort==3)
replace nssecsynth1=0 if (cohort==4)
replace nssecsynth1=0 if (cohort==2 & nssec==3)
replace nssecsynth1=1 if (cohort==2 & nssec==1)
replace nssecsynth1=2 if (cohort==2 & nssec==2)
replace nssecsynth1=3 if (cohort==2 & nssec==4)
replace nssecsynth1=4 if (cohort==2 & nssec==5)
replace nssecsynth1=5 if (cohort==2 & nssec==6)
replace nssecsynth1=6 if (cohort==2 & nssec==7)
replace nssecsynth1=7 if (cohort==2 & nssec==8)

gen nssecsynth2=.
replace nssecsynth2=0 if (cohort==0)
replace nssecsynth2=0 if (cohort==1)
replace nssecsynth2=0 if (cohort==2)
replace nssecsynth2=0 if (cohort==4)
replace nssecsynth2=0 if (cohort==3 & nssec==3)
replace nssecsynth2=1 if (cohort==3 & nssec==1)
replace nssecsynth2=2 if (cohort==3 & nssec==2)
replace nssecsynth2=3 if (cohort==3 & nssec==4)
replace nssecsynth2=4 if (cohort==3 & nssec==5)
replace nssecsynth2=5 if (cohort==3 & nssec==6)
replace nssecsynth2=6 if (cohort==3 & nssec==7)
replace nssecsynth2=7 if (cohort==3 & nssec==8)

gen nssecsynth3=.
replace nssecsynth3=0 if (cohort==0)
replace nssecsynth3=0 if (cohort==1)
replace nssecsynth3=0 if (cohort==2)
replace nssecsynth3=0 if (cohort==3)
replace nssecsynth3=0 if (cohort==4 & nssec==3)
replace nssecsynth3=1 if (cohort==4 & nssec==1)
replace nssecsynth3=2 if (cohort==4 & nssec==2)
replace nssecsynth3=3 if (cohort==4 & nssec==4)
replace nssecsynth3=4 if (cohort==4 & nssec==5)
replace nssecsynth3=5 if (cohort==4 & nssec==6)
replace nssecsynth3=6 if (cohort==4 & nssec==7)
replace nssecsynth3=7 if (cohort==4 & nssec==8)

lab drop cohort_lbl 
qui do "${do_fld}\setupdefinelabels.do"	
qui do "${do_fld}\setupapplylabels.do"	

mi estimate, saving(miestfile1, replace) post dots: logit econbin i.obinc i.obinc2 i.obinc3 i.obinc4 i.obinc5 i.sexc i.sexc2 i.sexc3 i.sexc4 i.sexc5 i.tenurec i.tenurec2 i.tenurec3 i.tenurec4 i.tenurec5 i.nssecncds i.nssecbcs i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.cohort

est store imputed

etable

mimrgns, dydx(*) predict(pr)

mi estimate, saving(miestfile2, replace) post dots: svy: logit econbin i.obinc i.obinc2 i.obinc3 i.obinc4 i.obinc5 i.sexc i.sexc2 i.sexc3 i.sexc4 i.sexc5 i.tenurec i.tenurec2 i.tenurec3 i.tenurec4 i.tenurec5 i.nssecncds i.nssecbcs i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.cohort

est store imputedweight

etable, append

mimrgns, dydx(*) predict(pr)

cd "$out_fld"

collect style showbase all

collect label levels etable_depvar 1 "imp" ///
								   2 "imp weighted", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Imputation Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: ") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("impute.docx", replace)  
		
/*====================================================================
                        2: Graphs
====================================================================*/

cd "$out_fld"

mi estimate, saving(miestfile2, replace) post dots: svy: logit econbin i.obinc i.obinc2 i.obinc3 i.obinc4 i.obinc5 i.sexc i.sexc2 i.sexc3 i.sexc4 i.sexc5 i.tenurec i.tenurec2 i.tenurec3 i.tenurec4 i.tenurec5 i.nssecncds i.nssecbcs i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.cohort

mimrgns, predict(pr) dydx(nssecncds) 

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

drop ll* ul* beta* lowerbound* upperbound*

gen llb1=A[1,2] if _n==1
gen llc1=A[1,3] if _n==3
gen lld1=A[1,4] if _n==5
gen lle1=A[1,5] if _n==7
gen llf1=A[1,6] if _n==9
gen llg1=A[1,7] if _n==11
gen llh1=A[1,8] if _n==13
egen lowerbound1 = rowtotal(llb1 llc1 lld1 lle1 llf1 llg1 llh1)
replace lowerbound1=. if (lowerbound1==0)

gen ulb1=A[2,2] if _n==1
gen ulc1=A[2,3] if _n==3
gen uld1=A[2,4] if _n==5
gen ule1=A[2,5] if _n==7
gen ulf1=A[2,6] if _n==9
gen ulg1=A[2,7] if _n==11
gen ulh1=A[2,8] if _n==13
egen upperbound1 = rowtotal(ulb1 ulc1 uld1 ule1 ulf1 ulg1 ulh1)
replace upperbound1=. if (upperbound1==0)


gen beta1=(lowerbound1+upperbound1)/2

gen grouping1=_n if _n==1
replace grouping1=_n if _n==3
replace grouping1=_n if _n==5
replace grouping1=_n if _n==7
replace grouping1=_n if _n==9
replace grouping1=_n if _n==11
replace grouping1=_n if _n==13
label variable grouping1 "NS-SEC"
label define region1 1 "1.1" 3 "1.2" 5 "3" 7 "4" 9 "5" 11 "6" 13 "7"
label value grouping1 region1

graph twoway scatter beta1 grouping1, symbol(Oh) mcolor(red) ///
|| rspike upperbound1 lowerbound1 grouping1, vert lcolor(red)  /// 
xlabel(1 3 5 7 9 11 13, valuelabel alternate ) ///
name(ukhlsnssecdydxa1, replace) ///
saving(ukhlsnssecdydxa1, replace)

mimrgns, predict(pr) dydx(nssecbcs) 

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

gen llb1b=A[1,2] if _n==1
gen llc1b=A[1,3] if _n==3
gen lld1b=A[1,4] if _n==5
gen lle1b=A[1,5] if _n==7
gen llf1b=A[1,6] if _n==9
gen llg1b=A[1,7] if _n==11
gen llh1b=A[1,8] if _n==13
egen lowerbound1b = rowtotal(llb1b llc1b lld1b lle1b llf1b llg1b llh1b)
replace lowerbound1b=. if (lowerbound1b==0)

gen ulb1b=A[2,2] if _n==1
gen ulc1b=A[2,3] if _n==3
gen uld1b=A[2,4] if _n==5
gen ule1b=A[2,5] if _n==7
gen ulf1b=A[2,6] if _n==9
gen ulg1b=A[2,7] if _n==11
gen ulh1b=A[2,8] if _n==13
egen upperbound1b = rowtotal(ulb1b ulc1b uld1b ule1b ulf1b ulg1b ulh1b)
replace upperbound1b=. if (upperbound1b==0)


gen beta1b=(lowerbound1b+upperbound1b)/2

gen grouping1b=_n if _n==1
replace grouping1b=_n if _n==3
replace grouping1b=_n if _n==5
replace grouping1b=_n if _n==7
replace grouping1b=_n if _n==9
replace grouping1b=_n if _n==11
replace grouping1b=_n if _n==13
label variable grouping1b "NS-SEC"
label define region1b 1 "1.1" 3 "1.2" 5 "3" 7 "4" 9 "5" 11 "6" 13 "7"
label value grouping1b region1b

graph twoway scatter beta1b grouping1b, symbol(Oh) mcolor(red) ///
|| rspike upperbound1b lowerbound1b grouping1b, vert lcolor(red)  /// 
xlabel(1 3 5 7 9 11 13, valuelabel alternate ) ///
name(ukhlsnssecdydxa1b, replace) ///
saving(ukhlsnssecdydxa1b, replace)

mimrgns, predict(pr) dydx(nssecsynth1) 

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



* Add jitter to the x-values and apply fixed offset
gen jitter1 = grouping1 + runiform() * 0.1 - 0.45 // Shift slightly to the left
gen jitter2 = grouping1b + runiform() * 0.1 - 0.30 
gen jitter3 = grouping + runiform() * 0.1 
gen jitter4 = groupingb + runiform() * 0.1 + 0.30
gen jitter5 = groupingc + runiform() * 0.1 + 0.45

qui do "${do_fld}/pooledmarginsgraphsettings.do"	

graph twoway (scatter beta1 jitter1, msymbol(oh) mcolor(navy) lcolor(navy)) ///
             || (rspike upperbound1 lowerbound1 jitter1, vert fcolor(navy%100) lcolor(navy%100)) ///
             || (scatter beta1b jitter2, msymbol(dh) mcolor(maroon) lcolor(maroon)) ///
             || (rspike upperbound1b lowerbound1b jitter2, vert fcolor(maroon%100) lcolor(maroon%100)) ///
			 || (scatter beta jitter3, msymbol(th) mcolor(green) lcolor(green)) ///
             || (rspike upperbound lowerbound jitter3, vert fcolor(green%100) lcolor(green%100)) ///
			 || (scatter betab jitter4, msymbol(sh) mcolor(orange) lcolor(orange)) ///
             || (rspike upperboundb lowerboundb jitter4, vert fcolor(orange%100) lcolor(orange%100)) ///
			 || (scatter betac jitter5, msymbol(x) mcolor(teal) lcolor(teal)) ///
             || (rspike upperboundc lowerboundc jitter5, vert fcolor(teal%100) lcolor(teal%100)) ///
             , xlabel(1"1.1" 3"1.2" 5"3" 7"4" 9"5" 11"6" 13"7", valuelabel labsize(vsmall)) ///
			 ylabel(, labsize(vsmall)) ///
             legend(off) ///
             xtitle("NS-SEC", size(vsmall)) ///
             ytitle("Continuing Schooling", size(vsmall)) ///
             title("AMEs", size(vsmall)) ///
             name(nssecdydxbcombimppooled, replace) ///
             saving(nssecdydxbcombimppooled, replace)
			 
graph export "nssecdydxbcombimppooled.png", width(6000) replace

mi estimate, saving(miestfile2, replace) post dots: svy: logit econbin i.obin#i.cohort i.sex#i.cohort i.tenure#i.cohort ib(3).nssec#i.cohort i.cohort

mimrgns cohort, predict(pr) at(nssec=(1 2 3 4 5 6 7 8)) atmeans cmdmargins

mplotoffset, offset(0.15) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh)) ///
plot2(msymbol(dh)) ///
plot3(msymbol(th)) ///
plot4(msymbol(sh)) ///
plot5(msymbol(x)) ///
title("Predictive Margins", size(vsmall)) ///
xtitle("NS-SEC", size(vsmall)) ///
ytitle("Continuing Schooling", size(vsmall)) ///
xlabel(1 "1.1" 2 "1.2" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7", labsize(vsmall)) ///
ylabel( , labsize(vsmall)) ///
name(nssecpredcombimppooled, replace) ///
saving(nssecpredcombimppooled, replace)

graph export "nssecpredcombimppooled.png", width(6000) replace

graph combine nssecdydxbcombimppooled nssecpredcombimppooled, ///
col(1) iscale(0.75) ///
title("Imputed Predictive and Average Marginal Effects of NS-SEC on Continuing Schooling by Cohorts", size(vsmall)) ///
caption("Educational Attainment, Sex, Housing Tenure, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: NCDS, BCS, BHPS & UKHLS. Weighted N="REDACTED". Reference Category NS-SEC 2", size(vsmall)) ///
ycommon 

graph export "nssecmarginscombimppooled.png", width(6000) replace

graph combine nssecpredcombsvy nssecpredcombimppooled nssecdydxbcomb nssecdydxbcombimppooled , ///
title("Predictive and Average Marginal Effects of NS-SEC on Continuing Schooling by Cohorts", size(vsmall)) ///
subtitle("CRA (left) versus MI (right) models", size(vsmall)) ///
caption("Educational Attainment, Sex, Housing Tenure, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: NCDS, BCS, BHPS & UKHLS. Weighted N="REDACTED". Reference Category NS-SEC 2 for AMEs", size(vsmall)) ///
ycommon 

graph export "nssecmarginscombimp.png", width(6000) replace



mi estimate, saving(miestfile2, replace) post dots: svy: logit econbin i.obinc i.obinc2 i.obinc3 i.obinc4 i.obinc5 i.sexc i.sexc2 i.sexc3 i.sexc4 i.sexc5 i.tenurec i.tenurec2 i.tenurec3 i.tenurec4 i.tenurec5 i.nssecncds i.nssecbcs i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.cohort

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

drop ll* ul* beta* lowerbound* upperbound* grouping* 

gen lla=0 if _n==5
gen llb=A[1,32] if _n==1
gen llc=A[1,33] if _n==3
gen lld=A[1,34] if _n==7
gen lle=A[1,35] if _n==9
gen llf=A[1,36] if _n==11
gen llg=A[1,37] if _n==13
gen llh=A[1,38] if _n==15
egen lowerbound = rowtotal(lla llb llc lld lle llf llg llh)

gen ula=0 if _n==5
gen ulb=A[2,32] if _n==1
gen ulc=A[2,33] if _n==3
gen uld=A[2,34] if _n==7
gen ule=A[2,35] if _n==9
gen ulf=A[2,36] if _n==11
gen ulg=A[2,37] if _n==13
gen ulh=A[2,38] if _n==15
egen upperbound = rowtotal(ula ulb ulc uld ule ulf ulg ulh)

gen beta=(lowerbound+upperbound)/2

drop ll* ul* 

gen llb=A[1,40] if _n==1
gen llc=A[1,41] if _n==3
gen lld=A[1,42] if _n==7
gen lle=A[1,43] if _n==9
gen llf=A[1,44] if _n==11
gen llg=A[1,45] if _n==13
gen llh=A[1,46] if _n==15
egen lowerbound2 = rowtotal(llb llc lld lle llf llg llh)

gen ulb=A[2,40] if _n==1
gen ulc=A[2,41] if _n==3
gen uld=A[2,42] if _n==7
gen ule=A[2,43] if _n==9
gen ulf=A[2,44] if _n==11
gen ulg=A[2,45] if _n==13
gen ulh=A[2,46] if _n==15
egen upperbound2 = rowtotal(ulb ulc uld ule ulf ulg ulh)

gen beta2=(lowerbound2+upperbound2)/2

drop ll* ul* 

gen llb=A[1,48] if _n==1
gen llc=A[1,49] if _n==3
gen lld=A[1,50] if _n==7
gen lle=A[1,51] if _n==9
gen llf=A[1,52] if _n==11
gen llg=A[1,53] if _n==13
gen llh=A[1,54] if _n==15
egen lowerbound3 = rowtotal(llb llc lld lle llf llg llh)

gen ulb=A[2,48] if _n==1
gen ulc=A[2,49] if _n==3
gen uld=A[2,50] if _n==7
gen ule=A[2,51] if _n==9
gen ulf=A[2,52] if _n==11
gen ulg=A[2,53] if _n==13
gen ulh=A[2,54] if _n==15
egen upperbound3 = rowtotal(ulb ulc uld ule ulf ulg ulh)

gen beta3=(lowerbound3+upperbound3)/2

drop ll* ul* 

gen llb=A[1,56] if _n==1
gen llc=A[1,57] if _n==3
gen lld=A[1,58] if _n==7
gen lle=A[1,59] if _n==9
gen llf=A[1,60] if _n==11
gen llg=A[1,61] if _n==13
gen llh=A[1,62] if _n==15
egen lowerbound4 = rowtotal(llb llc lld lle llf llg llh)

gen ulb=A[2,56] if _n==1
gen ulc=A[2,57] if _n==3
gen uld=A[2,58] if _n==7
gen ule=A[2,59] if _n==9
gen ulf=A[2,60] if _n==11
gen ulg=A[2,61] if _n==13
gen ulh=A[2,62] if _n==15
egen upperbound4 = rowtotal(ulb ulc uld ule ulf ulg ulh)

gen beta4=(lowerbound4+upperbound4)/2

drop ll* ul* 

gen llb=A[1,64] if _n==1
gen llc=A[1,65] if _n==3
gen lld=A[1,66] if _n==7
gen lle=A[1,67] if _n==9
gen llf=A[1,68] if _n==11
gen llg=A[1,69] if _n==13
gen llh=A[1,70] if _n==15
egen lowerbound5 = rowtotal(llb llc lld lle llf llg llh)

gen ulb=A[2,64] if _n==1
gen ulc=A[2,65] if _n==3
gen uld=A[2,66] if _n==7
gen ule=A[2,67] if _n==9
gen ulf=A[2,68] if _n==11
gen ulg=A[2,69] if _n==13
gen ulh=A[2,70] if _n==15
egen upperbound5 = rowtotal(ulb ulc uld ule ulf ulg ulh)

gen beta5=(lowerbound5+upperbound5)/2

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
gen jitter4b = groupingall + runiform() * 0.1 + 0.15
gen jitter5b = groupingall + runiform() * 0.1 + 0.30


qui do "${do_fld}/pooledmarginsgraphsettings.do"	

graph twoway (scatter beta jitter1b, symbol(oh) mcolor(navy) lcolor(navy) legend(label(1 "Cohort 1"))) || rspike upperbound lowerbound jitter1b, vert fcolor(navy%100) lcolor(navy%100) lwidth(thin) || /// 
(scatter beta2 jitter2b, msymbol(dh) mcolor(maroon) lcolor(maroon) legend(label(3 "Cohort 2"))) || rspike upperbound2 lowerbound2 jitter2b, vert fcolor(maroon%100) lcolor(maroon%100) lwidth(thin) ///
|| (scatter beta3 jitter3b, msymbol(th) mcolor(green) lcolor(green) legend(label(5 "Cohort 3"))) || rspike upperbound3 lowerbound3 jitter3b, vert fcolor(green%100) lcolor(green%100) lwidth(thin) ///
|| (scatter beta4 jitter4b, msymbol(sh) mcolor(orange) lcolor(orange) legend(label(7 "Cohort 4"))) || rspike upperbound4 lowerbound4 jitter4b, vert fcolor(orange%100) lcolor(orange%100) lwidth(thin) ///
|| (scatter beta5 jitter5b, msymbol(x) mcolor(teal) lcolor(teal) legend(label(9 "Cohort 5"))) || rspike upperbound5 lowerbound5 jitter5b, vert fcolor(teal%100) lcolor(teal%100) lwidth(thin) ///
xtitle("NS-SEC", size(small)) ///
xla(1"1.1" 3"1.2" 5"2" 7"3" 9"4" 11"5" 13"6" 15"7", valuelabel ) ///
legend(off) ///
name(nsseccoef1misvy, replace) 


graph combine nsseccoef1svyplain.gph nsseccoef1misvy , ///
title("Log odds of Continuing Schooling versus Not by Parental NS-SEC", size(vsmall)) ///
subtitle("CRA (left) versus MI (right) models", size(vsmall)) ///
caption("Educational Attainment, Sex, Housing Tenure, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: NCDS, BCS, BHPS & UKHLS. CRA N=*REDACTED*, MI N="REDACTED". Reference Category NS-SEC 2 for AMEs. SVY Adjusted.", size(vsmall)) ///
ycommon /// 
name(nsseccoefsvycombmi, replace) ///
saving(nsseccoefsvycombmi, replace)


graph export "nsseccoefsvycombmi.png", width(6000) replace



qui do "${do_fld}/pooledmarginsgraphsettings.do"	

mi estimate, saving(miestfile2, replace) post dots: svy: logit econbin i.obin#i.cohort i.sex#i.cohort i.tenure#i.cohort ib(3).nssec#i.cohort i.cohort


mimrgns cohort, predict(pr) at(obin=(0 1)) atmeans vsquish cmdmargins

mplotoffset, offset(0.15) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh)) ///
plot2(msymbol(dh)) ///
plot3(msymbol(th)) ///
plot4(msymbol(sh)) ///
plot5(msymbol(x)) ///
    xtitle("Educational Attainment", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "<5" 1 "≥5", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(obincombcohortimp, replace) ///
	saving(obincombcohortimp, replace)
	
graph export "obincombcohortimp.png", width(6000) replace

graph combine obinpredcomb obincombcohortimp , ///
title("Predictive and Average Marginal Effects of Educational Attainment on Continuing Schooling by Cohorts", size(vsmall)) ///
subtitle("CRA (left) versus MI (right) models", size(vsmall)) ///
caption("NS-SEC, Sex, Housing Tenure, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: NCDS, BCS, BHPS & UKHLS. CRA N=*REDACTED*, MI N="REDACTED". Reference Category NS-SEC 2 for AMEs. SVY Adjusted.", size(vsmall)) ///
ycommon ///
name(obinmarginscombimpsvy, replace) ///
saving(obinmarginscombimpsvy, replace)

graph export "obinmarginscombimp.png", width(6000) replace


mimrgns cohort, predict(pr) at(sex=(0 1)) atmeans vsquish cmdmargins

mplotoffset, offset(0.15) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh)) ///
plot2(msymbol(dh)) ///
plot3(msymbol(th)) ///
plot4(msymbol(sh)) ///
plot5(msymbol(x)) ///
    xtitle("Sex", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "Male" 1 "Female", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(sexpredcohortimp, replace) ///
	saving(sexpredcohortimp, replace)
	
graph export "sexpredcohortimp.png", width(6000) replace

graph combine sexpredcomb.gph sexpredcohortimp , ///
title("Predictive and Average Marginal Effects of Sex on Continuing Schooling by Cohorts", size(vsmall)) ///
subtitle("CRA (left) versus MI (right) models", size(vsmall)) ///
caption("NS-SEC, Educational Attainment, Housing Tenure, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: NCDS, BCS, BHPS & UKHLS. CRA N="REDACTED", MI N="REDACTED". Reference Category NS-SEC 2 for AMEs. SVY Adjusted.", size(vsmall)) ///
ycommon ///
name(sexmarginscombimpsvy, replace) ///
saving(sexmarginscombimpsvy, replace)

graph export "sexmarginscombimpsvy.png", width(6000) replace

mimrgns cohort, predict(pr) at(tenure=(0 1)) atmeans vsquish cmdmargins

mplotoffset, offset(0.15) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh)) ///
plot2(msymbol(dh)) ///
plot3(msymbol(th)) ///
plot4(msymbol(sh)) ///
plot5(msymbol(x)) ///
    xtitle("Housing Tenure", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "Don't Own Home" 1 "Own Home", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(tenurepredcohortimp, replace) ///
	saving(tenurepredcohortimp, replace)
	
graph export "tenurepredcohortimp.png", width(6000) replace


graph combine tenurepredcomb.gph tenurepredcohortimp , ///
title("Predictive and Average Marginal Effects of Housing Tenure on Continuing Schooling by Cohorts", size(vsmall)) ///
subtitle("CRA (left) versus MI (right) models", size(vsmall)) ///
caption("NS-SEC, Educational Attainment, Sex, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: NCDS, BCS, BHPS & UKHLS. CRA N="REDACTED", MI N="REDACTED". Reference Category NS-SEC 2 for AMEs. SVY Adjusted.", size(vsmall)) ///
ycommon ///
name(tenuremarginscombukhlsimpsvy, replace) ///
saving(tenuremarginscombukhlsimpsvy, replace)

graph export "tenuremarginscombukhlsimp.png", width(6000) replace



*

mi estimate, saving(miestfile1, replace) post dots: logit econbin i.obinc i.obinc2 i.obinc3 i.obinc4 i.obinc5 i.sexc i.sexc2 i.sexc3 i.sexc4 i.sexc5 i.tenurec i.tenurec2 i.tenurec3 i.tenurec4 i.tenurec5 i.nssecncds i.nssecbcs i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.cohort

mimrgns, dydx(*) predict(pr)

mi estimate, saving(miestfile2, replace) post dots: svy: logit econbin i.obinc i.obinc2 i.obinc3 i.obinc4 i.obinc5 i.sexc i.sexc2 i.sexc3 i.sexc4 i.sexc5 i.tenurec i.tenurec2 i.tenurec3 i.tenurec4 i.tenurec5 i.nssecncds i.nssecbcs i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.cohort

mimrgns, dydx(*) predict(pr)

