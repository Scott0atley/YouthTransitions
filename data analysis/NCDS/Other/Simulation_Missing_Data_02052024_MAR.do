


capture program drop regress1

program regress1, rclass
 drop _all
    
    * Set number of observations
    set obs 1000
    
    * Generate metric dependent variable
    gen dep = runiform()

* Generate Independent variable 1
gen ind1 = ceil(2 * runiform())

replace ind1 = 1 if dep > 0.8
replace ind1 = 2 if dep < 0.6


* Assign second category of sex to a proportion of observations where econ201 is 4

gen ind2 = ceil(2 * runiform())
replace ind2 = 1 if dep > 0.8
replace ind2 = 2 if dep < 0.6


gen missing = ceil(2 * runiform())
replace missing = 1 if dep > 0.8
replace missing = 2 if dep < 0.6


gen ind3=.
replace ind3=0 if(missing==1)
replace ind3=1 if(missing==2)

regress dep ind1 ind2 ind3

gen beta1 = _b[ind1]
	gen se1 = _se[ind1]
	
	gen beta2 = _b[ind2]
	gen se2 = _se[ind2]
	
	gen beta3 = _b[ind3]
	gen se3 = _se[ind3]

end

* use the simulate command to rerun myprogram 1000 times and collect the estimates/indices
simulate beta1 se1 beta2 se2 beta3 se3, reps(1000) seed(1234): regress1 


* print the estimates and the fit indices
describe *
summarize

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6

rename _sim_1 beta1 
rename _sim_2 se1 
rename _sim_3 beta2 
rename _sim_4 se2 
rename _sim_5 beta3 
rename _sim_6 se3 

cd "G:\Stata data and do\Missing Simulation Data"

save godmodel, replace




capture program drop sem1

program sem1, rclass
 drop _all
    
    * Set number of observations
    set obs 1000
    
    * Generate metric dependent variable
    gen depb = runiform()
	
* Generate Independent variable 1
gen ind1b = ceil(2 * runiform())

replace ind1b = 1 if depb > 0.8
replace ind1b = 2 if depb < 0.6


* Assign second category of sex to a proportion of observations where econ201 is 4

gen ind2b = ceil(2 * runiform())
replace ind2b = 1 if depb > 0.8
replace ind2b = 2 if depb < 0.6


gen missingb = ceil(2 * runiform())
replace missingb = 1 if depb > 0.8
replace missingb = 2 if depb < 0.6


gen ind3b=.
replace ind3b=0 if(missingb==1)
replace ind3b=1 if(missingb==2)

sem (depb <- ind1b ind2b ind3b), method(mlmv)

gen beta1b = _b[ind1b]
	gen se1b = _se[ind1b]
	
	gen beta2b = _b[ind2b]
	gen se2b = _se[ind2b]
	
	gen beta3b = _b[ind3b]
	gen se3b = _se[ind3b]

end

* use the simulate command to rerun myprogram 1000 times and collect the estimates/indices
simulate beta1b se1b beta2b se2b beta3b se3b, reps(1000) seed(1234): sem1 


* print the estimates and the fit indices
describe *
summarize

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6


rename _sim_1 beta1b 
rename _sim_2 se1b 
rename _sim_3 beta2b 
rename _sim_4 se2b 
rename _sim_5 beta3b 
rename _sim_6 se3b 


save semgodmodel, replace





capture program drop missingregress1

program missingregress1, rclass
 drop _all
    
    * Set number of observations
    set obs 1000
    
    * Generate metric dependent variable
    gen depc = runiform()
	
* Generate Independent variable 1
gen ind1c = ceil(2 * runiform())

replace ind1c = 1 if depc > 0.8
replace ind1c = 2 if depc < 0.6


* Assign second category of sex to a proportion of observations where econ201 is 4

gen ind2c = ceil(2 * runiform())
replace ind2c = 1 if depc > 0.8
replace ind2c = 2 if depc < 0.6


gen missingc = ceil(2 * runiform())
replace missingc = 1 if depc > 0.8
replace missingc = 2 if depc < 0.6


gen ind3c=.
replace ind3c=0 if(missingc==1)
replace ind3c=1 if(missingc==2)

replace ind3c = . if ind3c==1 & depc < 0.5

regress depc ind1c ind2c ind3c


