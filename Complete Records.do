* New thingy *



cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two"
use "G:\Stata data and do\BCS\BCS Sample Survey 21\stata\stata11\bcs21yearsample"

codebook va86sep

gen econ201=.
replace econ201=1 if(va86sep==5)
replace econ201=1 if(va86sep==6)
replace econ201=1 if(va86sep==7)

replace econ201=2 if(va86sep==4)

replace econ201=3 if(va86sep==3)

replace econ201=4 if(va86sep==1)
replace econ201=4 if(va86sep==2)

label define econ201_lbl 1"Employment" 2"Education" 3"Training & Apprenticeships" 4"Unemployment & OLF"
label values econ201 econ201_lbl

tab econ201

gen crecords=bcsid

tab crecords


cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two"
save subsample_test, replace

use "G:\Stata data and do\NCDS\Occupation Codes\UKDA-7023-stata9\stata9\bcs3_occupation_coding_father"

gen nssecf=. 
replace nssecf=1 if (B3FSNSSEC==2)

replace nssecf=2 if (B3FSNSSEC==3.1)
replace nssecf=2 if (B3FSNSSEC==3.2)
replace nssecf=2 if (B3FSNSSEC==3.3)

replace nssecf=3 if (B3FSNSSEC==4.1)
replace nssecf=3 if (B3FSNSSEC==4.2)
replace nssecf=3 if (B3FSNSSEC==4.3)
replace nssecf=3 if (B3FSNSSEC==5)

replace nssecf=4 if (B3FSNSSEC==7.1)
replace nssecf=4 if (B3FSNSSEC==7.2)
replace nssecf=4 if (B3FSNSSEC==7.3)
replace nssecf=4 if (B3FSNSSEC==7.4)

replace nssecf=5 if (B3FSNSSEC==8.1)
replace nssecf=5 if (B3FSNSSEC==9.1)
replace nssecf=5 if (B3FSNSSEC==9.2)

replace nssecf=6 if (B3FSNSSEC==10)
replace nssecf=6 if (B3FSNSSEC==11.1)
replace nssecf=6 if (B3FSNSSEC==11.2)

replace nssecf=7 if (B3FSNSSEC==12.1)
replace nssecf=7 if (B3FSNSSEC==12.2)
replace nssecf=7 if (B3FSNSSEC==12.3)
replace nssecf=7 if (B3FSNSSEC==12.4)
replace nssecf=7 if (B3FSNSSEC==12.5)
replace nssecf=7 if (B3FSNSSEC==12.6)
replace nssecf=7 if (B3FSNSSEC==12.7)

replace nssecf=8 if (B3FSNSSEC==13.1)
replace nssecf=8 if (B3FSNSSEC==13.2)
replace nssecf=8 if (B3FSNSSEC==13.3)
replace nssecf=8 if (B3FSNSSEC==13.4)
replace nssecf=8 if (B3FSNSSEC==13.5)

label define nssec_lbl 1"Large Employers and higher managerial occupations" 2"Higher professional occupations" 3"Lower Managerial and professional occupations" 4"Intermediate occupations" 5"Small employers and own account workers" 6"Lower supervisory and technical occupations" 7"Semi-routine occupations" 8"Routine occupations"
label value nssecf nssec_lbl

tab nssecf

cd "G:\Stata data and do\NCDS\Occupation Codes\UKDA-7023-stata9\stata9"

merge 1:1 BCSID using bcs3_occupation_coding_mother

drop _merge

gen nssecm=. 
replace nssecm=1 if (B3MSNSSEC==2)

replace nssecm=2 if (B3MSNSSEC==3.1)
replace nssecm=2 if (B3MSNSSEC==3.2)
replace nssecm=2 if (B3MSNSSEC==3.3)

replace nssecm=3 if (B3MSNSSEC==4.1)
replace nssecm=3 if (B3MSNSSEC==4.2)
replace nssecm=3 if (B3MSNSSEC==4.3)
replace nssecm=3 if (B3MSNSSEC==5)

replace nssecm=4 if (B3MSNSSEC==7.1)
replace nssecm=4 if (B3MSNSSEC==7.2)
replace nssecm=4 if (B3MSNSSEC==7.3)
replace nssecm=4 if (B3MSNSSEC==7.4)

replace nssecm=5 if (B3MSNSSEC==8.1)
replace nssecm=5 if (B3MSNSSEC==9.1)
replace nssecm=5 if (B3MSNSSEC==9.2)

