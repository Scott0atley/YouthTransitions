

/*====================================================================
                        1: Base Model
====================================================================*/

cd"$dta_fld"

use merge_cra_pooled_v1.dta, clear


logit econbin i.obinc i.obinc2 i.obinc3 i.obinc4 i.obinc5 i.sexc i.sexc2 i.sexc3 i.sexc4 i.sexc5 i.tenurec i.tenurec2 i.tenurec3 i.tenurec4 i.tenurec5 i.nssecncds i.nssecbcs i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.cohort

etable 

margins , dydx(*) post

etable, append

logit econbin i.obinc i.obinc2 i.obinc3 i.obinc4 i.obinc5 i.sexc i.sexc2 i.sexc3 i.sexc4 i.sexc5 i.tenurec i.tenurec2 i.tenurec3 i.tenurec4 i.tenurec5 i.nssecncds i.nssecbcs i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.cohort

qv i.nssecncds 
qv i.nssecbcs
qv i.nssecsynth1 
qv i.nssecsynth2 
qv i.nssecsynth3
qv i.cohort 


/*====================================================================
                        2: Regression Table
====================================================================*/

cd "$out_fld"

collect style showbase all

collect label levels etable_depvar 1 "CRA Pooled Model" ///
										2 "CRA Pooled Margins", modify

collect style cell, font(Book Antiqua)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Regression Models") ///
		titlestyles(font(Book Antiqua, size(14) bold)) ///
		note("Data Source: NCDS, BCS, BHPS & UKHLS N= "REDACTED"") ///
		notestyles(font(Book Antiqua, size(8) italic)) ///
		export("pooledanalysisCRA_v1.docx", replace)  

/*====================================================================
                        3: Graphs
====================================================================*/

cd "$dta_fld"

logit econbin i.obin#i.cohort i.sex#i.cohort i.tenure#i.cohort ib(3).nssec#i.cohort i.cohort

margins if cohort==0, dydx(nssec) saving(fileinteract1, replace)
marginsplot, name(nssecncdsfile, replace)

margins if cohort==1, dydx(nssec) saving(fileinteract2, replace)
marginsplot, name(nssecbcsfile, replace)

margins if cohort==2, dydx(nssec) saving(fileinteract3, replace)
marginsplot, name(nssecukhls1file, replace)

margins if cohort==3, dydx(nssec) saving(fileinteract4, replace)
marginsplot, name(nssecukhls2file, replace)

margins if cohort==4, dydx(nssec) saving(fileinteract5, replace)
marginsplot, name(nssecukhls3file, replace)

keep econbin obin sex tenure nssec obinc obinc2 obinc3 obinc4 obinc5 sexc sexc2 sexc3 sexc4 sexc5 tenurec tenurec2 tenurec3 tenurec4 tenurec5 nssecncds nssecbcs nssecsynth1 nssecsynth2 nssecsynth3 cohort strata psu id combined_adult_xw

save merge_cra_pooled_v2, replace 

qui do "${do_fld}/pooledmarginsgraph.do"		


graph twoway (scatter margins1a jitter1, msymbol(oh) mcolor(navy)) ///
             || (rspike margins1uba margins1lba jitter1, vert lcolor(navy)) ///
             || (scatter margins1b jitter2, msymbol(dh) mcolor(maroon)) ///
             || (rspike margins1ubb margins1lbb jitter2, vert lcolor(maroon)) ///
			 || (scatter margins1c jitter3, msymbol(th) mcolor(green)) ///
             || (rspike margins1ubc margins1lbc jitter3, vert lcolor(green)) ///
			 || (scatter margins1d jitter4, msymbol(sh) mcolor(orange)) ///
             || (rspike margins1ubd margins1lbd jitter4, vert lcolor(orange)) ///
			 || (scatter margins1e jitter5, msymbol(x) mcolor(teal)) ///
             || (rspike margins1ube margins1lbe jitter5, vert lcolor(teal)) ///
             , xlabel(1"1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", valuelabel labsize(vsmall)) ///
			 ylabel( , labsize(vsmall)) ///
             legend(off) ///
             xtitle("NS-SEC", size(vsmall)) ///
             ytitle("Continuing Schooling", size(vsmall)) ///
             title("AMEs", size(vsmall)) ///
             name(nssecdydxbcomb, replace) ///
             saving(nssecdydxbcomb, replace)
			 
graph export "nssecdydxbcomb.png", width(6000) replace

