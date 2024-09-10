

/*====================================================================
                        1: Margins Graphs
====================================================================*/

use fileinteract1, clear
append using fileinteract2, nolabel

merge 1:1 _n using merge_cra 

gen n= _n

list n _margin _ci_ub _ci_lb in 1/14

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
			 note("Data Source: NCDS & BCS, N= 9134, Reference Category NS-SEC 2", size(vsmall)) ///
			 legend(label(1 "NCDS AMEs") label(2 "NCDS AME CIs")) ///
			 name(nssecdydxa, replace)

replace _margin = .0565201 if (_n==1)
replace _margin = .0235324 if (_n==2)
replace _margin = -.0409704 if (_n==3)
replace _margin = -.1222127 if (_n==4)
replace _margin = -.1513352 if (_n==5)
replace _margin = -.0735693 if (_n==6)
replace _margin = -.1068935 if (_n==7)


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

replace _ci_ub = .1620804 if (_n==1)
replace _ci_ub = .1231722 if (_n==2)
replace _ci_ub = .0459616 if (_n==3)
replace _ci_ub = -.0332415 if (_n==4)
replace _ci_ub = -.0725132 if (_n==5)
replace _ci_ub = .011396 if (_n==6)
replace _ci_ub = -.0277402 if (_n==7)

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

replace _ci_lb = -.0490403 if (_n==1)
replace _ci_lb = -.0761074 if (_n==2)
replace _ci_lb = -.1279024 if (_n==3)
replace _ci_lb = -.2111839 if (_n==4)
replace _ci_lb = -.2301571 if (_n==5)
replace _ci_lb = -.1585346 if (_n==6)
replace _ci_lb = -.1860467 if (_n==7)

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
			 note("Data Source: NCDS & BCS, N= 9134, Reference Category NS-SEC 2", size(vsmall)) ///
			 legend(label(1 "BCS AMEs") label(2 "BCS AME CIs"))	///
			 name(nssecdydxb, replace)

* Add jitter to the x-values and apply fixed offset
gen jitter1 = grouping + runiform() * 0.1 - 0.05 - 0.10 // Shift slightly to the left
gen jitter2 = groupingb + runiform() * 0.1 - 0.05 + 0.10 // Shift slightly to the right

cd "$out_fld"