

/*====================================================================
                        1: SOC Models
====================================================================*/

logit $mb1c90

etable, append 

fitstat

predict yhata1 if e(sample)

ttest yhata1, by(econbin)

logit $mb1c90

margins, dydx(*) post

etable, append


logit $mb2c90

etable, append 

fitstat

predict yhatb1 if e(sample)

ttest yhatb1, by(econbin)

logit $mb2c90

margins, dydx(*) post

etable, append


logit $mb3c90

etable, append 

fitstat

predict yhatc1 if e(sample)

ttest yhatc1, by(econbin)

logit $mb3c90

margins, dydx(*) post

etable, append

/*====================================================================
                        2: SOC Regression Tables
====================================================================*/


collect style showbase all

collect label levels etable_depvar 1 "NS-SEC 2000 Model" ///
										2 "NS-SEC 2000 Margins" /// 
										3 "CAMSIS 2000 Model" ///
										4 "CAMSIS 2000 Margins" /// 
										5 "RGSC 2000 Model" ///
										6 "RGSC 2000 Margins" /// 
										7 "NS-SEC 90 Model" ///
										8 "NS-SEC 90 Margins" /// 
										9 "RGSC 90 Model" ///
										10 "RGSC 90 Margins" ///
										11 "CAMSIS 90 Model" ///
										12 "CAMSIS 90 Margins", modify

collect style cell, font(Book Antiqua)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Regression Models") ///
		titlestyles(font(Book Antiqua, size(12) bold)) ///
		note("Data Source: NCDS") ///
		notestyles(font(Book Antiqua, size(8) italic)) ///
		export("logitregressionchapteroneb.docx", replace)  
		

/*====================================================================
                        3: SOC Coef Plots
====================================================================*/

logit $mb1c90
est store logitnsseca90