qui do "${do_fld}/pooledmarginsgraphsettings.do"

cd "$out_fld"

logit econbin i.obin#i.cohort i.sex#i.cohort i.tenure#i.cohort ib(3).nssec#i.cohort i.cohort

margins cohort, at(nssec=(1 2 3 4 5 6 7 8)) atmeans saving(prednssec, replace)

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
name(nssecpredcomb, replace) ///
saving(nssecpredcomb, replace)

graph export "nssecpredcomb.png", width(6000) replace


graph combine nssecdydxbcomb nssecpredcomb, ///
col(1) iscale(0.75) ///
title("Predictive and Average Marginal Effects of NS-SEC on Continuing Schooling by Cohorts", size(vsmall)) ///
caption("Educational Attainment, Sex, Housing Tenure, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: NCDS, BCS, BHPS & UKHLS. Unweighted N="REDACTED". Reference Category NS-SEC 2", size(vsmall)) ///
ycommon 

graph export "nssecmarginscomb.png", width(6000) replace



logit econbin i.obinc i.obinc2 i.obinc3 i.obinc4 i.obinc5 i.sexc i.sexc2 i.sexc3 i.sexc4 i.sexc5 i.tenurec i.tenurec2 i.tenurec3 i.tenurec4 i.tenurec5 i.nssecncds i.nssecbcs i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.cohort

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

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
title("Log odds of Continuing Schooling versus Not by Parental NS-SEC", size(small) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(small) color(black)) ///
note("Data Source: NCDS, BCS, BHPS & UKHLS, Unweighted N="REDACTED"", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, and Housing Tenure included in Model", size(vsmall) color(black)) ///
xtitle("NS-SEC", size(small)) ///
xla(1"1.1" 3"1.2" 5"2" 7"3" 9"4" 11"5" 13"6" 15"7", valuelabel ) name(nsseccoef1, replace)

graph twoway (scatter beta jitter1b, symbol(oh) mcolor(navy) lcolor(navy) legend(label(1 "Cohort 1"))) || /// 
(scatter beta2 jitter2b, msymbol(dh) mcolor(maroon) lcolor(maroon) legend(label(3 "Cohort 2"))) || ///
(scatter beta3 jitter3b, msymbol(th) mcolor(green) lcolor(green) legend(label(5 "Cohort 3"))) || ///
(scatter beta4 jitter4b, msymbol(sh) mcolor(orange) lcolor(orange) legend(label(6 "Cohort 4"))) || ///
(scatter beta5 jitter5b, msymbol(x) mcolor(teal) lcolor(teal) legend(label(9 "Cohort 5"))), /// 
title("Log odds of Continuing Schooling versus Not by Parental NS-SEC", size(small) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(small) color(black)) ///
note("Data Source: NCDS, BCS, BHPS & UKHLS, Unweighted N="REDACTED"", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, and Housing Tenure included in Model", size(vsmall) color(black)) ///
xtitle("NS-SEC", size(small)) ///
xla(1"1.1" 3"1.2" 5"2" 7"3" 9"4" 11"5" 13"6" 15"7", valuelabel ) name(nsseccoef1, replace)


qui do "${do_fld}\setupgraph.do"	

logit econbin i.obin#i.cohort i.sex#i.cohort i.tenure#i.cohort ib(3).nssec#i.cohort i.cohort

margins cohort, at(obin=(0 1)) atmeans vsquish

mplotoffset, offset(0.15) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh)) ///
plot2(msymbol(dh)) ///
plot3(msymbol(th)) ///
plot4(msymbol(sh)) ///
plot5(msymbol(x)) ///
    title("Predictive Margins of Educational Attainment on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS, BCS, BHPS & UKHLS. Unweighted N="REDACTED".", size(vsmall)) ///
    xtitle("Educational Attainment", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "<5 O'levels/GCSEs" 1 "≥5 O'levels/GCSEs", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(obinpredcomb, replace) ///
	saving(obinpredcomb, replace)
	
graph export "obincombcohort.png", width(6000) replace


logit econbin i.obin#i.cohort i.sex#i.cohort i.tenure#i.cohort ib(3).nssec#i.cohort i.cohort

margins cohort, at(sex=(0 1)) atmeans vsquish

mplotoffset, offset(0.15) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh)) ///
plot2(msymbol(dh)) ///
plot3(msymbol(th)) ///
plot4(msymbol(sh)) ///
plot5(msymbol(x)) ///
    title("Predictive Margins of Sex on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Educational Attainment, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS, BCS, BHPS & UKHLS. Unweighted N="REDACTED".", size(vsmall)) ///
    xtitle("Sex", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "Female" 1 "Male", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(sexpredcomb, replace) ///
	saving(sexpredcomb, replace)
	
graph export "sexcombcohort.png", width(6000) replace

logit econbin i.obin#i.cohort i.sex#i.cohort i.tenure#i.cohort ib(3).nssec#i.cohort i.cohort

margins cohort, at(tenure=(0 1)) atmeans vsquish

mplotoffset, offset(0.15) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh)) ///
plot2(msymbol(dh)) ///
plot3(msymbol(th)) ///
plot4(msymbol(sh)) ///
plot5(msymbol(x)) ///
    title("Predictive Margins of Housing Tenure on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Educational Attainment, Sex, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS, BCS, BHPS & UKHLS. Unweighted N="REDACTED".", size(vsmall)) ///
    xtitle("Housing Tenure", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "Own Home" 1 "Don't Own Home", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(tenurepredcomb, replace) ///
	saving(tenurepredcomb, replace)
	
graph export "tenurecombcohort.png", width(6000) replace



* SVY graphs

cd"$dta_fld"

use merge_cra_pooled_v1.dta, clear

replace strata=3126 if cohort==0 | cohort==1 

replace combined_adult_xw=1 if strata==3126

replace psu= 4250 + _n if cohort==0 | cohort==1 

svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)

