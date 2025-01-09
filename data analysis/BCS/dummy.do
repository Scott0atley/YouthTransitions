
/*====================================================================
                        1: Educational Attainment = 0
====================================================================*/

clear

cd "$dta_fld"

use "bcs_recoded_raw.dta"

drop if missing(crecords)

misstable summarize econbin obin sex tenure nssec 

misstable patterns econbin obin sex tenure nssec

misstable patterns econbin obin tenure sex nssec  , frequency


replace obin=0 if (obin==.)

logit $mb1c

etable 

margins, dydx(*) post

etable, append 

cd "$outputs"

collect style showbase all

collect label levels etable_depvar 1 "0" ///
										2 "0 margins", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: NCDS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("0logits.docx", replace) 

cd "$dta_fld"

save bcs_obin_zero, replace 

/*====================================================================
                        1: Educational Attainment = 1
====================================================================*/

clear

cd "$dta_fld"

use "bcs_recoded_raw.dta"

drop if missing(crecords)

misstable summarize econbin obin sex tenure nssec 

misstable patterns econbin obin sex tenure nssec

misstable patterns econbin obin tenure sex nssec  , frequency


replace obin=1 if (obin==.)

logit $mb1c

etable 

margins, dydx(*) post

etable, append 

cd "$outputs"


collect style showbase all

collect label levels etable_depvar 1 "1" ///
										2 "1 margins", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: NCDS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("1logits.docx", replace) 
		
cd "$dta_fld"

save bcs_obin_zero, replace 




