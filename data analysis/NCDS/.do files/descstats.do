

/*====================================================================
                        1: Table of Analyitical Variables 
====================================================================*/

cd "$out_fld"

collect clear

table (var) (), statistic(fvfrequency econbin obin sex tenure nssec nssec90 rgsc rgsc90) ///
					statistic(fvpercent econbin obin sex tenure nssec nssec90 rgsc rgsc90) ///
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
					1.rgsc 2.rgsc 3.rgsc 4.rgsc 5.rgsc 6.rgsc ///
                    1.nssec90 2.nssec90 3.nssec90 4.nssec90 5.nssec90 6.nssec90 7.nssec90 8.nssec90 ///
                    1.rgsc90 2.rgsc90 3.rgsc90 4.rgsc90 5.rgsc90 6.rgsc90 ///
					empty mylabel ///
					camsis ///
                    cam90 ///
					empty n]) (Col[1 2])

collect label levels Col 1 "n" 2 "%"			
collect style header Col, title(hide)
collect style header var[empty mylabel], level(hide)
collect style row stack, nobinder
collect style cell var [econbin obin sex tenure nssec nssec90 rgsc rgsc90]#Col[1], nformat(%6.0fc) 
collect style cell var[econbin obin sex tenure nssec nssec90 rgsc rgsc90]#Col[2], nformat(%6.2f) sformat("%s%%") 	
collect style cell var[camsis cam90], nformat(%6.2f)
collect style cell border_block[item row-header], border(top, pattern(nil)) 
collect title "Table 1: Descriptive Statistics for Economic Activity"
collect note "Data Source: NCDS"
collect preview

collect export "Table1.docx", replace

/*====================================================================
                        2: Descriptive Stats by Dep. 
====================================================================*/

dtable i.obin i.sex i.tenure i.nssec i.rgsc i.nssec90 i.rgsc90 camsis cam90, by(econbin) nformat(%6.2fc) title(Descriptive Statistics by Economic Activity) export("Table2", as(docx) replace)


/*====================================================================
                        3: Social Stratification Stats 
====================================================================*/

dtable i.nssec, by(nssec90) nformat(%6.2fc) title(Descriptive Statistics comparing NS-SEC by SOC2000 and SOC90 codes) export("Table3", as(docx) replace)

dtable i.rgsc, by(rgsc90) nformat(%6.2fc) title(Descriptive Statistics comparing RGSC by SOC2000 and SOC90 codes) export("Table4", as(docx) replace)

summarize camsis, detail

summarize cam90, detail