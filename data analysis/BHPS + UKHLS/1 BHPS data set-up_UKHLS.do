clear all
set maxvar 20000

* Synth Cohorts

use"$bhpsdata\ba_indresp_protect.dta", clear
merge m:1 ba_hid using "$bhpsdata\ba_hhsamp_protect.dta", keepusing(ba_psu ba_strata)
rename _merge ba_hhsamp_merge 
keep if ba_region<17
drop if ba_ivfio>1

gen wave = 1
gen waveyear = 1990+wave 

gen ba_year12 = 0 
replace ba_year12 = 1 if ba_doby==waveyear-16 & ba_dobm<9
replace ba_year12 = 1 if ba_doby==waveyear-17 & ba_dobm>8
drop if ba_year12==.
drop if ba_year12==0 

rename ba_fnpid_bh ba_fnpid
rename ba_mnpid_bh ba_mnpid

count

save "$workingdata\ba_synthcohort_01_v1.dta", replace

* Identify synth cohorts in all other BHPS waves 

foreach w in b c d e f g h i j k l m n o p q r {
	use "$bhpsdata\b`w'_indresp_protect.dta", clear
	merge m:1 b`w'_hid using "$bhpsdata/b`w'_hhsamp_protect.dta", keepusing(b`w'_psu b`w'_strata)
	rename _merge b`w'hhsamp_merge
	keep if b`w'_region<17
	drop if b`w'_ivfio>1
	
	gen wave= strpos("abcdefghijklmnopqr", "`w'")
	gen waveyear = 1990+wave 
	gen b`w'_year12 =0
	replace b`w'_year12 = 1 if b`w'_doby==waveyear-16 & b`w'_dobm<9
	replace b`w'_year12 = 1 if b`w'_doby==waveyear-17 & b`w'_dobm>8
	drop if b`w'_year12==.
	drop if b`w'_year12==0  
	
	rename b`w'_fnpid_bh b`w'_fnpid
	rename b`w'_mnpid_bh b`w'_mnpid
	
	count 
	
	save "$workingdata\b`w'_synthcohort_01_v1.dta", replace
}

* Mother Dataset 

