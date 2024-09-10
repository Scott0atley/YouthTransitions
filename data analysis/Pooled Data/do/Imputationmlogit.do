

/*====================================================================
                        1: Imputation
====================================================================*/
clear

use "$dta_fld/merge_impute"

gen cohort=0 if (id >=1 & id <=8411)
replace cohort=1 if (id >=8412 & id <=19672)


mi set flong

mi register imputed econ201 obin sex tenure nssec cohort parity breast mage med fed
tab _mi_miss
		

cd "$dta_fld"

mi impute chained ///
///
(logit, augment) obin sex tenure cohort breast ///
///
(ologit, augment) med fed mage parity ///
///
(mlogit, augment) econ201 nssec ///
///
if cohort==1, rseed(12346) dots force add(260) burnin(20) savetrace(subsample_testimpute, replace) 

save merged_cohort_impute_mlogit, replace



gen obinc=.
replace obinc=0 if (obin==0 & cohort==0)
replace obinc=0 if (cohort==1)
replace obinc=1 if (obin==1 & cohort==0)

gen obinc2=.
replace obinc2=0 if (obin==0 & cohort==1)
replace obinc2=0 if (cohort==0)
replace obinc2=1 if (obin==1 & cohort==1)

gen sexc=.
replace sexc=0 if (sex==0 & cohort==0)
replace sexc=0 if (cohort==1)
replace sexc=1 if (sex==1 & cohort==0)

gen sexc2=.
replace sexc2=0 if (sex==0 & cohort==1)
replace sexc2=0 if (cohort==0)
replace sexc2=1 if (sex==1 & cohort==1)

gen tenurec=.
replace tenurec=0 if (tenure==0 & cohort==0)
replace tenurec=0 if (cohort==1)
replace tenurec=1 if (tenure==1 & cohort==0)

gen tenurec2=.
replace tenurec2=0 if (tenure==0 & cohort==1)
replace tenurec2=0 if (cohort==0)
replace tenurec2=1 if (tenure==1 & cohort==1)

gen nssecncds=.
replace nssecncds=0 if (cohort==1)
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
replace nssecbcs=0 if (cohort==1 & nssec==3)
replace nssecbcs=1 if (cohort==1 & nssec==1)
replace nssecbcs=2 if (cohort==1 & nssec==2)
replace nssecbcs=3 if (cohort==1 & nssec==4)
replace nssecbcs=4 if (cohort==1 & nssec==5)
replace nssecbcs=5 if (cohort==1 & nssec==6)
replace nssecbcs=6 if (cohort==1 & nssec==7)
replace nssecbcs=7 if (cohort==1 & nssec==8)


mi estimate, saving(miestfile1, replace) post dots: mlogit econ201 i.obinc i.obinc2 i.sexc i.sexc2 i.tenurec i.tenurec2 i.nssecncds i.nssecbcs i.cohort

est store imputed

etable

mimrgns, dydx(*) predict(pr)

mimrgns, dydx(*) predict(outcome(1))

mimrgns, dydx(*) predict(outcome(3))

mimrgns, dydx(*) predict(outcome(4))

coefplot

cd "$out_fld"

collect style showbase all

collect label levels etable_depvar 1 "imp", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Imputation Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: NCDS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("imputemlogit.docx", replace)  
		
/*====================================================================
                        2: Graphs
====================================================================*/

cd "$dta_fld"

mi estimate, saving(miestfile2b, replace) post dots: mlogit econ201 i.obin#i.cohort i.sex#i.cohort i.tenure#i.cohort ib(3).nssec#i.cohort i.cohort

mimrgns if cohort==0, predict(outcome(1)) dydx(nssec) cmdmargins

cd "$out_fld"

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

gen llb=A[1,1] if _n==1
gen llc=A[1,2] if _n==3
gen lld=A[1,4] if _n==5
gen lle=A[1,5] if _n==7
gen llf=A[1,6] if _n==9
gen llg=A[1,7] if _n==11
gen llh=A[1,8] if _n==13
egen lowerbound = rowtotal(llb llc lld lle llf llg llh)
replace lowerbound=. if (lowerbound==0)

gen ulb=A[2,1] if _n==1
gen ulc=A[2,2] if _n==3
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
label variable grouping "Class"
label define region 1 "1.1" 3 "1.2" 5 "3" 7 "4" 9 "5" 11 "6" 13 "7"
label value grouping region

graph twoway scatter beta grouping, symbol(oh) mcolor(red) ///
|| rspike upperbound lowerbound grouping, vert lcolor(red)  /// 
xlabel(1 3 5 7 9 11 13, valuelabel alternate ) ///
name(mlogit1dydx, replace) ///
saving(mlogit1dydx, replace)



mimrgns if cohort==0, predict(outcome(3)) dydx(nssec) cmdmargins

matrix list e(b)
matrix list r(table)
matrix define Ab = r(table)
matrix define Ab = Ab["ll".."ul", 1...]
matrix list Ab

drop ll* ul* 

gen llb=Ab[1,1] if _n==1
gen llc=Ab[1,2] if _n==3
gen lld=Ab[1,4] if _n==5
gen lle=Ab[1,5] if _n==7
gen llf=Ab[1,6] if _n==9
gen llg=Ab[1,7] if _n==11
gen llh=Ab[1,8] if _n==13
egen lowerboundb = rowtotal(llb llc lld lle llf llg llh)
replace lowerboundb=. if (lowerboundb==0)

gen ulb=Ab[2,1] if _n==1
gen ulc=Ab[2,2] if _n==3
gen uld=Ab[2,4] if _n==5
gen ule=Ab[2,5] if _n==7
gen ulf=Ab[2,6] if _n==9
gen ulg=Ab[2,7] if _n==11
gen ulh=Ab[2,8] if _n==13
egen upperboundb = rowtotal(ulb ulc uld ule ulf ulg ulh)
replace upperboundb=. if (upperboundb==0)


gen betab=(lowerboundb+upperboundb)/2

gen groupingb=_n if _n==1
replace groupingb=_n if _n==3
replace groupingb=_n if _n==5
replace groupingb=_n if _n==7
replace groupingb=_n if _n==9
replace groupingb=_n if _n==11
replace groupingb=_n if _n==13
label variable groupingb "Class"
label value groupingb region

