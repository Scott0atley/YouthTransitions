

/*====================================================================
                        1: Base Model 
====================================================================*/

logit $mb1c

est store logitnsseca

etable 

fitstat

predict yhatf if e(sample)

ttest yhatf, by(econbin)

est restore logitnsseca 

cd "$out_fld"

coefplot (logitnsseca), ciopt(color(black)) msymbol(Oh) mcolor(black) lcolor(black) drop(_cons) xline(0) ///
title("Coefficient Plots of Logistic Regression Results", size(small) color(black)) ///
subtitle("Betas and CIs of Logit model analysing structural impacts on continuing schooling", size(small) color(black)) ///
note("Data Source: NCDS, N=8,411", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, Housing Tenure, and NS-SEC included in Model", size(vsmall) color(black)) ///
xlabel(, labsize(small)) ylabel(, labsize(small))

graph export "coefplot1.png", width(6000) replace


/*====================================================================
                        2: Quasi-Variance Statistics
====================================================================*/

logit $qvn

estimates store modellogita

estimates restore modellogita

qv i.qvnssec

/*====================================================================
                        3: Log Odds vs Quasi-Variance Graph
====================================================================*/

matrix define LB = e(qvlb)
matrix list LB

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

gen group=_n if _n==6
replace group=_n if _n==2
replace group=_n if _n==4
replace group=_n if _n==8
replace group=_n if _n==10
replace group=_n if _n==12
replace group=_n if _n==14
replace group=_n if _n==16

label variable group "Class"
label define region 2 "1.1" 4 "1.2" 6 "2" 8 "3" 10 "4" 12 "5" 14 "6" 16 "7"
label value group region

graph twoway scatter b group ///
|| rspike quasiupper quasilower group, vert   /// 
xlabel(2 4 6 8 10 12 14 16, valuelabel alternate )

logit $qvn

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

gen lla=0 if _n==5
gen llb=A[1,8] if _n==1
gen llc=A[1,9] if _n==3
gen lld=A[1,10] if _n==7
gen lle=A[1,11] if _n==9
gen llf=A[1,12] if _n==11
gen llg=A[1,13] if _n==13
gen llh=A[1,14] if _n==15
egen lowerbound = rowtotal(lla llb llc lld lle llf llg llh)

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

gen grouping=_n if _n==5
replace grouping=_n if _n==1
replace grouping=_n if _n==3
replace grouping=_n if _n==7
replace grouping=_n if _n==9
replace grouping=_n if _n==11
replace grouping=_n if _n==13
replace grouping=_n if _n==15
label variable grouping "Class"
label define regions 1 "1.1" 3 "1.2" 5 "2" 7 "3" 9 "4" 11 "5" 13 "6" 15 "7"
label value grouping regions

graph twoway scatter beta grouping ///
|| rspike upperbound lowerbound grouping, vert   /// 
xlabel(1 3 5 7 9 11 13 15, valuelabel alternate )

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) legend(label(1 "Log Odds Coefficient")) legend(label(2 "Log Odds Confidence Intervals"))) || rspike upperbound lowerbound grouping, lcolor(black) || (scatter b group, msymbol(Dh) mcolor(red) legend(label(3 "Log Odds Coefficient")) legend(label(4 "Quasi-Variance Bounds"))) || rspike quasiupper quasilower group, lcolor(red) ///
xtitle("NS-SEC", size(small)) ///
xla(1 3 5 7 9 11 13 15, valuelabel alternate ) name(quasi1, replace)

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) legend(label(1 "Log Odds Coefficient")) legend(label(2 "Log Odds Confidence Intervals"))) || rspike upperbound lowerbound grouping, lcolor(black) || (scatter b group, msymbol(Dh) mcolor(red) legend(label(3 "Log Odds Coefficient")) legend(label(4 "Quasi-Variance Bounds"))) || rspike quasiupper quasilower group, lcolor(red) ///
title("Predictions of Staying in Schooling versus Not by Parental NS-SEC", size(small) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(small) color(black)) ///
note("Data Source: NCDS, N=8,411", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, and Housing Tenure included in Model", size(vsmall) color(black)) ///
xtitle("NS-SEC", size(small)) ///
xla(1 3 5 7 9 11 13 15, valuelabel alternate ) name(quasi1b, replace)

graph export "logitquasigraph.png", width(6000) replace


/*====================================================================
                        4: Marginal Effects Graphs
====================================================================*/

logit $mb1c

margins nssec, atmeans saving(file1, replace)
marginsplot, recast(scatter) ciopt(color(black)) recastci(rspike) title("NS-SEC, Predictive Margins", size(small)) xtitle("NS-SEC", size(small)) ytitle("Continuing Schooling", size(small)) plotopts(msymbol(Oh) mcolor(black) lcolor(black) lpattern("l")) ylabel(, labsize(small)) xlabel(1 "1.1" 2 "1.2" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7" , labsize(small)) name(main1, replace) 

margins, dydx(nssec)
marginsplot, recast(scatter) plotopts(msymbol(Oh) mcolor(black) lcolor(black) lpattern("l")) ciopt(color(black)) recastci(rspike) title("NS-SEC, AMEs of Continuing Schooling", size(small)) xtitle("NS-SEC", size(small)) ytitle("Continue Schooling", size(small)) ylabel(, labsize(small)) xlabel(1 "1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", labsize(small)) note("Reference Category NS-SEC 2", size(vsmall)) name(diff1, replace)

graph combine main1 diff1, xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental NS-SEC on Continuing Schooling", size(small)) note("Data Source: NCDS, N=8,411", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) ycommon name(comb, replace)

graph export "ncdsnssecmargins.png", width(6000) replace


margins obin, atmeans saving(file6, replace)
marginsplot, recast(scatter) ciopt(color(black)) recastci(rspike) ///
    title("Educational Attainment, Predictive Margins", size(small)) ///
    xtitle("Educational Attainment", size(small)) ///
    ytitle("Continuing Schooling", size(small)) ///
    plotopts(msymbol(Oh) mcolor(black) lcolor(black) lpattern("l")) ///
    ylabel(, labsize(small)) ///
    xlabel(0 "<5 O'Levels" 1 "≥5 O'Levels") ///
    xscale(range(-0.5 1.5)) ///
    xsize(4) /// 
    note("Data Source: NCDS, N=8,411", size(vsmall)) ///
    caption("NS-SEC, Sex, and Housing Tenure also included in Model", size(vsmall)) ///
    name(main2, replace)


graph export "ncdsobinmargins.png", width(6000) replace

margins sex, atmeans saving(file11, replace)
marginsplot, recast(scatter) ciopt(color(black)) recastci(rspike) title("Sex, Predictive Margins", size(small)) xtitle("Sex", size(small)) ytitle("Continuing Schooling", size(small)) plotopts(msymbol(Oh) mcolor(black) lcolor(black) lpattern("l")) ylabel(, labsize(small)) xlabel(0 "Female" 1 "Male") xscale(range(-0.5 1.5)) xsize(4) note("Data Source: NCDS, N=8,411", size(vsmall)) caption("Educational Attainment, NS-SEC, and Housing Tenure also included in Model", size(vsmall)) name(main2, replace) 

graph export "ncdssexmargins.png", width(6000) replace

margins tenure, atmeans saving(file16, replace)
marginsplot, recast(scatter) ciopt(color(black)) recastci(rspike) title("Housing Tenure, Predictive Margins", size(small)) xtitle("Housing Tenure", size(small)) ytitle("Continuing Schooling", size(small)) plotopts(msymbol(Oh) mcolor(black) lcolor(black) lpattern("l")) ylabel(, labsize(small)) xlabel(0 "Own Home" 1 "Don't Own Home") xscale(range(-0.5 1.5)) xsize(4) note("Data Source: NCDS, N=8,411", size(vsmall)) caption("Educational Attainment, Sex, and NS-SEC also included in Model", size(vsmall)) name(main2, replace) 

graph export "ncdstenuremargins.png", width(6000) replace

/*====================================================================
                        5: Marginal Effects Models
====================================================================*/

logit $mb1c

margins, dydx(*) post

est store logitnssecccamarg

etable, append

/*====================================================================
                        6: Regression Table
====================================================================*/

collect style showbase all

collect label levels etable_depvar 1 "NS-SEC Model" ///
										2 "Margins Model", modify

collect style cell, font(Book Antiqua)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: NCDS") ///
		notestyles(font(Book Antiqua, size(8) italic)) ///
		export("logitregressionchapterone.docx", replace)  
	
cd "$dta_fld"
save basemodelncds, replace