foreach w in a b c d e f g h i j k l m n o p q r {
	use "$bhpsdata\b`w'_indresp_protect.dta", clear
	merge m:1 pid using "$bhpsdata\b`w'_indall_protect.dta", ///
		keepusing(b`w'_sppid)
		
	drop _merge 
	
	drop if b`w'_sex==1 
	drop if b`w'_mnpid_bh
	rename pid b`w'_mnpid 
	
	keep b`w'_mnpid b`w'_jbstat b`w'_jbsoc90 b`w'_jbsemp b`w'_jbmngr b`w'_jbsize b`w'_nchild b`w'_jbrgsc_dv b`w'_hoh b`w'_jbft b`w'_jbhad b`w'_cjsbly b`w'_jlrgsc_dv b`w'_hhtype b`w'_tenure b`w'_mastat b`w'_sppid b`w'_hid b`w'_isced b`w'_ivfio b`w'_jbhas b`w'_jboff b`w'_jbsec_bh b`w'_jlsec b`w'_jbcssf b`w'_jlcssf
	
	rename b`w'_jbstat b`w'_jbstat_mo
	rename b`w'_jbsoc90 b`w'_jbsoc90_mo
	rename b`w'_jbsemp b`w'_jbsemp_mo
	rename b`w'_jbmngr b`w'_jbmngr_mo
	rename b`w'_jbsize b`w'_jbsize_mo
	rename b`w'_nchild b`w'_nchild_mo
	rename b`w'_jbrgsc_dv b`w'_jbrgsc_dv_mo
	rename b`w'_hoh b`w'_hoh_mo
	rename b`w'_jbft b`w'_jbft_mo
	rename b`w'_jbhad b`w'_jbhad_mo
	rename b`w'_cjsbly b`w'_cjsbly_mo
	rename b`w'_jlrgsc_dv b`w'_jlrgsc_dv_mo
	rename b`w'_hhtype b`w'_hhtype_mo
	rename b`w'_tenure b`w'_tenure_mo
	rename b`w'_mastat b`w'_mastat_mo
	rename b`w'_sppid b`w'_sppid_mo
	rename b`w'_hid b`w'_hid_mo
	rename b`w'_isced b`w'_isced_mo
	rename b`w'_ivfio b`w'_ivfio_mo
	rename b`w'_jbhas b`w'_jbhas_mo
	rename b`w'_jboff b`w'_jboff_mo
	rename b`w'_jbsec_bh b`w'_jbsec_mo
	rename b`w'_jlsec b`w'_jlsec_mo
	rename b`w'_jbcssf b`w'_jbcss_mo
	rename b`w'_jlcssf b`w'_jlcss_mo
	
	save "$workingdata\b`w'_mother_01_v1.dta", replace
}

* Father Dataset 

foreach w in a b c d e f g h i j k l m n o p q r {
	use "$bhpsdata\b`w'_indresp_protect.dta", clear
	merge m:1 pid using "$bhpsdata\b`w'_indall_protect.dta", ///
		keepusing(b`w'_sppid)
		
	drop _merge 
	
	drop if b`w'_sex==2
	drop if b`w'_fnpid_bh
	rename pid b`w'_fnpid 
	
	keep b`w'_fnpid b`w'_jbstat b`w'_jbsoc90 b`w'_jbsemp b`w'_jbmngr b`w'_jbsize b`w'_nchild b`w'_jbrgsc_dv b`w'_hoh b`w'_jbft b`w'_jbhad b`w'_cjsbly b`w'_jlrgsc_dv b`w'_hhtype b`w'_tenure b`w'_mastat b`w'_sppid b`w'_hid b`w'_isced b`w'_ivfio b`w'_jbhas b`w'_jboff b`w'_jbsec_bh b`w'_jlsec b`w'_jbcssm b`w'_jlcssm
	 
	rename b`w'_jbstat b`w'_jbstat_fa
	rename b`w'_jbsoc90 b`w'_jbsoc90_fa
	rename b`w'_jbsemp b`w'_jbsemp_fa
	rename b`w'_jbmngr b`w'_jbmngr_fa
	rename b`w'_jbsize b`w'_jbsize_fa
	rename b`w'_nchild b`w'_nchild_fa
	rename b`w'_jbrgsc_dv b`w'_jbrgsc_dv_fa
	rename b`w'_hoh b`w'_hoh_fa
	rename b`w'_jbft b`w'_jbft_fa
	rename b`w'_jbhad b`w'_jbhad_fa
	rename b`w'_cjsbly b`w'_cjsbly_fa
	rename b`w'_jlrgsc_dv b`w'_jlrgsc_dv_fa
	rename b`w'_hhtype b`w'_hhtype_fa
	rename b`w'_tenure b`w'_tenure_fa
	rename b`w'_mastat b`w'_mastat_fa
	rename b`w'_sppid b`w'_sppid_fa
	rename b`w'_hid b`w'_hid_fa
	rename b`w'_isced b`w'_isced_fa
	rename b`w'_ivfio b`w'_ivfio_fa
	rename b`w'_jbhas b`w'_jbhas_fa
	rename b`w'_jboff b`w'_jboff_fa
	rename b`w'_jbsec_bh b`w'_jbsec_fa
	rename b`w'_jlsec b`w'_jlsec_fa
	rename b`w'_jbcssm b`w'_jbcss_fa
	rename b`w'_jlcssm b`w'_jlcss_fa
	
	save "$workingdata\b`w'_father_01_v1.dta", replace
}

* Merging all datasets together 

foreach w in a b c d e f g h i j k l m n o p q r {
	use "$workingdata\b`w'_synthcohort_01_v1.dta", clear
	
	merge m:1 b`w'_mnpid using "$workingdata\b`w'_mother_01_v1.dta"
	tab _merge 
	rename _merge mummerge
	label var mummerge "mum merge"
	keep if mummerge==1|mummerge==3
	count 
	
	save "$workingdata\b`w'_syntheticcohort_02_mummerge.dta", replace
	
	use "$workingdata\b`w'_syntheticcohort_02_mummerge.dta", clear
	merge m:1 b`w'_fnpid using "$workingdata\b`w'_father_01_v1.dta"
	
	tab _merge 
	rename _merge dadmerge 
	label var dadmerge "dad merge"
	keep if dadmerge==1|dadmerge==3
	count
	
	save "$workingdata\b`w'_syntheticcohort_03_merged.dta", replace
	}

* Append all waves together 

foreach w in a b c d e f g h i j k l m n o p q r {
	use "$workingdata\b`w'_syntheticcohort_03_merged.dta", clear
	rename b`w'_* *
	save "$workingdata\b`w'syntheticcohort_03_merged_v2.dta", replace
	
}

use "$workingdata\basyntheticcohort_03_merged_v2.dta", clear
append using "$workingdata\bbsyntheticcohort_03_merged_v2.dta"
append using "$workingdata\bcsyntheticcohort_03_merged_v2.dta"
append using "$workingdata\bdsyntheticcohort_03_merged_v2.dta"
append using "$workingdata\besyntheticcohort_03_merged_v2.dta"
append using "$workingdata\bfsyntheticcohort_03_merged_v2.dta"
append using "$workingdata\bgsyntheticcohort_03_merged_v2.dta"
append using "$workingdata\bhsyntheticcohort_03_merged_v2.dta"
append using "$workingdata\bisyntheticcohort_03_merged_v2.dta"
append using "$workingdata\bjsyntheticcohort_03_merged_v2.dta"
append using "$workingdata\bksyntheticcohort_03_merged_v2.dta"
append using "$workingdata\blsyntheticcohort_03_merged_v2.dta"
append using "$workingdata\bmsyntheticcohort_03_merged_v2.dta"
append using "$workingdata\bnsyntheticcohort_03_merged_v2.dta"
append using "$workingdata\bosyntheticcohort_03_merged_v2.dta"
append using "$workingdata\bpsyntheticcohort_03_merged_v2.dta"
append using "$workingdata\bqsyntheticcohort_03_merged_v2.dta"
append using "$workingdata\brsyntheticcohort_03_merged_v2.dta"

* Sort by wave and waveyear 

order pid wave waveyear 
sort waveyear 
label var waveyear "Year GCSE survey took place"
label var wave "Wave GCSE Survey took place"

* Keeo only Essex original sample

tab memorig waveyear, missing
keep if memorig==3
tab memorig waveyear, missing

count

duplicates list pid

* Outcome Vars

* Educational Attainment

capture drop num_gcseac 
gen num_gcseac =.

replace num_gcseac = 0 if (qfede==0 & (qfedd==1)) & (ivlyr==2 | ivlyr==.)
tab num_gcseac, missing
replace num_gcseac = 1 if nqfede==1 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 2 if nqfede==2 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 3 if nqfede==3 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 4 if nqfede==4 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 5 if nqfede==5 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 6 if nqfede==6 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 7 if nqfede==7 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 8 if nqfede==8 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 9 if nqfede==9 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 10 if nqfede==10 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 11 if nqfede==11 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 12 if nqfede==12 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 13 if nqfede==13 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 14 if nqfede==14 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 15 if nqfede==15 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 16 if nqfede==16 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 17 if nqfede==17 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 18 if nqfede==18 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 19 if nqfede==19 & (ivlyr==2 | ivlyr==.)
replace num_gcseac = 20 if nqfede==20 & (ivlyr==2 | ivlyr==.)

replace num_gcseac = 0 if (qfedxb==0 & (qfedxa==1)) & (ivlyr==1)
replace num_gcseac = 1 if nqfexb==1 & ivlyr==1
replace num_gcseac = 2 if nqfexb==1 & ivlyr==2
replace num_gcseac = 3 if nqfexb==1 & ivlyr==3
replace num_gcseac = 4 if nqfexb==1 & ivlyr==4
replace num_gcseac = 5 if nqfexb==1 & ivlyr==5
replace num_gcseac = 6 if nqfexb==1 & ivlyr==6
replace num_gcseac = 7 if nqfexb==1 & ivlyr==7
replace num_gcseac = 8 if nqfexb==1 & ivlyr==8
replace num_gcseac = 9 if nqfexb==1 & ivlyr==9
replace num_gcseac = 10 if nqfexb==1 & ivlyr==10
replace num_gcseac = 11 if nqfexb==1 & ivlyr==11
replace num_gcseac = 12 if nqfexb==1 & ivlyr==12
replace num_gcseac = 13 if nqfexb==1 & ivlyr==13
replace num_gcseac = 14 if nqfexb==1 & ivlyr==14
replace num_gcseac = 15 if nqfexb==1 & ivlyr==15
replace num_gcseac = 16 if nqfexb==1 & ivlyr==16
replace num_gcseac = 17 if nqfexb==1 & ivlyr==17
replace num_gcseac = 18 if nqfexb==1 & ivlyr==18
replace num_gcseac = 19 if nqfexb==1 & ivlyr==19
replace num_gcseac = 20 if nqfexb==1 & ivlyr==20


capture drop obin
gen obin=.
replace obin=0 if num_gcseac<5 & num_gcseac!=. & num_gcseac!=8
replace obin=1 if num_gcseac>4 & num_gcseac!=.

tab obin, missing


* Mother NS-SEC

capture drop nssec8_mo lastnssec8_mo 

recode jbsec_mo (-9=.) ///
				(10/20=1 "1.1 Large employers and higher managerial occupations") ///
				(31/34=2 "1.2 Higher professional occupations") ///
				(41/60=3 "2 Lower managerial and professional occupations") ///
				(71/74=4 "3 Intermediate occupations") ///
				(81/92=5 "4 Small employers and own account workers") ///
				(100/112=6 "5 Lower supervisory and technical occupations") ///
				(121/127=7 "6 Semi-routine occupations") ///
				(131/135=8 "7 Routine occupations") ///
				(-8=9 "8 Unclassified or unclassifiable"), ///
				gen(nssec8_mo)
				label var nssec8_mo "Mother's NS-SEC - 9 Category"
				
recode jlsec_mo (-9 -7=.) ///
				(10/20=1 "1.1 Large employers and higher managerial occupations") ///
				(31/34=2 "1.2 Higher professional occupations") ///
				(41/60=3 "2 Lower managerial and professional occupations") ///
				(71/74=4 "3 Intermediate occupations") ///
				(81/92=5 "4 Small employers and own account workers") ///
				(100/112=6 "5 Lower supervisory and technical occupations") ///
				(121/127=7 "6 Semi-routine occupations") ///
				(131/135=8 "7 Routine occupations") ///
				(-8=9 "8 Unclassified or unclassifiable"), ///
				gen(lastnssec8_mo)
				label var lastnssec8_mo "Mother's Last NS-SEC - 9 Category"
				
replace nssec8_mo = lastnssec8_mo if (nssec8_mo==. & lastnssec8_mo!=. & jbstat_mo>2)

* Mother CAMSIS 

capture drop camsis_mo
clonevar camsis_mo = jbcss_mo 

replace camsis_mo = jlcss_mo if (camsis_mo==. & jlcss_mo!=. & jbstat_mo>2)

replace camsis_mo=. if camsis_mo<0

label var camsis_mo "Mother's CAMSIS score"

* Mother RGSC 

capture drop rgsc7_mo lastrgsc7_mo

recode jbrgsc_dv_mo (-9=.) ///
				(1=1 "1 Professional occupations") ///
				(2=2 "2 Managerial & technical occupations") ///
				(3=3 "3NM Skilled non-manual") ///
				(4=4 "3M Skilled manual") ///
				(5=5 "4 Partly skilled occupations") ///
				(6=6 "5 Unskilled occupations") ///
				(-8=7 "6 Unclassified or unclassifiable"), ///
				gen(rgsc7_mo)
				label var rgsc7_mo "Mother's RGSC - 7 Category"
				
recode jlrgsc_dv_mo (-9=.) ///
				(1=1 "1 Professional occupations") ///
				(2=2 "2 Managerial & technical occupations") ///
				(3=3 "3NM Skilled non-manual") ///
				(4=4 "3M Skilled manual") ///
				(5=5 "4 Partly skilled occupations") ///
				(6=6 "5 Unskilled occupations") ///
				(-8=7 "6 Unclassified or unclassifiable"), ///
				gen(lastrgsc7_mo)
				label var lastrgsc7_mo "Mother's RGSC - 7 Category"		
	
replace rgsc7_mo = lastrgsc7_mo if (rgsc7_mo==. & lastrgsc7_mo!=. & jbstat_mo>2)

* Father NS-SEC 

capture drop nssec8_fa lastnssec8_fa 

recode jbsec_fa (-9=.) ///
				(10/20=1 "1.1 Large employers and higher managerial occupations") ///
				(31/34=2 "1.2 Higher professional occupations") ///
				(41/60=3 "2 Lower managerial and professional occupations") ///
				(71/74=4 "3 Intermediate occupations") ///
				(81/92=5 "4 Small employers and own account workers") ///
				(100/112=6 "5 Lower supervisory and technical occupations") ///
				(121/127=7 "6 Semi-routine occupations") ///
				(131/135=8 "7 Routine occupations") ///
				(-8=9 "8 Unclassified or unclassifiable"), ///
				gen(nssec8_fa)
				label var nssec8_fa "Father's NS-SEC - 9 Category"
				
recode jlsec_fa (-9 -7=.) ///
				(10/20=1 "1.1 Large employers and higher managerial occupations") ///
				(31/34=2 "1.2 Higher professional occupations") ///
				(41/60=3 "2 Lower managerial and professional occupations") ///
				(71/74=4 "3 Intermediate occupations") ///
				(81/92=5 "4 Small employers and own account workers") ///
				(100/112=6 "5 Lower supervisory and technical occupations") ///
				(121/127=7 "6 Semi-routine occupations") ///
				(131/135=8 "7 Routine occupations") ///
				(-8=9 "8 Unclassified or unclassifiable"), ///
				gen(lastnssec8_fa)
				label var lastnssec8_fa "Father's Last NS-SEC - 9 Category"
				
replace nssec8_fa = lastnssec8_fa if (nssec8_fa==. & lastnssec8_fa!=. & jbstat_fa>2)


* Father CAMSIS 

capture drop camsis_fa
clonevar camsis_fa = jbcss_fa

replace camsis_fa = jlcss_fa if (camsis_fa==. & jlcss_fa!=. & jbstat_fa>2)

replace camsis_fa=. if camsis_fa<0

label var camsis_fa "Father's CAMSIS score"

* Father RGSC 

capture drop rgsc7_fa lastrgsc7_fa

recode jbrgsc_dv_fa (-9=.) ///
				(1=1 "1 Professional occupations") ///
				(2=2 "2 Managerial & technical occupations") ///
				(3=3 "3NM Skilled non-manual") ///
				(4=4 "3M Skilled manual") ///
				(5=5 "4 Partly skilled occupations") ///
				(6=6 "5 Unskilled occupations") ///
				(-8=7 "6 Unclassified or unclassifiable"), ///
				gen(rgsc7_fa)
				label var rgsc7_fa "Father's RGSC - 7 Category"
				
recode jlrgsc_dv_fa (-9=.) ///
				(1=1 "1 Professional occupations") ///
				(2=2 "2 Managerial & technical occupations") ///
				(3=3 "3NM Skilled non-manual") ///
				(4=4 "3M Skilled manual") ///
				(5=5 "4 Partly skilled occupations") ///
				(6=6 "5 Unskilled occupations") ///
				(-8=7 "6 Unclassified or unclassifiable"), ///
				gen(lastrgsc7_fa)
				label var lastrgsc7_fa "Father's RGSC - 7 Category"		
	
replace rgsc7_fa = lastrgsc7_fa if (rgsc7_fa==. & lastrgsc7_fa!=. & jbstat_fa>2)



* Parental Social Class 

gen nssec=. 
replace nssec=nssec8_fa
replace nssec=. if nssec8_fa==9

replace nssec= nssec8_mo if nssec8_fa==. & nssec8_mo!=.
replace nssec=. if nssec==9

gen camsis=. 
replace camsis=camsis_fa
replace camsis= camsis_mo if camsis_fa==. & camsis_mo!=.

gen rgsc=. 
replace rgsc=rgsc7_fa
replace rgsc=. if rgsc7_fa==7 

replace rgsc= rgsc7_mo if rgsc7_fa==. & rgsc7_mo!=.
replace rgsc=. if rgsc==7

* Sex 
tab sex

gen female=. 
replace female=1 if sex==1 
replace female=0 if sex==2
lab define sex 0"Female" 1"Male" 
lab val female sex 

* Tenure 

gen tenure=.
replace tenure=0 if tenure_dv>=1 & tenure_dv<=2 
replace tenure=1 if tenure_dv>=3 & tenure_dv<=7

lab define tenure 0"Own Home" 1"Don't Own Home" 
label val tenure tenure 

* Econ Activity post-schooling 

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

tab wave if indin91_xw!=., missing
tab wave if indin99_xw!=., missing
tab wave if indin01_xw!=., missing

capture drop combined_adult_xw 
gen combined_adult_xw = indin91_xw 
replace combined_adult_xw = indin99_xw if indin91_xw==.
replace combined_adult_xw = indin01_xw if indin91_xw==. & indin99_xw==.
summarize combined_adult_xw
count

capture drop missing 
gen missing = 1 if econ>=. | obin>=. | female>=. | tenure>=. | nssec>=. | waveyear>=. 

tab missing, missing

save "$workingdata\bhps_clean_state_v1.dta", replace

keep if !missing(econ, obin, female, tenure, nssec, rgsc, camsis, waveyear)

save "$workingdata\bhps_cra_v1.dta", replace