gen beta1c = _b[ind1c]
	gen se1c = _se[ind1c]
	
	gen beta2c = _b[ind2c]
	gen se2c = _se[ind2c]
	
	gen beta3c = _b[ind3c]
	gen se3c = _se[ind3c]

end

* use the simulate command to rerun myprogram 1000 times and collect the estimates/indices
simulate beta1c se1c beta2c se2c beta3c se3c, reps(1000) seed(1234): missingregress1 


* print the estimates and the fit indices
describe *
summarize

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6


rename _sim_1 beta1c 
rename _sim_2 se1c 
rename _sim_3 beta2c
rename _sim_4 se2c
rename _sim_5 beta3c
rename _sim_6 se3c


save missingmodel, replace




capture program drop missing01

program missing01, rclass
 drop _all
    
    * Set number of observations
    set obs 1000
    
    * Generate metric dependent variable
    gen depd = runiform()
	
* Generate Independent variable 1
gen ind1d = ceil(2 * runiform())

replace ind1d = 1 if depd > 0.8
replace ind1d = 2 if depd < 0.6


* Assign second category of sex to a proportion of observations where econ201 is 4

gen ind2d = ceil(2 * runiform())
replace ind2d = 1 if depd > 0.8
replace ind2d = 2 if depd < 0.6


gen missingd = ceil(2 * runiform())
replace missingd = 1 if depd > 0.8
replace missingd = 2 if depd < 0.6


gen ind3d=.
replace ind3d=0 if(missingd==1)
replace ind3d=1 if(missingd==2)

replace ind3d = . if ind3d==1 & depd < 0.5

replace ind3d=0 if missing(ind3d)


regress depd ind1d ind2d ind3d


gen beta1d = _b[ind1d]
	gen se1d = _se[ind1d]
	
	gen beta2d = _b[ind2d]
	gen se2d = _se[ind2d]
	
	gen beta3d = _b[ind3d]
	gen se3d = _se[ind3d]

end

* use the simulate command to rerun myprogram 1000 times and collect the estimates/indices
simulate beta1d se1d beta2d se2d beta3d se3d, reps(1000) seed(1234): missing01 


* print the estimates and the fit indices
describe *
summarize

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6


rename _sim_1 beta1d
rename _sim_2 se1d
rename _sim_3 beta2d
rename _sim_4 se2d
rename _sim_5 beta3d
rename _sim_6 se3d


save missing01, replace



capture program drop missing11

program missing11, rclass
 drop _all
    
    * Set number of observations
    set obs 1000
    
    * Generate metric dependent variable
    gen depe = runiform()
	
* Generate Independent variable 1
gen ind1e = ceil(2 * runiform())

replace ind1e = 1 if depe > 0.8
replace ind1e = 2 if depe < 0.6


* Assign second category of sex to a proportion of observations where econ201 is 4

gen ind2e = ceil(2 * runiform())
replace ind2e = 1 if depe > 0.8
replace ind2e = 2 if depe < 0.6


gen missinge = ceil(2 * runiform())
replace missinge = 1 if depe > 0.8
replace missinge = 2 if depe < 0.6


gen ind3e=.
replace ind3e=0 if(missinge==1)
replace ind3e=1 if(missinge==2)

replace ind3e = . if ind3e==1 & depe < 0.5

replace ind3e=1 if missing(ind3e)


regress depe ind1e ind2e ind3e


gen beta1e = _b[ind1e]
	gen se1e = _se[ind1e]
	
	gen beta2e = _b[ind2e]
	gen se2e = _se[ind2e]
	
	gen beta3e = _b[ind3e]
	gen se3e = _se[ind3e]

end

* use the simulate command to rerun myprogram 1000 times and collect the estimates/indices
simulate beta1e se1e beta2e se2e beta3e se3e, reps(1000) seed(1234): missing11 


* print the estimates and the fit indices
describe *
summarize

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6


rename _sim_1 beta1e
rename _sim_2 se1e
rename _sim_3 beta2e
rename _sim_4 se2e
rename _sim_5 beta3e
rename _sim_6 se3e


save missing11, replace




capture program drop missingsingle1

program missingsingle1, rclass
 drop _all
    
    * Set number of observations
    set obs 1000
    
    * Generate metric dependent variable
    gen depf = runiform()
	
* Generate Independent variable 1
gen ind1f = ceil(2 * runiform())