svy: logit econbin i.obin#i.cohort i.sex#i.cohort i.tenure#i.cohort ib(3).nssec#i.cohort i.cohort

margins if cohort==0, dydx(nssec) saving(fileinteract1, replace)
marginsplot, name(nssecncdsfile, replace)

margins if cohort==1, dydx(nssec) saving(fileinteract2, replace)
marginsplot, name(nssecbcsfile, replace)

margins if cohort==2, dydx(nssec) saving(fileinteract3, replace)
marginsplot, name(nssecukhls1file, replace)

margins if cohort==3, dydx(nssec) saving(fileinteract4, replace)
marginsplot, name(nssecukhls2file, replace)

margins if cohort==4, dydx(nssec) saving(fileinteract5, replace)
marginsplot, name(nssecukhls3file, replace)

keep econbin obin sex tenure nssec obinc obinc2 obinc3 obinc4 obinc5 sexc sexc2 sexc3 sexc4 sexc5 tenurec tenurec2 tenurec3 tenurec4 tenurec5 nssecncds nssecbcs nssecsynth1 nssecsynth2 nssecsynth3 cohort strata psu id combined_adult_xw

save merge_cra_pooled_v3, replace 



/*====================================================================
                        1: Margins Graphs
====================================================================*/

use fileinteract1, clear

merge 1:1 _n using merge_cra_pooled_v3
drop _merge 

gen n= _n

list n _margin _ci_ub _ci_lb in 1/7

gen mar1a = _margin if (n==1)
gen mar2a = _margin if (n==2)
gen mar3a = _margin if (n==3)
gen mar4a = _margin if (n==4)
gen mar5a = _margin if (n==5)
gen mar6a = _margin if (n==6)
gen mar7a = _margin if (n==7)
egen margins1a = rowtotal(mar1a mar2a mar3a mar4a mar5a mar6a mar7a)
replace margins1a=. if(margins1a==0)

tab margins1a

gen mar1uba = _ci_ub if (n==1)
gen mar2uba = _ci_ub if (n==2)
gen mar3uba = _ci_ub if (n==3)
gen mar4uba = _ci_ub if (n==4)
gen mar5uba = _ci_ub if (n==5)
gen mar6uba = _ci_ub if (n==6)
gen mar7uba = _ci_ub if (n==7)
egen margins1uba = rowtotal(mar1uba mar2uba mar3uba mar4uba mar5uba mar6uba mar7uba)
replace margins1uba=. if(margins1uba==0)

tab margins1uba

gen mar1lba = _ci_lb if (n==1)
gen mar2lba = _ci_lb if (n==2)
gen mar3lba = _ci_lb if (n==3)
gen mar4lba = _ci_lb if (n==4)
gen mar5lba = _ci_lb if (n==5)
gen mar6lba = _ci_lb if (n==6)
gen mar7lba = _ci_lb if (n==7)
egen margins1lba = rowtotal(mar1lba mar2lba mar3lba mar4lba mar5lba mar6lba mar7lba)
replace margins1lba=. if(margins1lba==0)

