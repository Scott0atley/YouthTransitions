


clear

* Set number of observations
set obs 1000

* Set seed for reproducibility
set seed 1234

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

cd "G:\Stata data and do\do files\PhD Chapters\Chapter One"

save SimulationBase, replace

regress dep ind1 ind2 ind3

* Store Complete Records Analysis Model 

est store cra
etable

* Produce Complete FIML Model and store it 

sem (dep <- ind1 ind2 ind3), method(mlmv)

est store fimlcomplete
etable, append

* introduce missingness at independent variable 3 condition on the distribution of the dependent variable (think missingness of housing tenure dependent on income level). Then regress and store the model. The choice of > 0.5 is based upon the desire to construct a MAR mechanism, whereby the fact that the data are missing is systematically related to the observed but not the unobserved data. For example, a registry examining depression may encounter data that are MAR if male participants are less likely to complete a survey about depression severity than female participants.

* example to help: Let's say female students tend to have more missing values in their performance scores (outcome) compared to male students. This could be due to administrative errors in recording scores or differences in reporting practices between genders. However, once gender is known, the mechanism behind missingness is unrelated to the actual performance of the students. For example, missing scores might occur equally among high-performing and low-performing female students.


replace ind3 = . if ind3==1 & dep < 0.5


tab ind3

regress dep ind1 ind2 ind3

est store missing 
etable, append

save SimulationMissing, replace

* Model where all missingness is coded as 0

replace ind3=0 if missing(ind3)

regress dep ind1 ind2 ind3

est store missingzero

etable, append

save SimulationZero, replace

* Model where all missingness is coded as 1

use "SimulationMissing.dta"

replace ind3=1 if missing(ind3)

regress dep ind1 ind2 ind3

est store missingone

etable, append

save SimulationOne, replace


* Single Use Mode Imputation Method (Mode imputation over mean because we are using a categorical variable)

use "SimulationMissing.dta"

tab ind3

egen m_ind3= mode(ind3)

replace ind3=m_ind3 if missing(ind3)

tab ind3

regress dep ind1 ind2 ind3 

est store single
etable, append

save SimulationSimple, replace

* FIML Model and store it 

use "SimulationMissing.dta"

sem (dep <- ind1 ind2 ind3), method(mlmv)


est store fiml
etable, append


program pro3, rclass replace
    * drop of all variables to create an empty dataset
    drop _all
    
* Set number of observations
set obs 1000
* Set seed for reproducibility
set seed 1234
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

replace ind3 = . if ind3==1 & dep < 0.5

    * model estimation
    sem (dep <- ind1 ind2 ind3), nocapslatent standardized
    return scalar d_by_ind1 = [y]_b[x1]
    return scalar d_by_ind1 [y]_b[x2]
	return scalar d_by_ind3 = [y]_b[x3]

    * fit indices calculation
    estat gof, stats(all)
end

simulate d_by_ind1 = [y]_b[x1] d_by_ind1 = [y]_b[x2] d_by_ind3 = [y]_b[x3], reps(100) nodots: pro3

* print the estimates and the fit indices
describe *
summarize
ci mean y_by_x1 y_by_x2 y_by_x3 


program mp1, rclass
    * Set number of observations
set obs 1000
* Set seed for reproducibility
set seed 1234
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

replace ind3 = . if ind3==1 & dep < 0.5
    * model estimation
    sem (dep <- ind1 ind2 ind3), nocapslatent standardized
    return scalar y_by_x1 = [y]_b[x1]
    return scalar y_by_x2 = [y]_b[x2]
    * fit indices calculation
    estat gof, stats(all)
    return scalar RMSEA = r(rmsea)
    return scalar SRMR = r(srmr)
end

* use the simulate command to rerun myprogram 1000 times and collect the estimates/indices
simulate y_by_x1 = [dep]_b[x1] y_by_x2 = [dep]_b[x2] RMSEA = r(rmsea) SRMR = r(srmr), reps(100) nodots: mp1

* print the estimates and the fit indices
describe *
summarize
ci mean y_by_x1 y_by_x2 RMSEA SRMR







save "SimulationSimulation.dta"

*MI No Aux Model 

use "SimulationMissing.dta"

