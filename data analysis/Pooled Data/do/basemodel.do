

/*====================================================================
                        1: Base Model
====================================================================*/

logit $merge2

etable 

margins , dydx(*) post

etable, append

/*====================================================================
                        2: Regression Table
====================================================================*/

cd "$out_fld"

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
		note("Data Source: NCDS & BCS") ///
		notestyles(font(Book Antiqua, size(8) italic)) ///
		export("logitregressionchapterone.docx", replace)  

/*====================================================================
                        3: Graphs
====================================================================*/

cd "$dta_fld"

logit $merge1 

margins if cohort==0, dydx(nssec) saving(fileinteract1, replace)
marginsplot, name(nssecncdsfile, replace)

margins if cohort==1, dydx(nssec) saving(fileinteract2, replace)
marginsplot, name(nssecbcsfile, replace)

save merge_cra, replace 

qui do "${do_fld}/pooledmarginsgraph.do"		



graph twoway (scatter margins1a jitter1, msymbol(oh) mcolor(red) lcolor(red)) ///
             || (rspike margins1uba margins1lba jitter1, vert fcolor(red%100) lcolor(red%100)) ///
             || (scatter margins1b jitter2, msymbol(dh) mcolor(blue) lcolor(blue)) ///
             || (rspike margins1ubb margins1lbb jitter2, vert fcolor(blue%60) lcolor(blue%60)) ///
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

logit $merge1 

margins cohort, at(nssec=(1 2 3 4 5 6 7 8)) atmeans saving(prednssec, replace)

mplotoffset, offset(0.2) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
title("Predictive Margins", size(vsmall)) ///
xtitle("NS-SEC", size(vsmall)) ///
ytitle("Continuing Schooling", size(vsmall)) ///
xlabel(1 "1.1" 2 "1.2" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7", labsize(vsmall)) ///
ylabel( , labsize(vsmall)) ///
legend(rows(2)) ///
legend(order(3 "NCDS" 4 "BCS")) ///
name(nssecpredcomb, replace)

graph export "nssecpredcomb.png", width(6000) replace

mplotoffset, offset(0.2) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
title("Predictive Margins", size(vsmall)) ///
xtitle("NS-SEC", size(vsmall)) ///
ytitle("Continuing Schooling", size(vsmall)) ///
xlabel(1 "1.1" 2 "1.2" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7", labsize(vsmall)) ///
ylabel( , labsize(vsmall)) ///
legend(off) ///
name(nssecpredcombformi, replace)

graph combine nssecdydxbcomb nssecpredcomb, ///
title("Predictive and Average Marginal Effects of NS-SEC on Continuing Schooling by Cohorts", size(vsmall)) ///
caption("Educational Attainment, Sex, Housing Tenure, and Cohort interactions also included in Model.", size(vsmall)) ///
note("Data Source: NCDS & BCS, N= 9985, Reference Category NS-SEC 2 for AMEs", size(vsmall)) ///
ycommon 

graph export "nssecmarginscomb.png", width(6000) replace

qui do "${do_fld}\setupgraph.do"	

logit $merge1 

margins cohort, at(obin=(0 1)) atmeans vsquish

mplotoffset, offset(0.05) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
    title("Predictive Margins of Educational Attainment on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Sex, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 9985", size(vsmall)) ///
    xtitle("Educational Attainment", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "<5" 1 "≥5", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(obinpredcomb, replace) ///
	saving(obinpredcomb, replace)
	
graph export "obincombcohort.png", width(6000) replace


logit $merge1 

margins cohort, at(sex=(0 1)) atmeans vsquish

mplotoffset, offset(0.05) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
    title("Predictive Margins of Sex on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Educational Attainment, Housing Tenure, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 9985", size(vsmall)) ///
    xtitle("Sex", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "Female" 1 "Male", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(sexpredcomb, replace) ///
	saving(sexpredcomb, replace)
	
graph export "sexcombcohort.png", width(6000) replace

logit $merge1 

margins cohort, at(tenure=(0 1)) atmeans vsquish

mplotoffset, offset(0.05) recast(scatter) recastci(rspike) ///
plot1(msymbol(oh) mcolor(red) lcolor(red%100)) ///
plot2(msymbol(dh) mcolor(blue) lcolor(blue%100)) ///
    title("Predictive Margins of Housing Tenure on Continuing Schooling by Cohorts", size(vsmall)) ///
	caption("Educational Attainment, Sex, NS-SEC, and Cohort interactions also included in Model.", size(vsmall)) ///
	note("Data Source: NCDS & BCS, N= 9985", size(vsmall)) ///
    xtitle("Housing Tenure", size(vsmall)) ///
    ytitle("Continuing Schooling", size(vsmall)) ///
    xlabel(0 "Own Home" 1 "Don't Own Home", labsize(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	name(tenurepredcomb, replace) ///
	saving(tenurepredcomb, replace)
	
graph export "tenurecombcohort.png", width(6000) replace

logit $merge2 

est store coeflogit

coefplot , drop(_cons) ///
msymbol(oh) mcolor(black) ciopt(color(black)) lcolor(black) xline(0, lcolor(black)) ///
title("Coefficient Plots of Logistic Regression Results", size(vsmall) color(black)) ///
subtitle("Not continue schooling as reference category modelling youth's first transition", size(vsmall) color(black)) ///
note("Data Source: NCDS & BCS, N= 9985.", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, Housing Tenure, NS-SEC, and Cohort interactions included in Model", size(vsmall) color(black)) ///
xlabel(, labsize(vsmall)) ylabel(1 "Five or More O'levels # NCDS" 2 "Five or More O'levels # BCS" 3 "Male # NCDS" 4 "Male # BCS" 5 "Do not Own Home # NCDS" 6 "Do not Own Home # BCS" 7 "1.1 # NCDS" 8 "1.2 # NCDS" 9 "3 # NCDS" 10 "4 # NCDS" 11 "5 # NCDS" 12 "6 # NCDS" 13 "7 # NCDS" 14 "1.1 # BCS" 15 "1.2 # BCS" 16 "3 # BCS" 17 "4 # BCS" 18 "5 # BCS" 19 "6 # BCS" 20 "7 # BCS" 21 "BCS", labsize(vsmall)) ///
name(mergecoefplot, replace) ///
saving(mergecoefplot, replace)

graph export "coefcombcohort.png", width(6000) replace