tab margins1lba

gen grouping=_n if _n==1
replace grouping=_n if _n==2
replace grouping=_n if _n==3
replace grouping=_n if _n==4
replace grouping=_n if _n==5
replace grouping=_n if _n==6
replace grouping=_n if _n==7
label variable grouping "Class"
label define regionsmarg 1 "1" 2 "2" 3"3" 4 "4" 5 "5" 6 "6" 7 "7"
label value grouping regionsmarg

graph twoway (scatter margins1a grouping, lcolor(black%100)) ///
             (rspike margins1uba margins1lba grouping, vert fcolor(black%20) lcolor(black%20)) ///
             , xlabel(1"1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", valuelabel alternate) ///
			 xtitle("NS-SEC", size(vsmall)) ///
			 ytitle("Continuing Schooling", size(vsmall)) ///
			 title("NS-SEC, AMEs", size(vsmall)) ///
			 caption("Educational Attainment, Sex, Housing Tenure, and interactions with Cohorts also included in Model.", size(vsmall)) ///
			 note("Data Source: NCDS, BCS, BHPS & UKHLS N=, Reference Category NS-SEC 2", size(vsmall)) ///
			 legend(label(1 "NCDS AMEs") label(2 "NCDS AME CIs")) ///
			 name(nssecdydxa, replace)
			 
drop mar1* mar2* mar3* mar4* mar5* mar6* mar7* _deriv _term _predict _at _atopt _margin _se_margin _statistic _pvalue _ci_lb _ci_ub

merge 1:1 _n using fileinteract2 
drop _merge 
			 
gen mar1b = _margin if (n==1)
gen mar2b = _margin if (n==2)
gen mar3b = _margin if (n==3)
gen mar4b = _margin if (n==4)
gen mar5b = _margin if (n==5)
gen mar6b = _margin if (n==6)
gen mar7b = _margin if (n==7)
egen margins1b = rowtotal(mar1b mar2b mar3b mar4b mar5b mar6b mar7b)
replace margins1b=. if(margins1b==0)

tab margins1b

gen mar1ubb = _ci_ub if (n==1)
gen mar2ubb = _ci_ub if (n==2)
gen mar3ubb = _ci_ub if (n==3)
gen mar4ubb = _ci_ub if (n==4)
gen mar5ubb = _ci_ub if (n==5)
gen mar6ubb = _ci_ub if (n==6)
gen mar7ubb = _ci_ub if (n==7)
egen margins1ubb = rowtotal(mar1ubb mar2ubb mar3ubb mar4ubb mar5ubb mar6ubb mar7ubb)
replace margins1ubb=. if(margins1ubb==0)

tab margins1ubb

gen mar1lbb = _ci_lb if (n==1)
gen mar2lbb = _ci_lb if (n==2)
gen mar3lbb = _ci_lb if (n==3)
gen mar4lbb = _ci_lb if (n==4)
gen mar5lbb = _ci_lb if (n==5)
gen mar6lbb = _ci_lb if (n==6)
gen mar7lbb = _ci_lb if (n==7)
egen margins1lbb = rowtotal(mar1lbb mar2lbb mar3lbb mar4lbb mar5lbb mar6lbb mar7lbb)
replace margins1lbb=. if(margins1lbb==0)

tab margins1lbb

gen groupingb=_n if _n==1
replace groupingb=_n if _n==2
replace groupingb=_n if _n==3
replace groupingb=_n if _n==4
replace groupingb=_n if _n==5
replace groupingb=_n if _n==6
replace groupingb=_n if _n==7
label variable groupingb "Class"
label define regionsmargb 1 "1" 2 "2" 3"3" 4 "4" 5 "5" 6 "6" 7 "7"
label value groupingb regionsmargb


graph twoway (scatter margins1b groupingb, lcolor(black%100)) ///
             (rspike margins1ubb margins1lbb groupingb, vert fcolor(black%20) lcolor(black%20)) ///
             , xlabel(1"1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", valuelabel alternate) ///
			 xtitle("NS-SEC", size(vsmall)) ///
			 ytitle("Continuing Schooling", size(vsmall)) ///
			 title("NS-SEC, AMEs", size(vsmall)) ///
			 caption("Educational Attainment, Sex, Housing Tenure, and interactions with Cohorts also included in Model.", size(vsmall)) ///
			 note("Data Source: NCDS, BCS, BHPS & UKHLS N=, Reference Category NS-SEC 2", size(vsmall)) ///
			 legend(label(1 "BCS AMEs") label(2 "BCS AME CIs"))	///
			 name(nssecdydxb, replace)
			 
