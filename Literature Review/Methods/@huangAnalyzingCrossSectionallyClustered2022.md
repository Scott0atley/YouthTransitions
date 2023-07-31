# Analyzing Cross-Sectionally Clustered Data Using Generalized Estimating Equations
#### (2022) - Francis L. Huang
**Journal**: Journal of Educational and Behavioral Statistics
**Link**:: http://journals.sagepub.com/doi/10.3102/10769986211017480
**DOI**:: 10.3102/10769986211017480
**Links**:: 
**Tags**:: #paper #Methods #GeneralizedEstimatingEquations 
**Cite Key**:: [@huangAnalyzingCrossSectionallyClustered2022]

### Abstract

```
The presence of clustered data is common in the sociobehavioral sciences. One approach that specifically deals with clustered data but has seen little use in education is the generalized estimating equations (GEEs) approach. We provide a background on GEEs, discuss why it is appropriate for the analysis of clustered data, and provide worked examples using both continuous and binary outcomes. Comparisons are made between GEEs, multilevel models, and ordinary least squares results to highlight similarities and differences between the approaches. Detailed walkthroughs are provided using both R and SPSS Version 26.
```

### Notes

“Comparisons are made between GEEs, multilevel models, and ordinary least squares results to highlight similarities and differences between the approaches.” (Huang, 2022, p. 101) Comparisons between GEEs and random effects would be a good progression to this paper (Something I am going to do in thesis)

“In the social and behavioral sciences, observations are often nested within clusters or groups. The two classic forms of nesting involve observations within groups (e.g., cross-sectionally clustered data such as students within schools, patients within hospitals) and measurements over time within units (e.g., repeated measures within individuals). Several studies have demonstrated that ignoring the clustered nature of nested data may result in misestimated standard errors (Huang, 2016) resulting in greater Type I or Type II errors (Bliese & Hanges, 2004), and depending on how a model is specified, regression coefficients may be biased as well (Huang, 2018a)” (Huang, 2022, p. 101)

“simple and straightforward method used for the analysis of clustered data is the generalized estimating equations (GEEs; Liang & Zeger, 1986; Zeger et al., 1988)” (Huang, 2022, p. 101)

“valid approach for dealing with clustered data (Hardin & Hilbe, 2013; McNeish, 2019; McNeish et al., 2017; Zorn, 2001).” (Huang, 2022, p. 101)

“In psychology and education, an often used method to account for the clustering is the multilevel model (MLM; also known as a random effects or mixed model).” (Huang, 2022, p. 101)

“Although MLMs are flexible and robust, researchers have highlighted that other, often simpler methods can answer a research question of interest while accounting for the clustering effect (Huang, 2014, 2016, 2018b, 2018c; McNeish, 2014; McNeish et al., 2016; Murnane & Willett, 2011)” (Huang, 2022, p. 102)

“GEEs are an extension of the generalized linear model (GLM) but specifically account for violations of observation independence (Hardin & Hilbe, 2013). The GEE approach gets its name as model estimates are based on the solutions (solved by the statistical software) of GEEs and is a computationally simpler alternative to maximum likelihood (Agresti, 2007). GEEs are often introduced in textbooks as a means of modeling longitudinal data using categorical outcomes (Agresti, 2007; Allison, 2005; Hardin & Hilbe, 2013).” (Huang, 2022, p. 102)

“he general form of the GEE (Liang & Zeger, 1986),” (Huang, 2022, p. 102)

“U” (Huang, 2022, p. 102)

“where the estimate of is the solution to the GEE where is a vector of p coefficients including the intercept. For the equation for each p coefficient, the jth cluster contributes a three-way product (after the summation sign) involving the partial derivative of j (a vector of cluster j’s mean responses) with respect to regression coefficient times the inverse of what is referred to as the mj mj (where mj is the number of units within a cluster) working covariance matrix V (to be discussed later) times the third term which is merely the residual or the observed less the predicted values (where yj is a vector of responses for cluster j and Xj is an mj p design matrix). Obtaining the solution to the equations can done using iteratively reweighted least squares (IRLS; Hilbe & Robinson, 2013, p. 143).” (Huang, 2022, p. 103)

