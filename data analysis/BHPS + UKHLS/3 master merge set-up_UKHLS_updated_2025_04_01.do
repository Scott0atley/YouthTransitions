clear all 

use "$workingdata\bhps_clean_state_v1.dta", clear

merge m:1 pidp using "$workingdata\ukhls_clean_state_v1.dta"
drop _merge

gen id = _n + "REDACTED"


gen synth_cohort=waveyear 
replace synth_cohort=ks4_acadyr if waveyear==.

gen s_cohort=. 
replace s_cohort=1 if synth_cohort>=1991 & synth_cohort<=1999
replace s_cohort=2 if synth_cohort>=2000 & synth_cohort<=2009
replace s_cohort=3 if synth_cohort>=2010 & synth_cohort<=2013


lab def s_cohort 1"1991/1999" 2"2000/2009" 3"2010/2013" 
lab val s_cohort s_cohort
lab var s_cohort "Synthetic School Cohorts -- Grouped"

gen maxsample= 1 if !missing(s_cohort)

keep if !missing(s_cohort)

lab var econ "Economic Activity post-mandatory Schooling"
lab var female "Sex"
lab var tenure "Parental Housing Tenure -- Age 16"
lab var nssec "Parental NS-SEC -- Age 16"
lab var obin "Educational Attainment -- no. A*-C GCSEs"

lab drop female 
lab define female 0"Male" 1"Female" 
lab val female female 

lab define nssec 1"1.1 Large employers and higher managerial occupations" ///
				  2"1.2 Higher professional occupations" ///
				  3"2 Lower managerial and professional occupations" ///
				  4"3 Intermediate occupations" ///
				  5"4 Small employers and own account workers" ///
				  6"5 Lower supervisory and technical occupations" ///
				  7"6 Semi-routine occupations" ///
				  8"7 Routine occupations" 
lab val nssec nssec

lab drop obin
lab define obin 0"Less than Five GCSEs" 1"Five or More GCSEs"
lab val obin obin


* Weights 

svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)
svydes, gen(onevar)

logit econ obin female tenure ib(3).nssec i.s_cohort

svy: logit econ obin female tenure ib(3).nssec i.s_cohort
* *REDACTED* strata omitted
svydes econ obin female tenure nssec s_cohort if !e(sample), gen(restrat)
svydes

save "$workingdata\merge_master_v1.dta", replace
svydes econ obin female tenure nssec s_cohort if !e(sample)


save "$workingdata/TEMP.dta", replace

bysort strata psu: keep if _n==1
bysort strata: gen n_psu = _N
fre n_psu 
list pidp strata psu if n_psu==1

bysort strata: keep if _n==1 
sort strata
generate newstrata= strata[_n+1] if n_psu==1
fre newstrata
list pidp strata psu newstrata if n_psu==1
keep if n_psu==1
keep strata newstrata n_psu 
merge 1:m strata using "$workingdata\merge_master_v1.dta"
fre n_psu 
replace strata = newstrata if n_psu==1 
drop _merge 

svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)
svy: logit econ obin female tenure ib(3).nssec i.s_cohort
**REDACTED*

svydes econ obin female tenure nssec s_cohort if !e(sample), gen(newrestrat)

save "$workingdata/TEMP.dta", replace

bysort strata psu: keep if _n==1 
bysort strata: gen n_psu2 = _N 
fre n_psu2
list pidp strata psu if n_psu2==1

bysort strata: keep if _n==1 
sort strata 
gen newstrata2 = strata[_n+1] if n_psu2==1
fre newstrata2 
list pidp strata psu newstrata2 if n_psu2==1 
keep if n_psu2==1
keep strata newstrata2 n_psu2 
merge 1:m strata using "$workingdata/TEMP.dta"
drop _merge 
fre n_psu2 
replace strata = newstrata2 if n_psu2==1

svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)
svy: logit econ obin female tenure ib(3).nssec i.s_cohort
**REDACTED*

svydes econ obin female tenure nssec s_cohort if !e(sample)

