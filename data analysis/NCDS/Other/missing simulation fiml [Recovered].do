


clear

* Set number of observations
set obs 1000

* Set seed for reproducibility
set seed 1234

* Generate metric dependent variable
gen dep = runiform()

gen ind1 = ceil(2 * runiform())

replace ind1 = 1 if econ201 > 0.4
replace ind1 = 2 if econ201 > 0.3


* Assign second category of sex to a proportion of observations where econ201 is 4

gen ind2 = ind1

gen missing = ind1

gen ind3=.
replace ind3=0 if(missing==1)
replace ind3=1 if(missing==2)


regress dep ind1 ind2 ind3


* Display the first few observations
list in 1/10


regress econ201 sex edu ten

est store cra
etable

* introduce missingness

replace ten = . if econ201 > 0.3


regress econ201 edu sex ten 

est store missing 
etable, append

* FIML 
sem (econ201 <- sex edu ten), method(mlmv)

est store fiml
etable, append

est table cra missing fiml

*MI Aux

* Generate auxiliary variable 1 - 1-3 vairables that are predictive of both the probability of missingness and the underlying missing values themselves
gen aux1 = 0.5 * ten + econ201 + rnormal(0, 1)
gen aux2 = 0.8 * ten - econ201 + rnormal(0, 1)
gen aux3 = 0.6 * ten + 0.4 * econ201 + rnormal(0, 1)
gen aux4 = 0.3 * ten + 1.2 * econ201 + rnormal(0, 1)
gen aux5 = 0.7 * ten - 0.2 * econ201 + rnormal(0, 1)
gen aux6 = 0.9 * ten + 0.1 * econ201 + rnormal(0, 1)
gen aux7 = 0.4 * ten - 0.6 * econ201 + rnormal(0, 1)
gen aux8 = 0.2 * ten + 0.9 * econ201 + rnormal(0, 1)
gen aux9 = 0.1 * ten - 0.3 * econ201 + rnormal(0, 1)
gen aux10 = 0.6 * ten + 0.7 * econ201 + rnormal(0, 1)

* Display the first few observations of the auxiliary variables
list ten econ201 aux1-aux10 in 1/10


* Generate auxiliary variable 4 - variables that are predictive of the underlying missing values only
gen aux11 = rnormal(0, 1)
gen aux12 = rnormal(0, 1)
gen aux13 = rnormal(0, 1)
gen aux14 = rnormal(0, 1)
gen aux15 = rnormal(0, 1)
gen aux16 = rnormal(0, 1)


cd "G:\Stata data and do\do files\PhD Chapters\Chapter One"
save simulationone, replace

* setting MI data up

mi set wide

mi register imputed econ201 sex edu ten 

tab _mi_miss


mi impute chained ///
///
(regress) econ201 ///
(logit, augment) sex edu ten ///
///
, rseed(12345) dots force add(10) burnin(10) 


* mi model

mi estimate, post dots: regress econ201 sex edu ten

est store imputednoaux
etable, append

est table cra missing fiml imputednoaux

save simulationtwo, replace

use "G:\Stata data and do\do files\PhD Chapters\Chapter One\simulationone.dta"


* setting MI data up

mi set wide

mi register imputed econ201 sex edu ten aux1 aux2 aux3 aux4 aux5 aux6 aux7 aux8 aux9 aux10 aux11 aux12 aux13 aux14 aux15 aux16

tab _mi_miss


mi impute chained ///
///
(regress) econ201 aux1 aux2 aux3 aux4 aux5 aux6 aux7 aux8 aux9 aux10 aux11 aux12 aux13 aux14 aux15 aux16 ///
(logit, augment) sex edu ten ///
///
, rseed(12345) dots force add(5) burnin(10) 


* mi model

mi estimate, post dots: regress econ201 sex edu ten

est store imputed
etable, append

est table cra missing fiml imputednoaux imputed

save simulationthree, replace


cd "G:\Stata data and do\Tables and Figures\Tables and Figuers for Chapter One"

collect style showbase all

collect label levels etable_depvar 1 "Complete" ///
								   2 "Missing" ///
								   3 "FIML" ///
								   4 "Imputed with no auxillary" ///
								   5 "Imputed", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.3f))  ///
		cstat(_r_se, nformat(%6.3f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 1: Simulation Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: NCDS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("simulation.docx", replace)  
		
		
		
		
		
		
		
		
		
		
		
		

