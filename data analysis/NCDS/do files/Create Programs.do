

capture program drop regress1

program regress1, rclass
 drop _all
    
* Set number of observations
set obs 1000
    
* Generate metric independent variable #1
drawnorm x1, n(1000) means(40) sds(12)

* Generate metric independent variable #2
drawnorm x2, n(1000) means(200) sds(50)

* Generate metric independent variable #3
drawnorm x3, n(1000) means(150) sds(5)

* Generate metric dependent variable
gen y = 3*x1 + 4*x2 + 4*x3 + rnormal(500, 150)

regress y x1 x2 x3


gen beta1c = _b[x1]
gen se1c = _se[x1]
	
gen beta2c = _b[x2]
gen se2c = _se[x2]
	
gen beta3c = _b[x3]
gen se3c = _se[x3]

gen error1 = e(rmse)
	

end

capture program drop sem1

program sem1, rclass
 drop _all
    
* Set number of observations
set obs 1000
    
* Generate metric independent variable #1
drawnorm x1, n(1000) means(40) sds(12)

* Generate metric independent variable #2
drawnorm x2, n(1000) means(200) sds(50)

* Generate metric independent variable #3
drawnorm x3, n(1000) means(150) sds(5)

* Generate metric dependent variable
gen y = 3*x1 + 4*x2 + 4*x3 + rnormal(500, 150)

sem (y <- x1 x2 x3), method(mlmv)

gen beta1c = _b[x1]
gen se1c = _se[x1]
	
gen beta2c = _b[x2]
gen se2c = _se[x2]
	
gen beta3c = _b[x3]
gen se3c = _se[x3]

end



capture program drop missingmcar

program missingmcar, rclass
 drop _all
    
* Set number of observations
set obs 1000
    
* Generate metric independent variable #1
drawnorm x1, n(1000) means(40) sds(12)

* Generate metric independent variable #2
drawnorm x2, n(1000) means(200) sds(50)

* Generate metric independent variable #3
drawnorm x3, n(1000) means(150) sds(5)

* Generate metric dependent variable
gen y = 3*x1 + 4*x2 + 4*x3 + rnormal(500, 150)

* Generate MCAR 
gen rmcar = rbinomial(1, 0.5)  // MCAR: 50% chance of missingness (binary random)
replace x2 = . if rmcar == 0  // Set x to missing where rmcar == 0

regress y x1 x2 x3


gen beta1 = _b[x1]
gen se1 = _se[x1]
	
gen beta2 = _b[x2]
gen se2 = _se[x2]
	
gen beta3 = _b[x3]
gen se3 = _se[x3]

gen error1 = e(rmse)

end


capture program drop missingmar

program missingmar, rclass
 drop _all
    
* Set number of observations
set obs 1000
    
* Generate metric independent variable #1
drawnorm x1, n(1000) means(40) sds(12)

* Generate metric independent variable #2
drawnorm x2, n(1000) means(200) sds(50)

* Generate metric independent variable #3
drawnorm x3, n(1000) means(150) sds(5)

* Generate metric dependent variable
gen y = 3*x1 + 4*x2 + 4*x3 + rnormal(500, 150)

* Generate MAR
gen prob_mar = logistic(y-2105.2)
gen rmar = 0 if prob_mar==0
replace x2 = . if rmar == 0  // Set x to missing where rmar == 0
regress y x1 x2 x3


gen beta1 = _b[x1]
gen se1 = _se[x1]
	
gen beta2 = _b[x2]
gen se2 = _se[x2]
	
gen beta3 = _b[x3]
gen se3 = _se[x3]

gen error1 = e(rmse)

end



capture program drop missingmean

program missingmean, rclass
 drop _all
    
* Set number of observations
set obs 1000
    
* Generate metric independent variable #1
drawnorm x1, n(1000) means(40) sds(12)

* Generate metric independent variable #2
drawnorm x2, n(1000) means(200) sds(50)

* Generate metric independent variable #3
drawnorm x3, n(1000) means(150) sds(5)

* Generate metric dependent variable
gen y = 3*x1 + 4*x2 + 4*x3 + rnormal(500, 150)

