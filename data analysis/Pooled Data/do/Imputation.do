

/*====================================================================
                        1: Imputation
====================================================================*/
clear

use "$dta_fld/merge_impute"

gen cohort=0 if (id >=1 & id <=8411)
replace cohort=1 if (id >=8412 & id <=19672)


mi set flong

mi register imputed econbin obin sex tenure nssec cohort parity breast mage med fed
tab _mi_miss
		

cd "$dta_fld"

mi impute chained ///
///
(logit, augment) econbin obin sex tenure cohort breast ///
///
(ologit, augment) med fed mage parity ///
///
(mlogit, augment) nssec ///
///
if cohort==1, rseed(12346) dots force add(260) burnin(20) savetrace(subsample_testimpute, replace) 

save merged_cohort_impute, replace



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


mi estimate, saving(miestfile1, replace) post dots: logit econbin i.obinc i.obinc2 i.sexc i.sexc2 i.tenurec i.tenurec2 i.nssecncds i.nssecbcs i.cohort

est store imputed

etable

mimrgns, dydx(*) predict(pr)


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
		export("impute.docx", replace)  
		
/*====================================================================
                        2: Graphs
====================================================================*/

cd "$dta_fld"

mi estimate, saving(miestfile2, replace) post dots: logit econbin i.obin#i.cohort i.sex#i.cohort i.tenure#i.cohort ib(3).nssec#i.cohort i.cohort

mimrgns if cohort==0, predict(pr) dydx(nssec)

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

graph twoway scatter beta grouping, symbol(Oh) mcolor(red) ///
|| rspike upperbound lowerbound grouping, vert lcolor(red)  /// 
xlabel(1 3 5 7 9 11 13, valuelabel alternate ) ///
name(ncdsnssecdydx, replace) ///
saving(ncdsnssecdydx, replace)


mi estimate, saving(miestfile2, replace) post dots: logit econbin i.obin#i.cohort i.sex#i.cohort i.tenure#i.cohort ib(3).nssec#i.cohort i.cohort

mimrgns if cohort==1, predict(pr) dydx(nssec) 

matrix list e(b)
matrix list r(table)
matrix define Ab = r(table)
matrix define Ab = Ab["ll".."ul", 1...]
matrix list Ab

gen llb2=Ab[1,1] if _n==2
gen llc2=Ab[1,2] if _n==4
gen lld2=Ab[1,4] if _n==6
gen lle2=Ab[1,5] if _n==8
gen llf2=Ab[1,6] if _n==10
gen llg2=Ab[1,7] if _n==12
gen llh2=Ab[1,8] if _n==14
egen lowerbound2 = rowtotal(llb2 llc2 lld2 lle2 llf2 llg2 llh2)
replace lowerbound2=. if (lowerbound2==0)


gen ulb2=Ab[2,1] if _n==2
gen ulc2=Ab[2,2] if _n==4
gen uld2=Ab[2,4] if _n==6
gen ule2=Ab[2,5] if _n==8
gen ulf2=Ab[2,6] if _n==10
gen ulg2=Ab[2,7] if _n==12
gen ulh2=Ab[2,8] if _n==14
egen upperbound2 = rowtotal(ulb2 ulc2 uld2 ule2 ulf2 ulg2 ulh2)
replace upperbound2=. if (upperbound2==0)


gen beta2=(lowerbound2+upperbound2)/2

gen grouping2=_n if _n==2
replace grouping2=_n if _n==4
replace grouping2=_n if _n==6
replace grouping2=_n if _n==8
replace grouping2=_n if _n==10
replace grouping2=_n if _n==12
replace grouping2=_n if _n==14
label variable grouping2 "Class"
label define region2b 2 "1.1" 4 "1.2" 6 "3" 8 "4" 10 "5" 12 "6" 14 "7"
label value grouping2 region2b

graph twoway scatter beta2 grouping2, symbol(Oh) mcolor(blue) ///
|| rspike upperbound2 lowerbound2 grouping2, vert lcolor(blue)  /// 
xlabel(2 4 6 8 10 12 14, valuelabel alternate ) ///
name(bcsnssecdydx, replace) ///
saving(bcsnssecdydx, replace)  

