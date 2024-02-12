



	drop _all
	matrix c = (1, 0.5968, 1, 0.5678, 0.6174, 1)
	matrix m = (52.23,49.576,52.645)
	matrix sd = (10.25,9.34,9.36) 
	drawnorm x1 x2 y, n(1000) corr(c) cstorage(lower) means(m) sds(sd)
	reg y x1 x2

	
	replace x1=. if _n>870
	
	replace x2=. if _n>870
	
	replace x1=. if x1<42.40675
	
	replace y=. if _n<21
	
	reg y x1 x2
	
	sem (y <- x1 x2), method(mlmv)


	
	mi set wide
	
	mi register imputed y x1 x2 
	
	mi impute chained ///
	///
	(regress) y x1 x2 ///
	, rseed(12346) dots force add(50) burnin(20) 
	
	mi estimate: regress y x1 x2
	
	
	
