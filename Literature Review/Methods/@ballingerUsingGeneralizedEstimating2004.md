# Using Generalized Estimating Equations for Longitudinal Data Analysis
#### (2004) - Gary A. Ballinger
**Journal**: Organizational Research Methods
**Link**:: http://journals.sagepub.com/doi/10.1177/1094428104263672
**DOI**:: 10.1177/1094428104263672
**Links**:: 
**Tags**:: #paper #Methods #GeneralizedEstimatingEquations 
**Cite Key**:: [@ballingerUsingGeneralizedEstimating2004]

### Abstract

```
The generalized estimating equation (GEE) approach of Zeger and Liang facilitates analysis of data collected in longitudinal, nested, or repeated measures designs. GEEs use the generalized linear model to estimate more efficient and unbiased regression parameters relative to ordinary least squares regression in part because they permit specification of a working correlation matrix that accounts for the form of within-subject correlation of responses on dependent variables of many different distributions, including normal, binomial, and Poisson. The author briefly explains the theory behind GEEs and their beneficial statistical properties and limitations and compares GEEs to suboptimal approaches for analyzing longitudinal data through use of two examples. The first demonstration applies GEEs to the analysis of data from a longitudinal lab study with a counted response variable; the second demonstration applies GEEs to analysis of data with a normally distributed response variable from subjects nested within branch offices ofan organization.
```

### Notes

“Harrison and Hulin (1989) identified generalized estimating equations (GEEs) as an analytic tool with promise for organizational research because the method accounted for correlation of responses within subject for response variables and was flexible enough for use in analyzing response variables that were not normally distributed.” (Ballinger, 2004, p. 128)

“Researchers have generally agreed that logit or probit models are appropriate for constructing regression models of binary choice behaviors (McCullagh & Nelder, 1989; Pindyck & Rubinfeld, 1998; Harrison, 2002), and Poisson or negative binomial regression using generalized linear models has been accepted as the best means of estimating probabilities in cases in which the dependent variable consists of counted data (Gardner et al., 1995).” (Ballinger, 2004, p. 129)

“GEEs were developed by Liang and Zeger (1986) and Zeger and Liang (1986) as a means of testing hypotheses regarding the influence of factors on binary and other exponentially (e.g., Poisson, Gamma, negative binomial) distributed response variables collected within subjects across time” (Ballinger, 2004, p. 130)

“In other words, for every one-unit increase in a covariate across the population, GEE tells the user how much the average response would change (Zorn, 2001).” (Ballinger, 2004, p. 130)

“Fitting a GEE model requires the user to specify (a) the link function to be used, (b) the distribution of the dependent variable, and (c) the correlation structure of the dependent variable.” (Ballinger, 2004, p. 131)

“Harrison (2002) noted that the link function is what “makes [generalized linear modeling] techniques part of a larger family of log-linear models; nonlinear and distinct from multiple linear regression in the link function but linear and familiar in terms of the string of regression parameters” (p. 454). An example of a link function would be the logit link for binary response variables.” (Ballinger, 2004, p. 131)

“As in generalized linear models, the variance needs to be expressed as a function of the mean” (Ballinger, 2004, p. 132)

“Gardner and colleagues (1995) showed, misspecification of the link function or the variance function can have important consequences, for example, specifying a normal distribution when the data are counted can lead to incorrect statistical conclusions.” (Ballinger, 2004, p. 132)

“Because the variance estimator that is used in generalized linear models assumes independence of observations, in developing the GEE model, Zeger and Liang (1986) extended use of a method of estimating the variance that incorporates the correlation of the observations and produces variance estimates (but not regression coefficients) that are consistent in cases in which the specification of the variance function is not exactly correct (Diggle et al., 2002; Hardin & Hilbe, 2003; Wedderburn, 1974; Zeger & Liang, 1986).” (Ballinger, 2004, p. 132)

“Specifying a Poisson distribution with a binary distribution (and vice versa) is a major error that can lead to mistakes regarding inferences about regression parameters.” (Ballinger, 2004, p. 132)

“As a rule, if the responses are binary data, users should specify the binomial distribution. In cases in which the responses are counted, users should first select a Poisson distribution and then examine the extent of dispersion in the outcome predictor.” (Ballinger, 2004, p. 132)

“It is this working correlation matrix that allows GEEs to estimate models that account for the correlation of the responses (Liang & Zeger, 1986).” (Ballinger, 2004, p. 133)

““The goal of selecting a working correlation structure is to estimate β more efficiently” (Pan, 2001, p. 122), and incorrect specification of the correlation structure can affect the efficiency of the parameter estimates (Fitzmaurice, 1995).” (Ballinger, 2004, p. 133)

“For data that are correlated within cluster over time, an autoregressive correlation structure is specified to set the within-subject correlations as an exponential function of this lag period, which is determined by the user.” (Ballinger, 2004, p. 133)

“Where there is no logical ordering for observations within a cluster (such as when data are clustered within subject or within an organizational unit but not necessarily collected over time), an exchangeable correlation matrix should be used (Horton & Lipsitz, 1999)” (Ballinger, 2004, p. 133)

“Users may also permit the free estimation on the within-subject correlation from the data.” (Ballinger, 2004, p. 133)

“Finally, users may assume that the responses within subject are independent of each other; this approach sacrifices one of the two benefits of using GEE in that it does not account for withinsubject correlation” (Ballinger, 2004, p. 133)

“Zheng (2000) introduced a simple extension of R2 statistics for GEE models of continuous, binary, and counted responses that is referred to as “marginal R-square.”” (Ballinger, 2004, p. 134)

“For cases in which users may be undecided between two structures, Pan (2001) proposed a test that extends Akaike’s information criterion to allow comparison of covariance matrices under GEE models to the covariance matrix generated from a model that assumes no correlation within cluster.” (Ballinger, 2004, p. 134)

“Pan’s quasilikelihood under the independence model information criterion (QIC) measure is helpful in selecting the appropriate correlation structure” (Ballinger, 2004, p. 134)

“Residuals from GEE regression models should be checked for the presence of outlier values that may seriously affect the results (Diggle et al., 2002).” (Ballinger, 2004, p. 135)

“A valuable visual test of the GEE model that has been estimated is to request residual versus fitted plots for each individual panel. In visually testing the residuals, a researcher should look for patterns that suggest a random distribution of residuals; they should not be clustered around certain values (Hardin & Hilbe, 2003).” (Ballinger, 2004, p. 135)

“Users should be cautioned that the estimate of the variance produced under GEE models could be highly biased when the number of subjects within which observations are nested is small (Prentice, 1988).” (Ballinger, 2004, p. 145)

“Despite the advances of Zheng (2000) and Pan (2001), goodness-of-fit statistics for GEEs that would function as the equivalent to measures such as the magnitude of the squared differences of observed versus predicted values or dispersion measures are not widely accepted for most classes of dependent variables beyond binary data or for different correlation structures (Barnhart & Williamson, 1998; Horton et al., 1999; Sheu, 2000; Stokes, 1999).” (Ballinger, 2004, p. 145)