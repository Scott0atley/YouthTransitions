

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
