

/*====================================================================
                        1: Imputation
====================================================================*/
clear

use "$dta_fld/merge_impute"

gen cohort=0 if (id >=1 & id <=8411)
replace cohort=1 if (id >=8412 & id <=19672)


mi set flong

mi register imputed econbin obin sex tenure nssec cohort parity breast mage med fed
tab _mi_miss
		

cd "$dta_fld"

mi impute chained ///
///
(logit, augment) econbin obin sex tenure cohort breast ///
///
(ologit, augment) med fed mage parity ///
///
(mlogit, augment) nssec ///
///
if cohort==1, rseed(12346) dots force add(260) burnin(20) savetrace(subsample_testimpute, replace) 

save merged_cohort_impute, replace



gen obinc=.
replace obinc=0 if (obin==0 & cohort==0)
replace obinc=0 if (cohort==1)
replace obinc=1 if (obin==1 & cohort==0)

gen obinc2=.
replace obinc2=0 if (obin==0 & cohort==1)
replace obinc2=0 if (cohort==0)
replace obinc2=1 if (obin==1 & cohort==1)

gen sexc=.
replace sexc=0 if (sex==0 & cohort==0)
replace sexc=0 if (cohort==1)
replace sexc=1 if (sex==1 & cohort==0)

gen sexc2=.
replace sexc2=0 if (sex==0 & cohort==1)
replace sexc2=0 if (cohort==0)
replace sexc2=1 if (sex==1 & cohort==1)

gen tenurec=.
replace tenurec=0 if (tenure==0 & cohort==0)
replace tenurec=0 if (cohort==1)
replace tenurec=1 if (tenure==1 & cohort==0)

gen tenurec2=.
replace tenurec2=0 if (tenure==0 & cohort==1)
replace tenurec2=0 if (cohort==0)
replace tenurec2=1 if (tenure==1 & cohort==1)

gen nssecncds=.
replace nssecncds=0 if (cohort==1)
replace nssecncds=0 if (cohort==0 & nssec==3)
replace nssecncds=1 if (cohort==0 & nssec==1)
replace nssecncds=2 if (cohort==0 & nssec==2)
replace nssecncds=3 if (cohort==0 & nssec==4)
replace nssecncds=4 if (cohort==0 & nssec==5)
replace nssecncds=5 if (cohort==0 & nssec==6)
replace nssecncds=6 if (cohort==0 & nssec==7)
replace nssecncds=7 if (cohort==0 & nssec==8)

gen nssecbcs=.
replace nssecbcs=0 if (cohort==0)
replace nssecbcs=0 if (cohort==1 & nssec==3)
replace nssecbcs=1 if (cohort==1 & nssec==1)
replace nssecbcs=2 if (cohort==1 & nssec==2)
replace nssecbcs=3 if (cohort==1 & nssec==4)
replace nssecbcs=4 if (cohort==1 & nssec==5)
replace nssecbcs=5 if (cohort==1 & nssec==6)
replace nssecbcs=6 if (cohort==1 & nssec==7)
replace nssecbcs=7 if (cohort==1 & nssec==8)


mi estimate, saving(miestfile1, replace) post dots: logit econbin i.obinc i.obinc2 i.sexc i.sexc2 i.tenurec i.tenurec2 i.nssecncds i.nssecbcs i.cohort

est store imputed

etable

mimrgns, dydx(*) predict(pr)


cd "$out_fld"

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