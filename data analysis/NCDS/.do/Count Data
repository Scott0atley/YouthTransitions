///GLM and Poisson: Count Based Models

gen opass=.
replace opass=0 if (n1701==0)
replace opass=1 if (n1701==1)
replace opass=2 if (n1701==2)
replace opass=3 if (n1701==3)
replace opass=4 if (n1701==4)
replace opass=5 if (n1701==5)
replace opass=6 if (n1701==6)
replace opass=7 if (n1701==7)
replace opass=8 if (n1701==8)
replace opass=9 if (n1701==9)
replace opass=10 if (n1701==10)
replace opass=11 if (n1701==11)
replace opass=12 if (n1701==12)

hist opass, freq

///GLM Poisson Model
glm opass i.lea sex white i.fclass fman freem, fam(poi)

///Checking for independence #1 Scaled dispersion statistics
glm opass i.lea sex white i.fclass fman freem, fam(poi) nolog scale(x2)

glm opass i.lea sex white i.fclass fman freem, nolog fam(poi) eform scale(x2) nohead

///	Robust Sandwich Estimator
glm opass i.lea sex white i.fclass fman freem, fam(poi) vce(robust) nolog
///Bootstrapping
bootstrap, reps(1000): glm opass i.lea sex white i.fclass fman freem, fam(poi)

///Checking for zeros
///zero count and summary statistics
summarize opass
di exp(-.1833361)*.1833361^0/exp(lnfactorial(0))
display .83248831*7116
///5923.9868 = 5924 zero counts
codebook ocat
///substantial dispartity between expected and observed zero counts in the data, Poisson distribution not advised 

///checking if the mean is the varaince on the count response variables
 tabstat opass, statistics(mean variance)
/// mean=0.18 and Variance=0.86, these are not the same by a lot

///Is the Pearson Chi2 dispersion statistic a value of approximately 1.0?
glm opass i.lea sex white i.fclass fman freem, fam(poi)
///pearson dispersion statistic = 2.89


///goodness of fit statistics
qui poisson opass i.lea sex white i.fclass fman freem
estat gof

///score testing
glm opass i.lea sex white i.fclass fman freem, fam(poi) nolog nohead
predict mu
gen double z=((opass-mu)^2-opass)/(mu*sqrt(2))
regress z
///Lagrange Multiplier test
summ opass, meanonly
scalar nybar= r(sum)
gen double musq= mu*mu 
summ musq, meanonly
scalar mu2= r(sum)
scalar chival= (mu2-nybar)^2/(2*mu2)

display "LM Value= " chival _n "P-Value= " chiprob(1,chival)

///analysis of fit
///to check best predictor fitting
qui poisson opass i.lea sex white i.fclass fman freem
lrdrop1
///for most parisomonious model, probably should drop fman from model

///Storing Models
qui glm opass i.lea sex white i.fclass fman freem, fam(poi)
est store A
qui glm opass i.lea sex white i.fclass fman freem, fam(poi) nolog scale(x2)
est store B
qui glm opass i.lea sex white i.fclass fman freem, fam(poi) vce(robust) nolog
est store C
bootstrap, reps(1000): glm opass i.lea sex white i.fclass fman freem, fam(poi)
est store D
 
/// negative binomial regression

global xvars "i.lea sex white i.fclass fman freem"
global xtest "comp gram sec tech other I II III IV V sex white fman freem"
glm opass $xvars, fam(poi) vce(robust) nolog nohead
 
countfit opass $xtest, prm nbreg max(12)

///negative binomial regression
glm opass $xvars, fam(poi) vce(robust) 
estat ic
glm opass $xvars, fam(nb ml) vce(robust) 
estat ic
linktest

///NB-P Binomial to test the NB2 models
nbregp opass $xvars, nolog vce(robust)
estat ic

///Poisson-Logit Hurdle Model

///gen first hurdle
gen odum=.
replace odum=1 if(opass==1)
replace odum=1 if(opass==2)
replace odum=1 if(opass==3)
replace odum=1 if(opass==4)
replace odum=1 if(opass==5)
replace odum=1 if(opass==6)
replace odum=1 if(opass==7)
replace odum=1 if(opass==8)
replace odum=1 if(opass==9)
replace odum=1 if(opass==10)
replace odum=1 if(opass==11)
replace odum=1 if(opass==12)
replace odum=0 if(opass==0)

logit odum $xvars, nolog
estat ic

///gen second hurdle
ztp opass $xvars if opass>0, nolog
estat ic
display exp(1.684374)

display 2694.589+1188.007
///AIC = 3882.60

///NB-Logit model
logit odum $xvars, nolog
estat ic

ztnb opass $xvars if opass>0, nolog
estat ic

display 2694.589+1004.352
///AIC = 3698.94

///Final Model NB-Logit
logit odum $xvars, nolog vce(robust)
estat ic

ztnb opass $xvars if opass>0, nolog vce(robust)
estat ic


zipcv opass $xvars, nolog inflate($xvars) vuong


///for over dispersion
glm opass i.lea sex white i.fclass fman freem, fam(poi) disp(2.888918) irls