drop mar1* mar2* mar3* mar4* mar5* mar6* mar7* _deriv _term _predict _at _atopt _margin _se_margin _statistic _pvalue _ci_lb _ci_ub

merge 1:1 _n using fileinteract3 
drop _merge 

gen mar1b = _margin if (n==1)
gen mar2b = _margin if (n==2)
gen mar3b = _margin if (n==3)
gen mar4b = _margin if (n==4)
gen mar5b = _margin if (n==5)
gen mar6b = _margin if (n==6)
gen mar7b = _margin if (n==7)
egen margins1c = rowtotal(mar1b mar2b mar3b mar4b mar5b mar6b mar7b)
replace margins1c=. if(margins1c==0)

tab margins1c

gen mar1ubb = _ci_ub if (n==1)
gen mar2ubb = _ci_ub if (n==2)
gen mar3ubb = _ci_ub if (n==3)
gen mar4ubb = _ci_ub if (n==4)
gen mar5ubb = _ci_ub if (n==5)
gen mar6ubb = _ci_ub if (n==6)
gen mar7ubb = _ci_ub if (n==7)
egen margins1ubc = rowtotal(mar1ubb mar2ubb mar3ubb mar4ubb mar5ubb mar6ubb mar7ubb)
replace margins1ubc=. if(margins1ubc==0)

tab margins1ubc

gen mar1lbb = _ci_lb if (n==1)
gen mar2lbb = _ci_lb if (n==2)
gen mar3lbb = _ci_lb if (n==3)
gen mar4lbb = _ci_lb if (n==4)
gen mar5lbb = _ci_lb if (n==5)
gen mar6lbb = _ci_lb if (n==6)
gen mar7lbb = _ci_lb if (n==7)
egen margins1lbc = rowtotal(mar1lbb mar2lbb mar3lbb mar4lbb mar5lbb mar6lbb mar7lbb)
replace margins1lbc=. if(margins1lbc==0)

tab margins1lbc

gen groupingc=_n if _n==1
replace groupingc=_n if _n==2
replace groupingc=_n if _n==3
replace groupingc=_n if _n==4
replace groupingc=_n if _n==5
replace groupingc=_n if _n==6
replace groupingc=_n if _n==7
label variable groupingc "Class"
label define regionsmargc 1 "1" 2 "2" 3"3" 4 "4" 5 "5" 6 "6" 7 "7"
label value groupingc regionsmargc


graph twoway (scatter margins1c groupingc, lcolor(black%100)) ///
             (rspike margins1ubc margins1lbc groupingc, vert fcolor(black%20) lcolor(black%20)) ///
             , xlabel(1"1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", valuelabel alternate) ///
			 xtitle("NS-SEC", size(vsmall)) ///
			 ytitle("Continuing Schooling", size(vsmall)) ///
			 title("NS-SEC, AMEs", size(vsmall)) ///
			 caption("Educational Attainment, Sex, Housing Tenure, and interactions with Cohorts also included in Model.", size(vsmall)) ///
			 note("Data Source: NCDS, BCS, BHPS & UKHLS N=, Reference Category NS-SEC 2", size(vsmall)) ///
			 legend(label(1 "UKHLS 1999-99 AMEs") label(2 "UKHLS 1999-99 AME CIs"))	///
			 name(nssecdydxc, replace)
			 
drop mar1* mar2* mar3* mar4* mar5* mar6* mar7* _deriv _term _predict _at _atopt _margin _se_margin _statistic _pvalue _ci_lb _ci_ub

merge 1:1 _n using fileinteract4 
drop _merge 

gen mar1b = _margin if (n==1)
gen mar2b = _margin if (n==2)
gen mar3b = _margin if (n==3)
gen mar4b = _margin if (n==4)
gen mar5b = _margin if (n==5)
gen mar6b = _margin if (n==6)
gen mar7b = _margin if (n==7)
egen margins1d = rowtotal(mar1b mar2b mar3b mar4b mar5b mar6b mar7b)
replace margins1d=. if(margins1d==0)

tab margins1d