qui do "${do_fld}\setupgraph.do"	

cd"$out_fld"

graph twoway (scatter beta grouping, symbol(oh) mcolor(red)) || rspike upperbound lowerbound grouping, lcolor(red%60) || (scatter beta2 grouping2, msymbol(dh) mcolor(blue)) || rspike upperbound2 lowerbound2 grouping2, lcolor(blue%60) ///
title("AMEs", size(vsmall)) ///
xtitle("NS-SEC", size(vsmall)) ///
xla(1 3 5 7 9 11 13, valuelabel labsize(vsmall)) name(minssecdydx, replace) ///
ytitle("Continuing Schooling", size(vsmall)) ///
yla( , labsize(vsmall)) ///
legend(off)

graph export "minssecdydxbcomb.png", width(6000) replace



qui do "${do_fld}/pooledmarginsgraphsettings.do"		

drop ll* ul* lowerbound* upperbound* beta* grouping*
mimrgns cohort, predict(pr) at(nssec=(1 2 3 4 5 6 7 8)) atmeans cmdmargins

matrix list e(b)
matrix list r(table)
matrix define A1 = r(table)
matrix define A1 = A1["ll".."ul", 1...]
matrix list A1

gen lla=A1[1,1] if _n==1
gen llb=A1[1,3] if _n==3
gen llc=A1[1,5] if _n==5
gen lld=A1[1,7] if _n==7
gen lle=A1[1,9] if _n==9
gen llf=A1[1,11] if _n==11
gen llg=A1[1,13] if _n==13
gen llh=A1[1,15] if _n==15
egen lowerbound = rowtotal(lla llb llc lld lle llf llg llh)
replace lowerbound=. if (lowerbound==0)

gen ula=A1[2,1] if _n==1
gen ulb=A1[2,3] if _n==3
gen ulc=A1[2,5] if _n==5
gen uld=A1[2,7] if _n==7
gen ule=A1[2,9] if _n==9
gen ulf=A1[2,11] if _n==11
gen ulg=A1[2,13] if _n==13
gen ulh=A1[2,15] if _n==15
egen upperbound = rowtotal(ula ulb ulc uld ule ulf ulg ulh)
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
label variable grouping "Class"
label define regional 1 "1.1" 3 "1.2" 5 "2" 7 "3" 9 "4" 11 "5" 13 "6" 15 "7"
label value grouping regional

graph twoway scatter beta grouping, symbol(Oh) mcolor(red) ///
|| rspike upperbound lowerbound grouping, vert lcolor(red)  /// 
xlabel(1 3 5 7 9 11 13 15, valuelabel alternate ) ///
name(ncdsnssecpred, replace) ///
saving(ncdsnssecpred, replace)


gen lla2=A1[1,2] if _n==2
gen llb2=A1[1,4] if _n==4
gen llc2=A1[1,6] if _n==6
gen lld2=A1[1,8] if _n==8
gen lle2=A1[1,10] if _n==10
gen llf2=A1[1,12] if _n==12
gen llg2=A1[1,14] if _n==14
gen llh2=A1[1,16] if _n==16
egen lowerbound2 = rowtotal(lla2 llb2 llc2 lld2 lle2 llf2 llg2 llh2)
replace lowerbound2=. if (lowerbound2==0)

gen ula2=A1[2,2] if _n==2
gen ulb2=A1[2,4] if _n==4
gen ulc2=A1[2,6] if _n==6
gen uld2=A1[2,8] if _n==8
gen ule2=A1[2,10] if _n==10
gen ulf2=A1[2,12] if _n==12
gen ulg2=A1[2,14] if _n==14
gen ulh2=A1[2,16] if _n==16
egen upperbound2 = rowtotal(ula2 ulb2 ulc2 uld2 ule2 ulf2 ulg2 ulh2)
replace upperbound2=. if (upperbound2==0)


gen beta2=(lowerbound2+upperbound2)/2

