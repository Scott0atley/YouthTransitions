# Handling missing data in the National Child Development Study: User guide (Version 2).
#### (2021) - R Silverwood, M Narayanan, B Dodgeon, G Ploubidis
**Journal**: 
**Link**:: 
**DOI**:: 
**Links**:: 
**Tags**:: #paper #NCDS #MissingData 
**Cite Key**:: [@Silverwood2021]

### Abstract

```
Non-response is common in longitudinal surveys. Missing values due to nonresponse mean less efficient estimates because of the reduced size of the of the analysis sample, but also introduce the potential for bias since respondents are often systematically different from non-respondents.
```

### Notes
“Missing values due to nonresponse mean less efficient estimates because of the reduced size of the of the analysis sample, but also introduce the potential for bias since respondents are often systematically different from non-respondents.” (Silverwood et al., 2021, p. 2)

“(i) missing completely at random (MCAR), meaning that missingness does not depend on either observed or unobserved values (i.e. is completely at random); (ii) missing at random (MAR), meaning that, given the observed values, missingness does not depend on unobserved values; or (iii) missing not at random (MNAR), meaning that missingness depends on unobserved (and possibly observed) values (1, 2).” (Silverwood et al., 2021, p. 2)

“If data are MAR then popular analysis approaches include multiple imputation (MI) (2, 4, 5), inverse probability weighting (IPW) (6, 7), and full information maximum likelihood (FIML) (8, 9).” (Silverwood et al., 2021, p. 2)

“We found disadvantaged socio-economic background in childhood, worse mental health and lower cognitive ability in early life, and lack of civic and social participation in adulthood to be consistently associated with nonresponse. A full list of the identified predictors of non-response at each sweep is available in the Appendix.” (Silverwood et al., 2021, p. 2)

“These variables can be straightforwardly used as “auxiliary variables” (Silverwood et al., 2021, p. 3)

“Their appropriate use can help maximise the plausibility of the MAR assumption in order to reduce bias due to missing data and have the potential to restore sample representativeness in NCDS.” (Silverwood et al., 2021, p. 3)

“Each imputed data set is analysed using the substantive model of interest and the results are combined using standard rules (2), resulting in standard errors that incorporate the variability in results between the” (Silverwood et al., 2021, p. 3)

“this way, uncertainty about the missing data is appropriately accounted for in the inference.” (Silverwood et al., 2021, p. 4)

“A complete case analysis (see below) uses data from only 1896 cohort members” (Silverwood et al., 2021, p. 8)

“Of the original NCDS sample” (Silverwood et al., 2021, p. 8)

“Inferences from the complete case analysis only necessarily relate to the population of individuals with complete data on these specific variables” (Silverwood et al., 2021, p. 8)

“An exploration of the extent of missingness in the analysis variables can be conducted using the misstable summarize” (Silverwood et al., 2021, p. 9)

“This can be undertaken using misstable patterns (see help misstable)” (Silverwood et al., 2021, p. 9)

“In the presence of a MCAR mechanism, the distributions of all variables should be the” (Silverwood et al., 2021, p. 10)

“same (allowing for sampling variability) in the two groups. If it appears that there are systematic differences between the two groups, then this is suggestive of a MAR or MNAR mechanism” (Silverwood et al., 2021, p. 11)

“we derive a variable which indicates whether a cohort member is included in the complete case analysis and then see whether the distributions of analysis variables differ between complete cases and non-complete cases” (Silverwood et al., 2021, p. 11)

