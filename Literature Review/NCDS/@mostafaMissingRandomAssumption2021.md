# Missing at random assumption made more plausible: Evidence from the 1958 British birth cohort
#### (2021) - Tarek Mostafa, Martina Narayanan, Benedetta Pongiglione, Brian Dodgeon, Alissa Goodman, Richard J. Silverwood, George B. Ploubidis
**Journal**: Journal of Clinical Epidemiology
**Link**:: https://linkinghub.elsevier.com/retrieve/pii/S0895435621000627
**DOI**:: 10.1016/j.jclinepi.2021.02.019
**Links**:: 
**Tags**:: #paper #NCDS #MissingData 
**Cite Key**:: [@mostafaMissingRandomAssumption2021]

### Abstract

```
Objective: Non-response is unavoidable in longitudinal surveys. The consequences are lower statistical power and the potential for bias. We implemented a systematic data-driven approach to identify predictors of non-response in the National Child Development Study (NCDS; 1958 British birth cohort). Such variables can help make the missing at random assumption more plausible, which has implications for the handling of missing data Study Design and Setting: We identified predictors of non-response using data from the 11 sweeps (birth to age 55) of the NCDS (n = 17,415), employing parametric regressions and the LASSO for variable selection. Results: Disadvantaged socio-economic background in childhood, worse mental health and lower cognitive ability in early life, and lack of civic and social participation in adulthood were consistently associated with non-response. Using this information, along with other data from NCDS, we were able to replicate the “population distribution” of educational attainment and marital status (derived from external data), and the original distributions of key early life characteristics. Conclusion: The identified predictors of non-response have the potential to improve the plausibility of the missing at random assumption. They can be straightforwardly used as “auxiliary variables” in analyses with principled methods to reduce bias due to missing data. © 2021 Elsevier Inc. All rights reserved.
```

### Notes

“They can be straightforwardly used as “auxiliary variables” in analyses with principled methods to reduce bias due to missing data.” (Mostafa et al., 2021, p. 44)

“ntextualizing the 1958 British National Child Development Study (NCDS) within Rubin’s framework, we know that the missing data generating mechanism is not” (Mostafa et al., 2021, p. 44)

“CAR as previous work [13,14] has shown that various variables are associated with non-response. In practice, as is expected to be the case in the vast majority of longitudinal surveys, in most analyses employing NCDS the missing data generating mechanism is MAR or MNAR” (Mostafa et al., 2021, p. 45)

“e used binary variables indicating non-response for each sweep of NCDS from age 7 onwards. We defined non-response as participants who did not take part in the survey, either because of refusal, the survey team not been being able to establish contact, or because contact was not attempted, for example because of long-term refusal (Table S1). We did not consider as non-response participants that have died or emigrated since our aim was to identify predictors of non-response and not of mortality or emigration” (Mostafa et al., 2021, p. 46)

“onsidering that the NCDS mortality rate is representative of the population (Fig. 1 and Table S2), the target population in each sweep of NCDS needs to be adjusted accordingly to reflect these changes. With the exception of modelling mortality as an outcome of interest, including participants that have died in any form of missing data analysis within NCDS would be the equivalent of generalizing estimates to a non-existent (immortal) target population. The NCDS target population at each age is therefore all people born in 1958 who are alive and living in Great Britain at this ag” (Mostafa et al., 2021, p. 46)

“he 3-stage approach can be summarized as follows for non-response at sweep t: Stage 1: Complete case univariable modified Poisson regressions of non-response at sweep t on each potential predictor of non-response at sweep 0 up to sweep t –1. Retain predictors with P< 0.05. Stage 2: Complete case multivariable modified Poisson regressions of non-response at sweep t on all retained predictors at sweep 0, then separately on all retained predictors at sweep 1, up to all retained predictors at sweep t 1. Retain predictors with P< 0.05.” (Mostafa et al., 2021, p. 46)

“ge 3: MI using all retained variables plus nonresponse at sweep t in the imputation model. MI multivariable modified Poisson regressions for all retained predictors at sweep 0, up to sweep t –1,adjusted for predictors at all previous (but not subsequent) sweeps. Retain predictors with P< 0.001” (Mostafa et al., 2021, p. 47)

“ge 3 allowed us to compare predictors of nonresponse from all stages of the life course and identify the set that has the potential to maximize the plausibility of the MAR assumption for a given NCDS sweep.” (Mostafa et al., 2021, p. 47)

“n order to investigate whether the predictors of nonresponse identified at Stage 3, used in conjunction with other data from NCDS, have the potential to restore sample representativeness in NCDS despite selective attrition, we compared estimates from participants at age 50 with the known population distribution of educational attainment and marital status derived from the APS in 2008. We also investigated whether the original distributions of paternal social class at birth and cognitive ability at age 7 could be replicated using data from only respondents at age 55” (Mostafa et al., 2021, p. 47)

“Stata” (Mostafa et al., 2021, p. 47)

“rthermore, our results can only be generalized to those born in 1958 in Britain or close to that year” (Mostafa et al., 2021, p. 53)

“A publicly available step-by-step user guide based on our results is available on the CLS website to allow users of NCDS data to appropriately account for missing data [39].” (Mostafa et al., 2021, p. 53)