gen grouping2=_n if _n==2
replace grouping2=_n if _n==4
replace grouping2=_n if _n==6
replace grouping2=_n if _n==8
replace grouping2=_n if _n==10
replace grouping2=_n if _n==12
replace grouping2=_n if _n==14
replace grouping2=_n if _n==16
label variable grouping2 "Class"
label define regional2 2 "1.1" 4 "1.2" 6 "2" 8 "3" 10 "4" 12 "5" 14 "6" 16 "7"
label value grouping2 regional2

graph twoway scatter beta2 grouping2, symbol(Oh) mcolor(red) ///
|| rspike upperbound2 lowerbound2 grouping2, vert lcolor(red)  /// 
xlabel(2 4 6 8 10 12 14 16, valuelabel alternate ) ///
name(bcsnssecpred, replace) ///
saving(bcsnssecpred, replace)

graph twoway (scatter beta grouping, symbol(oh) mcolor(red)) || rspike upperbound lowerbound grouping, lcolor(red%60) || (scatter beta2 grouping2, msymbol(dh) mcolor(blue)) || rspike upperbound2 lowerbound2 grouping2, lcolor(blue%60) ///
title("Predictive Margins", size(vsmall)) ///
xtitle("NS-SEC", size(vsmall)) ///
xla(1 3 5 7 9 11 13 15, valuelabel labsize(vsmall)) name(minssecpred, replace) ///
ytitle("Continuing Schooling", size(vsmall)) ///
yla( , labsize(vsmall)) ///
legend(rows(2)) ///
legend(order(1 "NCDS" 3 "BCS")) 

graph export "minssecpredcomb.png", width(6000) replace


graph combine minssecdydx minssecpred, ///
title("Predictive and Average Marginal Effects of NS-SEC on Continuing Schooling by Cohorts", size(vsmall)) ///
caption("Educational Attainment, Sex, Housing Tenure, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: NCDS & BCS, N= 19672, Reference Category NS-SEC 2 for AMEs", size(vsmall)) ///
ycommon 

graph export "nssecmarginscombmi.png", width(6000) replace


graph combine nssecpredcombformi minssecpred nssecdydxbcomb minssecdydx , ///
title("Predictive and Average Marginal Effects of NS-SEC on Continuing Schooling by Cohorts", size(vsmall)) ///
subtitle("CRA versus MI models", size(vsmall)) ///
caption("Educational Attainment, Sex, Housing Tenure, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: NCDS & BCS, Reference Category NS-SEC 2 for AMEs", size(vsmall)) ///
ycommon 

graph export "nssecmarginsmiversus.png", width(6000) replace



mimrgns cohort, predict(pr) at(obin=(0 1)) atmeans cmdmargins