* Generate MAR
gen prob_mar = logistic(y-2105.2)
gen rmar = 0 if prob_mar==0
replace x2 = . if rmar == 0  // Set x to missing where rmar == 0

summarize x2, meanonly
replace x2 = r(mean) if missing(x2)

regress y x1 x2 x3


gen beta1c = _b[x1]
gen se1c = _se[x1]
	
gen beta2c = _b[x2]
gen se2c = _se[x2]
	
gen beta3c = _b[x3]
gen se3c = _se[x3]

gen error1c = e(rmse)
	

end


capture program drop semmlmv

program semmlmv, rclass
    * drop all variables to create an empty dataset
    drop _all
    
* Set number of observations
set obs 1000
    
* Generate metric independent variable #1
drawnorm x1, n(1000) means(40) sds(12)

* Generate metric independent variable #2
drawnorm x2, n(1000) means(200) sds(50)

* Generate metric independent variable #3
drawnorm x3, n(1000) means(150) sds(5)

* Generate metric dependent variable
gen y = 3*x1 + 4*x2 + 4*x3 + rnormal(500, 150)

* Generate MAR
gen prob_mar = logistic(y-2105.2)
gen rmar = 0 if prob_mar==0
replace x2 = . if rmar == 0  // Set x to missing where rmar == 0
    
* Model estimation
sem (y <- x1 x2 x3), method(mlmv)
	
gen beta1 = _b[x1]
gen se1 = _se[x1]
	
gen beta2 = _b[x2]
gen se2 = _se[x2]
	
gen beta3 = _b[x3]
gen se3 = _se[x3]
    
	
end


capture program drop minoaux1

program minoaux1, rclass
    * drop all variables to create an empty dataset
    drop _all
    
* Set number of observations
set obs 1000
    
* Generate metric independent variable #1
drawnorm x1, n(1000) means(40) sds(12)

* Generate metric independent variable #2
drawnorm x2, n(1000) means(200) sds(50)

* Generate metric independent variable #3
drawnorm x3, n(1000) means(150) sds(5)

* Generate metric dependent variable
gen y = 3*x1 + 4*x2 + 4*x3 + rnormal(500, 150)

* Generate MAR
gen prob_mar = logistic(y-2105.2)
gen rmar = 0 if prob_mar==0
replace x2 = . if rmar == 0  // Set x to missing where rmar == 0
	
    * Model estimation

mi set wide

mi register imputed y x1 x2 x3

tab _mi_miss


mi impute chained ///
///
(regress) y x1 x2 x3 ///
, rseed(12345) dots force add(10) burnin(10) 


mi estimate, post dots: regress y x1 x2 x3

	
gen beta1 = _b[x1]
gen se1 = _se[x1]
	
gen beta2 = _b[x2]
gen se2 = _se[x2]
	
gen beta3 = _b[x3]
gen se3 = _se[x3]
    
	
end

capture program drop miaux1


program miaux1, rclass
    * drop all variables to create an empty dataset
    drop _all
    
* Set number of observations
set obs 1000
    
* Generate metric independent variable #1
drawnorm x1, n(1000) means(40) sds(12)

* Generate metric independent variable #2
drawnorm x2, n(1000) means(200) sds(50)

* Generate metric independent variable #3
drawnorm x3, n(1000) means(150) sds(5)

* Generate metric dependent variable
gen y = 3*x1 + 4*x2 + 4*x3 + rnormal(500, 150)

* Generate MAR
gen prob_mar = logistic(y-2105.2)
gen rmar = 0 if prob_mar==0
replace x2 = . if rmar == 0  // Set x to missing where rmar == 0
	
	
* Generate Auxiliary Variables Predictive of Probability of Missingness and Missing Values 	
gen aux1 = 0.7*x2 + 0.3*y + rnormal(0, 10)   // Correlated with x2 and y
gen aux2 = 0.5*x2 + 0.5*y + rnormal(0, 15)   // Balanced correlation with x2 and y
gen aux3 = 0.6*x2 + 0.2*x1 + 0.2*y + rnormal(0, 12)   // Adds x1 for slight variation
gen aux4 = 0.4*x2 + 0.6*y + rnormal(0, 20)   // Heavier weight on y (missingness predictor)
gen aux5 = 0.3*x2 + 0.3*y + 0.4*x3 + rnormal(0, 18)  // Introduces correlation with x3