replace nssecm=6 if (B3MSNSSEC==10)
replace nssecm=6 if (B3MSNSSEC==11.1)
replace nssecm=6 if (B3MSNSSEC==11.2)

replace nssecm=7 if (B3MSNSSEC==12.1)
replace nssecm=7 if (B3MSNSSEC==12.2)
replace nssecm=7 if (B3MSNSSEC==12.3)
replace nssecm=7 if (B3MSNSSEC==12.4)
replace nssecm=7 if (B3MSNSSEC==12.5)
replace nssecm=7 if (B3MSNSSEC==12.6)
replace nssecm=7 if (B3MSNSSEC==12.7)

replace nssecm=8 if (B3MSNSSEC==13.1)
replace nssecm=8 if (B3MSNSSEC==13.2)
replace nssecm=8 if (B3MSNSSEC==13.3)
replace nssecm=8 if (B3MSNSSEC==13.4)
replace nssecm=8 if (B3MSNSSEC==13.5)

label value nssecm nssec_lbl

tab nssecm

tab nssecf 

gen nssecdom=.
replace nssecdom=1 if (nssecf==1)
replace nssecdom=2 if (nssecf==2)
replace nssecdom=3 if (nssecf==3)
replace nssecdom=4 if (nssecf==4)
replace nssecdom=5 if (nssecf==5)
replace nssecdom=6 if (nssecf==6)
replace nssecdom=7 if (nssecf==7)
replace nssecdom=8 if (nssecf==8)
replace nssecdom=1 if (nssecf==. & nssecm==1)
replace nssecdom=2 if (nssecf==. & nssecm==2)
replace nssecdom=3 if (nssecf==. & nssecm==3)
replace nssecdom=4 if (nssecf==. & nssecm==4)
replace nssecdom=5 if (nssecf==. & nssecm==5)
replace nssecdom=6 if (nssecf==. & nssecm==6)
replace nssecdom=7 if (nssecf==. & nssecm==7)
replace nssecdom=8 if (nssecf==. & nssecm==8)
label values nssecdom nssec_lbl

tab nssecdom

rename BCSID bcsid
keep bcsid nssecdom 

cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two"

merge 1:m bcsid using subsample_test

keep bcsid econ201 nssecdom crecords sex

save subsample_test, replace

use "G:\Stata data and do\BCS\BCS Birth\stata9\bcs7072a"

* Auxillary variables *
gen pmart=.
replace pmart=0 if (a0012==1)
replace pmart=1 if (a0012==2)
replace pmart=0 if (a0012==3)
replace pmart=0 if (a0012==4)
replace pmart=0 if (a0012==5)

label define pmart_lbl 0"Single" 1"Married"
label values pmart pmart_lbl

gen parity=.
replace parity=1 if(a0166==0)
replace parity=2 if(a0166==1)
replace parity=3 if(a0166==2)
replace parity=4 if(a0166==3)
replace parity=4 if(a0166>3 & a0166<18)

label define parity_lbl 1"0" 2"1" 3"2" 4"3+"
label values parity parity_lbl

gen breast=.
replace breast=0 if(a0297==1)
replace breast=1 if(a0297==2)

label define breast_lbl 0"Attempted" 1"Not Attempted"
label values breast breast_lbl

gen mage=.
replace mage=1 if(a0005a>13 & a0005a<20)
replace mage=2 if(a0005a>19 & a0005a<25)
replace mage=3 if(a0005a>24 & a0005a<30)
replace mage=4 if(a0005a>29 & a0005a<35)
replace mage=5 if(a0005a>34 & a0005a<53)

label define mage_lbl 1"less than 20" 2"20-24" 3"25-29" 4"30-34" 5"35 or more"
label values mage mage_lbl

gen med=.
replace med=1 if(a0009>6 & a0009<15)
replace med=2 if(a0009==15)
replace med=3 if(a0009==16)
replace med=4 if(a0009==17)
replace med=5 if(a0009>17 & a0009<32)

label define med 1"14 or less" 2"15" 3"16" 4"17" 5"18 or more"
label values med med_lbl 

gen fed=.
replace fed=1 if(a0010>6 & a0010<15)
replace fed=2 if(a0010==15)
replace fed=3 if(a0010==16)
replace fed=4 if(a0010==17)
replace fed=5 if(a0010>17 & a0010<32)

label define fed 1"14 or less" 2"15" 3"16" 4"17" 5"18 or more"
label values fed fed_lbl

keep bcsid pmart parity breast mage med fed

merge 1:m bcsid using subsample_test

drop _merge