replace ind1f = 1 if depf > 0.8
replace ind1f = 2 if depf < 0.6


* Assign second category of sex to a proportion of observations where econ201 is 4

gen ind2f = ceil(2 * runiform())
replace ind2f = 1 if depf > 0.8
replace ind2f = 2 if depf < 0.6


gen missingf = ceil(2 * runiform())
replace missingf = 1 if depf > 0.8
replace missingf = 2 if depf < 0.6


gen ind3f=.
replace ind3f=0 if(missingf==1)
replace ind3f=1 if(missingf==2)

replace ind3f = . if ind3f==1 & depf < 0.5

egen m_ind3f= mode(ind3f)

replace ind3f=m_ind3f if missing(ind3f)


regress depf ind1f ind2f ind3f


gen beta1f = _b[ind1f]
	gen se1f = _se[ind1f]
	
	gen beta2f = _b[ind2f]
	gen se2f = _se[ind2f]
	
	gen beta3f = _b[ind3f]
	gen se3f = _se[ind3f]

end

* use the simulate command to rerun myprogram 1000 times and collect the estimates/indices
simulate beta1f se1f beta2f se2f beta3f se3f, reps(1000) seed(1234): missingsingle1 


* print the estimates and the fit indices
describe *
summarize

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6


rename _sim_1 beta1f
rename _sim_2 se1f
rename _sim_3 beta2f
rename _sim_4 se2f
rename _sim_5 beta3f
rename _sim_6 se3f


save missingsingle1, replace




capture program drop semmlmv


program semmlmv, rclass
    * drop all variables to create an empty dataset
    drop _all
    
    * Set number of observations
    set obs 1000
    
    * Generate metric dependent variable
    gen depg = runiform()
    * Generate Independent variable 1
    gen ind1g = ceil(2 * runiform())
    replace ind1g = 1 if depg > 0.8
    replace ind1g = 2 if depg < 0.6
    * Assign second category of sex to a proportion of observations where econ201 is 4
    gen ind2g = ceil(2 * runiform())
    replace ind2g = 1 if depg > 0.8
    replace ind2g = 2 if depg < 0.6
    
    gen missingg = ceil(2 * runiform())
    replace missingg = 1 if depg > 0.8
    replace missingg = 2 if depg < 0.6
    
    gen ind3g = .
    replace ind3g = 0 if(missingg == 1)
    replace ind3g = 1 if(missingg == 2)
    
    replace ind3g = . if ind3g == 1 & depg < 0.5
    
    * Model estimation
	sem (depg <- ind1g ind2g ind3g), method(mlmv)
	
	gen beta1g = _b[ind1g]
	gen se1g = _se[ind1g]
	
	gen beta2g = _b[ind2g]
	gen se2g = _se[ind2g]
	
	gen beta3g = _b[ind3g]
	gen se3g = _se[ind3g]
    
	
end

* use the simulate command to rerun myprogram 1000 times and collect the estimates/indices
simulate beta1g se1g beta2g se2g beta3g se3g, reps(1000) seed(1234): semmlmv 


* print the estimates and the fit indices
describe *
summarize

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6

rename _sim_1 beta1g
rename _sim_2 se1g
rename _sim_3 beta2g
rename _sim_4 se2g
rename _sim_5 beta3g
rename _sim_6 se3g

save semmlmv, replace





capture program drop minoaux1


program minoaux1, rclass
    * drop all variables to create an empty dataset
    drop _all
    
    * Set number of observations
    set obs 1000
    
    * Generate metric dependent variable
    gen deph = runiform()
    * Generate Independent variable 1
    gen ind1h = ceil(2 * runiform())
    replace ind1h = 1 if deph > 0.8
    replace ind1h = 2 if deph < 0.6
    * Assign second category of sex to a proportion of observations where econ201 is 4
    gen ind2h = ceil(2 * runiform())
    replace ind2h = 1 if deph > 0.8
    replace ind2h = 2 if deph < 0.6
    
    gen missingh = ceil(2 * runiform())
    replace missingh = 1 if deph > 0.8
    replace missingh = 2 if deph < 0.6
    
    gen ind3h = .
    replace ind3h = 0 if(missingh == 1)
    replace ind3h = 1 if(missingh == 2)
    
    replace ind3h = . if ind3h == 1 & deph < 0.5
	
    * Model estimation

mi set wide

mi register imputed deph ind1h ind2h ind3h