gen mar1ubb = _ci_ub if (n==1)
gen mar2ubb = _ci_ub if (n==2)
gen mar3ubb = _ci_ub if (n==3)
gen mar4ubb = _ci_ub if (n==4)
gen mar5ubb = _ci_ub if (n==5)
gen mar6ubb = _ci_ub if (n==6)
gen mar7ubb = _ci_ub if (n==7)
egen margins1ubd = rowtotal(mar1ubb mar2ubb mar3ubb mar4ubb mar5ubb mar6ubb mar7ubb)
replace margins1ubd=. if(margins1ubd==0)

tab margins1ubd

gen mar1lbb = _ci_lb if (n==1)
gen mar2lbb = _ci_lb if (n==2)
gen mar3lbb = _ci_lb if (n==3)
gen mar4lbb = _ci_lb if (n==4)
gen mar5lbb = _ci_lb if (n==5)
gen mar6lbb = _ci_lb if (n==6)
gen mar7lbb = _ci_lb if (n==7)
egen margins1lbd = rowtotal(mar1lbb mar2lbb mar3lbb mar4lbb mar5lbb mar6lbb mar7lbb)
replace margins1lbd=. if(margins1lbd==0)

tab margins1ubd

gen groupingd=_n if _n==1
replace groupingd=_n if _n==2
replace groupingd=_n if _n==3
replace groupingd=_n if _n==4
replace groupingd=_n if _n==5
replace groupingd=_n if _n==6
replace groupingd=_n if _n==7
label variable groupingd "Class"
label define regionsmargd 1 "1" 2 "2" 3"3" 4 "4" 5 "5" 6 "6" 7 "7"
label value groupingd regionsmargd


graph twoway (scatter margins1d groupingd, lcolor(black%100)) ///
             (rspike margins1ubd margins1lbd groupingd, vert fcolor(black%20) lcolor(black%20)) ///
             , xlabel(1"1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", valuelabel alternate) ///
			 xtitle("NS-SEC", size(vsmall)) ///
			 ytitle("Continuing Schooling", size(vsmall)) ///
			 title("NS-SEC, AMEs", size(vsmall)) ///
			 caption("Educational Attainment, Sex, Housing Tenure, and interactions with Cohorts also included in Model.", size(vsmall)) ///
			 note("Data Source: NCDS, BCS, BHPS & UKHLS N=, Reference Category NS-SEC 2", size(vsmall)) ///
			 legend(label(1 "UKHLS 2000-09 AMEs") label(2 "UKHLS 2000-09 AME CIs"))	///
			 name(nssecdydxd, replace)
			 
drop mar1* mar2* mar3* mar4* mar5* mar6* mar7* _deriv _term _predict _at _atopt _margin _se_margin _statistic _pvalue _ci_lb _ci_ub

merge 1:1 _n using fileinteract5 
drop _merge 

gen mar1b = _margin if (n==1)
gen mar2b = _margin if (n==2)
gen mar3b = _margin if (n==3)
gen mar4b = _margin if (n==4)
gen mar5b = _margin if (n==5)
gen mar6b = _margin if (n==6)
gen mar7b = _margin if (n==7)
egen margins1e = rowtotal(mar1b mar2b mar3b mar4b mar5b mar6b mar7b)
replace margins1e=. if(margins1e==0)

tab margins1e

gen mar1ubb = _ci_ub if (n==1)
gen mar2ubb = _ci_ub if (n==2)
gen mar3ubb = _ci_ub if (n==3)
gen mar4ubb = _ci_ub if (n==4)
gen mar5ubb = _ci_ub if (n==5)
gen mar6ubb = _ci_ub if (n==6)
gen mar7ubb = _ci_ub if (n==7)
egen margins1ube = rowtotal(mar1ubb mar2ubb mar3ubb mar4ubb mar5ubb mar6ubb mar7ubb)
replace margins1ube=. if(margins1ube==0)

tab margins1ube

gen mar1lbb = _ci_lb if (n==1)
gen mar2lbb = _ci_lb if (n==2)
gen mar3lbb = _ci_lb if (n==3)
gen mar4lbb = _ci_lb if (n==4)
gen mar5lbb = _ci_lb if (n==5)
gen mar6lbb = _ci_lb if (n==6)
gen mar7lbb = _ci_lb if (n==7)
egen margins1lbe = rowtotal(mar1lbb mar2lbb mar3lbb mar4lbb mar5lbb mar6lbb mar7lbb)
replace margins1lbe=. if(margins1lbe==0)

tab margins1lbe