save subsample_test, replace


use "G:\Stata data and do\BCS\BCS Sweep 10\UKDA-3723-stata\stata\stata11_se\sn3723"

gen htenure=.
replace htenure=0 if (d2==1)
replace htenure=0 if (d2==2)

replace htenure=1 if (d2==3)
replace htenure=1 if (d2==4)
replace htenure=1 if (d2==5)
replace htenure=1 if (d2==6)
replace htenure=1 if (d2==7)

label define tenure_lbl 0"Own Home" 1"Don't Own Home"
label value htenure tenure_lbl

tab htenure

keep bcsid htenure

cd "G:\Stata data and do\BCS\BCS Sweep 16\stata\stata11_se"

merge 1:m bcsid using bcs7016x

drop _merge

replace htenure=0 if(htenure==. & of3_1==1) 
replace htenure=0 if(htenure==. & of3_2==1) 

replace htenure=1 if(htenure==. & of3_3==1) 
replace htenure=1 if(htenure==. & of3_4==1) 
replace htenure=1 if(htenure==. & of3_5==1) 

tab htenure 

cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two"

keep bcsid htenure

merge 1:m bcsid using subsample_test

drop _merge

save subsample_test, replace

use "G:\Stata data and do\BCS\BCS Sweep 26\stata\stata11\bcs96x"

gen bin26=. 
replace bin26=1 if(b960154>4 & b960154<16)

replace bin26=0 if(b960154<5 & b960154>0)

replace bin26=1 if(b960169>4 & b960169<11)

replace bin26=0 if(b960169<5 & b960169>0)

replace bin26=0 if(b960154==. & b960157>0 & b960157<11)

replace bin26=0 if(b960169==. & b960172>0 & b960172<9)

tab bin26

keep bcsid bin26 

cd "G:\Stata data and do\BCS\BCS Sweep 30\UKDA-5558-stata\stata\stata11_se"

merge 1:m bcsid using bcs2000

gen o30=edolev1
tab o30
replace o30=. if(o30==98)
replace o30=. if(o30==99)

list bin26 o30 in 1/100


gen obinary=.
replace obinary=0 if(o30==0)
replace obinary=0 if(o30==1)
replace obinary=0 if(o30==2)
replace obinary=0 if(o30==3)
replace obinary=0 if(o30==4)

replace obinary=1 if(o30==5)
replace obinary=1 if(o30==6)
replace obinary=1 if(o30==7)
replace obinary=1 if(o30==8)
replace obinary=1 if(o30==9)
replace obinary=1 if(o30==10)
replace obinary=1 if(o30==11)
replace obinary=1 if(o30==12)
replace obinary=1 if(o30==13)
replace obinary=1 if(o30==14)
replace obinary=1 if(o30==15)

tab obinary


gen obin=.
replace obin=0 if(bin26==0)
replace obin=0 if(bin26==. & obinary==0)


replace obin=1 if(bin26==1)
replace obin=1 if(bin26==. & obinary==1)

label define obin_lbl 0"Less than Five O'Levels" 1"Five or More O'Levels"
label values obin obin_lbl

tab obin

keep bcsid obin 

cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two"

merge 1:m bcsid using subsample_test

drop _merge

save subsample_test, replace

keep if !missing(crecords)

misstable summarize econ201 obin htenure sex nssecdom

misstable patterns econ201 obin htenure sex nssecdom

misstable patterns econ201 obin htenure sex nssecdom, frequency



dtable i.obin i.sex i.htenure i.nssecdom, by(econ201) title(Descriptive Statistics by Economic Activity) export("testBCS", as(docx) replace)

mlogit econ201 i.obin i.htenure i.sex ib(8).nssecdom


estimates store nsseccca

gen qvnssec=.
replace qvnssec=1 if(nssec==8)
replace qvnssec=2 if(nssec==1)
replace qvnssec=3 if(nssec==2)
replace qvnssec=4 if(nssec==3)
replace qvnssec=5 if(nssec==4)
replace qvnssec=6 if(nssec==5)
replace qvnssec=7 if(nssec==6)
replace qvnssec=8 if(nssec==7)

label define qvnssec_lbl 1"Routine occupations" 2"Large Employers and higher managerial occupations" 3"Higher professional occupations" 4"Lower Managerial and professional occupations" 5"Intermediate occupations" 6"Small employers and own account workers" 7"Lower supervisory and technical occupations" 8"Semi-routine occupations" 
label values qvnssec qvnssec_lbl