save "$workingdata/TEMP.dta", replace

bysort strata psu: keep if _n==1 
bysort strata: gen n_psu3 = _N 
fre n_psu3
list pidp strata psu if n_psu3==1

bysort strata: keep if _n==1 
sort strata 
gen newstrata3 = strata[_n+1] if n_psu3==1
fre newstrata3 
list pidp strata psu newstrata3 if n_psu3==1 
keep if n_psu3==1
keep strata newstrata3 n_psu3 
merge 1:m strata using "$workingdata/TEMP.dta"
drop _merge 
fre n_psu3 
replace strata = newstrata3 if n_psu3==1

svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)
svy: logit econ obin female tenure ib(3).nssec i.s_cohort
**REDACTED* 

svydes econ obin female tenure nssec s_cohort if !e(sample)

save "$workingdata/TEMP.dta", replace

bysort strata psu: keep if _n==1 
bysort strata: gen n_psu4 = _N 
fre n_psu4
list pidp strata psu if n_psu4==1

bysort strata: keep if _n==1 
sort strata 
gen newstrata4 = strata[_n+1] if n_psu4==1
fre newstrata4 
list pidp strata psu newstrata4 if n_psu4==1 
keep if n_psu4==1
keep strata newstrata4 n_psu4 
merge 1:m strata using "$workingdata/TEMP.dta"
drop _merge 
fre n_psu4 
replace strata = newstrata4 if n_psu4==1

svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)
svy: logit econ obin female tenure ib(3).nssec i.s_cohort
**REDACTED*

svydes econ obin female tenure nssec s_cohort if !e(sample)

save "$workingdata/TEMP.dta", replace

bysort strata psu: keep if _n==1 
bysort strata: gen n_psu5 = _N 
fre n_psu5
list pidp strata psu if n_psu5==1

bysort strata: keep if _n==1 
sort strata 
gen newstrata5 = strata[_n+1] if n_psu5==1
fre newstrata5 
list pidp strata psu newstrata5 if n_psu5==1 
keep if n_psu5==1
keep strata newstrata5 n_psu5 
merge 1:m strata using "$workingdata/TEMP.dta"
drop _merge 
fre n_psu5 
replace strata = newstrata5 if n_psu5==1

svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)
svy: logit econ obin female tenure ib(3).nssec i.s_cohort
**REDACTED*

svydes econ obin female tenure nssec s_cohort if !e(sample)

save "$workingdata/TEMP.dta", replace

bysort strata psu: keep if _n==1 
bysort strata: gen n_psu6 = _N 
fre n_psu6
list pidp strata psu if n_psu6==1

bysort strata: keep if _n==1 
sort strata 
gen newstrata6 = strata[_n+1] if n_psu6==1
fre newstrata6 
list pidp strata psu newstrata6 if n_psu6==1 
keep if n_psu6==1
keep strata newstrata6 n_psu6 
merge 1:m strata using "$workingdata/TEMP.dta"
drop _merge 
fre n_psu6 
replace strata = newstrata6 if n_psu6==1

svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)
svy: logit econ obin female tenure ib(3).nssec i.s_cohort
**REDACTED*

svydes econ obin female tenure nssec s_cohort if !e(sample)

save "$workingdata/TEMP.dta", replace

bysort strata psu: keep if _n==1 
bysort strata: gen n_psu7 = _N 
fre n_psu7
list pidp strata psu if n_psu7==1

bysort strata: keep if _n==1 
sort strata 
gen newstrata7 = strata[_n+1] if n_psu7==1
fre newstrata7 
list pidp strata psu newstrata7 if n_psu7==1 
keep if n_psu7==1
keep strata newstrata7 n_psu7 
merge 1:m strata using "$workingdata/TEMP.dta"
drop _merge 
fre n_psu7 
replace strata = newstrata7 if n_psu7==1

svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)
svy: logit econ obin female tenure ib(3).nssec i.s_cohort
**REDACTED* 

svydes econ obin female tenure nssec s_cohort if !e(sample)

