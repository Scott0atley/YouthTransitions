clear all
set maxvar 20000

* Data Management 
* Mother

foreach w in a b c d e f g {
	use "$ukhlsdata/`w'_indresp_protect", clear
	local waveno=strpos("abcdefghijklmnopqrstuvwxyz", "`w'")
	gen wave=`waveno'
	
	rename `w'_* *mo
	
	keep if sex_dv==2
	
	keep	pidp hidp ppid sppid mnpid pno ivfio jbnssec_dv jbnssec3_dv jbnssec5_dv jbnssec8_dv jlnssec_dv jlnssec3_dv jlnssec5_dv jlnssec8_dv jboff* jbstat jbhas jbbgm jbbgy jbft_dv jbsemp* jbrgsc_dv jlrgsc_dv jbsoc00* jlsoc00* qfhigh_dv hiqual_dv qfhigh* wave
	
	rename pidp mnspid 

save "$workingdata\TEMP_ukhls_wave`w'_mother_v1.dta", replace

}

* Father

foreach w in a b c d e f g {
	use "$ukhlsdata/`w'_indresp_protect", clear
	local waveno=strpos("abcdefghijklmnopqrstuvwxyz", "`w'")
	gen wave=`waveno'

	rename `w'_* *fa
	
	keep if sex_dv==1
	
	keep	pidp hidp ppid sppid mnpid pno ivfio jbnssec_dv jbnssec3_dv jbnssec5_dv jbnssec8_dv jlnssec_dv jlnssec3_dv jlnssec5_dv jlnssec8_dv jboff* jbstat jbhas jbbgm jbbgy jbft_dv jbsemp* jbrgsc_dv jlrgsc_dv jbsoc00* jlsoc00* qfhigh_dv hiqual_dv qfhigh* wave
	
	rename pidp fnspid 
	

save "$workingdata\TEMP_ukhls_wave`w'_father_v1.dta", replace
	

}


* Young Person

foreach w in a b c d e f g {
	use"$ukhlsdata/`w'_indresp_protect.dta",clear
	local waveno=strpos("abcdefghijklmnopqrstuvwxyz", "`w'")
	gen wave=`waveno'

	merge m:1 `w'_hidp using "$ukhlsdata/`w'_hhresp_protect.dta", keepusing(`w'_tenure_dv)
	drop if _merge==2
	rename _merge hhresepmerge_wave`w'
	
	rename `w'_* *
	
	merge m:1 mnspid using "$workingdata\TEMP_ukhls_wave`w'_mother_v1.dta"
	drop if _merge==2
	rename _merge mummerge_wave`w'
	
	merge m:1 fnspid using "$workingdata\TEMP_ukhls_wave`w'_father_v1.dta"
	drop if _merge==2
	rename _merge dadmerge_wave`w'
	
	save "$workingdata/TEMP_ukhls_wave`w'_youngadult_v1.dta", replace
	
}

* Append Datasets 

use "$workingdata\TEMP_ukhls_wavea_youngadult_v1.dta", clear
keep pidp hidp fnpid fnspid mnpid mnspid psu strata *_xw hhorig sex age_dv doby* tenure_dv wave* *wave* *merge* *mo *fa intdatm* intdaty* jbstat

append using "$workingdata\TEMP_ukhls_waveb_youngadult_v1.dta"
keep pidp hidp fnpid fnspid mnpid mnspid psu strata *_xw hhorig sex age_dv doby* tenure_dv wave* *wave* *merge* *mo *fa intdatm* intdaty* jbstat

append using "$workingdata\TEMP_ukhls_wavec_youngadult_v1.dta"
keep pidp hidp fnpid fnspid mnpid mnspid psu strata *_xw hhorig sex age_dv doby* tenure_dv wave* *wave* *merge* *mo *fa intdatm* intdaty* jbstat

append using "$workingdata\TEMP_ukhls_waved_youngadult_v1.dta"
keep pidp hidp fnpid fnspid mnpid mnspid psu strata *_xw hhorig sex age_dv doby* tenure_dv wave* *wave* *merge* *mo *fa intdatm* intdaty* jbstat