graph twoway scatter betab groupingb, symbol(dh) mcolor(red) ///
|| rspike upperboundb lowerboundb groupingb, vert lcolor(red)  /// 
xlabel(1 3 5 7 9 11 13, valuelabel alternate ) ///
name(mlogit3dydx, replace) ///
saving(mlogit3dydx, replace)



mimrgns if cohort==0, predict(outcome(4)) dydx(nssec) cmdmargins

matrix list e(b)
matrix list r(table)
matrix define Ac = r(table)
matrix define Ac = Ac["ll".."ul", 1...]
matrix list Ac

drop ll* ul* 

gen llb=Ac[1,1] if _n==1
gen llc=Ac[1,2] if _n==3
gen lld=Ac[1,4] if _n==5
gen lle=Ac[1,5] if _n==7
gen llf=Ac[1,6] if _n==9
gen llg=Ac[1,7] if _n==11
gen llh=Ac[1,8] if _n==13
egen lowerboundc = rowtotal(llb llc lld lle llf llg llh)
replace lowerboundc=. if (lowerboundc==0)

gen ulb=Ac[2,1] if _n==1
gen ulc=Ac[2,2] if _n==3
gen uld=Ac[2,4] if _n==5
gen ule=Ac[2,5] if _n==7
gen ulf=Ac[2,6] if _n==9
gen ulg=Ac[2,7] if _n==11
gen ulh=Ac[2,8] if _n==13
egen upperboundc = rowtotal(ulb ulc uld ule ulf ulg ulh)
replace upperboundc=. if (upperboundc==0)


gen betac=(lowerboundc+upperboundc)/2

gen groupingc=_n if _n==1
replace groupingc=_n if _n==3
replace groupingc=_n if _n==5
replace groupingc=_n if _n==7
replace groupingc=_n if _n==9
replace groupingc=_n if _n==11
replace groupingc=_n if _n==13
label variable groupingc "Class"
label value groupingc region

graph twoway scatter betac groupingc, symbol(th) mcolor(red) ///
|| rspike upperboundc lowerboundc groupingc, vert lcolor(red)  /// 
xlabel(1 3 5 7 9 11 13, valuelabel alternate ) ///
name(mlogit4dydx, replace) ///
saving(mlogit4dydx, replace)


* Generate jittered and offset variables
gen jitter1 = grouping - 0.2 + runiform() * 0.1
gen jitter2 = grouping + runiform() * 0.1
gen jitter3 = grouping + 0.2 + runiform() * 0.1

graph twoway (scatter beta grouping, symbol(oh) mcolor(red)) || rspike upperbound lowerbound grouping, lcolor(red%60) || ///
(scatter betab groupingb, msymbol(dh) mcolor(red)) || rspike upperboundb lowerboundb groupingb, lcolor(red%60) || ///
(scatter betac groupingc, msymbol(th) mcolor(red)) || rspike upperboundc lowerboundc groupingc, lcolor(red%60) ///
title("AMEs", size(vsmall)) ///
xtitle("NS-SEC", size(vsmall)) ///
xla(1"1.1" 3"1.2" 5"3" 7"4" 9"5" 11"6" 13"7", valuelabel labsize(vsmall)) name(mlologitnssecdydx, replace) ///
ytitle("Continuing Schooling", size(vsmall)) ///
yla( , labsize(vsmall)) ///
legend(rows(2)) ///
legend(order(1 "Employment NCDS" 3 "Apprenticeship NCDS" 5 "Unemployment & OLF NCDS")) 

graph export "mlologitnssecdydx.png", width(6000) replace





mimrgns if cohort==1, predict(outcome(1)) dydx(nssec) cmdmargins

matrix list e(b)
matrix list r(table)
matrix define A1 = r(table)
matrix define A1 = A1["ll".."ul", 1...]
matrix list A1

drop ll* ul* 

gen llb=A1[1,1] if _n==2
gen llc=A1[1,2] if _n==4
gen lld=A1[1,4] if _n==6
gen lle=A1[1,5] if _n==8
gen llf=A1[1,6] if _n==10
gen llg=A1[1,7] if _n==12
gen llh=A1[1,8] if _n==14
egen lowerbound1 = rowtotal(llb llc lld lle llf llg llh)
replace lowerbound1=. if (lowerbound1==0)

gen ulb=A1[2,1] if _n==2
gen ulc=A1[2,2] if _n==4
gen uld=A1[2,4] if _n==6
gen ule=A1[2,5] if _n==8
gen ulf=A1[2,6] if _n==10
gen ulg=A1[2,7] if _n==12
gen ulh=A1[2,8] if _n==14
egen upperbound1 = rowtotal(ulb ulc uld ule ulf ulg ulh)
replace upperbound1=. if (upperbound1==0)


gen beta1=(lowerbound1+upperbound1)/2

gen grouping1=_n if _n==2
replace grouping1=_n if _n==4
replace grouping1=_n if _n==6
replace grouping1=_n if _n==8
replace grouping1=_n if _n==10
replace grouping1=_n if _n==12
replace grouping1=_n if _n==14
label variable grouping1 "Class"
label define region1 2 "1.1" 4 "1.2" 6 "3" 8 "4" 10 "5" 12 "6" 14 "7"
label value grouping1 region1

graph twoway scatter beta1 grouping1, symbol(oh) mcolor(blue) ///
|| rspike upperbound1 lowerbound1 grouping1, vert lcolor(blue)  /// 
xlabel(2 4 6 8 10 12 14, valuelabel alternate ) ///
name(mlogit1adydx, replace) ///
saving(mlogit1adydx, replace)



mimrgns if cohort==1, predict(outcome(3)) dydx(nssec) cmdmargins

matrix list e(b)
matrix list r(table)
matrix define Ab2 = r(table)
matrix define Ab2 = Ab2["ll".."ul", 1...]
matrix list Ab2

drop ll* ul* 

gen llb=Ab2[1,1] if _n==2
gen llc=Ab2[1,2] if _n==4
gen lld=Ab2[1,4] if _n==6
gen lle=Ab2[1,5] if _n==8
gen llf=Ab2[1,6] if _n==10
gen llg=Ab2[1,7] if _n==12
gen llh=Ab2[1,8] if _n==14
egen lowerboundb2 = rowtotal(llb llc lld lle llf llg llh)
replace lowerboundb2=. if (lowerboundb2==0)