gen groupinge=_n if _n==1
replace groupinge=_n if _n==2
replace groupinge=_n if _n==3
replace groupinge=_n if _n==4
replace groupinge=_n if _n==5
replace groupinge=_n if _n==6
replace groupinge=_n if _n==7
label variable groupinge "Class"
label define regionsmarge 1 "1" 2 "2" 3"3" 4 "4" 5 "5" 6 "6" 7 "7"
label value groupinge regionsmarge


graph twoway (scatter margins1e groupinge, lcolor(black%100)) ///
             (rspike margins1ube margins1lbe groupinge, vert fcolor(black%20) lcolor(black%20)) ///
             , xlabel(1"1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", valuelabel alternate) ///
			 xtitle("NS-SEC", size(vsmall)) ///
			 ytitle("Continuing Schooling", size(vsmall)) ///
			 title("NS-SEC, AMEs", size(vsmall)) ///
			 caption("Educational Attainment, Sex, Housing Tenure, and interactions with Cohorts also included in Model.", size(vsmall)) ///
			 note("Data Source: NCDS, BCS, BHPS & UKHLS N=, Reference Category NS-SEC 2", size(vsmall)) ///
			 legend(label(1 "UKHLS 2010-13 AMEs") label(2 "UKHLS 2010-13 AME CIs"))	///
			 name(nssecdydxe, replace)

			
* Add jitter to the x-values and apply fixed offset
gen jitter1 = grouping + runiform() * 0.1 - 0.30 // Shift slightly to the left
gen jitter2 = groupingb + runiform() * 0.1 - 0.15 
gen jitter3 = groupingc + runiform() * 0.1 
gen jitter4 = groupingd + runiform() * 0.1 + 0.15
gen jitter5 = groupingc + runiform() * 0.1 + 0.30



cd "$out_fld"


graph twoway (scatter margins1a jitter1, msymbol(oh) mcolor(navy)) ///
             || (rspike margins1uba margins1lba jitter1, vert lcolor(navy)) ///
             || (scatter margins1b jitter2, msymbol(dh) mcolor(maroon)) ///
             || (rspike margins1ubb margins1lbb jitter2, vert lcolor(maroon)) ///
			 || (scatter margins1c jitter3, msymbol(th) mcolor(green)) ///
             || (rspike margins1ubc margins1lbc jitter3, vert lcolor(green)) ///
			 || (scatter margins1d jitter4, msymbol(sh) mcolor(orange)) ///
             || (rspike margins1ubd margins1lbd jitter4, vert lcolor(orange)) ///
			 || (scatter margins1e jitter5, msymbol(x) mcolor(teal)) ///
             || (rspike margins1ube margins1lbe jitter5, vert lcolor(teal)) ///
             , xlabel(1"1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", valuelabel labsize(vsmall)) ///
			 ylabel( , labsize(vsmall)) ///
             legend(off) ///
             xtitle("NS-SEC", size(vsmall)) ///
             ytitle("Continuing Schooling", size(vsmall)) ///
             title("AMEs", size(vsmall)) ///
             name(nssecdydxbcombsvy, replace) ///
             saving(nssecdydxbcombsvy, replace)
			 
graph export "nssecdydxbcombsvy.png", width(6000) replace

qui do "${do_fld}/pooledmarginsgraphsettings.do"

cd "$out_fld"

svy: logit econbin i.obin#i.cohort i.sex#i.cohort i.tenure#i.cohort ib(3).nssec#i.cohort i.cohort

margins cohort, at(nssec=(1 2 3 4 5 6 7 8)) atmeans saving(prednssec, replace)

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
name(nssecpredcombsvy, replace) ///
saving(nssecpredcombsvy, replace)

graph export "nssecpredcombsvy.png", width(6000) replace


graph combine nssecdydxbcomb nssecpredcomb, ///
col(1) iscale(0.75) ///
title("Predictive and Average Marginal Effects of NS-SEC on Continuing Schooling by Cohorts", size(vsmall)) ///
caption("Educational Attainment, Sex, Housing Tenure, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: NCDS, BCS, BHPS & UKHLS. Unweighted N="REDACTED". Reference Category NS-SEC 2", size(vsmall)) ///
ycommon 

graph export "nssecmarginscombsvy.png", width(6000) replace