* Generate Auxiliary Variables Predictive of ONLY Missing Values 

gen aux6 = 0.9*x2 + rnormal(0, 10)   // Strong correlation with x2, no y dependence
gen aux7 = 0.8*x2 + 0.2*x3 + rnormal(0, 12)   // Includes x3, but no direct link to missingness
gen aux8 = 0.85*x2 + 0.1*x1 + rnormal(0, 15)  // Includes x1, but missingness-independent
	
* setting MI data up

mi set wide

mi register imputed y x1 x2 x3 aux1 aux2 aux3 aux4 aux5 aux6 aux7 aux8 


mi impute chained ///
///
(regress) depi x1 x2 x3 aux1 aux2 aux3 aux4 aux5 aux6 aux7 aux8 aux9 aux10 aux11 aux12 aux13 aux14 aux15 aux16 ///
, rseed(12345) dots force add(10) burnin(10) 


* mi model

mi estimate, post dots: regress y x1 x2 x3

	
gen beta1 = _b[x1]
gen se1 = _se[x1]
	
gen beta2 = _b[x2]
gen se2 = _se[x2]
	
gen beta3 = _b[x3]
gen se3 = _se[x3]
    
	
end

capture program drop miaux100


program miaux100, rclass
    * drop all variables to create an empty dataset
    drop _all
    
* Set number of observations
set obs 1000
    
* Generate metric independent variable #1
drawnorm x1, n(1000) means(40) sds(12)

* Generate metric independent variable #2
drawnorm x2, n(1000) means(200) sds(50)

* Generate metric independent variable #3
drawnorm x3, n(1000) means(150) sds(5)

* Generate metric dependent variable
gen y = 3*x1 + 4*x2 + 4*x3 + rnormal(500, 150)

* Generate MAR
gen prob_mar = logistic(y-2105.2)
gen rmar = 0 if prob_mar==0
replace x2 = . if rmar == 0  // Set x to missing where rmar == 0
	
	
* Generate Auxiliary Variables Predictive of Probability of Missingness and Missing Values 	
gen aux1 = 0.7*x2 + 0.3*y + rnormal(0, 10)   // Correlated with x2 and y
gen aux2 = 0.5*x2 + 0.5*y + rnormal(0, 15)   // Balanced correlation with x2 and y
gen aux3 = 0.6*x2 + 0.2*x1 + 0.2*y + rnormal(0, 12)   // Adds x1 for slight variation
gen aux4 = 0.4*x2 + 0.6*y + rnormal(0, 20)   // Heavier weight on y (missingness predictor)
gen aux5 = 0.3*x2 + 0.3*y + 0.4*x3 + rnormal(0, 18)  // Introduces correlation with x3

* Generate Auxiliary Variables Predictive of ONLY Missing Values 

gen aux6 = 0.9*x2 + rnormal(0, 10)   // Strong correlation with x2, no y dependence
gen aux7 = 0.8*x2 + 0.2*x3 + rnormal(0, 12)   // Includes x3, but no direct link to missingness
gen aux8 = 0.85*x2 + 0.1*x1 + rnormal(0, 15)  // Includes x1, but missingness-independent
	
* setting MI data up

mi set wide

mi register imputed y x1 x2 x3 aux1 aux2 aux3 aux4 aux5 aux6 aux7 aux8 


mi impute chained ///
///
(regress) depi x1 x2 x3 aux1 aux2 aux3 aux4 aux5 aux6 aux7 aux8 aux9 aux10 aux11 aux12 aux13 aux14 aux15 aux16 ///
, rseed(12345) dots force add(100) burnin(20) 


* mi model

mi estimate, post dots: regress y x1 x2 x3

	
gen beta1 = _b[x1]
gen se1 = _se[x1]
	
gen beta2 = _b[x2]
gen se2 = _se[x2]
	
gen beta3 = _b[x3]
gen se3 = _se[x3]    
	
end