coefplot (logitnsseca90), ciopt(color(black)) msymbol(Oh) mcolor(black) lcolor(black) drop(_cons) xline(0) ///
title("Coefficient Plots of Logistic Regression Results for SOC 90 Codes", size(small) color(black)) ///
subtitle("Betas and CIs of Logit model analysing structural impacts on continuing schooling", size(small) color(black)) ///
note("Data Source: NCDS, N=8,411", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, Housing Tenure, and NS-SEC included in Model", size(vsmall) color(black)) ///
xlabel(, labsize(small)) ylabel(, labsize(small))

graph export "coefplot190.png", width(6000) replace

logit $mb3c90
est store logitcamsis90

coefplot (logitcamsis90), ciopt(color(black)) msymbol(Oh) mcolor(black) lcolor(black) drop(_cons) xline(0) ///
title("Coefficient Plots of Logistic Regression Results for SOC 90 Codes", size(small) color(black)) ///
subtitle("Betas and CIs of Logit model analysing structural impacts on continuing schooling", size(small) color(black)) ///
note("Data Source: NCDS, N=8,411", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, Housing Tenure, and CAMSIS included in Model", size(vsmall) color(black)) ///
xlabel(, labsize(small)) ylabel(, labsize(small))

graph export "coefplot290.png", width(6000) replace

logit $mb2c90
est store logitrgsc90

coefplot (logitrgsc90), ciopt(color(black)) msymbol(Oh) mcolor(black) lcolor(black) drop(_cons) xline(0) ///
title("Coefficient Plots of Logistic Regression Results for SOC 90 Codes", size(small) color(black)) ///
subtitle("Betas and CIs of Logit model analysing structural impacts on continuing schooling", size(small) color(black)) ///
note("Data Source: NCDS, N=8,411", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, Housing Tenure, and RGSC included in Model", size(vsmall) color(black)) ///
xlabel(, labsize(small)) ylabel(, labsize(small))

graph export "coefplot390.png", width(6000) replace

coefplot (logitnsseca90, ciopt(color(red%50)) msymbol(oh) mcolor(red%50) lcolor(red) drop(_cons) label("NS-SEC model")) ///
         (logitcamsis90, ciopt(color(blue%50)) msymbol(dh) mcolor(blue%50) lcolor(blue) drop(_cons) offset(0.1) label("CAMSIS model")) ///
         (logitrgsc90, ciopt(color(gold%50)) msymbol(th) mcolor(gold%50) lcolor(gold) drop(_cons) offset(-0.1) label("RGSC model")), ///
         xline(0) ///
         title("Coefficient Plots of Logistic Regression Results for SOC 90 Codes", size(small) color(black)) ///
         subtitle("Betas and CIs of Logit model analysing structural impacts on continuing schooling", size(small) color(black)) ///
         note("Data Source: NCDS, N=8,411", size(vsmall) color(black)) ///
         caption("Educational Attainment, Sex, Housing Tenure, and Social Stratification Measures included in Model", size(vsmall) color(black)) ///
         xlabel(, labsize(small)) ylabel(, labsize(small)) ///
         legend(order(2 "NS-SEC model" 4 "CAMSIS model" 6 "RGSC model") size(small))

graph export "coefplotcomb90.png", width(6000) replace

coefplot (logitnsseca90, ciopt(color(red%50)) msymbol(oh) mcolor(red%50) lcolor(red) drop(_cons) label("NS-SEC model")) ///
         (logitcamsis90, ciopt(color(blue%50)) msymbol(dh) mcolor(blue%50) lcolor(blue) drop(_cons) offset(0.1) label("CAMSIS model")) ///
         (logitrgsc90, ciopt(color(gold%50)) msymbol(th) mcolor(gold%50) lcolor(gold) drop(_cons) offset(-0.1) label("RGSC model")), ///
         xline(0) ///
         xlabel(, labsize(small)) ylabel(, labsize(small)) ///
         legend(order(2 "NS-SEC model" 4 "CAMSIS model" 6 "RGSC model") size(small)) name(coef2, replace)

graph combine coef1 coef2, xsize(6.5) ysize(2.7) iscale(.8) ///
title("Coefficient Plots of Logistic Regression Results by SOC", size(small)) ///
subtitle("Betas and CIs of Logit model analysing structural impacts on continuing schooling", size(small) color(black)) /// 
note("Data Source: NCDS, N=8,411. SOC2000 on left, SOC90 on right.", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, Housing Tenure, and Social Stratification Measures included in Model", size(vsmall) color(black)) 

graph export "coefcombsoc.png", width(6000) replace



/*====================================================================
                        4: SOC Quasi-Variance
====================================================================*/

logit $qvn90

estimates store modellogitab

estimates restore modellogitab

qv i.qvnssec90

matrix define LB = e(qvlb)
matrix list LB

drop lba lbb lbc lbd lbe lbf lbg lbh quasilower
gen lba=LB[1,1] if _n==6
gen lbb=LB[2,1] if _n==2
gen lbc=LB[3,1] if _n==4
gen lbd=LB[4,1] if _n==8
gen lbe=LB[5,1] if _n==10
gen lbf=LB[6,1] if _n==12
gen lbg=LB[7,1] if _n==14
gen lbh=LB[8,1] if _n==16
egen quasilower = rowtotal(lba lbb lbc lbd lbe lbf lbg lbh)
replace quasilower=. if(quasilower==0)

matrix define UB = e(qvub)
matrix list UB

drop uba ubb ubc ubd ube ubf ubg ubh quasiupper b

gen uba=UB[1,1] if _n==6
gen ubb=UB[2,1] if _n==2
gen ubc=UB[3,1] if _n==4
gen ubd=UB[4,1] if _n==8
gen ube=UB[5,1] if _n==10
gen ubf=UB[6,1] if _n==12
gen ubg=UB[7,1] if _n==14
gen ubh=UB[8,1] if _n==16
egen quasiupper = rowtotal(uba ubb ubc ubd ube ubf ubg ubh)
replace quasiupper=. if(quasiupper==0)

gen b=(quasilower+quasiupper)/2

drop group 
gen group=_n if _n==6
replace group=_n if _n==2
replace group=_n if _n==4
replace group=_n if _n==8
replace group=_n if _n==10
replace group=_n if _n==12
replace group=_n if _n==14
replace group=_n if _n==16

label variable group "Class"
label define regionb 2 "1.1" 4 "1.2" 6 "2" 8 "3" 10 "4" 12 "5" 14 "6" 16 "7"
label value group regionb

graph twoway scatter b group ///
|| rspike quasiupper quasilower group, vert   /// 
xlabel(2 4 6 8 10 12 14 16, valuelabel alternate )

logit $qvn90

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

drop lla llb llc lld lle llf llg llh lowerbound
gen lla=0 if _n==5
gen llb=A[1,8] if _n==1
gen llc=A[1,9] if _n==3
gen lld=A[1,10] if _n==7
gen lle=A[1,11] if _n==9
gen llf=A[1,12] if _n==11
gen llg=A[1,13] if _n==13
gen llh=A[1,14] if _n==15
egen lowerbound = rowtotal(lla llb llc lld lle llf llg llh)

drop ula ulb ulc uld ule ulf ulg ulh upperbound beta
gen ula=0 if _n==5
gen ulb=A[2,8] if _n==1
gen ulc=A[2,9] if _n==3
gen uld=A[2,10] if _n==7
gen ule=A[2,11] if _n==9
gen ulf=A[2,12] if _n==11
gen ulg=A[2,13] if _n==13
gen ulh=A[2,14] if _n==15
egen upperbound = rowtotal(ula ulb ulc uld ule ulf ulg ulh)

gen beta=(lowerbound+upperbound)/2

drop grouping 
gen grouping=_n if _n==5
replace grouping=_n if _n==1
replace grouping=_n if _n==3
replace grouping=_n if _n==7
replace grouping=_n if _n==9
replace grouping=_n if _n==11
replace grouping=_n if _n==13
replace grouping=_n if _n==15
label variable grouping "Class"
label define regionsb 1 "1.1" 3 "1.2" 5 "2" 7 "3" 9 "4" 11 "5" 13 "6" 15 "7"
label value grouping regionsb

graph twoway scatter beta grouping ///
|| rspike upperbound lowerbound grouping, vert   /// 
xlabel(1 3 5 7 9 11 13 15, valuelabel alternate )

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) legend(label(1 "Log Odds Coefficient")) legend(label(2 "Log Odds Confidence Intervals"))) || rspike upperbound lowerbound grouping, lcolor(black) || (scatter b group, msymbol(Dh) mcolor(red) legend(label(3 "Log Odds Coefficient")) legend(label(4 "Quasi-Variance Bounds"))) || rspike quasiupper quasilower group, lcolor(red) ///
title("Predictions of Staying in Schooling versus Not by Parental NS-SEC (SOC90)", size(small) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(small) color(black)) ///
note("Data Source: NCDS, N=8,411", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, and Housing Tenure included in Model", size(vsmall) color(black)) ///
xtitle("NS-SEC", size(small)) ///
xla(1 3 5 7 9 11 13 15, valuelabel alternate ) 

graph export "logitquasibgraph.png", width(6000) replace

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) legend(label(1 "Log Odds Coefficient")) legend(label(2 "Log Odds Confidence Intervals"))) || rspike upperbound lowerbound grouping, lcolor(black) || (scatter b group, msymbol(Dh) mcolor(red) legend(label(3 "Log Odds Coefficient")) legend(label(4 "Quasi-Variance Bounds"))) || rspike quasiupper quasilower group, lcolor(red) ///
xtitle("NS-SEC", size(small)) ///
xla(1 3 5 7 9 11 13 15, valuelabel alternate ) name(quasi1b, replace)

graph combine quasi1 quasi1b, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Comaprative Log Odds and Quasi-variance Statistics by SOC construction of Parental NS-SEC", size(small)) subtitle("Predictions of Staying in Schooling versus Not by Parental NS-SEC", size(small)) note("Data Source: NCDS, N=8,411. SOC2000 on left, SOC90 on right.", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(combquasi, replace)

graph export "logitquasibcombgraph.png", width(6000) replace


logit $qvr90

qv i.qvrgsc90

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
label define regionrac 2 "1" 4 "2" 6 "3NM" 8 "3M" 10 "4" 12 "5" 
label value group regionrc

graph twoway scatter b group ///
|| rspike quasiupper quasilower group, vert   /// 
xlabel(2 4 6 8 10 12, valuelabel alternate )

logit $qvr90

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
label define regionsrac 1 "1" 3 "2" 5 "3NM" 7 "3M" 9 "4" 11 "5" 
label value grouping regionsrc

graph twoway scatter beta grouping ///
|| rspike upperbound lowerbound grouping, vert   /// 
xlabel(1 3 5 7 9 11, valuelabel alternate )

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) legend(label(1 "Log Odds Coefficient")) legend(label(2 "Log Odds Confidence Intervals"))) || rspike upperbound lowerbound grouping, lcolor(black) || (scatter b group, msymbol(Dh) mcolor(red) legend(label(3 "Log Odds Coefficient")) legend(label(4 "Quasi-Variance Bounds"))) || rspike quasiupper quasilower group, lcolor(red) ///
title("Predictions of Staying in Schooling versus Not by Parental RGSC (SOC 90)", size(small) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(small) color(black)) ///
note("Data Source: NCDS, N=8,411", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, and Housing Tenure included in Model", size(vsmall) color(black)) ///
xtitle("RGSC", size(small)) ///
xla(1"1" 3"2" 5"3NM" 7"3M" 9"4" 11"5", valuelabel alternate ) 

graph export "logitquasigraphrgsc90.png", width(6000) replace

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) legend(label(1 "Log Odds Coefficient")) legend(label(2 "Log Odds Confidence Intervals"))) || rspike upperbound lowerbound grouping, lcolor(black) || (scatter b group, msymbol(Dh) mcolor(red) legend(label(3 "Log Odds Coefficient")) legend(label(4 "Quasi-Variance Bounds"))) || rspike quasiupper quasilower group, lcolor(red) ///
xtitle("RGSC", size(small)) ///
xla(1"1" 3"2" 5"3NM" 7"3M" 9"4" 11"5", valuelabel alternate ) name(quasi2b, replace)