“with GEEs, the likelihoods are not formulated which is a reason why GEEs are referred to as quasi-likelihood estimating equations and are referred to as “score-like” equations (Kleinbaum & Klein, 2010).” (Huang, 2022, p. 103)

“With GEEs, the clustering effect is considered to be a nuisance (i.e., not of interest and merely to be accounted for properly), and the violation of the observation independence assumption is addressed in two ways: by using the working correlation matrix and cluster-robust standard errors (CRSEs).” (Huang, 2022, p. 103)

“If the outcomes within a cluster are not expected to be related to each other (which is the standard assumption of observation independence), then an independence correlation structure can be specified (Norton et al., 1996).” (Huang, 2022, p. 103)

“However, one reason researchers use MLMs to account for clustering is that some form of correlation between individuals in a cluster might be expected. For example, students attending the same school might have outcomes more similar with each other compared to students in other schools as a result of the shared resources (e.g., teachers, materials, facilities) that are the same within a school but may differ across schools” (Huang, 2022, p. 104)

“outcomes within a cluster are expected to be correlated with each other to some extent (see Figure 1B) and do not follow any type of logical or time ordering, such as cross-sectional data where observations are nested within groups, then an exchangeable correlation structure can be specified (Ballinger, 2004; Horton & Lipsitz, 1999; Kleinbaum & Klein, 2010).” (Huang, 2022, p. 104)

“A random intercept (RI) MLM and an exchangeable correlation matrix assume the same correlation structure (Feng et al., 2001).” (Huang, 2022, p. 104)

“FIGURE 1. Examples of common working correlation matrices (assuming four observa-” (Huang, 2022, p. 104)

“tions per cluster) used with generalized estimating equations.” (Huang, 2022, p. 104)

“In addition to accounting for clustering using the working correlation matrix, empirical or robust sandwich estimators are used by default to adjust regression coefficient standard errors using both heteroscedasticity and cluster-robust corrections (White, 1980; Zeger & Liang, 1986)” (Huang, 2022, p. 105)

“These standard errors though are often only effective at maintaining the proper Type I errors with a large enough number of J clusters, and this may also depend on how unbalanced group sizes are (Cameron & Miller, 2015; Hardin & Hilbe, 2013) and, with binary outcomes, the prevalence rate of the outcome (Crespi et al., 2011; Rogers & Stoner, 2015)” (Huang, 2022, p. 105)

“there is no consistent definition of what a large number of clusters constitute (Kleinbaum & Klein, 2010, p. 354).” (Huang, 2022, p. 105) for fucks sake

“Fortunately though, developments and the availability of add-ons in R, SAS, or Stata to correct for a smaller number of clusters (e.g., 20) are available and have shown to be effective at controlling Type I error rates (Li & Redden, 2015; Mancl & DeRouen, 2001; McNeish & Stapleton, 2016; Wang et al., 2016).” (Huang, 2022, p. 105)

“GEEs may be described as models (e.g., a GEE model; Hardin & Hilbe, 2013; Kleinbaum & Klein, 2010), but technically, a GEE is an approach or method to estimate the parameters of a GLM (McNeish, 2019; Pek ́ ar & Brabec, 2018).” (Huang, 2022, p. 106)

“The choice of which model to use (e.g., GEE or MLM) should be based on the research question of interest and not on which procedure gives more desirable results. Snijders and Bosker (2012) indicated that MLMs may give more efficient standard errors compared to the traditional sandwich estimators (p. 200), thus possibly providing more power to detect statistically significant effects. The improved efficiency though may be contingent on MLM modeling assumptions being met though, in practice, these assumptions are not always checked (Dedrick et al., 2009).” (Huang, 2022, p. 107)