gen ulb=Ab2[2,1] if _n==2
gen ulc=Ab2[2,2] if _n==4
gen uld=Ab2[2,4] if _n==6
gen ule=Ab2[2,5] if _n==8
gen ulf=Ab2[2,6] if _n==10
gen ulg=Ab2[2,7] if _n==12
gen ulh=Ab2[2,8] if _n==14
egen upperboundb2 = rowtotal(ulb ulc uld ule ulf ulg ulh)
replace upperboundb2=. if (upperboundb2==0)


gen betab2=(lowerboundb2+upperboundb2)/2

gen groupingb2=_n if _n==2
replace groupingb2=_n if _n==4
replace groupingb2=_n if _n==6
replace groupingb2=_n if _n==8
replace groupingb2=_n if _n==10
replace groupingb2=_n if _n==12
replace groupingb2=_n if _n==14
label variable groupingb2 "Class"
label value groupingb2 region1

graph twoway scatter betab2 groupingb2, symbol(dh) mcolor(blue) ///
|| rspike upperboundb2 lowerboundb2 groupingb2, vert lcolor(blue)  /// 
xlabel(2 4 6 8 10 12 14, valuelabel alternate ) ///
name(mlogit3bdydx, replace) ///
saving(mlogit3bdydx, replace)



mimrgns if cohort==1, predict(outcome(4)) dydx(nssec) cmdmargins

matrix list e(b)
matrix list r(table)
matrix define Ac3 = r(table)
matrix define Ac3 = Ac3["ll".."ul", 1...]
matrix list Ac3

drop ll* ul* 

gen llb=Ac3[1,1] if _n==2
gen llc=Ac3[1,2] if _n==4
gen lld=Ac3[1,4] if _n==6
gen lle=Ac3[1,5] if _n==8
gen llf=Ac3[1,6] if _n==10
gen llg=Ac3[1,7] if _n==12
gen llh=Ac3[1,8] if _n==14
egen lowerboundc3 = rowtotal(llb llc lld lle llf llg llh)
replace lowerboundc3=. if (lowerboundc3==0)

gen ulb3=Ac3[2,1] if _n==2
gen ulc3=Ac3[2,2] if _n==4
gen uld3=Ac3[2,4] if _n==6
gen ule3=Ac3[2,5] if _n==8
gen ulf3=Ac3[2,6] if _n==10
gen ulg3=Ac3[2,7] if _n==12
gen ulh3=Ac3[2,8] if _n==14
egen upperboundc3 = rowtotal(ulb ulc uld ule ulf ulg ulh)
replace upperboundc3=. if (upperboundc3==0)


gen betac3=(lowerboundc3+upperboundc3)/2

gen groupingc3=_n if _n==2
replace groupingc3=_n if _n==4
replace groupingc3=_n if _n==6
replace groupingc3=_n if _n==8
replace groupingc3=_n if _n==10
replace groupingc3=_n if _n==12
replace groupingc3=_n if _n==14
label variable groupingc3 "Class"
label value groupingc3 region1

graph twoway scatter betac3 groupingc3, symbol(th) mcolor(blue) ///
|| rspike upperboundc3 lowerboundc3 groupingc3, vert lcolor(blue)  /// 
xlabel(2 4 6 8 10 12 14, valuelabel alternate ) ///
name(mlogit4bdydx, replace) ///
saving(mlogit4bdydx, replace)


* Generate jittered and offset variables
gen jitter1b = grouping1 - 0.2 + runiform() * 0.1
gen jitter2b = grouping1 + runiform() * 0.1
gen jitter3b = grouping1 + 0.2 + runiform() * 0.1

graph twoway (scatter beta1 grouping1, symbol(oh) mcolor(blue)) || rspike upperbound1 lowerbound1 grouping1, lcolor(blue%60) || ///
(scatter betab2 groupingb2, msymbol(dh) mcolor(blue)) || rspike upperboundb2 lowerboundb2 groupingb2, lcolor(blue%60) || ///
(scatter betac3 groupingc3, msymbol(th) mcolor(blue)) || rspike upperboundc3 lowerboundc3 groupingc3, lcolor(blue%60) ///
title("AMEs", size(vsmall)) ///
xtitle("NS-SEC", size(vsmall)) ///
xla(2"1.1" 4"1.2" 6"3" 8"4" 10"5" 12"6" 14"7", valuelabel labsize(vsmall)) name(mlologitnssecdydx, replace) ///
ytitle("Continuing Schooling", size(vsmall)) ///
yla( , labsize(vsmall)) ///
legend(rows(2)) ///
legend(order(1 "Employment BCS" 3 "Apprenticeship BCS" 5 "Unemployment & OLF BCS")) 

graph export "mlologitnssecdydxb.png", width(6000) replace

qui do "${do_fld}/pooledmarginsgraphsettings.do"		

graph twoway (scatter beta grouping, symbol(oh) mcolor(red)) || rspike upperbound lowerbound grouping, lcolor(red%60) || ///
(scatter beta1 grouping1, symbol(dh) mcolor(blue)) || rspike upperbound1 lowerbound1 grouping1, lcolor(blue%60) ///
title("AMEs Employment", size(vsmall)) ///
xtitle("NS-SEC", size(vsmall)) ///
xla(1"1.1" 3"1.2" 5"3" 7"4" 9"5" 11"6" 13"7", valuelabel labsize(vsmall)) name(mlologitnssecdydx, replace) ///
ytitle("Employment", size(vsmall)) ///
yla( , labsize(vsmall)) ///
legend(off) ///
saving(mlogitnssecb1, replace)

graph export "mlogitnssecb1.png", width(6000) replace


graph twoway (scatter betab groupingb, msymbol(oh) mcolor(red)) || rspike upperboundb lowerboundb groupingb, lcolor(red%60) || ///
(scatter betab2 groupingb2, msymbol(dh) mcolor(blue)) || rspike upperboundb2 lowerboundb2 groupingb2, lcolor(blue%60) ///
title("AMEs Apprenticeship", size(vsmall)) ///
xtitle("NS-SEC", size(vsmall)) ///
xla(1"1.1" 3"1.2" 5"3" 7"4" 9"5" 11"6" 13"7", valuelabel labsize(vsmall)) name(mlologitnssecdydx, replace) ///
ytitle("Apprenticeship", size(vsmall)) ///
yla( , labsize(vsmall)) ///
legend(off) ///
saving(mlogitnssecb3, replace)