graph combine quasi2 quasi2b, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Comaprative Log Odds and Quasi-variance Statistics by SOC construction of Parental RGSC", size(small)) subtitle("Predictions of Staying in Schooling versus Not by Parental RGSC", size(small)) note("Data Source: NCDS, N=8,411. SOC2000 on left, SOC90 on right.", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(combquasi2, replace)

graph export "logitquasigraphrgsccomb.png", width(6000) replace


/*====================================================================
                        4: SOC Margins Plots
====================================================================*/


logit $mb1c90
margins nssec90, atmeans saving(file190, replace) post

marginsplot, recast(scatter) ciopt(color(black)) recastci(rspike) title("NS-SEC, Predictive Margins", size(small)) xtitle("NS-SEC", size(small)) ytitle("Continuing Schooling", size(small)) plotopts(msymbol(Oh) mcolor(black) lcolor(black) lpattern("l")) ylabel(, labsize(small)) xlabel(1 "1.1" 2 "1.2" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7" , labsize(small)) name(main190, replace) 


logit $mb1c90
margins, dydx(nssec90)

marginsplot, recast(scatter) plotopts(msymbol(Oh) mcolor(black) lcolor(black) lpattern("l")) ciopt(color(black)) recastci(rspike) title("NS-SEC, AMEs of Continuing Schooling", size(small)) xtitle("NS-SEC", size(small)) ytitle("Continue Schooling", size(small)) ylabel(, labsize(small)) xlabel(1 "1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", labsize(small)) note("Reference Category NS-SEC 2", size(vsmall)) name(diff190, replace)


graph combine main1 main190 diff1 diff190, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental NS-SEC on Continuing Schooling by SOC Codes", size(small)) note("Data Source: NCDS, N=8,411, SOC 2000 on left, SOC 90 on right", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb1a, replace)

graph export "ncdsnssecmarginscomb.png", width(6000) replace


logit $mb2c90
margins rgsc90, atmeans saving(file1a, replace)

marginsplot, recast(scatter) ciopt(color(black)) recastci(rspike) title("RGSC, Predictive Margins", size(small)) xtitle("RGSC", size(small)) ytitle("Continuing Schooling", size(small)) plotopts(msymbol(Oh) mcolor(black) lcolor(black) lpattern("l")) ylabel(, labsize(small)) xlabel(1 "1" 2"2" 3"3NM" 4"3M" 5"4" 6"5", labsize(small)) name(main1ab, replace) 

logit $mb2c90
margins, dydx(rgsc90)

marginsplot, recast(scatter) plotopts(msymbol(Oh) mcolor(black) lcolor(black) lpattern("l")) ciopt(color(black)) recastci(rspike) title("RGSC, AMEs of Continuing Schooling", size(small)) xtitle("RGSC", size(small)) ytitle("Continue Schooling", size(small)) ylabel(, labsize(small)) xlabel(1 "1" 2"3NM" 3"3M" 4"4" 5"5", labsize(small)) note("Reference Category RGSC 2", size(vsmall)) name(diff1ab, replace)


graph combine main1a main1ab diff1a diff1ab, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental RGSC on Continuing Schooling by SOC Codes", size(small)) note("Data Source: NCDS, N=8,411, SOC 2000 on left, SOC 90 on right", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb2a, replace)

graph export "ncdsRGSCmarginscomb.png", width(6000) replace


logit $mb3c90

margins, at(cam90 =(0(1)88)) saving(file1b, replace)
marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) title("CAMSIS, Predictive Margins", size(small)) xtitle("CAMSIS", size(small)) ytitle("Continuing Schooling", size(small)) ylabel(, labsize(small)) xlabel(, labsize(small)) plotopts(lcolor(black) lpattern("l")) name(main1bb, replace) 