save "$workingdata/TEMP.dta", replace

bysort strata psu: keep if _n==1 
bysort strata: gen n_psu8 = _N 
fre n_psu8
list pidp strata psu if n_psu8==1

bysort strata: keep if _n==1 
sort strata 
gen newstrata8 = strata[_n+1] if n_psu8==1
fre newstrata8 
list pidp strata psu newstrata8 if n_psu8==1 
keep if n_psu8==1
keep strata newstrata8 n_psu8 
merge 1:m strata using "$workingdata/TEMP.dta"
drop _merge 
fre n_psu8 
replace strata = newstrata8 if n_psu8==1

svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)
svy: logit econ obin female tenure ib(3).nssec i.s_cohort
**REDACTED*

svydes econ obin female tenure nssec s_cohort if !e(sample)

save "$workingdata/TEMP.dta", replace

bysort strata psu: keep if _n==1 
bysort strata: gen n_psu9 = _N 
fre n_psu9
list pidp strata psu if n_psu9==1

bysort strata: keep if _n==1 
sort strata 
gen newstrata9 = strata[_n+1] if n_psu9==1
fre newstrata9 
list pidp strata psu newstrata9 if n_psu9==1 
keep if n_psu9==1
keep strata newstrata9 n_psu9 
merge 1:m strata using "$workingdata/TEMP.dta"
drop _merge 
fre n_psu9 
replace strata = newstrata9 if n_psu9==1

svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)
svy: logit econ obin female tenure ib(3).nssec i.s_cohort
**REDACTED*

svydes econ obin female tenure nssec s_cohort if !e(sample)

save "$workingdata/TEMP.dta", replace

bysort strata psu: keep if _n==1 
bysort strata: gen n_psu10 = _N 
fre n_psu10
list pidp strata psu if n_psu10==1

bysort strata: keep if _n==1 
sort strata 
gen newstrata10 = strata[_n+1] if n_psu10==1
fre newstrata10 
list pidp strata psu newstrata10 if n_psu10==1 
keep if n_psu10==1
keep strata newstrata10 n_psu10 
merge 1:m strata using "$workingdata/TEMP.dta"
drop _merge 
fre n_psu10 
replace strata = newstrata10 if n_psu10==1

svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)
svy: logit econ obin female tenure ib(3).nssec i.s_cohort
**REDACTED*

tab strata if !e(sample) & missing==.
tab psu if !e(sample) & missing==.
tab combined_adult_xw if !e(sample) & missing==.

replace strata=2004 if strata==2005
replace strata=2015 if strata==2016
replace strata=2093 if strata==2094
replace strata=2442 if strata==2441
replace strata=2442 if strata==2443

svy: logit econ obin female tenure ib(3).nssec i.s_cohort
**REDACTED* 

save "$workingdata/TEMP.dta", replace

bysort strata psu: keep if _n==1 
bysort strata: gen n_psu11 = _N 
fre n_psu11
list pidp strata psu if n_psu11==1

bysort strata: keep if _n==1 
sort strata 
gen newstrata11 = strata[_n+1] if n_psu11==1
fre newstrata11 
list pidp strata psu newstrata11 if n_psu11==1 
keep if n_psu11==1
keep strata newstrata11 n_psu11 
merge 1:m strata using "$workingdata/TEMP.dta"
drop _merge 
fre n_psu11 
replace strata = newstrata11 if n_psu11==1

svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)
svy: logit econ obin female tenure ib(3).nssec i.s_cohort
**REDACTED* 

save "$workingdata/TEMP.dta", replace

bysort strata psu: keep if _n==1 
bysort strata: gen n_psu12 = _N 
fre n_psu12
list pidp strata psu if n_psu12==1

bysort strata: keep if _n==1 
sort strata 
gen newstrata12 = strata[_n+1] if n_psu12==1
fre newstrata12 
list pidp strata psu newstrata12 if n_psu12==1 
keep if n_psu12==1
keep strata newstrata12 n_psu12 
merge 1:m strata using "$workingdata/TEMP.dta"
drop _merge 
fre n_psu12 
replace strata = newstrata12 if n_psu12==1