append using "$workingdata\TEMP_ukhls_wavee_youngadult_v1.dta"
keep pidp hidp fnpid fnspid mnpid mnspid psu strata *_xw hhorig sex age_dv doby* tenure_dv wave* *wave* *merge* *mo *fa intdatm* intdaty* jbstat

append using "$workingdata\TEMP_ukhls_wavef_youngadult_v1.dta"
keep pidp hidp fnpid fnspid mnpid mnspid psu strata *_xw hhorig sex age_dv doby* tenure_dv wave* *wave* *merge* *mo *fa intdatm* intdaty* jbstat

append using "$workingdata\TEMP_ukhls_waveg_youngadult_v1.dta"
keep pidp hidp fnpid fnspid mnpid mnspid psu strata *_xw hhorig sex age_dv doby* tenure_dv wave* *wave* *merge* *mo *fa intdatm* intdaty* jbstat

* sample orign

tab hhorig, missing 

keep if hhorig==1

* Merge with NPD 

merge m:m pidp using "REDACTED"

keep if _merge==2 | _merge==3
rename _merge ks4_merge 
count 
tab wave, missing

tab ks4_acadyr if wave!=., missing

* gen academic indicator 

capture drop year_12 
gen year_12 = 1 if ks4_acadyr==2009 & ((intdatm_dv>8 & intdaty_dv==2009) | intdatm_dv<9 & intdaty_dv==2010)
replace year_12 = 2 if ks4_acadyr==2010 & ((intdatm_dv>8 & intdaty_dv==2010) | intdatm_dv<9 & intdaty_dv==2011)
replace year_12 = 3 if ks4_acadyr==2011 & ((intdatm_dv>8 & intdaty_dv==2011) | intdatm_dv<9 & intdaty_dv==2012)
replace year_12 = 4 if ks4_acadyr==2012 & ((intdatm_dv>8 & intdaty_dv==2012) | intdatm_dv<9 & intdaty_dv==2013)
replace year_12 = 5 if ks4_acadyr==2013 & ((intdatm_dv>8 & intdaty_dv==2013) | intdatm_dv<9 & intdaty_dv==2014)
replace year_12 = 6 if ks4_acadyr==2014 & ((intdatm_dv>8 & intdaty_dv==2014) | intdatm_dv<9 & intdaty_dv==2015)
replace year_12 = 7 if ks4_acadyr==2015 & ((intdatm_dv>8 & intdaty_dv==2015) | intdatm_dv<9 & intdaty_dv==2016)
replace year_12 = 8 if ks4_acadyr==2016 & ((intdatm_dv>8 & intdaty_dv==2016) | intdatm_dv<9 & intdaty_dv==2017)

lab define year_12 1"GCSEs 08/09, Year 12 09/10" ///
				   2"GCSEs 09/10, Year 12 10/11" ///
				   3"GCSEs 10/11, Year 12 11/12" ///
				   4"GCSEs 11/12, Year 12 12/13" ///
				   5"GCSEs 12/13, Year 12 13/14" ///
				   6"GCSEs 13/14, Year 12 14/15" ///
				   7"GCSEs 14/15, Year 12 15/16" ///
				   8"GCSEs 15/16, Year 12 16/17"
lab val year_12 year_12

tab year_12, missing

tab year_12 age, missing

keep if age==16 | age==17

count


* Educational Attainment 

capture drop obin 
gen obin = 0 if ks4_gcse_ac<4 & ks4_gcse_ac>=0
replace obin = 1 if ks4_gcse_ac>4 & ks4_gcse_ac<=14

capture lab define obin 0"Less than 5 GCSEs" 1"Five or More GCSEs" 
lab val obin obin
lab var obin "Achieved 5 or more GCSEs A-C"

* Housing Tenure

gen tenure= 1 if tenure_dv>=3 & tenure_dv<=8
replace tenure=0 if tenure_dv>=1 & tenure_dv<=2

capture lab define tenure 0"Own Home" 1"Don't Own Home" 
lab val tenure tenure 
lab var tenure "Housing Tenure in Year 12"

* Sex

gen female=1 if sex==1 
replace female=0 if sex==2 
lab define female 0"Female" 1"female" 
lab val female female 
lab var female "Sex"

* Parental NS-SEC 
* Mother 

