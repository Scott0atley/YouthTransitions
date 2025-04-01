

/*==============================================================================
							1: Base Model
==============================================================================*/

logit $full

est store logitnsseca

etable

fitstat

predict yhatf if e(sample)
ttest yhatf, by(econ)

/*==============================================================================
							2: Marginal Effects Model
==============================================================================*/

logit $full

margins, dydx(*) post 

est store logitnssecccamarg 

etable, append 


/*==============================================================================
							3: Quasi-Variance Statistics 
==============================================================================*/

logit econ i.obinc i.obinc2 i.obinc3 i.sexc i.sexc2 i.sexc3 i.tenurec i.tenurec2 i.tenurec3 i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.s_cohort

estimates store modellogita 

qv i.nssecsynth1 
qv i.nssecsynth2 
qv i.nssecsynth3

qv i.s_cohort 

/*==============================================================================
							4: Regression Table
==============================================================================*/

cd"$out_fld"

collect style showbase all 

collect label levels etable_depvar 1 "CRA Model" ///
								   2 "CRA Margins Model", modify
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
export("cra_ukhls_v1.docx", replace) 

* No way to import qv statistics, have to add manually to word file. 

/*==============================================================================
							5: Weighted Model 
==============================================================================*/

svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)

svy: logit econ i.obinc i.obinc2 i.obinc3 i.sexc i.sexc2 i.sexc3 i.tenurec i.tenurec2 i.tenurec3 i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.s_cohort

etable, append

margins , dydx(*) post

etable, append

svy: logit econ i.obinc i.obinc2 i.obinc3 i.sexc i.sexc2 i.sexc3 i.tenurec i.tenurec2 i.tenurec3 i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.s_cohort

qv i.nssecsynth1 
qv i.nssecsynth2 
qv i.nssecsynth3

qv i.s_cohort 

collect style showbase all 

collect label levels etable_depvar 1 "CRA Model" ///
								   2 "CRA Margins Model" ///
								   3 "CRA Weighted Model" ///
								   4 "CRA Weighted Margins Model", modify
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
export("cra_ukhls_weighted_v1.docx", replace) 

/*==============================================================================
							6: Marginal Effects Graphs
==============================================================================*/

svy: logit $full

cd"$workingdata" 

margins, dydx(nssecsynth1) saving(fileinteract1.dta, replace)
marginsplot, name(nssec1file, replace)

margins, dydx(nssecsynth2) saving(fileinteract2.dta, replace)
marginsplot, name(nssec2file, replace)

margins, dydx(nssecsynth3) saving(fileinteract3.dta, replace)
marginsplot, name(nssec3file, replace)


save merge_cra_v1.dta, replace 

qui do "${do_fld}/synthmarginsgraph.do"	
qui do "${do_fld}/synthmarginsgraphsettings.do"	


cd"$out_fld"

graph twoway (scatter margins1a jitter1, msymbol(oh) mcolor(navy) lcolor(navy)) ///
             || (rspike margins1uba margins1lba jitter1, vert fcolor(navy%100) lcolor(navy%100)) ///
             || (scatter margins1b groupingb, msymbol(dh) mcolor(maroon) lcolor(maroon)) ///
             || (rspike margins1ubb margins1lbb groupingb, vert fcolor(maroon%100) lcolor(maroon%100)) ///
			 || (scatter margins1c jitter2, msymbol(th) mcolor(green) lcolor(green)) ///
             || (rspike margins1ubc margins1lbc jitter2, vert fcolor(green%100) lcolor(green%100)) ///
             , xlabel(1"1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", valuelabel labsize(vsmall)) ///
			 ylabel( , labsize(vsmall)) ///
             legend(off) ///
             xtitle("NS-SEC", size(vsmall)) ///
             ytitle("Continuing Schooling", size(vsmall)) ///
             title("AMEs", size(vsmall)) ///
             name(nssecdydxbcomb, replace) ///
             saving(nssecdydxbcomb, replace)
			 
graph export "nssecdydxbcomb.png", width(6000) replace
	
svy: logit econ i.obin#i.s_cohort i.female#i.s_cohort i.tenure#i.s_cohort ib(3).nssec#i.s_cohort i.s_cohort

margins s_cohort, at(nssec=(1 2 3 4 5 6 7 8)) atmeans saving(prednssec, replace)

mplotoffset, offset(0.2) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh))  ///
plot2(msymbol(dh))  ///
plot3(msymbol(th))  ///
title("Predictive Margins", size(vsmall)) ///
xtitle("NS-SEC", size(vsmall)) ///
ytitle("Continuing Schooling", size(vsmall)) ///
xlabel(1 "1.1" 2 "1.2" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7", labsize(vsmall)) ///
ylabel( , labsize(vsmall)) ///
name(nssecpredcomb, replace)

graph export "nssecpredcomb.png", width(6000) replace


graph combine nssecdydxbcomb nssecpredcomb, ///
col(1) iscale(0.75) ///
title("Predictive and Average Marginal Effects of NS-SEC on Continuing Schooling by Synthetic Cohorts", size(vsmall)) ///
caption("Educational Attainment, Sex, Housing Tenure, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Weighted N="REDACTED". Reference Category NS-SEC 2 for AMEs", size(vsmall)) ///
ycommon ///
name(nssecmarginscombukhls, replace)

graph export "nssecmarginscombukhls.png", width(6000) replace

qui do "${do_fld}/3b graphsetup.do"	

svy: logit econ i.obin#i.s_cohort i.female#i.s_cohort i.tenure#i.s_cohort ib(3).nssec#i.s_cohort i.s_cohort

margins s_cohort, at(obin=(0 1)) atmeans vsquish

mplotoffset, offset(0.20) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh)) ///
plot2(msymbol(dh)) ///
plot3(msymbol(dh)) ///
    title("Predictive Margins of Educational Attainment on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Weighted N="REDACTED".", size(vsmall)) ///
    xtitle("Educational Attainment", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "<5 GCSEs" 1 "≥5 GCSEs", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(obinpredcomb, replace) ///
	saving(obinpredcomb, replace)
	
graph export "obincombcohortukhls.png", width(6000) replace

margins s_cohort, at(female=(0 1)) atmeans vsquish

mplotoffset, offset(0.20) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh)) ///
plot2(msymbol(dh)) ///
plot3(msymbol(dh)) ///
    title("Predictive Margins of Sex on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Weighted N="REDACTED".", size(vsmall)) ///
    xtitle("Sex", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "Male" 1 "Female", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(sexpredcomb, replace) ///
	saving(sexpredcomb, replace)
	
graph export "sexpredcohortukhls.png", width(6000) replace

margins s_cohort, at(tenure=(0 1)) atmeans vsquish

mplotoffset, offset(0.20) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh)) ///
plot2(msymbol(dh)) ///
plot3(msymbol(dh)) ///
    title("Predictive Margins of Housing Tenure on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Weighted N="REDACTED".", size(vsmall)) ///
    xtitle("Housing Tenure", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "Don't Own Home" 1 "Own Home", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(tenurepredcomb, replace) ///
	saving(tenurepredcomb, replace)
	
graph export "tenurepredcohortukhls.png", width(6000) replace



svy: logit econ i.obinc i.obinc2 i.obinc3 i.sexc i.sexc2 i.sexc3 i.tenurec i.tenurec2 i.tenurec3 i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.s_cohort

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

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
xla(1"1.1" 3"1.2" 5"2" 7"3" 9"4" 11"5" 13"6" 15"7", valuelabel ) name(nsseccoef1, replace)


save"$workingdata/merge_master_cra_v1.dta", replace