svyset psu [pweight=combined_adult_xw], strata(strata) single(scaled)
svy: logit econ obin female tenure ib(3).nssec i.s_cohort
**REDACTED* 

replace strata="REDACTED" if strata=="REDACTED"

svy: logit econ obin female tenure ib(3).nssec i.s_cohort
**REDACTED*
drop if strata==.


* Transform Variables for cohort interactions... 

gen obinc=.
replace obinc=0 if (obin==0 & s_cohort==1)
replace obinc=0 if (s_cohort==2)
replace obinc=0 if (s_cohort==3)
replace obinc=1 if (obin==1 & s_cohort==1)

lab def obinc 1"Five or More GCSEs 1991/1999" 0"Less than Five GCSEs 1991/1999"
lab val obinc obinc

gen obinc2=.
replace obinc2=0 if (obin==0 & s_cohort==2)
replace obinc2=0 if (s_cohort==1)
replace obinc2=0 if (s_cohort==3)
replace obinc2=1 if (obin==1 & s_cohort==2)

lab def obinc2 1"Five or More GCSEs 2000/2009" 0"Less than Five GCSEs 2000/2009"
lab val obinc2 obinc2

gen obinc3=.
replace obinc3=0 if (obin==0 & s_cohort==3)
replace obinc3=0 if (s_cohort==1)
replace obinc3=0 if (s_cohort==2)
replace obinc3=1 if (obin==1 & s_cohort==3)

lab def obinc3 1"Five or More GCSEs 2010/2013" 0"Less than Five GCSEs 2010/2013"
lab val obinc3 obinc3

gen sexc=.
replace sexc=0 if (female==0 & s_cohort==1)
replace sexc=0 if (s_cohort==2)
replace sexc=0 if (s_cohort==3)
replace sexc=1 if (female==1 & s_cohort==1)

lab def sexc 1"Female 1991/1999" 0"Male 1991/1999"
lab val sexc sexc

gen sexc2=.
replace sexc2=0 if (female==0 & s_cohort==2)
replace sexc2=0 if (s_cohort==1)
replace sexc2=0 if (s_cohort==3)
replace sexc2=1 if (female==1 & s_cohort==2)

lab def sexc2 1"Female 2000/2009" 0"Male 2000/2009"
lab val sexc2 sexc2

gen sexc3=.
replace sexc3=0 if (female==0 & s_cohort==3)
replace sexc3=0 if (s_cohort==1)
replace sexc3=0 if (s_cohort==2)
replace sexc3=1 if (female==1 & s_cohort==3)

lab def sexc3 1"Female 2010/2013" 0"Male 2010/2013"
lab val sexc3 sexc3

gen tenurec=.
replace tenurec=0 if (tenure==0 & s_cohort==1)
replace tenurec=0 if (s_cohort==2)
replace tenurec=0 if (s_cohort==3)
replace tenurec=1 if (tenure==1 & s_cohort==1)

lab def tenurec 1"Own Home 1991/1999" 0"Don't Own Home 1991/1999"
lab val tenurec tenurec

gen tenurec2=.
replace tenurec2=0 if (tenure==0 & s_cohort==2)
replace tenurec2=0 if (s_cohort==1)
replace tenurec2=0 if (s_cohort==3)
replace tenurec2=1 if (tenure==1 & s_cohort==2)

lab def tenurec2 1"Own Home 2000/2009" 0"Don't Own Home 2000/2009"
lab val tenurec2 tenurec2

gen tenurec3=.
replace tenurec3=0 if (tenure==0 & s_cohort==3)
replace tenurec3=0 if (s_cohort==1)
replace tenurec3=0 if (s_cohort==2)
replace tenurec3=1 if (tenure==1 & s_cohort==3)

lab def tenurec3 1"Own Home 2010/2013" 0"Don't Own Home 2010/2013"
lab val tenurec3 tenurec3