graph export "mlogitnssecb3.png", width(6000) replace


graph twoway (scatter betac groupingc, msymbol(oh) mcolor(red)) || rspike upperboundc lowerboundc groupingc, lcolor(red%60) || ///
(scatter betac3 groupingc3, msymbol(dh) mcolor(blue)) || rspike upperboundc3 lowerboundc3 groupingc3, lcolor(blue%60) ///
title("AMEs Unemployment & OLF", size(vsmall)) ///
xtitle("NS-SEC", size(vsmall)) ///
xla(1"1.1" 3"1.2" 5"3" 7"4" 9"5" 11"6" 13"7", valuelabel labsize(vsmall)) name(mlologitnssecdydx, replace) ///
ytitle("Unemployment & OLF", size(vsmall)) ///
yla( , labsize(vsmall)) ///
legend(rows(2)) ///
legend(order(1 "NCDS" 3 "BCS")) ///
saving(mlogitnssecb4, replace)

graph export "mlogitnssecb4.png", width(6000) replace


graph combine mlogitnssecb1.gph mlogitnssecb3.gph mlogitnssecb4.gph, ///
ycommon

graph export "mlogitcombnssec.png", width(6000) replace


drop ll* ul* lowerbound* upperbound* beta* grouping*

mimrgns if cohort==0, predict(outcome(1)) at(nssec=(1 2 3 4 5 6 7 8)) atmeans cmdmargins

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

gen llb=A[1,1] if _n==1
gen llc=A[1,2] if _n==3
gen llc1=A[1,3] if _n==5
gen lld=A[1,4] if _n==7
gen lle=A[1,5] if _n==9
gen llf=A[1,6] if _n==11
gen llg=A[1,7] if _n==13
gen llh=A[1,8] if _n==15
egen lowerbound = rowtotal(llb llc llc1 lld lle llf llg llh)
replace lowerbound=. if (lowerbound==0)

gen ulb=A[2,1] if _n==1
gen ulc=A[2,2] if _n==3
gen ulc1=A[2,3] if _n==5
gen uld=A[2,4] if _n==7
gen ule=A[2,5] if _n==9
gen ulf=A[2,6] if _n==11
gen ulg=A[2,7] if _n==13
gen ulh=A[2,8] if _n==15
egen upperbound = rowtotal(ulb ulc ulc1 uld ule ulf ulg ulh)
replace upperbound=. if (upperbound==0)


gen beta=(lowerbound+upperbound)/2

gen grouping=_n if _n==1
replace grouping=_n if _n==3
replace grouping=_n if _n==5
replace grouping=_n if _n==7
replace grouping=_n if _n==9
replace grouping=_n if _n==11
replace grouping=_n if _n==13
replace grouping=_n if _n==15
label define regional 1 "1.1" 3 "1.2" 5 "2" 7 "3" 9 "4" 11 "5" 13 "6" 15 "7"
label variable grouping "Class"
label value grouping regional

graph twoway scatter beta grouping, symbol(oh) mcolor(red) ///
|| rspike upperbound lowerbound grouping, vert lcolor(red)  /// 
xlabel(1 3 5 7 9 11 13 15, valuelabel alternate ) ///
name(mlogit1pred, replace) ///
saving(mlogit1pred, replace)

mimrgns if cohort==0, predict(outcome(3)) at(nssec=(1 2 3 4 5 6 7 8)) atmeans cmdmargins

matrix list e(b)
matrix list r(table)
matrix define Ab = r(table)
matrix define Ab = Ab["ll".."ul", 1...]
matrix list Ab

drop ll* ul* 

gen llb=Ab[1,1] if _n==1
gen llc=Ab[1,2] if _n==3
gen llc1=Ab[1,3] if _n==5
gen lld=Ab[1,4] if _n==7
gen lle=Ab[1,5] if _n==9
gen llf=Ab[1,6] if _n==11
gen llg=Ab[1,7] if _n==13
gen llh=Ab[1,8] if _n==15
egen lowerboundb = rowtotal(llb llc llc1 lld lle llf llg llh)
replace lowerboundb=. if (lowerboundb==0)

gen ulb=Ab[2,1] if _n==1
gen ulc=Ab[2,2] if _n==3
gen ulc1=Ab[2,3] if _n==5
gen uld=Ab[2,4] if _n==7
gen ule=Ab[2,5] if _n==9
gen ulf=Ab[2,6] if _n==11
gen ulg=Ab[2,7] if _n==13
gen ulh=Ab[2,8] if _n==15
egen upperboundb = rowtotal(ulb ulc ulc1 uld ule ulf ulg ulh)
replace upperboundb=. if (upperboundb==0)


gen betab=(lowerboundb+upperboundb)/2

gen groupingb=_n if _n==1
replace groupingb=_n if _n==3
replace groupingb=_n if _n==5
replace groupingb=_n if _n==7
replace groupingb=_n if _n==9
replace groupingb=_n if _n==11
replace groupingb=_n if _n==13
replace groupingb=_n if _n==15
label variable groupingb "Class"
label value groupingb regional

graph twoway scatter betab groupingb, symbol(dh) mcolor(red) ///
|| rspike upperboundb lowerboundb groupingb, vert lcolor(red)  /// 
xlabel(1 3 5 7 9 11 13 15, valuelabel alternate ) ///
name(mlogit3pred, replace) ///
saving(mlogit3pred, replace)


mimrgns if cohort==0, predict(outcome(4)) at(nssec=(1 2 3 4 5 6 7 8)) atmeans cmdmargins

matrix list e(b)
matrix list r(table)
matrix define Ac = r(table)
matrix define Ac = Ac["ll".."ul", 1...]
matrix list Ac

drop ll* ul* 

gen llb=Ac[1,1] if _n==1
gen llc=Ac[1,2] if _n==3
gen llc1=Ac[1,3] if _n==5
gen lld=Ac[1,4] if _n==7
gen lle=Ac[1,5] if _n==9
gen llf=Ac[1,6] if _n==11
gen llg=Ac[1,7] if _n==13
gen llh=Ac[1,8] if _n==15
egen lowerboundc = rowtotal(llb llc llc1 lld lle llf llg llh)
replace lowerboundc=. if (lowerboundc==0)

