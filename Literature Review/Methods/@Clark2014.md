# Should I Use Fixed or Random Effects?
#### (2014) - Tom S. Clark, Drew A. Linzer
**Journal**: Political Science Research and Methods
**Link**:: 
**DOI**:: 10.1017/psrm.2014.32
**Links**:: 
**Tags**:: #paper #Methods #FixedEffects #RandomEffects 
**Cite Key**:: [@Clark2014]

### Abstract

```
Empirical analyses in political science very commonly confront data that are groupedmultiple votes by individual legislators, multiple years in individual states, multiple conflicts during individual years, and so forth. Modeling these data presents a series of potential challenges, of which accounting for differences across the groups is perhaps the most well-known. Two widely-used methods are the use of either “fixed” or “random” effects models. However, how best to choose between these approaches remains unclear in the applied literature. We employ a series of simulation experiments to evaluate the relative performance of fixed and random effects estimators for varying types of datasets. We further investigate the commonly-used Hausman test, and demonstrate that it is neither a necessary nor sufficient statistic for deciding between fixed and random effects. We summarize the results into a typology of datasets to offer practical guidance to the applied researcher.
```

### Notes

“All empirical modeling decisions involve a choice about how to balance variance and bia” (Clark and Linzer, 2014, p. 1)

“Indeed, it is not uncommon for one to object” (Clark and Linzer, 2014, p. 1)

“to the use of random effects by noting that if the covariates are correlated with the unit effects, there may be resulting bias in the parameter estimates. While that claim is true, it does not imply that any correlation between the covariates and the unit effects implies fixed effects should be favored” (Clark and Linzer, 2014, p. 2)

“A common approach to resolving this problem is to employ the Hausman test, which is intended to tell the researcher how significantly parameter estimates differ between the two approaches. As we demonstrate below, the Hausman test is neither a necessary nor a sufficient metric for deciding between fixed and random effects” (Clark and Linzer, 2014, p. 2)

“disadvantages—to consider when selecting an approach. The fixed effects model will produce unbiased estimates of β, but those estimates can be subject to high sample-to-sample variability. The random effects model will, except in rare circumstances, introduce bias in estimates of β, but can greatly constrain the variance of those estimates—leading to estimates that are closer, on average, to the true value in any particular sample.” (Clark and Linzer, 2014, p. 6)

“A related drawback of fixed effects models is that they require the estimation of a parameter for each unit—the coefficient on the unit dummy variable. This can substantially reduce the model’s power and increase the standard errors of the coefficient estimates” (Clark and Linzer, 2014, p. 7)

“andom effects models enable estimation of β with lower sample-to-sample variability by partially pooling information across units (Gelman and Hill 2007, 258). By estimating the variance parameter σ2 α in Equation 4, the random effects estimator is, in effect, forming a compromise between the fixed effects and pooled models” (Clark and Linzer, 2014, p. 7)

“The most serious drawback of the random effects approach is the problem of bias that partial pooling can introduce in estimates of β. To avoid this bias, the random effects estimator requires the assumption that there is no correlation between the covariate of interest, x, and the unit effects, αj” (Clark and Linzer, 2014, p. 8)

“As a consequence, to decide between a random effects and fixed effects model, researchers often rely on the Hausman (1978) specification test (e.g., Greene 2008, 208-209). The Hausman test is designed to detect violation of the random effects modeling assumption that the explanatory variables are orthogonal to the unit effects. If there is no correlation between the independent variable(s) and the unit effects, then estimates of β in the fixed effects model ( ˆ βF E) should be similar to estimates of β in the random effects model ( ˆ βRE)” (Clark and Linzer, 2014, p. 10)

“Under the null hypothesis of orthogonality, H is distributed chi-square with degrees of freedom equal to the number of regressors in the model. A finding that p < 0.05 is taken as evidence that, at conventional levels of significance, the two models are different enough to reject the null hypothesis, and hence to reject the random effects model in favor of the fixed effects model” (Clark and Linzer, 2014, p. 10)

“If the Hausman test does not indicate a significant difference (p > 0.05), however, it does not necessarily follow that the random effects estimator is “safely” free from bias, and therefore to be preferred over the fixed effects estimator.” (Clark and Linzer, 2014, p. 10)

“The common belief that the Hausman test will reject the random effects model (p < 0.05) if there is any correlation between covariates and unit effects is clearly shown to be incorrect. When the number of units or the number of observations per unit is small—especially when the covariate is sluggish—the Hausman test will typically fail to reject the random effects specification, sometimes when the correlation between the predictors and the units is as high as 0.95” (Clark and Linzer, 2014, p. 15)

“Our analysis yields a series of general rules of thumb that should guide researchers when deciding how best to model their data. There are, in our view, three primary considerations: the extent to which variation in the explanatory variable is primarily within unit (the standard case) as opposed to across units (the sluggish case), the amount of data one has (the number of units and observations per unit), and the goal of the modeling exercise. We offer a general framework for modeling choices by considering the latter two criteria in both the general and sluggish cases” (Clark and Linzer, 2014, p. 27)

“, if perfect (or near-perfect) collinearity between a regressor of interest and the unit effects (e.g., a legislator’s political party or a country’s electoral system) precludes the use of a fixed effects estimator, one should not resist the use of a random effects estimator because of potential correlation between the regressor and the unit effects” (Clark and Linzer, 2014, p. 28)

“When there is very little data, even under extreme violations of the assumption of zero correlation, the random effects estimator outperforms the fixed effects estimator” (Clark and Linzer, 2014, p. 28)

“Finally, we note that the pooled estimator is always weakly inferior to the random effects estimator, and the extent to which the random effects estimator is superior increases as the number of observations per unit increases. Thus, we find in the sluggish case that, again, the conventional wisdom that a violation of the random effects model’s assumption of zero correlation is neither a sufficient nor a necessary condition for choosing a fixed effects model.” (Clark and Linzer, 2014, p. 29)