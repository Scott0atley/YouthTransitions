


clear

* Set number of observations
set obs 1000

* Set seed for reproducibility
set seed 1234

* Generate metric dependent variable
gen dep = runiform()

* Generate Independent variable 1
gen ind1 = ceil(2 * runiform())

replace ind1 = 1 if dep > 0.6
replace ind1 = 2 if dep < 0.4


* Assign second category of sex to a proportion of observations where econ201 is 4

gen ind2 = ceil(2 * runiform())
replace ind2 = 1 if dep > 0.6
replace ind2 = 2 if dep < 0.4


gen missing = ceil(2 * runiform())
replace missing = 1 if dep > 0.6
replace missing = 2 if dep < 0.4


gen ind3=.
replace ind3=0 if(missing==1)
replace ind3=1 if(missing==2)

cd "G:\Stata data and do\do files\PhD Chapters\Chapter One"

save SimulationBase, replace


regress dep ind1 ind2 ind3

* Store Complete Records Analysis Model 

est store cra
etable

* Produce Complete FIML Model and store it. This is to use as a point of comparison for a FIML model with missingness included. It also serves as a point of comparison in estimators between Ordinary least sqaures OLS and MLMV estimators. They should produce the same results. 

sem (dep <- ind1 ind2 ind3), method(mlmv)

est store fimlcomplete
etable, append

* introduce missingness at independent variable 3 condition on the data being missing indpendent of observed and unobserved data. In other words, no systematic differences exist between participants with missing data and those with complete data. For example, some participants may have missing laboratory values because a batch of lab samples was processed improperly. In these instances, the missing data reduce the analyzable population of the study and consequently, the statistical power, but do not introduce bias: when data are MCAR, the data which remain can be considered a simple random sample of the full data set of interest. MCAR is generally regarded as a strong and often unrealistic assumption. (MCAR is what we want to have when handling missing data, MAR is a much more complicated affair)

gen mcar = runiform() if _n >512

replace ind3 = . if !missing(mcar)

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

* FIML Model and store it. Stata doesn't have a 'FIML' estimation command, instead within the sem framework it has the estimation method mlmv or maximum liklihood with missing values. These two acronyms are synonomous within the stata framework: https://www.stata.com/manuals14/semintro4.pdf#semintro4RemarksandexamplessemChoiceofestimationmethod . For method MLMV to perform what might seem like magic, joint normality of all variables is assumed and missing values are assumed to be missing at random (MAR). MAR means either that the missing values are scattered completely at random throughout the data or that values more likely to be missing than others can be predicted by the variables in the model. Method MLMV formally requires the assumption of joint normality of all variables, both observed and latent. 

use "SimulationMissing.dta"

sem (dep <- ind1 ind2 ind3), method(mlmv)

est store fiml
etable, append

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
		title("Table 1: Simulation Regression Models using a MCAR principle") ///
		titlestyles(font(Times New Roman, size(12) bold)) ///
		note("Data Source: Simulation using a MCAR principle. 51 per cent missingness introduced.") ///
		notestyles(font(Times New Roman, size(10) italic)) ///
		export("simulationMCAR.docx", replace)  
		
		
		
		
		
		
		
		
		
		
		
		
		