gen ulb=Ac[2,1] if _n==1
gen ulc=Ac[2,2] if _n==3
gen ulc1=Ac[2,3] if _n==5
gen uld=Ac[2,4] if _n==7
gen ule=Ac[2,5] if _n==9
gen ulf=Ac[2,6] if _n==11
gen ulg=Ac[2,7] if _n==13
gen ulh=Ac[2,8] if _n==15
egen upperboundc = rowtotal(ulb ulc ulc1 uld ule ulf ulg ulh)
replace upperboundc=. if (upperboundc==0)


gen betac=(lowerboundc+upperboundc)/2

gen groupingc=_n if _n==1
replace groupingc=_n if _n==3
replace groupingc=_n if _n==5
replace groupingc=_n if _n==7
replace groupingc=_n if _n==9
replace groupingc=_n if _n==11
replace groupingc=_n if _n==13
replace groupingc=_n if _n==15
label variable groupingc "Class"
label value groupingc regional

graph twoway scatter betac groupingc, symbol(th) mcolor(red) ///
|| rspike upperboundc lowerboundc groupingc, vert lcolor(red)  /// 
xlabel(1 3 5 7 9 11 13 15, valuelabel alternate ) ///
name(mlogit4pred, replace) ///
saving(mlogit4pred, replace)


mimrgns if cohort==1, predict(outcome(1)) at(nssec=(1 2 3 4 5 6 7 8)) atmeans cmdmargins

matrix list e(b)
matrix list r(table)
matrix define A1 = r(table)
matrix define A1 = A1["ll".."ul", 1...]
matrix list A1

drop ll* ul* 

gen llb=A1[1,1] if _n==2
gen llc=A1[1,2] if _n==4
gen llc1=A1[1,3] if _n==6
gen lld=A1[1,4] if _n==8
gen lle=A1[1,5] if _n==10
gen llf=A1[1,6] if _n==12
gen llg=A1[1,7] if _n==14
gen llh=A1[1,8] if _n==16
egen lowerbound1 = rowtotal(llb llc llc1 lld lle llf llg llh)
replace lowerbound1=. if (lowerbound1==0)

gen ulb=A1[2,1] if _n==2
gen ulc=A1[2,2] if _n==4
gen ulc1=A1[2,3] if _n==6
gen uld=A1[2,4] if _n==8
gen ule=A1[2,5] if _n==10
gen ulf=A1[2,6] if _n==12
gen ulg=A1[2,7] if _n==14
gen ulh=A1[2,8] if _n==16
egen upperbound1 = rowtotal(ulb ulc ulc1 uld ule ulf ulg ulh)
replace upperbound1=. if (upperbound1==0)


gen beta1=(lowerbound1+upperbound1)/2

gen grouping1=_n if _n==2
replace grouping1=_n if _n==4
replace grouping1=_n if _n==6
replace grouping1=_n if _n==8
replace grouping1=_n if _n==10
replace grouping1=_n if _n==12
replace grouping1=_n if _n==14
replace grouping1=_n if _n==16
label define regional1 2 "1.1" 4 "1.2" 6 "2" 8 "3" 10"4" 12 "5" 14 "6" 16 "7"
label variable grouping1 "Class"
label value grouping1 regional1

graph twoway scatter beta1 grouping1, symbol(oh) mcolor(blue) ///
|| rspike upperbound1 lowerbound1 grouping1, vert lcolor(blue)  /// 
xlabel(2 4 6 8 10 12 14 16, valuelabel alternate ) ///
name(mlogit1apred, replace) ///
saving(mlogit1apred, replace)



mimrgns if cohort==1, predict(outcome(3)) at(nssec=(1 2 3 4 5 6 7 8)) atmeans cmdmargins

matrix list e(b)
matrix list r(table)
matrix define Ab2 = r(table)
matrix define Ab2 = Ab2["ll".."ul", 1...]
matrix list Ab2

drop ll* ul* 

gen llb=Ab2[1,1] if _n==2
gen llc=Ab2[1,2] if _n==4
gen llc1=Ab2[1,3] if _n==6
gen lld=Ab2[1,4] if _n==8
gen lle=Ab2[1,5] if _n==10
gen llf=Ab2[1,6] if _n==12
gen llg=Ab2[1,7] if _n==14
gen llh=Ab2[1,8] if _n==16
egen lowerboundb2 = rowtotal(llb llc llc1 lld lle llf llg llh)
replace lowerboundb2=. if (lowerboundb2==0)

gen ulb=Ab2[2,1] if _n==2
gen ulc=Ab2[2,2] if _n==4
gen ulc1=Ab2[2,3] if _n==6
gen uld=Ab2[2,4] if _n==8
gen ule=Ab2[2,5] if _n==10
gen ulf=Ab2[2,6] if _n==12
gen ulg=Ab2[2,7] if _n==14
gen ulh=Ab2[2,8] if _n==16
egen upperboundb2 = rowtotal(ulb ulc ulc1 uld ule ulf ulg ulh)
replace upperboundb2=. if (upperboundb2==0)


gen betab2=(lowerboundb2+upperboundb2)/2

gen groupingb2=_n if _n==2
replace groupingb2=_n if _n==4
replace groupingb2=_n if _n==6
replace groupingb2=_n if _n==8
replace groupingb2=_n if _n==10
replace groupingb2=_n if _n==12
replace groupingb2=_n if _n==14
replace groupingb2=_n if _n==16
label variable groupingb2 "Class"
label value groupingb2 regional1

graph twoway scatter betab2 groupingb2, symbol(dh) mcolor(blue) ///
|| rspike upperboundb2 lowerboundb2 groupingb2, vert lcolor(blue)  /// 
xlabel(2 4 6 8 10 12 14 16, valuelabel alternate ) ///
name(mlogit3bpred, replace) ///
saving(mlogit3bpred, replace)



mimrgns if cohort==1, predict(outcome(4)) at(nssec=(1 2 3 4 5 6 7 8)) atmeans cmdmargins

matrix list e(b)
matrix list r(table)
matrix define Ac3 = r(table)
matrix define Ac3 = Ac3["ll".."ul", 1...]
matrix list Ac3

drop ll* ul* 

