# Fitting Stereotype Logistic Regression Models for Ordinal Response Variables in Educational Research (Stata)
#### (2014) - Xing Liu
**Journal**: Journal of Modern Applied Statistical Methods
**Link**:: http://digitalcommons.wayne.edu/jmasm/vol13/iss2/31
**DOI**:: 10.22237/jmasm/1414816200
**Links**:: 
**Tags**:: #paper #Methods #Logit #ProportionalOddsModel 
**Cite Key**:: [@liuFittingStereotypeLogistic2014]

### Abstract

```
The stereotype logistic (SL) model is an alternative to the proportional odds (PO) model for ordinal response variables when the proportional odds assumption is violated. This model seems to be underutilized. One major reason is the constraint of current statistical software packages. Statistical Package for the Social Sciences (SPSS) cannot perform the SL regression analysis, and SAS does not have the procedure developed to directly estimate the model. The purpose of this article was to illustrate the stereotype logistic (SL) regression model, and apply it to estimate mathematics proficiency level of high school students using Stata. In addition, it compared the results of fitting the PO model and the SL model. Data from the High School Longitudinal Study of 2009 (HSLS: 2009) (Ingels, et al., 2011) were used for the ordinal regression analyses.
```

### Notes

“The PO model assumes that the underlying binary models, which dichotomize the ordinal response variable, have the same coefficients. In other words, the logit coefficients for each predictor are the same across the ordinal categories. This is called the parallel lines or the proportional odds (PO) assumption. However, the PO assumption is often violated.” (Liu, 2014, p. 529)

“The SL model is an extension of both the multinomial logistic regression model and the PO model. First, the SL model is like the multinomial logistic model since they both estimate the odds of being at a particular category compared to the baseline category. Second, similar to the PO model, the SL model estimates the ordinal response variable rather than the nominal outcome variable, given a set of predictors.” (Liu, 2014, p. 529)

“Anderson’s SL model (1984) can be written in the following form” (Liu, 2014, p. 531)

“where j = 1, 2, ..., J −1; J is the baseline or reference category, which is the last category here, but can be the first category or any of the other categories decided by the researcher; Y is the ordinal response variable with categories from j to J; αj are the intercepts; β1, β2, ..., βp are logit coefficients for the predictors, X1, X2, ..., Xp, respectively, and φj are the constraints which are used to ensure the outcome variable is ordinal if the following condition is satisfied.” (Liu, 2014, p. 531)

“First, the PO model was used for the preliminary analysis with the Stata ologit command, and the proportional odds assumption was examined using the Brant test. Then the SL model with a single explanatory variable was fitted using the Stata slogit command” (Liu, 2014, p. 534)

“Model fit statistics for both the PO model and the SL model were provided by the Stata SPost package (Long & Freese, 2006). The results for both models were interpreted and compared. Following the suggestion by Hardin and Hilbe (2007) and Hilbe (2009), Stata AIC and BIC statistics were used for the comparison of model fit.” (Liu, 2014, p. 534)

“. fitstat” (Liu, 2014, p. 535)

“The Brant test of the PO assumption was examined using the brant command of the Stata SPost (Long & Freese, 2006) package. Stata Brant test provided results of a series of separate binary logistic regression across different category comparisons, univariate brant test result for each predictor, and the omnibus test for the overall model.” (Liu, 2014, p. 536)

“Compared to the PO model, it is found that the SL model is a better option when the proportional odds assumption is untenable. The SL model not only relaxes the PO assumption but also ensures the ordinal information of the categorical variable by putting an ordinality constraint on the estimated coefficients.” (Liu, 2014, p. 542)