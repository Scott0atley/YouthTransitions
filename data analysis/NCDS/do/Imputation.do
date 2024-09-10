

/*====================================================================
                        1: Multiple Imputation
====================================================================*/
clear

cd "$dta_fld"

use "ncds_recoded_raw.dta"

drop if missing(n4118)

misstable summarize econbin obin sex tenure nssec 

misstable patterns econbin obin sex tenure nssec

logit $mb1c

gen cc= e(sample)

foreach var in econbin obin sex tenure nssec {
	tab `var' cc, col
}

foreach var in acatnn0region bconnn99 maw5 aconnn512 acatnn236 bcatnn95 DadNeverReads ccatnn1434 ccatnn1150 genability11 toilet itoilet otoilet cooking water garden dconnn2492 dconnage16dv46{
	regress econbin `var'
	testparm `var'
}	

*** using Bodner (2008) tables 2 and 3 suggests that with around 30 per cent missingness 40 iterations is the most efficient to stop at and table 3 suggests 36 for 95% CI for half-widths and FMIs round that up to 40 ***

mi set flong

mi register imputed econbin obin sex tenure nssec maw5 aconnn512 genability11 toilet itoilet cooking water dconnn2492
tab _mi_miss

mi impute chained ///
///
(logit, augment) obin sex tenure maw5 aconnn512 genability11 toilet itoilet cooking water dconnn2492 econbin ///
///
(mlogit, augment) nssec ///
///
, rseed(12346) dots force add(40) burnin(20) savetrace(MI_test_trace, replace)
		
		
mi estimate, saving(miestfile1, replace) esample(misample1) post dots: logit econbin i.obin i.sex i.tenure ib(3).nssec

est store imputed

etable

mimrgns , dydx(*) predict(pr) 


coefplot (imputed), ciopt(color(black)) msymbol(Oh) mcolor(black) lcolor(black) drop(_cons) xline(0) ///
title("Coefficient Plots of Logistic Regression Results", size(small) color(black)) ///
subtitle("Betas and CIs of Logit model analysing structural impacts on continuing schooling", size(small) color(black)) ///
note("Data Source: NCDS", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, Housing Tenure, and NS-SEC included in Model", size(vsmall) color(black)) ///
xlabel(, labsize(small)) ylabel(, labsize(small))

coefplot (logitnsseca, ciopt(color(red%50)) msymbol(oh) mcolor(red%50) lcolor(red) drop(_cons) label("CRA Model")) ///
         (imputed, ciopt(color(blue%50)) msymbol(dh) mcolor(blue%50) lcolor(blue) drop(_cons) offset(0.1) label("Imputation Model")), ///
         xline(0) ///
         title("Coefficient Plots of Logistic Regression Results", size(small) color(black)) ///
         subtitle("Betas and CIs of Logit model analysing structural impacts on continuing schooling", size(small) color(black)) ///
         note("Data Source: NCDS", size(vsmall) color(black)) ///
         caption("Educational Attainment, Sex, Housing Tenure, and Social Stratification Measures included in Model", size(vsmall) color(black)) ///
         xlabel(, labsize(small)) ylabel(, labsize(small)) ///
         legend(order(2 "CRA Model" 4 "Imp Model") size(small))

cd "$out_fld"

graph export "coefplotcombmi.png", width(6000) replace

mimrgns nssec, predict(pr) atmeans cmdmargins

marginsplot, recast(scatter) ciopt(color(black)) recastci(rspike) title("NS-SEC, Predictive Margins", size(small)) xtitle("NS-SEC", size(small)) ytitle("Continuing Schooling", size(small)) plotopts(msymbol(Oh) mcolor(black) lcolor(black) lpattern("l")) ylabel(, labsize(small)) xlabel(1 "1.1" 2 "1.2" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7" , labsize(small)) name(impmain1, replace) 

mimrgns, predict(pr) dydx(nssec) cmdmargins

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

replace lowerbound=. if(lowerbound==0)


gen ulb=A[2,1] if _n==1
gen ulc=A[2,2] if _n==3
gen uld=A[2,4] if _n==5
gen ule=A[2,5] if _n==7
gen ulf=A[2,6] if _n==9
gen ulg=A[2,7] if _n==11
gen ulh=A[2,8] if _n==13
egen upperbound = rowtotal(ulb ulc uld ule ulf ulg ulh)

replace upperbound=. if(upperbound==0)


gen beta=(lowerbound+upperbound)/2

gen grouping=_n if _n==1
replace grouping=_n if _n==3
replace grouping=_n if _n==5
replace grouping=_n if _n==7
replace grouping=_n if _n==9
replace grouping=_n if _n==11
replace grouping=_n if _n==13
label variable grouping "Class"
label define regions 1 "1.1" 3 "1.2" 5 "3" 7 "4" 9 "5" 11 "6" 13 "7"
label value grouping regions

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) leg(off)) ///
|| rspike upperbound lowerbound grouping, vert lcolor(black)  /// 
xlabel(1"1.1" 3"1.2" 5"3" 7"4" 9"5" 11"6" 13"7", labsize(small) valuelabel) ylabel(, labsize(small)) ytitle("Continue Schooling", size(small)) name(impmain2, replace) ///
title("NS-SEC, AMEs of Continuing Schooling", size(small) color(black)) ///
xtitle("NS-SEC", size(small)) 

graph combine main1 impmain1 diff1 impmain2, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental NS-SEC on Continuing Schooling", size(small)) subtitle("CRA verus MI Models", size(small)) note("Data Source: NCDS", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(combimp1, replace) 

graph export "combimp1.png", width(6000) replace



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
		
		
		
mi estimate, post vartable nocitable 

mi estimate, post dftable nocitable 
		
cd "$dta_fld"
save ncds_mi, replace