capture drop nssec8_mo 
gen nssec8_mo =. 
replace nssec8_mo=1 if jbnssec8_dvmo==1
replace nssec8_mo=2 if jbnssec8_dvmo==2
replace nssec8_mo=3 if jbnssec8_dvmo==3
replace nssec8_mo=4 if jbnssec8_dvmo==4
replace nssec8_mo=5 if jbnssec8_dvmo==5
replace nssec8_mo=6 if jbnssec8_dvmo==6
replace nssec8_mo=7 if jbnssec8_dvmo==7
replace nssec8_mo=8 if jbnssec8_dvmo==8
replace nssec8_mo=9 if jbnssec8_dvmo==-8


lab define nssec8 1"1.1 Large employers and higher managerial occupations" ///
				  2"1.2 Higher professional occupations" ///
				  3"2 Lower managerial and professional occupations" ///
				  4"3 Intermediate occupations" ///
				  5"4 Small employers and own account workers" ///
				  6"5 Lower supervisory and technical occupations" ///
				  7"6 Semi-routine occupations" ///
				  8"7 Routine occupations" ///
				  9"8 Not in Employment"
lab val nssec8_mo nssec8  
lab var nssec8_mo "NS-SEC Mother"

* Father 
capture drop nssec8_fa
gen nssec8_fa =. 
replace nssec8_fa=1 if jbnssec8_dvfa==1
replace nssec8_fa=2 if jbnssec8_dvfa==2
replace nssec8_fa=3 if jbnssec8_dvfa==3
replace nssec8_fa=4 if jbnssec8_dvfa==4
replace nssec8_fa=5 if jbnssec8_dvfa==5
replace nssec8_fa=6 if jbnssec8_dvfa==6
replace nssec8_fa=7 if jbnssec8_dvfa==7
replace nssec8_fa=8 if jbnssec8_dvfa==8
replace nssec8_fa=9 if jbnssec8_dvfa==-8

lab val nssec8_fa nssec8  
lab var nssec8_fa "NS-SEC Father"

* Parental

gen nssec=. 
replace nssec=nssec8_fa
replace nssec=. if nssec8_fa==9

replace nssec= nssec8_mo if nssec8_fa==. & nssec8_mo!=.
replace nssec=. if nssec==9

lab val nssec nssec8 
lab var nssec "Parental NS-SEC"

* Econ activity 

gen econ=.
replace econ=0 if jbstat>=1 & jbstat<=6
replace econ=1 if jbstat==7 
replace econ=0 if jbstat>=8 & jbstat<=9

gen econm=. 
replace econm=1 if jbstat>=1 & jbstat<=2
replace econm=2 if jbstat==7
replace econm=3 if jbstat==9 
replace econm=4 if jbstat>=3 & jbstat<=6 
replace econm=4 if jbstat==8 
replace econm=4 if jbstat==97


lab define econ 0"Not Continue Schooling" 1"Continue Schooling" 
lab val econ econ

* Weights 

codebook *xw, compact

tab wave if indinus_xw!=., missing
tab wave if indinub_xw!=., missing
tab wave if indinui_xw!=., missing

capture drop combined_adult_xw 
gen combined_adult_xw = indinub_xw 
replace combined_adult_xw = indinus_xw if indinub_xw==. & wave==1
summarize combined_adult_xw
count


* sample restricted to year_12 sample only -- remove duplicates

tab year_12, missing 
drop if year_12==. 
count

tab hhorig, missing

duplicates list pidp if year_12!=.
sort pidp wave 
order pidp wave 

capture drop duplicate_obs 
duplicates tag pidp if year_12!=., gen(duplicate_obs)
tab duplicate_obs, missing

duplicates drop pidp if year_12!=., force
duplicates list pidp if year_12!=. 
tab duplicate_obs, missing

count
duplicates list pidp

capture drop missing 
gen missing = 1 if econ>=. | obin>=. | female>=. | tenure>=. | nssec>=. | ks4_acadyr>=. 

tab missing, missing

save "$workingdata/ukhls_clean_state_v1.dta", replace 

* CRA Sample

keep if !missing(econ, obin, nssec, tenure, female, ks4_acadyr)

save "$workingdata/ukhls_cra_v1.dta", replace 