“Other variables, such as parental divorce, display clear imbalances (1.6% in complete cases, 4.5% in non-complete cases” (Silverwood et al., 2021, p. 12)

“More formal statistical testing of differences between the groups could also be conducted, for example through use of t-tests or chi-squared tests (subject to the usual underlying assumptions).” (Silverwood et al., 2021, p. 12)

“Analysing such a small proportion of the available data may raise concerns over the potential for bias and will certainly lead to imprecision in the results obtained.” (Silverwood et al., 2021, p. 12)

“The imputation model should include all the variables in the substantive model (exposure(s), outcome(s), confounder(s), etc.) in the form in which they will enter the analysis model (i.e. subsequent to any recoding or transformations).” (Silverwood et al., 2021, p. 13)

“The imputation model should also include the following sets of auxiliary (i.e. not included in the substantive model) variables” (Silverwood et al., 2021, p. 13)

“Variables that are predictive of both the probability of missingness and the underlying missing values themselves. (In our example, variables that are associated with non-response and income, as the association with income will increase the likelihood of association with missing values of income.) • Variables that are predictive of the underlying missing values only. (In our example, variables associated with income.)” (Silverwood et al., 2021, p. 13)

“As missing data in NCDS is largely driven by non-response at a given sweep (as opposed to item non-response within sweeps), the first of these auxiliary variables can be selected from the pre-determined sets of variables predictive of non-response at each sweep (see Appendix).” (Silverwood et al., 2021, p. 13)

“second of these auxiliary variables should be selected using a combination of substantive/theoretical knowledge and exploration of the data.” (Silverwood et al., 2021, p. 13)

“Auxiliary variables with very little missing data themselves will add information to the imputation model, improving the quality of the imputed values” (Silverwood et al., 2021, p. 13)

“As missingness in NCDS (as in almost all cohort studies) increases as time progresses, this suggests favouring auxiliary variables from earlier sweeps, though should not rule out variables from later sweeps with high levels of completeness.” (Silverwood et al., 2021, p. 14)

“Missingness is largely driven by non-response at the age 55 sweep (since nonrespondents at previous sweeps are usually, though not always, also nonrespondents at this sweep” (Silverwood et al., 2021, p. 14)

“The remaining 26 variables could all be included in the imputation model as auxiliary variables, but there is evidence to suggest that variables that are predictive of the chance of missing values but are not predictive of the underlying missing values themselves will not add information, so should not be included in the imputation model (5).” (Silverwood et al., 2021, p. 14)

“therefore examine which of these 26 variables that are predictive of non-response at age 55 are also predictive of income at age 55, using the observed data.” (Silverwood et al., 2021, p. 14)

“We find that 21 of the 26 variables are associated with income at age 55 with p < 0.001 so are included as auxiliary variables in the imputation model” (Silverwood et al., 2021, p. 14)

“The key here is to avoid including variables that are completely unassociated with the underlying values of the variable(s) subject to missingness (income in this instance); whether or not variables that are only weakly associated with the underlying values enter the imputation model should not have a substantial impact on the MI analysis” (Silverwood et al., 2021, p. 15)

“Alternatively, a machine learning approach to variable selection, such as the lasso (15), could be considered” (Silverwood et al., 2021, p. 15) Look more into this.

““Monotone” is a sequential approach using a monotone missing pattern; “chained” is a sequential approach using chained equations; “mvn” uses multivariate normal regression.” (Silverwood et al., 2021, p. 16)

“Imputation using chained equations fills in missing values in multiple variables iteratively by using chained equations, a sequence of univariate imputation models with fully conditional specification of prediction equations, accommodating arbitrary missing value patterns” (Silverwood et al., 2021, p. 16)

“Consider the appropriate type of imputation model for each variable requiring imputation.” (Silverwood et al., 2021, p. 16)

“It is important to gain some familiarity with the data prior to undertaking any analysis, and MI analyses are no exception” (Silverwood et al., 2021, p. 17)

“there is evidence that MI is relatively robust to the assumption of normality if the amount of missing information is low (14).” (Silverwood et al., 2021, p. 17)

“Binary variables to be modelled using logistic regression (logit)” (Silverwood et al., 2021, p. 17)

“so that they take values 0 and a non-zero integer (usually 1).” (Silverwood et al., 2021, p. 17)

“Multinomial logistic regression (mlogit) models used to model unordered categorical variables (or ordered categorical variables where the proportional odds assumptions cannot be assumed to hold) with many levels are often unstable and can prevent the imputation model from converging. It may therefore be advisable to collapse together some categories of such unordered categorical variables to form a variable with fewer levels.” (Silverwood et al., 2021, p. 18)

“We decided to retain these variables in their original form, conduct the imputation, then consider recoding them only if the multinomial logistic regression imputation model relating to one or more of these variables fails to converge.” (Silverwood et al., 2021, p. 18)

“Prior to undertaking the imputation, the data need to be specified as an MI dataset using the mi set command (see help mi set). The data are given a specific style: wide, mlong, flong, or flongsep. We recommend using the wide style in most instances” (Silverwood et al., 2021, p. 18)

“The variables should then be registered as being either imputed, passive or regular using the mi register command (see help mi register). “Imputed” variables are variables that have missing values and for which you will have imputations; “passive” variables are variables that are a function of imputed variables or of other” (Silverwood et al., 2021, p. 18)

“passive variables; “regular” variables are variables that are neither imputed nor” (Silverwood et al., 2021, p. 19)

“passive and that have the same values, whether missing or not, in all imputed” (Silverwood et al., 2021, p. 19)

“A new variable _mi_miss has now been created.” (Silverwood et al., 2021, p. 19)

“This shows that only 538 cohort members are non-missing for all 51 variables in the” (Silverwood et al., 2021, p. 20)

“the imputation model is specified by stating each model type (regress, logit, etc.) followed by the list of variables to be modelled using that model type” (Silverwood et al., 2021, p. 20)

“When a variable is to be modelled by ologit or mlogit, Stata recognises this as a categorical variable and handles it as such when it appears as an explanatory variable in other univariate imputation models (i.e. as if the i. prefix had been specified in a standard regression model).” (Silverwood et al., 2021, p. 20)

“Augmented versions of these regressions, in which a few observations with small weights are added to the data during estimation to avoid perfect prediction, can be utilised when perfect prediction is detected through use of the augment” (Silverwood et al., 2021, p. 20)

“The number of imputed datasets to be added is controlled by the add(#) option. How many imputations should you use? While a small number of imputations (say 520) may be sufficient for reliable estimation of point estimates in most situations, estimating p-values with little error requires a greater number of imputations (perhaps 100 or more) (5, 17).” (Silverwood et al., 2021, p. 21)

“We suggest that 50 imputations would be sufficient in most situations.” (Silverwood et al., 2021, p. 21)

“It can be helpful for troubleshooting to review the output from all the fitted imputation models. The output can be produced by using the noisily option and saved in a log file.” (Silverwood et al., 2021, p. 21)

“Similarly, it can be helpful to examine the means and standard deviations of imputed values from each iteration of the imputation (the “trace data”). These data can be saved to a separate data file using the savetrace(filename)” (Silverwood et al., 2021, p. 21)

“The rseed(#) option allows you to specify the random-number seed of the imputation procedure, making the results exactly reproducible if run again on a different occasion.” (Silverwood et al., 2021, p. 21)

“you would probably want to open a log file prior to running the above code (log using; see help log) and close it afterwards (log close), as well as saving the imputed dataset at the end” (Silverwood et al., 2021, p. 23)

“With a greater number of variables, convergence issues and other problems will often be encountere” (Silverwood et al., 2021, p. 23)

“Having conducted the imputation and saved the imputed datasets, it is important to” (Silverwood et al., 2021, p. 24)

“check that the imputed values themselves appear sensible.” (Silverwood et al., 2021, p. 24)

“One approach is to plot the means and standard deviations of imputed values from” (Silverwood et al., 2021, p. 24)

“each iteration of the imputation (“trace data”), saved as part of the imputation” (Silverwood et al., 2021, p. 24)

“procedure” (Silverwood et al., 2021, p. 24)

“A useful command for doing so is xtline (see help xtline) as it allows the values for each imputed dataset to be plotted in a different colour.” (Silverwood et al., 2021, p. 24)

“An underlying trend in the trace data is not in itself problematic, but if such a trend remains at the end of the burn-in period (and looks like it would continue in subsequent iterations) it suggests that the values had not sufficiently stabilised at the end of burn-in period when the values for each imputed dataset were drawn. In such situations the imputation model should be re-fitted with a greater number of iterations in the burn-in period using the burnin(#)” (Silverwood et al., 2021, p. 24)

“It is also good practice to compare the distributions of variables between the observed data and the imputed datasets.” (Silverwood et al., 2021, p. 25)

“plotting histograms for continuous variables and comparing prevalences for binary/categorical variables” (Silverwood et al., 2021, p. 25)

“To move to the next plot type “end” or “q”; to exit the plots completely type “BREAK”.” (Silverwood et al., 2021, p. 25)

“substantial differences should be investigated further.” (Silverwood et al., 2021, p. 28)

“Once the above checks of the imputed values have been satisfactorily concluded using the test dataset of 5 imputations, the imputation model should be re-fitted using a greater number of imputations (here we use 50) and with a greater number of iterations in the burn-in period if this was deemed necessary (here we use 20). The checks of the imputed values should then be repeated on the new imputed dataset to ensure that everything now/still looks okay.” (Silverwood et al., 2021, p. 29)

“The analysis model can be fitted using mi estimate (see help mi estimate), which is followed by whatever command would usually (i.e. in the non-MI setting) be used to fit the analysis model. A useful option here is dots, which displays dots in the Stata results window as the estimations are performed within each imputed dataset (indicating that progress is being made, which otherwise would not be apparent). The” (Silverwood et al., 2021, p. 29)

“if strong predictors of the underlying values of the outcome variable are included in the imputation model as auxiliary variables, then there is additional information in the imputation model beyond that in the analysis model, and the imputed values of the outcome variable should be retained in the MI analysis model.” (Silverwood et al., 2021, p. 30)

“All other things being equal, one would therefore try to include as many individuals as possible in the MI analysis, but not (in general) at the expense of introducing (or limiting the reduction of) bias.” (Silverwood et al., 2021, p. 30)

“One suggestion would be to perform the analysis using different analysis samples in order to explore the sensitivity of the findings to this issue.” (Silverwood et al., 2021, p. 30)

“The variable NR09 is an indicator variable for non-response at Sweep 9, so using the subsample with NR09 = 0 is just restricting the model fitting to the 9137 Sweep 9 (age 55) respon” (Silverwood et al., 2021, p. 31)

“NR09==0” (Silverwood et al., 2021, p. 31)

“If we believe that data are MAR then the MI analysis will (assuming we have correctly specified our imputation model) give us unbiased results,” (Silverwood et al., 2021, p. 32)

“These 9137 cohort members represent all Sweep 9 respondents, including the 1896 complete cases included in the complete case analysis, 4410 additional cohort members who had observed income at age 55 data but who were missing data on one or more other analysis variables, and a further 2831 cohort members who were missing income data at age 55 (and may or may not have also been missing data on one or more other analysis variables).” (Silverwood et al., 2021, p. 32)

“a consequence of utilising all this additional information is increased precision – the standard errors of the coefficients in the MI analysis are reduced by almost a half and the 95% CIs are therefore much narrower” (Silverwood et al., 2021, p. 32)

“The mi estimate command can be reissued with the vartable and dftable options (but without specifying the analysis model) (see help mi estimate).” (Silverwood et al., 2021, p. 33)

“displays a table reporting variance information about MI estimates. The table contains estimates of within-imputation variances, between-imputation variances, total variances, relative increases in variance due to nonresponse (RVI), fractions of information about parameter estimates missing due to nonresponse (FMI), and relative efficiencies for using the chosen number of imputations rather than a hypothetically infinite number of imputations” (Silverwood et al., 2021, p. 33)

“information. Variables with large amounts of missing data and/or that are weakly correlated with other variables in the imputation model will tend to have high RVIs. The closer this number is to zero, the less effect missing data have on the variance of the estimate” (Silverwood et al., 2021, p. 33)

“higher the FMI is, the greater the number of imputations required for reliable results. One rule of thumb is to have the number imputations (at least) equal the highest FMI percentage” (Silverwood et al., 2021, p. 33)

“the relative efficiency is not close to 1, then it indicates that the analysis should be repeated with a greater number of imputations.” (Silverwood et al., 2021, p. 34)

“displays a table containing parameter-specific degrees of freedom (DF) and percentages of increase in standard errors due to nonresponse. The parameterspecific degrees of freedom depend not only on the number of imputations but also (inversely) on the RVI due to nonresponse. The closer the RVI is to zero, the larger the degrees of freedom regardless of the number of imputations.” (Silverwood et al., 2021, p. 34)

“We see from the table output that the smallest degrees of freedom correspond to a16_totalscore, which is to be expected given that this variable has the largest RVI.” (Silverwood et al., 2021, p. 35)

“argest degrees of freedom correspond to MumNotMarried (omitted from the below output), suggesting that the loss of information due to non-response is the smallest for the estimation of this coefficient. Consequently, the percentage increase in standard error is largest for a16_totalscore (47.4%) and smallest for MumNotMarried (20.3%).” (Silverwood et al., 2021, p. 35)

“In practice, it is impossible to know that data truly are MAR (as opposed to MNAR) and therefore we might wish to explore how robust our results are to the MAR assumption” (Silverwood et al., 2021, p. 36)

“of such “MNAR sensitivity analyses” have been proposed, which typically involve imputing data under a MNAR mechanism – or at least approximating the results of doing so” (Silverwood et al., 2021, p. 36)

“simple approach to this is to take the existing multiply imputed (under MAR) datasets, modify the imputed values for one or more subsets of the sample according to a MNAR scenario of interest, and re-fit the analysis model. Formally, this is a “pattern-mixture model” approach to MNAR sensitivity analysis” (Silverwood et al., 2021, p. 36)

“Using the simple approach to MNAR sensitivity analysis mentioned above, hypothesised scenarios such as “study members with missing income data have X units lower income than those with observed income data” can be explored by subtracting X units from the imputed income values in each imputed dataset and re-fitting the analysis model.” (Silverwood et al., 2021, p. 37)

“Different values of X could be considered in a more thorough sensitivity analysis.” (Silverwood et al., 2021, p. 37)

“The MNAR scenarios being considered could be more complex, for example the value of X may be hypothesised to differ between subgroups defined by another variable (e.g. males and females), with the imputed value modification approach extended in the obvious way.” (Silverwood et al., 2021, p. 37)

“Note that we use the mi passive command as a prefix to the generate and replace commands. This ensures that the commands are applied within each imputed dataset and that the resultant variables are registered as passive variables” (Silverwood et al., 2021, p. 38)

“We see that there is very little change in the estimated coefficients relative to the primary analysis. This suggests that the findings are robust to the hypothesised scenario that “cohort members with missing income at age 55 have 10% lower income than those with observed income data”. We could now continue to explore increasingly extreme hypothesised scenarios (20% lower income, 30% lower income, etc.) to see whether the findings continue to appear so robust.” (Silverwood et al., 2021, p. 39)

“we will briefly discuss the application of inverse probability weighting (IPW) for missing data handling (6, 7)” (Silverwood et al., 2021, p. 40)

“IPW, the complete cases are weighted by the inverse of their probability of being a complete case. This means that study members who were unlikely to be a complete case (but were anyway) are up-weighted relative to cohort members who were likely to be complete cases (and were), so can be conceptualised as the former effectively representing both themselves and all other similar study members with missing data” (Silverwood et al., 2021, p. 40)

“A common approach is to identify a set of variables which are predictive of being a complete case, which may or may not overlap with the set of variables in the analysis model, and fitting a model for being a complete case as a function of these variables.” (Silverwood et al., 2021, p. 40)

“major limitation is that if a study member is missing data on any one or more of the variables used to model being a complete case, then they will not be included in the sample to which this model is fitted and will not have a predicted probability of being a complete case, meaning that they cannot be included in the reweighted analysis model.” (Silverwood et al., 2021, p. 40)

“In the birth cohort setting this often means restricting to variables observed at or prior to birth.” (Silverwood et al., 2021, p. 40)

“A straightforward approach that can handle arbitrary missing data patterns would be to use MI in the estimation of the probabilities of being a complete case” (Silverwood et al., 2021, p. 41)

“In cohort studies, where attrition is the main driver of missing data, it is often sufficient to consider response at the survey sweep where the outcome variable was collected as a proxy for being a complete case. Non-responders at this sweep will by definition not be complete cases, and responders at this sweep will only not be complete cases in the presence of non-monotone attrition” (Silverwood et al., 2021, p. 41)

“An alternative approach would therefore be to conduct a non-analysis-specific probability-derivation procedure considering response at the survey sweep where the outcome variable was collected, rather than being a complete case per se” (Silverwood et al., 2021, p. 41)

“It is good practice to examine the distribution of weights (here we restrict to cohort members included in the complete case analysis to whom the weights will be applied) to ensure there are no extremely large values which would dominate the IPW analysis, resulting in a large reduction in effective sample size (7).” (Silverwood et al., 2021, p. 43)

“This means that the IPW analysis model will only be fitted on these 645 cohort members.” (Silverwood et al., 2021, p. 44)

“This analysis is inefficient because not all Sweep 9 (age 55) respondents (only 1909 out of 9137) were used in the derivation of the weights and not all cohort members included in the complete case analysis (only 645 out of 1896) were included in the IPW analysis” (Silverwood et al., 2021, p. 44)

“Alternatively, we could conduct the IPW analysis having first multiply imputed any missing values to ensure that there will be no such problems” (Silverwood et al., 2021, p. 45)

“The resultant weights vary between 2.6 and 15.2, with no extreme values. The weights are now defined for all 1896 cohort members in the complete case analysis, meaning that they will all be included in the IPW analysis model.” (Silverwood et al., 2021, p. 46)

“The MI IPW analysis is also more efficient than the previous IPW analysis because, in addition to all cohort members included in the complete case analysis being included in the IPW analysis, all Sweep 9 (age 55) respondents were used in the” (Silverwood et al., 2021, p. 47)

“derivation of the weights” (Silverwood et al., 2021, p. 48)

“The IPW-MI analysis therefore does not display the efficiency gains seen in the MI analysis relative to the complete case analysis, an observation which is true in general” (Silverwood et al., 2021, p. 48)