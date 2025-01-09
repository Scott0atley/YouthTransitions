

/*====================================================================
                        1: Set Directory
====================================================================*/

cd "$out_fld"

/*====================================================================
                        2: Sensitivity Models
====================================================================*/

logit $mb3c

est store logitcamsiscca

etable, append

fitstat

predict yhatc if e(sample)

ttest yhatc, by(econbin)

logit $mb3c

margins, dydx(*) post

est store logitcamsisccamarg

etable, append

logit $mb2c

est store logitrgsccca

etable, append

fitstat

predict yhatR if e(sample)

ttest yhatR, by(econbin)

logit $mb2c

margins, dydx(*) post

est store logitrgscccamarg

etable, append

/*====================================================================
                        3: Sensitivity Table
====================================================================*/

collect style showbase all

collect label levels etable_depvar 1 "NS-SEC Model" ///
										2 "NS-SEC Margins" ///
										3 "CAMSIS Model" ///
										4 "CAMSIS Margins" ///
										5 "RGSC Model" ///
										6 "RGSC Margins", modify

collect style cell, font(Book Antiqua)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: BCS") ///
		notestyles(font(Book Antiqua, size(8) italic)) ///
		export("logitregressionchapterone.docx", replace)  
		
/*====================================================================
                        4: Coef Plots
====================================================================*/

logit $mb1c
est store logitnsseca