gen llb=Ac3[1,1] if _n==2
gen llc=Ac3[1,2] if _n==4
gen llc1=Ac3[1,3] if _n==6
gen lld=Ac3[1,4] if _n==8
gen lle=Ac3[1,5] if _n==10
gen llf=Ac3[1,6] if _n==12
gen llg=Ac3[1,7] if _n==14
gen llh=Ac3[1,8] if _n==16
egen lowerboundc3 = rowtotal(llb llc llc1 lld lle llf llg llh)
replace lowerboundc3=. if (lowerboundc3==0)

gen ulb=Ac3[2,1] if _n==2
gen ulc=Ac3[2,2] if _n==4
gen ulc1=Ac3[2,3] if _n==6
gen uld=Ac3[2,4] if _n==8
gen ule=Ac3[2,5] if _n==10
gen ulf=Ac3[2,6] if _n==12
gen ulg=Ac3[2,7] if _n==14
gen ulh=Ac3[2,8] if _n==16
egen upperboundc3 = rowtotal(ulb ulc ulc1 uld ule ulf ulg ulh)
replace upperboundc3=. if (upperboundc3==0)


gen betac3=(lowerboundc3+upperboundc3)/2

gen groupingc3=_n if _n==2
replace groupingc3=_n if _n==4
replace groupingc3=_n if _n==6
replace groupingc3=_n if _n==8
replace groupingc3=_n if _n==10
replace groupingc3=_n if _n==12
replace groupingc3=_n if _n==14
replace groupingc3=_n if _n==16
label variable groupingc3 "Class"
label value groupingc3 regional1

graph twoway scatter betac3 groupingc3, symbol(th) mcolor(blue) ///
|| rspike upperboundc3 lowerboundc3 groupingc3, vert lcolor(blue)  /// 
xlabel(2 4 6 8 10 12 14 16, valuelabel alternate ) ///
name(mlogit4bpred, replace) ///
saving(mlogit4bpred, replace)


graph twoway (scatter beta grouping, symbol(oh) mcolor(red)) || rspike upperbound lowerbound grouping, lcolor(red%60) || ///
(scatter beta1 grouping1, symbol(dh) mcolor(blue)) || rspike upperbound1 lowerbound1 grouping1, lcolor(blue%60) ///
title("Predictive Margins Employment", size(vsmall)) ///
xtitle("NS-SEC", size(vsmall)) ///
xla(1"1.1" 3"1.2" 5"2" 7"3" 9"4" 11"5" 13"6" 15"7", valuelabel labsize(vsmall)) name(mlologitnssecdydx, replace) ///
ytitle("Employment", size(vsmall)) ///
yla( , labsize(vsmall)) ///
legend(off) ///
saving(mlogitnssecb1pred2, replace)

graph export "mlogitnssecb1pred2.png", width(6000) replace


graph twoway (scatter betab groupingb, msymbol(oh) mcolor(red)) || rspike upperboundb lowerboundb groupingb, lcolor(red%60) || ///
(scatter betab2 groupingb2, msymbol(dh) mcolor(blue)) || rspike upperboundb2 lowerboundb2 groupingb2, lcolor(blue%60) ///
title("Predictive Margins Apprenticeship", size(vsmall)) ///
xtitle("NS-SEC", size(vsmall)) ///
xla(1"1.1" 3"1.2" 5"2" 7"3" 9"4" 11"5" 13"6" 15"7", valuelabel labsize(vsmall)) name(mlologitnssecdydx, replace) ///
ytitle("Apprenticeship", size(vsmall)) ///
yla( , labsize(vsmall)) ///
legend(off) ///
saving(mlogitnssecb3pred2, replace)

graph export "mlogitnssecb3pred2.png", width(6000) replace


graph twoway (scatter betac groupingc, msymbol(oh) mcolor(red)) || rspike upperboundc lowerboundc groupingc, lcolor(red%60) || ///
(scatter betac3 groupingc3, msymbol(dh) mcolor(blue)) || rspike upperboundc3 lowerboundc3 groupingc3, lcolor(blue%60) ///
title("Predictive Margins Unemployment & OLF", size(vsmall)) ///
xtitle("NS-SEC", size(vsmall)) ///
xla(1"1.1" 3"1.2" 5"2" 7"3" 9"4" 11"5" 13"6" 15"7", valuelabel labsize(vsmall)) name(mlologitnssecdydx, replace) ///
ytitle("Unemployment & OLF", size(vsmall)) ///
yla( , labsize(vsmall)) ///
legend(off) ///
saving(mlogitnssecb4pred2, replace)

graph export "mlogitnssecb4pred2.png", width(6000) replace


graph combine mlogitnssecb1pred2.gph mlogitnssecb3pred2.gph mlogitnssecb4pred2.gph, ///
ycommon

graph export "mlogitcombnssecpred.png", width(6000) replace


graph combine mlogitnssecb1pred2.gph mlogitnssecb3pred2.gph mlogitnssecb4pred2.gph mlogitnssecb1.gph mlogitnssecb3.gph mlogitnssecb4.gph, ///
ycommon

graph export "mlogitcombnssecpred.png", width(6000) replace

qui do "${do_fld}\pooledmarginsgraphsettings.do"	


mimrgns cohort, predict(outcome(1)) at(obin=(0 1)) atmeans cmdmargins

