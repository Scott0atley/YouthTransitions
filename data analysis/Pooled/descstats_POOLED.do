

/*====================================================================
                        1: Table of Analyitical Variables 
====================================================================*/
use "$dta_fld/merge_cra_pooled_v1"

cd "$out_fld"

collect clear

table (var) (), statistic(fvfrequency econbin obin sex tenure nssec cohort) ///
					statistic(fvpercent econbin obin sex tenure nssec cohort) ///
					statistic(mean camsis cam90) ///  
					statistic(sd camsis cam90) 			
collect remap result[fvfrequency mean] = Col[1 1] 
	collect remap result[fvpercent sd] = Col[2 2]
collect get resname = "Mean", tag(Col[1] var[mylabel]) 
	collect get resname = "SD", tag(Col[2] var[mylabel])
collect get empty = "  ", tag(Col[1] var[empty]) 
	collect get empty = "  ", tag(Col[2] var[empty])
    
count
	collect get n = `r(N)', tag(Col[2] var[n])
	
collect layout (var[0.econbin 1.econbin ///
					0.obin 1.obin ///
					0.sex 1.sex  ///
					0.tenure 1.tenure ///
					1.nssec 2.nssec 3.nssec 4.nssec 5.nssec 6.nssec 7.nssec 8.nssec ///
					0.cohort 1.cohort 2.cohort 3.cohort 4.cohort ///
					empty mylabel ///
					empty n]) (Col[1 2])

collect label levels Col 1 "n" 2 "%"			
collect style header Col, title(hide)
collect style header var[empty mylabel], level(hide)
collect style row stack, nobinder
collect style cell var [econbin obin sex tenure nssec cohort]#Col[1], nformat(%6.0fc) 
collect style cell var[econbin obin sex tenure nssec cohort]#Col[2], nformat(%6.2f) sformat("%s%%") 	
collect style cell border_block[item row-header], border(top, pattern(nil)) 
collect title "Table 1: Descriptive Statistics for Economic Activity"
collect note "Data Source: NCDS, BCS, Waves 1-18 BHPS & Waves 1-6 UKHLS. Unweighted N="REDACTED""
collect preview

collect export "Table1.docx", replace

/*====================================================================
                        2: Descriptive Stats by Dep. 
====================================================================*/

dtable i.econbin i.obin i.sex i.tenure i.nssec, by(cohort) nformat(%6.2fc) title(Descriptive Statistics by Economic Activity) export("Table2", as(docx) replace)

