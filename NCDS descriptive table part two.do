collect clear

table (var) (), statistic(fvfrequency obin agesch sex ethnic fclass) ///
					statistic(fvpercent obin agesch sex ethnic fclass) 
					
collect remap result[fvfrequency mean] = Col[1 1] 
	collect remap result[fvpercent sd] = Col[2 2]
    
collect get resname = "Mean", tag(Col[1] var[mylabel]) 
	collect get resname = "SD", tag(Col[2] var[mylabel])
    
collect get empty = "  ", tag(Col[1] var[empty]) 
	collect get empty = "  ", tag(Col[2] var[empty])
    
count
	collect get n = `r(N)', tag(Col[2] var[n])
	
collect layout (var[0.obin 1.obin ///
					0.agesch 1.agesch ///
					0.sex 1.sex ///
					0.ethnic 1.ethnic ////
					1.fclass 2.fclass 3.fclass 4.fclass 5.fclass 6.fclass 7.fclass ////
					empty mylabel ///
					weight height ///
					empty n]) (Col[1 2])
					
collect style header Col, title(hide)

collect style header var[empty mylabel], level(hide)
collect style row stack, nobinder

collect style cell var[obin agesch sex ethnic fclass]#Col[1], nformat(%6.0fc) 
collect style cell var[obin agesch sex ethnic fclass]#Col[2], nformat(%6.2f) sformat("%s%%") 	

collect style cell border_block[item row-header], border(top, pattern(nil)) 

collect title "Table n: Descriptive Statistics for Logistic Regression Model"

collect note "Data Source: NCDS Sweep 16 & 23"

collect preview