mlogit econ201 i.obin i.sex i.htenure i.qvnssec, b(2) 

estimates store modela

coefplot modela, keep(*.qvnssec) vertical
graph save "coef.gph", replace

estimates restore modela

qv i.qvnssec
				
mat lb=e(qvlb)
         mat ub=e(qvub)
         svmat lb, names(lb)
         svmat ub, names(ub)
         gen b=(lb1+ub1)/2

         gen group=_n in 1/8
         label variable group "Class"
         label define region 1 "7" 2 "1.1" 3 "1.2" 4 "2" 5 "3" 6 "4" 7 "5" 8 "6"
         label value group region

         graph twoway scatter b group || rspike ub1 lb1 group, vert   ///
                 legend(off) ytitle("") xlabel(, valuelab) 
				 graph save "testqv.gph", replace

			estimates restore modela

			
			
			
				mlogit econ201 i.obin i.sex i.htenure i.qvnssec, b(2) 
				matrix list e(b)
				matrix list r(table)
				matrix define A = r(table)
				matrix define A = A["ll".."ul", 1...]
				matrix list A
				
				gen lla=0 if _n==1
				gen llb=A[1,8] if _n==2
				gen llc=A[1,9] if _n==3
				gen lld=A[1,10] if _n==4
				gen lle=A[1,11] if _n==5
				gen llf=A[1,12] if _n==6
				gen llg=A[1,13] if _n==7
				gen llh=A[1,14] if _n==8
				egen lowerbound = rowtotal(lla llb llc lld lle llf llg llh)

				gen ula=0 if _n==1
				gen ulb=A[2,8] if _n==2
				gen ulc=A[2,9] if _n==3
				gen uld=A[2,10] if _n==4
				gen ule=A[2,11] if _n==5
				gen ulf=A[2,12] if _n==6
				gen ulg=A[2,13] if _n==7
				gen ulh=A[2,14] if _n==8
				egen upperbound = rowtotal(ula ulb ulc uld ule ulf ulg ulh)
				
				gen beta=(lowerbound+upperbound)/2
				
				gen grouping=_n in 1/8
				label variable grouping "Class"
				label define regions 1 "7" 2 "1.1" 3 "1.2" 4 "2" 5 "3" 6 "4" 7 "5" 8 "6"
				label value grouping regions
				
				graph twoway scatter beta grouping || rspike upperbound lowerbound grouping, vert   ///
                 legend(off) ytitle("") xlabel(, valuelab) 
				 graph save "matrixgraph.gph", replace
				
				graph combine "testqv" "matrixgraph"
				
				twoway () () ///
				legend(off) ytitle("") xlabel(, valuelab) 
				graph save "overlapping.gph", replace






coefplot (nsseccca, label(Log Odds)) (qvnssec, label(Quasi-Variance)), drop(_cons) xline(0)




est store subsamplecca

etable

collect style showbase all

collect label levels etable_depvar 1 "NS-SEC" ///
								   2 "CAMSIS" ///
								   3 "RGSC" ///
								   4 "NS-SEC margins" ///
								   5 "CAMSIS margins" ///
								   6 "RGSC margins", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: CCA") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: BCS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("BCS_CCA_Subsample_Margins.docx", replace)  

mlogit econ201 i.obin i.htenure i.sex ib(8).nssecdom

margins, dydx(*) post

est store marginscca

etable, append

collect style showbase all

collect label levels etable_depvar 1 "CCA" ///
								   2 "Margins", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: CCA") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: BCS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("BCS_CCA_Subsample_Margins.docx", replace)  

*tested imputation pls ignore for now*


egen all_missing = rowmiss(econ201 obin sex htenure nssecdom)

tab all_missing


mi set wide

mi register imputed econ201 obin sex htenure nssecdom pmart parity breast mage med fed
tab _mi_miss



mi impute chained ///
///
(logit, augment) obin sex htenure pmart ///
///
(mlogit, augment) econ201 nssecdom parity mage ///
///
, rseed(12346) dots force add(50) burnin(20) savetrace(subsample_testimpute, replace)


mi estimate, post dots: mlogit econ201 i.obin i.sex i.htenure ib(8).nssecdom, b(2)

est store imp

etable

collect style showbase all

collect label levels etable_depvar 1 "imputed", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: CCA") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: BCS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("BCS_Imputed_Subsample.docx", replace)  

mimrgns , dydx(*) predict(outcome(1))

mimrgns , dydx(*) predict(outcome(3))

mimrgns , dydx(*) predict(outcome(4))

save subsample_impute, replace