tab _mi_miss


mi impute chained ///
///
(regress) deph ///
(logit, augment) ind1h ind2h ind3h ///
///
, rseed(12345) dots force add(10) burnin(10) 


mi estimate, post dots: regress deph ind1h ind2h ind3h

	
	gen beta1h = _b[ind1h]
	gen se1h = _se[ind1h]
	
	gen beta2h = _b[ind2h]
	gen se2h = _se[ind2h]
	
	gen beta3h = _b[ind3h]
	gen se3h = _se[ind3h]
    
	
end

* use the simulate command to rerun myprogram 1000 times and collect the estimates/indices
simulate beta1h se1h beta2h se2h beta3h se3h, reps(1000) seed(1234): minoaux1 


* print the estimates and the fit indices
describe *
summarize

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6

rename _sim_1 beta1h
rename _sim_2 se1h
rename _sim_3 beta2h
rename _sim_4 se2h
rename _sim_5 beta3h
rename _sim_6 se3h

save minoaux1, replace




capture program drop miaux1


program miaux1, rclass
    * drop all variables to create an empty dataset
    drop _all
    
    * Set number of observations
    set obs 1000
    
    * Generate metric dependent variable
    gen depi = runiform()
    * Generate Independent variable 1
    gen ind1i = ceil(2 * runiform())
    replace ind1i = 1 if depi > 0.8
    replace ind1i = 2 if depi < 0.6
    * Assign second category of sex to a proportion of observations where econ201 is 4
    gen ind2i = ceil(2 * runiform())
    replace ind2i = 1 if depi > 0.8
    replace ind2i = 2 if depi < 0.6
    
    gen missingi = ceil(2 * runiform())
    replace missingi = 1 if depi > 0.8
    replace missingi = 2 if depi < 0.6
    
    gen ind3i = .
    replace ind3i = 0 if(missingi == 1)
    replace ind3i = 1 if(missingi == 2)
    
    replace ind3i = . if ind3i == 1 & depi < 0.5
	
	* Generate auxiliary variable 1 - 1-3 vairables that are predictive of both the probability of missingness and the underlying missing values themselves
gen aux1 = 0.5 * ind3i + depi + rnormal(0, 1)
gen aux2 = 0.8 * ind3i - depi + rnormal(0, 1)
gen aux3 = 0.6 * ind3i + 0.4 * depi + rnormal(0, 1)
gen aux4 = 0.3 * ind3i + 1.2 * depi + rnormal(0, 1)
gen aux5 = 0.7 * ind3i - 0.2 * depi + rnormal(0, 1)
gen aux6 = 0.9 * ind3i + 0.1 * depi + rnormal(0, 1)
gen aux7 = 0.4 * ind3i - 0.6 * depi + rnormal(0, 1)
gen aux8 = 0.2 * ind3i + 0.9 * depi + rnormal(0, 1)
gen aux9 = 0.1 * ind3i - 0.3 * depi + rnormal(0, 1)
gen aux10 = 0.6 * ind3i + 0.7 * depi + rnormal(0, 1)


* Generate auxiliary variable 4 - variables that are predictive of the underlying missing values only
gen aux11 = rnormal(0, 1)
gen aux12 = rnormal(0, 1)
gen aux13 = rnormal(0, 1)
gen aux14 = rnormal(0, 1)
gen aux15 = rnormal(0, 1)
gen aux16 = rnormal(0, 1)
	
* setting MI data up

mi set wide

mi register imputed depi ind1i ind2i ind3i aux1 aux2 aux3 aux4 aux5 aux6 aux7 aux8 aux9 aux10 aux11 aux12 aux13 aux14 aux15 aux16


mi impute chained ///
///
(regress) depi aux1 aux2 aux3 aux4 aux5 aux6 aux7 aux8 aux9 aux10 aux11 aux12 aux13 aux14 aux15 aux16 ///
(logit, augment) ind1i ind2i ind3i ///
///
, rseed(12345) dots force add(10) burnin(10) 


* mi model

mi estimate, post dots: regress depi ind1i ind2i ind3i

	
	gen beta1i = _b[ind1i]
	gen se1i = _se[ind1i]
	
	gen beta2i = _b[ind2i]
	gen se2i = _se[ind2i]
	
	gen beta3i = _b[ind3i]
	gen se3i = _se[ind3i]
    
	