* Generate auxiliary variable 1 - 1-3 vairables that are predictive of both the probability of missingness and the underlying missing values themselves
gen aux1 = 0.5 * ind3 + dep + rnormal(0, 1)
gen aux2 = 0.8 * ind3 - dep + rnormal(0, 1)
gen aux3 = 0.6 * ind3 + 0.4 * dep + rnormal(0, 1)
gen aux4 = 0.3 * ind3 + 1.2 * dep + rnormal(0, 1)
gen aux5 = 0.7 * ind3 - 0.2 * dep + rnormal(0, 1)
gen aux6 = 0.9 * ind3 + 0.1 * dep + rnormal(0, 1)
gen aux7 = 0.4 * ind3 - 0.6 * dep + rnormal(0, 1)
gen aux8 = 0.2 * ind3 + 0.9 * dep + rnormal(0, 1)
gen aux9 = 0.1 * ind3 - 0.3 * dep + rnormal(0, 1)
gen aux10 = 0.6 * ind3 + 0.7 * dep + rnormal(0, 1)

* Display the first few observations of the auxiliary variables
list ind3 dep aux1-aux10 in 1/10


* Generate auxiliary variable 4 - variables that are predictive of the underlying missing values only
gen aux11 = rnormal(0, 1)
gen aux12 = rnormal(0, 1)
gen aux13 = rnormal(0, 1)
gen aux14 = rnormal(0, 1)
gen aux15 = rnormal(0, 1)
gen aux16 = rnormal(0, 1)

save SimulationAux, replace

* setting MI data up

mi set wide

mi register imputed dep ind1 ind2 ind3

tab _mi_miss


mi impute chained ///
///
(regress) dep ///
(logit, augment) ind1 ind2 ind3 ///
///
, rseed(12345) dots force add(10) burnin(10) 


* mi model

mi estimate, post dots: regress dep ind1 ind2 ind3

est store imputednoaux
etable, append

save SimulationNoAux, replace

* MI Aux Model

use "SimulationAux.dta"

* setting MI data up

mi set wide

mi register imputed dep ind1 ind2 ind3 aux1 aux2 aux3 aux4 aux5 aux6 aux7 aux8 aux9 aux10 aux11 aux12 aux13 aux14 aux15 aux16

tab _mi_miss


mi impute chained ///
///
(regress) dep aux1 aux2 aux3 aux4 aux5 aux6 aux7 aux8 aux9 aux10 aux11 aux12 aux13 aux14 aux15 aux16 ///
(logit, augment) ind1 ind2 ind3 ///
///
, rseed(12345) dots force add(10) burnin(10) 


* mi model

mi estimate, post dots: regress dep ind1 ind2 ind3

est store imputed
etable, append

save SimulationMI, replace

* MI model with 100 imputations, or what Allison calls efficient estimation of standard errors and confidence intervals

use "SimulationAux.dta"


mi set wide

mi register imputed dep ind1 ind2 ind3 aux1 aux2 aux3 aux4 aux5 aux6 aux7 aux8 aux9 aux10 aux11 aux12 aux13 aux14 aux15 aux16

tab _mi_miss


mi impute chained ///
///
(regress) dep aux1 aux2 aux3 aux4 aux5 aux6 aux7 aux8 aux9 aux10 aux11 aux12 aux13 aux14 aux15 aux16 ///
(logit, augment) ind1 ind2 ind3 ///
///
, rseed(12345) dots force add(100) burnin(20) 


* mi model

mi estimate, post dots: regress dep ind1 ind2 ind3

est store imputedmax
etable, append

save SimulationMI100, replace


cd "G:\Stata data and do\Tables and Figures\Tables and Figuers for Chapter One"

collect style showbase all

collect label levels etable_depvar 1 "Complete Records 'God Model'" ///
								   2 "Complete SEM" ///
								   3 "Missingness Introduced at Independent Variable 3" ///
								   4 "All Missingness coded as =0" ///
								   5 "All Missingness coded as =1" ///
								   6 "Single Use Modal Imputation" ///
								   7 "FIML" ///
								   8 "Imputed with no auxiliary variables and 10 imputations" ///
								   9 "Imputed with 10 imputations" ///
								   10 "Imputed with 100 imputations", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 1: Simulation Regression Models using a MAR principle") ///
		titlestyles(font(Times New Roman, size(12) bold)) ///
		note("Data Source: Simulation using a MAR principle. 51 per cent missingness introduced.") ///
		notestyles(font(Times New Roman, size(10) italic)) ///
		export("simulationMAR.docx", replace)  
		
		
		
		
		
		
		
		
		
		
		
		