“GEEs can be used with cross-sectional clustered data if the research questions are focused on the fixed effects portion (i.e., the point estimates and the standard errors) of the model. A benefit of GEEs is that they have fewer assumptions compared to MLMs: Residuals do not have to be normally distributed, assumptions about the random effects are not needed (e.g., the lack of correlation between predictors and random effects), and the working correlation matrix does not need to be correctly specified (Hubbard et al., 2010; McNeish, 2019).” (Huang, 2022, p. 107)

“GEEs should not be used if the research questions are about the random effects (e.g., What is the correlation of the RI and slope? Do the slopes randomly vary per group?).” (Huang, 2022, p. 107) Ok so how exactly can I make a paper comparing random effects to GEEs then... question for vernon on that one

“Compared to a standard GLM, the only additional input required from a researcher to run a model using GEEs is to specify the grouping or clustering variable (e.g., school id) and the working correlation matrix to use, of which there are common types to choose from (e.g., independence, exchangeable).” (Huang, 2022, p. 107)

“For the current analyses, we used the geepack (Højsgaard et al., 2005) package in R” (Huang, 2022, p. 108)

“Standard error comparisons. Various studies have shown that the standard errors for the group-level variables (Catholic and mean SES) estimated using OLS (Model 7) are often underestimated (Huang, 2018a; Maas & Hox, 2005; Musca et al., 2011).” (Huang, 2022, p. 111)

“arameter estimates for the regression coefficients are said to be consistent9 even if the correlation structure is misspecified (Feng et al., 2001; Kleinbaum & Klein, 2010), which is also a reason why this has been termed as a working correlation matrix since it was not required to be correctly specified (Zeger & Liang, 1986).” (Huang, 2022, p. 113)

“Typically though, misspecifying the correlation matrix has a larger effect on the standard errors than the regression coefficients (Kleinbaum & Klein, 2010).” (Huang, 2022, p. 113)

“Models estimated using GEEs are referred to as marginal or population average (PA) models, and models estimated with mixed effects are known as conditional or CS/subject-specific10 models. However, unlike regressions with continuous outcomes where GEE and MLM results will be similar, GEE and MLM estimates with dichotomous outcomes will systematically differ as a result of the nonidentity link (i.e., logit) used and depending on how much betweengroup variability is present as a result of the random effect.” (Huang, 2022, p. 115)

“Although GEEs present a viable alternative with the analysis of crosssectional clustered data, a few limitations should be considered. As GEEs use a quasi-likelihood estimation approach (Kleinbaum & Klein, 2010), tests or statistics that use the likelihood function (e.g., likelihood ratio test, Akaike information criterion, Bayesian information criterion) are not available to aid in model selection.” (Huang, 2022, p. 117)

“Researchers may indicate that an advantage of GEEs is that no assumptions are made about the random effects (e.g., its distribution) unlike MLMs (McNeish, 2019). However, in reality, the assumptions about the distribution of the random effects in MLMs have a negligible impact on fixed effect estimates (Maas & Hox, 2004).” (Huang, 2022, p. 118)

“advantage though of GEEs is that if the interest of the researcher is in point estimates and standard errors, then GEEs may arrive at the solution faster with less model assumptions about random effects (Hubbard et al., 2010).” (Huang, 2022, p. 118)

“Another limitation often discussed with regard to GEEs is in relation to missing data (Zorn, 2001). Complete cases analysis models using GEEs require that the data are missing completely at random (MCAR; Rubin, 2004) which may at times be an unreasonable assumption.” (Huang, 2022, p. 118)

“popular method applicable both to GEEs and MLMs is multiple imputation (MI; McPherson et al., 2013).13 Recent software developments using MI with clustered data (Enders et al., 2018; Grund et al., 2018) have made the procedure more readily accessible (Grund et al., 2019).” (Huang, 2022, p. 118)