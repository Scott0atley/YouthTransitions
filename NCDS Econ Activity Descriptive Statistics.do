collect clear

table (var) (), statistic(fvfrequency econ194 econ195 econ196 econ197 econ198 econ199 econ200 econ201 econ202 econ203 econ204 econ205) ///
					statistic(fvpercent econ194 econ195 econ196 econ197 econ198 econ199 econ200 econ201 econ202 econ203 econ204 econ205) 
					
collect remap result[fvfrequency mean] = Col[1 1] 
	collect remap result[fvpercent sd] = Col[2 2]
    
collect get resname = "Mean", tag(Col[1] var[mylabel]) 
	collect get resname = "SD", tag(Col[2] var[mylabel])
    
collect get empty = "  ", tag(Col[1] var[empty]) 
	collect get empty = "  ", tag(Col[2] var[empty])
    
count
	collect get n = `r(N)', tag(Col[2] var[n])
	
collect layout (var[1.econ194 2.econ194 3.econ194 4.econ194 5.econ194 6.econ194 ///
					1.econ195 2.econ195 3.econ195 4.econ195 5.econ195 6.econ195 ///
					1.econ196 2.econ196 3.econ196 4.econ196 5.econ196 6.econ196 ///
					1.econ197 2.econ197 3.econ197 4.econ197 5.econ197 6.econ197 ////
					1.econ198 2.econ198 3.econ198 4.econ198 5.econ198 6.econ198 ////
					1.econ199 2.econ199 3.econ199 4.econ199 5.econ199 6.econ199 ////
					1.econ200 2.econ200 3.econ200 4.econ200 5.econ200 6.econ200 ////
					1.econ201 2.econ201 3.econ201 4.econ201 5.econ201 6.econ201 ////
					1.econ202 2.econ202 3.econ202 4.econ202 5.econ202 6.econ202 ////
					1.econ203 2.econ203 3.econ203 4.econ203 5.econ203 6.econ203 ////
					1.econ204 2.econ204 3.econ204 4.econ204 5.econ204 6.econ204 ////
					1.econ205 2.econ205 3.econ205 4.econ205 5.econ205 6.econ205 ////
					empty mylabel ///
					weight height ///
					empty n]) (Col[1 2])
					
collect style header Col, title(hide)

collect style header var[empty mylabel], level(hide)
collect style row stack, nobinder

collect style cell var[econ194 econ195 econ196 econ197 econ198 econ199 econ200 econ201 econ202 econ203 econ204 econ205]#Col[1], nformat(%6.0fc) 
collect style cell var[econ194 econ195 econ196 econ197 econ198 econ199 econ200 econ201 econ202 econ203 econ204 econ205]#Col[2], nformat(%6.2f) sformat("%s%%") 	

collect style cell border_block[item row-header], border(top, pattern(nil)) 

collect title "Table n: Descriptive Statistics for Economic Activity"

collect note "Data Source: NCDS Sweep 16 & 23"

collect preview