gen nssecsynth1=.
replace nssecsynth1=0 if (s_cohort==2)
replace nssecsynth1=0 if (s_cohort==3)
replace nssecsynth1=0 if (s_cohort==1 & nssec==3)
replace nssecsynth1=1 if (s_cohort==1 & nssec==1)
replace nssecsynth1=2 if (s_cohort==1 & nssec==2)
replace nssecsynth1=3 if (s_cohort==1 & nssec==4)
replace nssecsynth1=4 if (s_cohort==1 & nssec==5)
replace nssecsynth1=5 if (s_cohort==1 & nssec==6)
replace nssecsynth1=6 if (s_cohort==1 & nssec==7)
replace nssecsynth1=7 if (s_cohort==1 & nssec==8)

lab def nssecsynth1 1"1.1 Large employers and higher managerial occupations 1991/1999" 2"1.2 Higher professional occupations 1991/1999" 3"3 Intermediate occupations 1991/1999" 4"4 Small employers and own account workers 1991/1999" 5"5 Lower supervisory and technical occupations 1991/1999" 6"6 Semi-routine occupations 1991/1999" 7"7 Routine occupations 1991/1999" 0"2 Lower managerial and professional occupations 1991/1999"
lab val nssecsynth1 nssecsynth1


gen nssecsynth2=.
replace nssecsynth2=0 if (s_cohort==1)
replace nssecsynth2=0 if (s_cohort==3)
replace nssecsynth2=0 if (s_cohort==2 & nssec==3)
replace nssecsynth2=1 if (s_cohort==2 & nssec==1)
replace nssecsynth2=2 if (s_cohort==2 & nssec==2)
replace nssecsynth2=3 if (s_cohort==2 & nssec==4)
replace nssecsynth2=4 if (s_cohort==2 & nssec==5)
replace nssecsynth2=5 if (s_cohort==2 & nssec==6)
replace nssecsynth2=6 if (s_cohort==2 & nssec==7)
replace nssecsynth2=7 if (s_cohort==2 & nssec==8)

lab def nssecsynth2 1"1.1 Large employers and higher managerial occupations 2000/2009" 2"1.2 Higher professional occupations 2000/2009" 3"3 Intermediate occupations 2000/2009" 4"4 Small employers and own account workers 2000/2009" 5"5 Lower supervisory and technical occupations 2000/2009" 6"6 Semi-routine occupations 2000/2009" 7"7 Routine occupations 2000/2009" 0"2 Lower managerial and professional occupations 2000/2009"
lab val nssecsynth2 nssecsynth2

gen nssecsynth3=.
replace nssecsynth3=0 if (s_cohort==1)
replace nssecsynth3=0 if (s_cohort==2)
replace nssecsynth3=0 if (s_cohort==3 & nssec==3)
replace nssecsynth3=1 if (s_cohort==3 & nssec==1)
replace nssecsynth3=2 if (s_cohort==3 & nssec==2)
replace nssecsynth3=3 if (s_cohort==3 & nssec==4)
replace nssecsynth3=4 if (s_cohort==3 & nssec==5)
replace nssecsynth3=5 if (s_cohort==3 & nssec==6)
replace nssecsynth3=6 if (s_cohort==3 & nssec==7)
replace nssecsynth3=7 if (s_cohort==3 & nssec==8)

lab def nssecsynth3 1"1.1 Large employers and higher managerial occupations 2010/2013" 2"1.2 Higher professional occupations 2010/2013" 3"3 Intermediate occupations 2010/2013" 4"4 Small employers and own account workers 2010/2013" 5"5 Lower supervisory and technical occupations 2010/2013" 6"6 Semi-routine occupations 2010/2013" 7"7 Routine occupations 2010/2013" 0"2 Lower managerial and professional occupations 2010/2013"
lab val nssecsynth3 nssecsynth3

drop sex 

save "$workingdata\merge_master_v1.dta", replace

keep if !missing(econ, obin, female, tenure, nssec, s_cohort)
* CRA wipes out data for years 2014/16

save "$workingdata\merge_cra_v1.dta", replace