mplotoffset, offset(0.05) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
    title("Predictive Margins of Educational Attainment on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 19672", size(vsmall)) ///
    xtitle("Educational Attainment", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "<5" 1 "≥5", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	legend(rows(1)) ///
	legend(order(3 "NCDS" 4 "BCS")) ///
	name(miobinpredcomb, replace) ///
	saving(miobinpredcomb, replace)
	
graph export "miobincombcohort.png", width(6000) replace

graph combine obinpredcomb miobinpredcomb, /// 
	title("Predictive Margins of Educational Attainment on Continuing Schooling by Cohorts", size(vsmall)) ///
	subtitle("CRA versus MI models", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS", size(vsmall)) ///
	ycommon ///
	name(obinpredcombversus, replace) ///
	saving(obinpredcombversus, replace)

graph export "miobincombversus.png", width(6000) replace


mimrgns cohort, predict(pr) at(sex=(0 1)) atmeans cmdmargins

mplotoffset, offset(0.05) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
    title("Predictive Margins of Sex on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Educational Attainment, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 19672", size(vsmall)) ///
    xtitle("Sex", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "Female" 1 "Male", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	legend(rows(1)) ///
	legend(order(3 "NCDS" 4 "BCS")) ///
	name(misexpredcomb, replace) ///
	saving(misexpredcomb, replace)
	
graph export "misexcombcohort.png", width(6000) replace

graph combine sexpredcomb misexpredcomb, /// 
	title("Predictive Margins of Educational Attainment on Continuing Schooling by Cohorts", size(vsmall)) ///
	subtitle("CRA versus MI models", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS", size(vsmall)) ///
	ycommon ///
	name(misexcombversus, replace) ///
	saving(misexcombversus, replace)

graph export "misexcombversus.png", width(6000) replace


mimrgns cohort, predict(pr) at(tenure=(0 1)) atmeans cmdmargins

mplotoffset, offset(0.05) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
    title("Predictive Margins of Housing Tenure on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Educational Attainment, Sex, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 19672", size(vsmall)) ///
    xtitle("Housing Tenure", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "Own Home" 1 "Don't Own Home", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	legend(rows(1)) ///
	legend(order(3 "NCDS" 4 "BCS")) ///
	name(mitenurepredcomb, replace) ///
	saving(mitenurepredcomb, replace)
	
graph export "mitenurecombcohort.png", width(6000) replace

graph combine tenurepredcomb mitenurepredcomb, /// 
	title("Predictive Margins of Educational Attainment on Continuing Schooling by Cohorts", size(vsmall)) ///
	subtitle("CRA versus MI models", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS", size(vsmall)) ///
	ycommon ///
	name(mitenurecombversus, replace) ///
	saving(mitenurecombversus, replace)

graph export "mitenurecombversus.png", width(6000) replace



mi estimate, saving(miestfile1, replace) post dots: logit econbin i.obinc i.obinc2 i.sexc i.sexc2 i.tenurec i.tenurec2 i.nssecncds i.nssecbcs i.cohort

est store imputed

qui do "${do_fld}\setupgraph.do"	

	
coefplot (imputed) , drop(_cons) ///
msymbol(oh) mcolor(black) ciopt(color(black)) lcolor(black) xline(0, lcolor(black)) ///
title("Coefficient Plots of Logistic Regression Results", size(vsmall) color(black)) ///
subtitle("Not continue schooling as reference category modelling youth's first transition", size(vsmall) color(black)) ///
note("Data Source: NCDS & BCS, N= 19672. BCS Cohort conditionally imputed.", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, Housing Tenure, NS-SEC, and Cohort interactions included in Model", size(vsmall) color(black)) ///
xlabel(, labsize(vsmall)) ylabel(1 "Five or More O'levels # NCDS" 2 "Five or More O'levels # BCS" 3 "Male # NCDS" 4 "Male # BCS" 5 "Do not Own Home # NCDS" 6 "Do not Own Home # BCS" 7 "1.1 # NCDS" 8 "1.2 # NCDS" 9 "3 # NCDS" 10 "4 # NCDS" 11 "5 # NCDS" 12 "6 # NCDS" 13 "7 # NCDS" 14 "1.1 # BCS" 15 "1.2 # BCS" 16 "3 # BCS" 17 "4 # BCS" 18 "5 # BCS" 19 "6 # BCS" 20 "7 # BCS" 21 "BCS", labsize(vsmall)) ///
name(mergecoefplotmi, replace) ///
saving(mergecoefplotmi, replace)



coefplot (coeflogit, ciopt(color(red%50)) msymbol(oh) mcolor(red%50) lcolor(red) drop(_cons) label("CRA Model")) ///
         (imputed, ciopt(color(blue%50)) msymbol(dh) mcolor(blue%50) lcolor(blue) drop(_cons) offset(0.1) label("Imputation Model")), ///
         xline(0) ///
         title("Coefficient Plots of Logistic Regression Results", size(small) color(black)) ///
         subtitle("Betas and CIs of Logit model analysing structural impacts on continuing schooling", size(small) color(black)) ///
         note("Data Source: NCDS & BCS", size(vsmall) color(black)) ///
         caption("Educational Attainment, Sex, Housing Tenure, and Social Stratification Measures included in Model", size(vsmall) color(black)) ///
         xlabel(, labsize(small)) ylabel(, labsize(small)) ///
         legend(order(2 "CRA Model" 4 "Imp Model") size(small)) ///
		name(mergecoefcombplot, replace) ///
		saving(mergecoefcombplot, replace)






