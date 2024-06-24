

/*====================================================================
                        1: Multiple Imputation
====================================================================*/
clear

cd "$dta_fld"

use "ncds_recoded_raw.dta"

drop if missing(n4118)

misstable summarize econbin obin sex tenure nssec 

misstable patterns econbin obin sex tenure nssec

logit $mb1c

gen cc= e(sample)

foreach var in econbin obin sex tenure nssec {
	tab `var' cc, col
}

foreach var in acatnn0region bconnn99 maw5 aconnn512 acatnn236 bcatnn95 DadNeverReads ccatnn1434 ccatnn1150 genability11 toilet itoilet otoilet cooking water garden dconnn2492 dconnage16dv46{
	regress econbin `var'
	testparm `var'
}	

*** using Bodner (2008) tables 2 and 3 suggests that with around 30 per cent missingness 40 iterations is the most efficient to stop at and table 3 suggests 36 for 95% CI for half-widths and FMIs round that up to 40 ***

mi set wide

mi register imputed econbin obin sex tenure nssec maw5 aconnn512 genability11 toilet itoilet cooking water dconnn2492
tab _mi_miss

mi impute chained ///
///
(logit, augment) obin sex tenure maw5 aconnn512 genability11 toilet itoilet cooking water dconnn2492 econbin ///
///
(mlogit, augment) nssec ///
///
, rseed(12346) dots force add(40) burnin(20) savetrace(MI_test_trace, replace)
		
		
mi estimate, post dots: logit econbin i.obin i.sex i.tenure ib(3).nssec

est store imputed

etable

mimrgns, dydx(*) predict(pr) 

cd "$out_fld"

collect style showbase all

collect label levels etable_depvar 1 "imp" ///
								   2 "margins", modify

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
		
		
		
mi estimate, post vartable nocitable 

mi estimate, post dftable nocitable 
		
cd "$dta_fld"
save ncds_mi, replace