end

* use the simulate command to rerun myprogram 1000 times and collect the estimates/indices
simulate beta1i se1i beta2i se2i beta3i se3i, reps(1000) seed(1234): miaux1 


* print the estimates and the fit indices
describe *
summarize

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6

rename _sim_1 beta1i
rename _sim_2 se1i
rename _sim_3 beta2i
rename _sim_4 se2i
rename _sim_5 beta3i
rename _sim_6 se3i

save miaux1, replace





capture program drop miaux100


program miaux100, rclass
    * drop all variables to create an empty dataset
    drop _all
    
    * Set number of observations
    set obs 1000
    
    * Generate metric dependent variable
    gen depj = runiform()
    * Generate Independent variable 1
    gen ind1j = ceil(2 * runiform())
    replace ind1j = 1 if depj > 0.8
    replace ind1j = 2 if depj < 0.6
    * Assign second category of sex to a proportion of observations where econ201 is 4
    gen ind2j = ceil(2 * runiform())
    replace ind2j = 1 if depj > 0.8
    replace ind2j = 2 if depj < 0.6
    
    gen missingj = ceil(2 * runiform())
    replace missingj = 1 if depj > 0.8
    replace missingj = 2 if depj < 0.6
    
    gen ind3j = .
    replace ind3j = 0 if(missingj == 1)
    replace ind3j = 1 if(missingj == 2)
    
    replace ind3j = . if ind3j == 1 & depj < 0.5
	
	* Generate auxiliary variable 1 - 1-3 vairables that are predictive of both the probability of missingness and the underlying missing values themselves
gen aux1b = 0.5 * ind3j + depj + rnormal(0, 1)
gen aux2b = 0.8 * ind3j - depj + rnormal(0, 1)
gen aux3b = 0.6 * ind3j + 0.4 * depj + rnormal(0, 1)
gen aux4b = 0.3 * ind3j + 1.2 * depj + rnormal(0, 1)
gen aux5b = 0.7 * ind3j - 0.2 * depj + rnormal(0, 1)
gen aux6b = 0.9 * ind3j + 0.1 * depj + rnormal(0, 1)
gen aux7b = 0.4 * ind3j - 0.6 * depj + rnormal(0, 1)
gen aux8b = 0.2 * ind3j + 0.9 * depj + rnormal(0, 1)
gen aux9b = 0.1 * ind3j - 0.3 * depj + rnormal(0, 1)
gen aux10b = 0.6 * ind3j + 0.7 * depj + rnormal(0, 1)


* Generate auxiliary variable 4 - variables that are predictive of the underlying missing values only
gen aux11b = rnormal(0, 1)
gen aux12b = rnormal(0, 1)
gen aux13b = rnormal(0, 1)
gen aux14b = rnormal(0, 1)
gen aux15b = rnormal(0, 1)
gen aux16b = rnormal(0, 1)
	
* setting MI data up

mi set wide

mi register imputed depj ind1j ind2j ind3j aux1b aux2b aux3b aux4b aux5b aux6b aux7b aux8b aux9b aux10b aux11b aux12b aux13b aux14b aux15b aux16b


mi impute chained ///
///
(regress) depj aux1b aux2b aux3b aux4b aux5b aux6b aux7b aux8b aux9b aux10b aux11b aux12b aux13b aux14b aux15b aux16b ///
(logit, augment) ind1j ind2j ind3j ///
///
, rseed(12345) dots force add(100) burnin(20) 


* mi model

mi estimate, post dots: regress depj ind1j ind2j ind3j

	
	gen beta1j = _b[ind1j]
	gen se1j = _se[ind1j]
	
	gen beta2j = _b[ind2j]
	gen se2j = _se[ind2j]
	
	gen beta3j = _b[ind3j]
	gen se3j = _se[ind3j]
    
	
end

* use the simulate command to rerun myprogram 1000 times and collect the estimates/indices
simulate beta1j se1j beta2j se2j beta3j se3j, reps(1000) seed(1234): miaux100 


* print the estimates and the fit indices
describe *
summarize

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6

rename _sim_1 beta1j
rename _sim_2 se1j
rename _sim_3 beta2j
rename _sim_4 se2j
rename _sim_5 beta3j
rename _sim_6 se3j

save miaux100, replace



ci mean beta1j se1j beta2j se2j beta3j se3j