mplotoffset, offset(0.05) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
    title("Predictive Margins of Educational Attainment on Employment by Cohorts", size(vsmall)) ///
	subtitle("Multnominal logistic regression using continuing schooling as the reference category", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 19672", size(vsmall)) ///
    xtitle("Educational Attainment", size(vsmall)) ///
    ytitle("Employment", size(vsmall)) ///
    xlabel(0 "<5" 1 "≥5", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	legend(rows(1)) ///
	legend(order(3 "NCDS" 4 "BCS")) ///
	name(mlogitobin1, replace) ///
	saving(mlogitobin1, replace)
	
graph export "mlogitobin1.png", width(6000) replace

mimrgns cohort, predict(outcome(3)) at(obin=(0 1)) atmeans cmdmargins

mplotoffset, offset(0.05) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
    title("Predictive Margins of Educational Attainment on Apprenticeship by Cohorts", size(vsmall)) ///
	subtitle("Multnominal logistic regression using continuing schooling as the reference category", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 19672", size(vsmall)) ///
    xtitle("Educational Attainment", size(vsmall)) ///
    ytitle("Apprenticeship", size(vsmall)) ///
    xlabel(0 "<5" 1 "≥5", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	legend(rows(1)) ///
	legend(order(3 "NCDS" 4 "BCS")) ///
	name(mlogitobin3, replace) ///
	saving(mlogitobin3, replace)
	
graph export "mlogitobin3.png", width(6000) replace

mimrgns cohort, predict(outcome(4)) at(obin=(0 1)) atmeans cmdmargins


mplotoffset, offset(0.05) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
    title("Predictive Margins of Educational Attainment on Unemployment & OLF by Cohorts", size(vsmall)) ///
	subtitle("Multnominal logistic regression using continuing schooling as the reference category", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 19672", size(vsmall)) ///
    xtitle("Educational Attainment", size(vsmall)) ///
    ytitle("Unemployment & OLF", size(vsmall)) ///
    xlabel(0 "<5" 1 "≥5", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	legend(rows(1)) ///
	legend(order(3 "NCDS" 4 "BCS")) ///
	name(mlogitobin4, replace) ///
	saving(mlogitobin4, replace)
	
graph export "mlogitobin4.png", width(6000) replace

qui do "${do_fld}/pooledmarginsgraphsettings.do"		

graph combine mlogitobin1 mlogitobin3 mlogitobin4, ///
	title("Predictive Margins of Educational Attainment by Cohorts", size(vsmall)) ///
	subtitle("Multnominal logistic regression using continuing schooling as the reference category", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 19672", size(vsmall)) ///
	ycommon

graph export "mlogitobin.png", width(6000) replace


mimrgns cohort, predict(outcome(1)) at(sex=(0 1)) atmeans cmdmargins

mplotoffset, offset(0.05) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
    title("Predictive Margins of Educational Attainment on Employment by Cohorts", size(vsmall)) ///
	subtitle("Multnominal logistic regression using continuing schooling as the reference category", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 19672", size(vsmall)) ///
    xtitle("Educational Attainment", size(vsmall)) ///
    ytitle("Employment", size(vsmall)) ///
    xlabel(0 "Female" 1 "Male", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	legend(rows(1)) ///
	legend(order(3 "NCDS" 4 "BCS")) ///
	name(mlogitsex1, replace) ///
	saving(mlogitsex1, replace)
	
graph export "mlogitsex1.png", width(6000) replace

mimrgns cohort, predict(outcome(3)) at(sex=(0 1)) atmeans cmdmargins

mplotoffset, offset(0.05) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
    title("Predictive Margins of Educational Attainment on Apprenticeship by Cohorts", size(vsmall)) ///
	subtitle("Multnominal logistic regression using continuing schooling as the reference category", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 19672", size(vsmall)) ///
    xtitle("Educational Attainment", size(vsmall)) ///
    ytitle("Apprenticeship", size(vsmall)) ///
    xlabel(0 "Female" 1 "Male", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	legend(rows(1)) ///
	legend(order(3 "NCDS" 4 "BCS")) ///
	name(mlogitsex3, replace) ///
	saving(mlogitsex3, replace)
	
graph export "mlogitsex3.png", width(6000) replace

mimrgns cohort, predict(outcome(4)) at(sex=(0 1)) atmeans cmdmargins


mplotoffset, offset(0.05) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
    title("Predictive Margins of Educational Attainment on Unemployment & OLF by Cohorts", size(vsmall)) ///
	subtitle("Multnominal logistic regression using continuing schooling as the reference category", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 19672", size(vsmall)) ///
    xtitle("Educational Attainment", size(vsmall)) ///
    ytitle("Unemployment & OLF", size(vsmall)) ///
    xlabel(0 "Female" 1 "Male", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	legend(rows(1)) ///
	legend(order(3 "NCDS" 4 "BCS")) ///
	name(mlogitsex4, replace) ///
	saving(mlogitsex4, replace)
	
graph export "mlogitsex4.png", width(6000) replace


graph combine mlogitsex1 mlogitsex3 mlogitsex4, ///
	title("Predictive Margins of Sex by Cohorts", size(vsmall)) ///
	subtitle("Multnominal logistic regression using continuing schooling as the reference category", size(vsmall)) ///
	caption("Educational Attainment, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 19672. BCS Cohort conditionally imputed.", size(vsmall)) ///
	ycommon



mimrgns cohort, predict(outcome(1)) at(tenure=(0 1)) atmeans cmdmargins

mplotoffset, offset(0.05) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
    title("Predictive Margins of Educational Attainment on Employment by Cohorts", size(vsmall)) ///
	subtitle("Multnominal logistic regression using continuing schooling as the reference category", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 19672", size(vsmall)) ///
    xtitle("Educational Attainment", size(vsmall)) ///
    ytitle("Employment", size(vsmall)) ///
    xlabel(0 "Own Home" 1 "Don't Own", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	legend(rows(1)) ///
	legend(order(3 "NCDS" 4 "BCS")) ///
	name(mlogittenure1, replace) ///
	saving(mlogittenure1, replace)
	
graph export "mlogittenure1.png", width(6000) replace

mimrgns cohort, predict(outcome(3)) at(tenure=(0 1)) atmeans cmdmargins

mplotoffset, offset(0.05) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
    title("Predictive Margins of Educational Attainment on Apprenticeship by Cohorts", size(vsmall)) ///
	subtitle("Multnominal logistic regression using continuing schooling as the reference category", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 19672", size(vsmall)) ///
    xtitle("Educational Attainment", size(vsmall)) ///
    ytitle("Apprenticeship", size(vsmall)) ///
    xlabel(0 "Own Home" 1 "Don't Own", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	legend(rows(1)) ///
	legend(order(3 "NCDS" 4 "BCS")) ///
	name(mlogittenure3, replace) ///
	saving(mlogittenure3, replace)
	
graph export "mlogittenure3.png", width(6000) replace

mimrgns cohort, predict(outcome(4)) at(tenure=(0 1)) atmeans cmdmargins


mplotoffset, offset(0.05) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
    title("Predictive Margins of Educational Attainment on Unemployment & OLF by Cohorts", size(vsmall)) ///
	subtitle("Multnominal logistic regression using continuing schooling as the reference category", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 19672", size(vsmall)) ///
    xtitle("Educational Attainment", size(vsmall)) ///
    ytitle("Unemployment & OLF", size(vsmall)) ///
    xlabel(0 "Own Home" 1 "Don't Own", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	legend(rows(1)) ///
	legend(order(3 "NCDS" 4 "BCS")) ///
	name(mlogittenure4, replace) ///
	saving(mlogittenure4, replace)
	
graph export "mlogittenure4.png", width(6000) replace


graph combine mlogittenure1 mlogittenure3 mlogittenure4, ///
	title("Predictive Margins of Housing Tenure by Cohorts", size(vsmall)) ///
	subtitle("Multnominal logistic regression using continuing schooling as the reference category", size(vsmall)) ///
	caption("Educational Attainment, Sex, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 19672. BCS Cohort conditionally imputed.", size(vsmall)) ///
	ycommon
	
	
	
	
	
	
mi estimate, saving(miestfile1, replace) post dots: mlogit econ201 i.obinc i.obinc2 i.sexc i.sexc2 i.tenurec i.tenurec2 i.nssecncds i.nssecbcs i.cohort

qui do "${do_fld}\setupgraph.do"	

	
coefplot (., keep(Employmnet:) msymbol(oh) mcolor(red) ciopt(color(red)) lcolor(red)) ///
         (., keep(Apprenticeship:) msymbol(dh) mcolor(blue) ciopt(color(blue)) lcolor(blue)) ///
         (., keep(Unemployment___OLF:) msymbol(th) mcolor(gold) ciopt(color(gold)) lcolor(gold)), ///
drop(_cons) xline(0, lcolor(black)) ///
title("Coefficient Plots of Multinominal Logistic Regression Results", size(vsmall) color(black)) ///
subtitle("Betas and CIs of Mlogit model analysing structural impacts on youth's first destination", size(vsmall) color(black)) ///
note("Data Source: NCDS & BCS, N= 19672. BCS Cohort conditionally imputed.", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, Housing Tenure, NS-SEC, and Cohort interactions included in Model", size(vsmall) color(black)) ///
xlabel(, labsize(vsmall)) ylabel(1 "Five or More O'levels # NCDS" 2 "Five or More O'levels # BCS" 3 "Male # NCDS" 4 "Male # BCS" 5 "Do not Own Home # NCDS" 6 "Do not Own Home # BCS" 7 "1.1 # NCDS" 8 "1.2 # NCDS" 9 "3 # NCDS" 10 "4 # NCDS" 11 "5 # NCDS" 12 "6 # NCDS" 13 "7 # NCDS" 14 "1.1 # BCS" 15 "1.2 # BCS" 16 "3 # BCS" 17 "4 # BCS" 18 "5 # BCS" 19 "6 # BCS" 20 "7 # BCS" 21 "BCS", labsize(vsmall)) ///
legend(rows(1)) ///
legend(label(1 "Employment" 2 "Apprenticeship" 3 "Unemployment & OLF") size(vsmall)) 


coefplot (., keep(Employmnet:) msymbol(oh) mcolor(red) ciopt(color(red)) lcolor(red)), ///
drop(_cons) xline(0, lcolor(black)) ///
xlabel(, labsize(vsmall)) ylabel(1 "Five or More O'levels # NCDS" 2 "Five or More O'levels # BCS" 3 "Male # NCDS" 4 "Male # BCS" 5 "Do not Own Home # NCDS" 6 "Do not Own Home # BCS" 7 "1.1 # NCDS" 8 "1.2 # NCDS" 9 "3 # NCDS" 10 "4 # NCDS" 11 "5 # NCDS" 12 "6 # NCDS" 13 "7 # NCDS" 14 "1.1 # BCS" 15 "1.2 # BCS" 16 "3 # BCS" 17 "4 # BCS" 18 "5 # BCS" 19 "6 # BCS" 20 "7 # BCS" 21 "BCS", labsize(vsmall)) ///
legend(off) ///
name(mlogitcoef1, replace) 


coefplot (., keep(Apprenticeship:) msymbol(dh) mcolor(blue) ciopt(color(blue)) lcolor(blue)), ///
drop(_cons) xline(0, lcolor(black)) ///
xlabel(, labsize(vsmall)) ylabel(1 "Five or More O'levels # NCDS" 2 "Five or More O'levels # BCS" 3 "Male # NCDS" 4 "Male # BCS" 5 "Do not Own Home # NCDS" 6 "Do not Own Home # BCS" 7 "1.1 # NCDS" 8 "1.2 # NCDS" 9 "3 # NCDS" 10 "4 # NCDS" 11 "5 # NCDS" 12 "6 # NCDS" 13 "7 # NCDS" 14 "1.1 # BCS" 15 "1.2 # BCS" 16 "3 # BCS" 17 "4 # BCS" 18 "5 # BCS" 19 "6 # BCS" 20 "7 # BCS" 21 "BCS", labsize(vsmall)) ///
legend(off) ///
name(mlogitcoef3, replace) 


coefplot (., keep(Unemployment___OLF:) msymbol(th) mcolor(gold) ciopt(color(gold)) lcolor(gold)), ///
drop(_cons) xline(0, lcolor(black)) ///
xlabel(, labsize(vsmall)) ylabel(1 "Five or More O'levels # NCDS" 2 "Five or More O'levels # BCS" 3 "Male # NCDS" 4 "Male # BCS" 5 "Do not Own Home # NCDS" 6 "Do not Own Home # BCS" 7 "1.1 # NCDS" 8 "1.2 # NCDS" 9 "3 # NCDS" 10 "4 # NCDS" 11 "5 # NCDS" 12 "6 # NCDS" 13 "7 # NCDS" 14 "1.1 # BCS" 15 "1.2 # BCS" 16 "3 # BCS" 17 "4 # BCS" 18 "5 # BCS" 19 "6 # BCS" 20 "7 # BCS" 21 "BCS", labsize(vsmall)) ///
legend(off) ///
name(mlogitcoef4, replace) 


graph combine mlogitcoef1 mlogitcoef3 mlogitcoef4, ///
title("Coefficient Plots of Multinominal Logistic Regression Results", size(vsmall) color(black)) ///
subtitle("Betas and CIs of Mlogit model analysing structural impacts on youth's first destination", size(vsmall) color(black)) ///
note("Data Source: NCDS & BCS, N= 19672. BCS Cohort conditionally imputed.", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, Housing Tenure, NS-SEC, and Cohort interactions included in Model", size(vsmall) color(black)) 
