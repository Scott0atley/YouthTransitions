# Models for Longitudinal Data: A Generalized Estimating Equation Approach
#### (1988) - Scott L. Zeger, Kung-Yee Liang, Paul S. Albert
**Journal**: Biometrics
**Link**:: https://www.jstor.org/stable/2531734?origin=crossref
**DOI**:: 10.2307/2531734
**Links**:: 
**Tags**:: #paper #Methods #GeneralizedEstimatingEquations 
**Cite Key**:: [@Zeger1988]

### Abstract

```
This article discusses extensions of generalized linear models for the analysis of longitudinal data. Two approaches are considered: subject-specific (SS) models in which heterogeneity in regression parameters is explicitly modelled; and population-averaged (PA) models in which the aggregate response for the population is the focus. We use a generalized estimating equation approach to fit both classes of models for discrete and continuous outcomes. When the subject-specific parameters are assumed to follow a Gaussian distribution, simple relationships between the PA and SS parameters are available. The methods are illustrated with an analysis of data on mother's smoking and children's respiratory disease.
```

### Notes

“article discusses extensions of generalized linear models for the analysis of longitudinal data.” (Zeger et al., 1988, p. 1049)

“Two approaches are considered: subject-specific (SS) models in which heterogeneity in regression parameters is explicitly modelled; and population-averaged (PA) models in which the aggregate response for the population is the focus.” (Zeger et al., 1988, p. 1049)

“This article considers statistical methods for longitudinal data where the broad scientific objective is to describe an outcome, y,, , for subject i at time t as a function of covariates, x,,. Longitudinal data are characterized by the fact that repeated observations for a subject tend to be correlated.” (Zeger et al., 1988, p. 1049)

“There are two distinct approaches to longitudinal data analysis in this case. First, the heterogeneity can be explicitly modelled; we will refer to this as the "subject-specific" (SS) approach. The mixed model is an example where the subject-specific effects are assumed to follow a parametric distribution across the population. Mixed linear models (Laird and Ware, 1982; Ware, 1985) for continuous longitudinal data are in common use.” (Zeger et al., 1988, p. 1049)

“Second, the population-averaged response can be modelled as a function of covariates without explicitly accounting for subject to subject heterogeneity. The regression coefficients have interpretation for the population rather than for any individual and hence we will use the term "population-averaged" (PA) model in this case.” (Zeger et al., 1988, p. 1050)

“We begin with the mixed generalized linear model, an example of a subject-specific model. Let y,, be an outcome random variable and x,, a p x 1 vector of fixed covariates at time t for subject i, where t = 1, . . ., n, and i = 1, . .. , K. Let z,, be a q x 1 vector of covariates (typically a subset of x,,) associated with a q x 1 random effect, b,, and let u,, = E( y,, I b,). Under the mixed GLM, the responses for subject i are assumed to satisfy where b, is an independent observation from a mixture distribution, F. The functions h and g are refened to as the "link" and "variance" functions, respectively. The objective of analysis is to estimate the fixed effects coefficients, j3, parameters of F, and possibly the scale parameter. 4.” (Zeger et al., 1988, p. 1050)

“n the population-averaged approach to longitudinal analysis, the marginal expectation, p,, = E( y,, ), is the focus. That is, we assume h*(p,,) = x:ij3* and var(y,,) = g*(p,O . 4 for some link function h* and variance function g*. Here, j3* describes how the populationaveraged response rather than one subject's response depends on the covariates. In the logistic case with x,, = (1, t j', PT is the change on a logit scale in the fraction of positive responses per unit time, rather than the typical change for an individual subject.” (Zeger et al., 1988, p. 1050)

“The principal distinction between SS and PA models is whether the regression coefficients describe an individual's or the average population response to changing x. A secondary distinction is in the nature of the assumed time dependence. PA models only describe the covariance among repeated observations for a subject; SS models explain the source of this covariance. In PA models, the covariance matrix must be positive-definite but is otherwise unrestricted. In SS models, the time dependence arises solely from the shared subject effects, b,, in the conditional mean. The covariance matrix is thus fully determined by the choices of g(u,,)and F. For example, in a logistic model with Gaussian random intercept, only positive correlation is possible” (Zeger et al., 1988, p. 1051)

“SS models are desirable when the response for an individual rather than for the population is the focus-for example, in studies of growth curves. Effective use of SS models is limited, however, by the information available per subject. In many longitudinal studies, each subject has few observations and it is notpossible to estimate separate regression coefficients, j3 + b,.” (Zeger et al., 1988, p. 1051)

“PA models are most effectively used in population studies such as in epidemiology. Here the difference in the population-averaged response between two groups with different risk factors is more the focus than is the change in an individual's response.” (Zeger et al., 1988, p. 1051)

“An advantage of PA models is that the population-averaged response for a given covariate value, x,,, is directly estimable from observations without assumptions about the heterogeneity across individuals in the parameters.” (Zeger et al., 1988, p. 1051)

“PA parameters depend on the degree of heterogeneity in the population (F).” (Zeger et al., 1988, p. 1051)