svy: logit econbin i.obinc i.obinc2 i.obinc3 i.obinc4 i.obinc5 i.sexc i.sexc2 i.sexc3 i.sexc4 i.sexc5 i.tenurec i.tenurec2 i.tenurec3 i.tenurec4 i.tenurec5 i.nssecncds i.nssecbcs i.nssecsynth1 i.nssecsynth2 i.nssecsynth3 i.cohort

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

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
title("Log odds of Continuing Schooling versus Not by Parental NS-SEC", size(small) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(small) color(black)) ///
note("Data Source: NCDS, BCS, BHPS & UKHLS, Unweighted N="REDACTED"", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, and Housing Tenure included in Model", size(vsmall) color(black)) ///
xtitle("NS-SEC", size(small)) ///
xla(1"1.1" 3"1.2" 5"2" 7"3" 9"4" 11"5" 13"6" 15"7", valuelabel ) name(nsseccoef1svy, replace)

graph twoway (scatter beta jitter1b, symbol(oh) mcolor(navy) lcolor(navy) legend(label(1 "Cohort 1"))) || /// 
(scatter beta2 jitter2b, msymbol(dh) mcolor(maroon) lcolor(maroon) legend(label(3 "Cohort 2"))) || ///
(scatter beta3 jitter3b, msymbol(th) mcolor(green) lcolor(green) legend(label(5 "Cohort 3"))) || ///
(scatter beta4 jitter4b, msymbol(sh) mcolor(orange) lcolor(orange) legend(label(6 "Cohort 4"))) || ///
(scatter beta5 jitter5b, msymbol(x) mcolor(teal) lcolor(teal) legend(label(9 "Cohort 5"))), /// 
title("Log odds of Continuing Schooling versus Not by Parental NS-SEC", size(small) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(small) color(black)) ///
note("Data Source: NCDS, BCS, BHPS & UKHLS, Unweighted N="REDACTED"", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, and Housing Tenure included in Model", size(vsmall) color(black)) ///
xtitle("NS-SEC", size(small)) ///
xla(1"1.1" 3"1.2" 5"2" 7"3" 9"4" 11"5" 13"6" 15"7", valuelabel ) name(nsseccoef2svy, replace)


qui do "${do_fld}\setupgraph.do"	

svy: logit econbin i.obin#i.cohort i.sex#i.cohort i.tenure#i.cohort ib(3).nssec#i.cohort i.cohort

margins cohort, at(obin=(0 1)) atmeans vsquish

mplotoffset, offset(0.15) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh)) ///
plot2(msymbol(dh)) ///
plot3(msymbol(th)) ///
plot4(msymbol(sh)) ///
plot5(msymbol(x)) ///
    title("Predictive Margins of Educational Attainment on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS, BCS, BHPS & UKHLS. Unweighted N="REDACTED".", size(vsmall)) ///
    xtitle("Educational Attainment", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "<5 O'levels/GCSEs" 1 "≥5 O'levels/GCSEs", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(obinpredcomb, replace) ///
	saving(obinpredcomb, replace)
	
graph export "obincombcohort.png", width(6000) replace


svy: logit econbin i.obin#i.cohort i.sex#i.cohort i.tenure#i.cohort ib(3).nssec#i.cohort i.cohort

margins cohort, at(sex=(0 1)) atmeans vsquish

mplotoffset, offset(0.15) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh)) ///
plot2(msymbol(dh)) ///
plot3(msymbol(th)) ///
plot4(msymbol(sh)) ///
plot5(msymbol(x)) ///
    title("Predictive Margins of Sex on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Educational Attainment, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS, BCS, BHPS & UKHLS. Unweighted N="REDACTED".", size(vsmall)) ///
    xtitle("Sex", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "Female" 1 "Male", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(sexpredcomb, replace) ///
	saving(sexpredcomb, replace)
	
graph export "sexcombcohort.png", width(6000) replace

svy: logit econbin i.obin#i.cohort i.sex#i.cohort i.tenure#i.cohort ib(3).nssec#i.cohort i.cohort

margins cohort, at(tenure=(0 1)) atmeans vsquish

mplotoffset, offset(0.15) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh)) ///
plot2(msymbol(dh)) ///
plot3(msymbol(th)) ///
plot4(msymbol(sh)) ///
plot5(msymbol(x)) ///
    title("Predictive Margins of Housing Tenure on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Educational Attainment, Sex, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS, BCS, BHPS & UKHLS. Unweighted N="REDACTED".", size(vsmall)) ///
    xtitle("Housing Tenure", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "Own Home" 1 "Don't Own Home", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(tenurepredcomb, replace) ///
	saving(tenurepredcomb, replace)
	
graph export "tenurecombcohort.png", width(6000) replace