coefplot (logitnsseca), ciopt(color(black)) msymbol(Oh) mcolor(black) lcolor(black) drop(_cons) xline(0) ///
title("Coefficient Plots of Logistic Regression Results", size(small) color(black)) ///
subtitle("Betas and CIs of Logit model analysing structural impacts on continuing schooling", size(small) color(black)) ///
note("Data Source: BCS, N=1,574", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, Housing Tenure, and NS-SEC included in Model", size(vsmall) color(black)) ///
xlabel(, labsize(small)) ylabel(, labsize(small))

graph export "coefplot1.png", width(6000) replace

logit $mb3c

coefplot (logitcamsiscca), ciopt(color(black)) msymbol(Oh) mcolor(black) lcolor(black) drop(_cons) xline(0) ///
title("Coefficient Plots of Logistic Regression Results", size(small) color(black)) ///
subtitle("Betas and CIs of Logit model analysing structural impacts on continuing schooling", size(small) color(black)) ///
note("Data Source: BCS, N=1,574", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, Housing Tenure, and CAMSIS included in Model", size(vsmall) color(black)) ///
xlabel(, labsize(small)) ylabel(, labsize(small))

graph export "coefplot2.png", width(6000) replace

logit $mb2c

coefplot (logitrgsccca), ciopt(color(black)) msymbol(Oh) mcolor(black) lcolor(black) drop(_cons) xline(0) ///
title("Coefficient Plots of Logistic Regression Results", size(small) color(black)) ///
subtitle("Betas and CIs of Logit model analysing structural impacts on continuing schooling", size(small) color(black)) ///
note("Data Source: BCS, N=1,574", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, Housing Tenure, and RGSC included in Model", size(vsmall) color(black)) ///
xlabel(, labsize(small)) ylabel(, labsize(small))

graph export "coefplot3.png", width(6000) replace

coefplot (logitnsseca, ciopt(color(red%50)) msymbol(oh) mcolor(red%50) lcolor(red) drop(_cons) label("NS-SEC model")) ///
         (logitcamsiscca, ciopt(color(blue%50)) msymbol(dh) mcolor(blue%50) lcolor(blue) drop(_cons) offset(0.1) label("CAMSIS model")) ///
         (logitrgsccca, ciopt(color(gold%50)) msymbol(th) mcolor(gold%50) lcolor(gold) drop(_cons) offset(-0.1) label("RGSC model")), ///
         xline(0) ///
         title("Coefficient Plots of Logistic Regression Results", size(small) color(black)) ///
         subtitle("Betas and CIs of Logit model analysing structural impacts on continuing schooling", size(small) color(black)) ///
         note("Data Source: BCS, N=1,574", size(vsmall) color(black)) ///
         caption("Educational Attainment, Sex, Housing Tenure, and Social Stratification Measures included in Model", size(vsmall) color(black)) ///
         xlabel(, labsize(small)) ylabel(, labsize(small)) ///
         legend(order(2 "NS-SEC model" 4 "CAMSIS model" 6 "RGSC model") size(small))

graph export "coefplotcomb.png", width(6000) replace

coefplot (logitnsseca, ciopt(color(red%50)) msymbol(oh) mcolor(red%50) lcolor(red) drop(_cons) label("NS-SEC model")) ///
         (logitcamsiscca, ciopt(color(blue%50)) msymbol(dh) mcolor(blue%50) lcolor(blue) drop(_cons) offset(0.1) label("CAMSIS model")) ///
         (logitrgsccca, ciopt(color(gold%50)) msymbol(th) mcolor(gold%50) lcolor(gold) drop(_cons) offset(-0.1) label("RGSC model")), ///
         xline(0) ///
         xlabel(, labsize(small)) ylabel(, labsize(small)) ///
         legend(order(2 "NS-SEC model" 4 "CAMSIS model" 6 "RGSC model") size(small)) name(coef1, replace)


/*====================================================================
                        4: Quasi-Variance for RGSC
====================================================================*/

logit $qvr

qv i.qvrgsc

matrix define LB = e(qvlb)
matrix list LB

drop lba lbb lbc lbd lbe lbf quasilower

gen lba=LB[1,1] if _n==4
gen lbb=LB[2,1] if _n==2
gen lbc=LB[3,1] if _n==6
gen lbd=LB[4,1] if _n==8
gen lbe=LB[5,1] if _n==10
gen lbf=LB[6,1] if _n==12
egen quasilower = rowtotal(lba lbb lbc lbd lbe lbf)
replace quasilower=. if(quasilower==0)

matrix define UB = e(qvub)
matrix list UB

drop uba ubb ubc ubd ube ubf quasiupper b

gen uba=UB[1,1] if _n==4
gen ubb=UB[2,1] if _n==2
gen ubc=UB[3,1] if _n==6
gen ubd=UB[4,1] if _n==8
gen ube=UB[5,1] if _n==10
gen ubf=UB[6,1] if _n==12
egen quasiupper = rowtotal(uba ubb ubc ubd ube ubf)
replace quasiupper=. if(quasiupper==0)

gen b=(quasilower+quasiupper)/2

drop group

gen group=_n if _n==4
replace group=_n if _n==2
replace group=_n if _n==6
replace group=_n if _n==8
replace group=_n if _n==10
replace group=_n if _n==12

label variable group "Class"
label define regionrc 2 "1" 4 "2" 6 "3NM" 8 "3M" 10 "4" 12 "5" 
label value group regionrc

graph twoway scatter b group ///
|| rspike quasiupper quasilower group, vert   /// 
xlabel(2 4 6 8 10 12, valuelabel alternate )

logit $qvr

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

drop lla llb llc lld lle llf lowerbound

gen lla=0 if _n==3
gen llb=A[1,8] if _n==1
gen llc=A[1,9] if _n==5
gen lld=A[1,10] if _n==7
gen lle=A[1,11] if _n==9
gen llf=A[1,12] if _n==11
egen lowerbound = rowtotal(lla llb llc lld lle llf)

drop ula ulb ulc uld ule ulf upperbound beta

gen ula=0 if _n==3
gen ulb=A[2,8] if _n==1
gen ulc=A[2,9] if _n==5
gen uld=A[2,10] if _n==7
gen ule=A[2,11] if _n==9
gen ulf=A[2,12] if _n==11
egen upperbound = rowtotal(ula ulb ulc uld ule ulf)

gen beta=(lowerbound+upperbound)/2

drop grouping 

gen grouping=_n if _n==3
replace grouping=_n if _n==1
replace grouping=_n if _n==5
replace grouping=_n if _n==7
replace grouping=_n if _n==9
replace grouping=_n if _n==11
label variable grouping "Class"
label define regionsrc 1 "1" 3 "2" 5 "3NM" 7 "3M" 9 "4" 11 "5" 
label value grouping regionsrc

graph twoway scatter beta grouping ///
|| rspike upperbound lowerbound grouping, vert   /// 
xlabel(1 3 5 7 9 11, valuelabel alternate )

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) legend(label(1 "Log Odds Coefficient")) legend(label(2 "Log Odds Confidence Intervals"))) || rspike upperbound lowerbound grouping, lcolor(black) || (scatter b group, msymbol(Dh) mcolor(red) legend(label(3 "Log Odds Coefficient")) legend(label(4 "Quasi-Variance Bounds"))) || rspike quasiupper quasilower group, lcolor(red) ///
xtitle("RGSC", size(small)) ///
xla(1"1" 3"2" 5"3NM" 7"3M" 9"4" 11"5", valuelabel alternate ) name(quasi2, replace)

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) legend(label(1 "Log Odds Coefficient")) legend(label(2 "Log Odds Confidence Intervals"))) || rspike upperbound lowerbound grouping, lcolor(black) || (scatter b group, msymbol(Dh) mcolor(red) legend(label(3 "Log Odds Coefficient")) legend(label(4 "Quasi-Variance Bounds"))) || rspike quasiupper quasilower group, lcolor(red) ///
title("Predictions of Staying in Schooling versus Not by Parental RGSC", size(small) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(small) color(black)) ///
note("Data Source: BCS, N=1,574", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, and Housing Tenure included in Model", size(vsmall) color(black)) ///
xtitle("RGSC", size(small)) ///
xla(1"1" 3"2" 5"3NM" 7"3M" 9"4" 11"5", valuelabel alternate ) name(quasi2b, replace)

graph export "logitquasigraphrgsc.png", width(6000) replace

graph combine quasi1 quasi2, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Comaprative Log Odds and Quasi-variance Statistics by Parental Social Class", size(small)) note("Data Source: BCS, N=1,574", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(combquasi, replace)

graph export "bcscombquasi.png", width(6000) replace


/*====================================================================
                        4: Margins Plots
====================================================================*/


logit $mb2c


margins rgsc, atmeans saving(file1a, replace)
marginsplot, recast(scatter) ciopt(color(black)) recastci(rspike) title("RGSC, Predictive Margins", size(small)) xtitle("RGSC", size(small)) ytitle("Continuing Schooling", size(small)) plotopts(msymbol(Oh) mcolor(black) lcolor(black) lpattern("l")) ylabel(, labsize(small)) xlabel(1 "1" 2"2" 3"3NM" 4"3M" 5"4" 6"5", labsize(small)) name(main1a, replace) 

margins, dydx(rgsc)
marginsplot, recast(scatter) plotopts(msymbol(Oh) mcolor(black) lcolor(black) lpattern("l")) ciopt(color(black)) recastci(rspike) title("RGSC, AMEs of Continuing Schooling", size(small)) xtitle("RGSC", size(small)) ytitle("Continue Schooling", size(small)) ylabel(, labsize(small)) xlabel(1 "1" 2"3NM" 3"3M" 4"4" 5"5", labsize(small)) note("Reference Category RGSC 2", size(vsmall)) name(diff1a, replace)

graph combine main1a diff1a, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental RGSC on Continuing Schooling", size(small)) note("Data Source: BCS, N=1,574", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb, replace)

graph export "bcsRGSCmargins.png", width(6000) replace


quietly logit $mb3c

margins, at(camsis =(0(1)88)) saving(file1b, replace)
marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) title("CAMSIS, Predictive Margins", size(small)) xtitle("CAMSIS", size(small)) ytitle("Continuing Schooling", size(small)) ylabel(, labsize(small)) xlabel(, labsize(small)) plotopts(lcolor(black) lpattern("l")) name(main1b, replace) 

margins, dydx(camsis) at(camsis =(0(1)88))
marginsplot, recast(line) plotopts(lcolor(black)) ciopt(color(black%20)) recastci(rarea) title("CAMSIS, AMEs of Continuing Schooling", size(small)) xtitle("CAMSIS", size(small)) ylabel(, labsize(small)) xlabel(, labsize(small))  ytitle("Continue Schooling", size(small)) name(diff1b, replace) 

graph combine main1b diff1b, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental CAMSIS on Continuing Schooling", size(small)) note("Data Source: BCS, N=1,574", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb, replace)

graph export "bcsCAMSISmargins.png", width(6000) replace


graph combine main1 main1a main1b diff1 diff1a diff1b, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental Social Stratification Measures on Continuing Schooling", size(small)) note("Data Source: BCS, N=1,574", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb, replace)

graph export "bcssocstratmargins.png", width(6000) replace