logit $mb3c90
margins, dydx(cam90) at(cam90 =(0(1)88))
marginsplot, recast(line) plotopts(lcolor(black)) ciopt(color(black%20)) recastci(rarea) title("CAMSIS, AMEs of Continuing Schooling", size(small)) xtitle("CAMSIS", size(small)) ylabel(, labsize(small)) xlabel(, labsize(small))  ytitle("Continue Schooling", size(small)) name(diff1bb, replace) 


graph combine main1b main1bb diff1b diff1bb, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental CAMSIS on Continuing Schooling by SOC Codes", size(small)) note("Data Source: NCDS, N=8,411, SOC 2000 on left, SOC 90 on right", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb3a, replace)

graph export "ncdsCAMSISmarginscomb.png", width(6000) replace


graph combine main190 main1ab main1bb diff190 diff1ab diff1bb, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Social Stratification Measures on Continuing Schooling by SOC 90", size(small)) note("Data Source: NCDS, N=8,411", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb4a, replace)

graph export "ncdscombmarginscomb90.png", width(6000) replace



graph combine comb comb4a, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Social Stratification Measures on Continuing Schooling by SOC 90", size(small)) note("Data Source: NCDS, N=8,411", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb3a, replace)

cd "$dta_fld"

save ncds_complete, replace






