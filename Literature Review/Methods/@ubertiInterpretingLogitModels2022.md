# Interpreting logit models
#### (2022) - Luca J. Uberti
**Journal**: The Stata Journal: Promoting communications on statistics and Stata
**Link**:: http://journals.sagepub.com/doi/10.1177/1536867X221083855
**DOI**:: 10.1177/1536867X221083855
**Links**:: 
**Tags**:: #paper #Methods #Logit #MarginalEffects #Elasticities #RiskRatios 
**Cite Key**:: [@ubertiInterpretingLogitModels2022]

### Abstract

```
The parameters of logit models are typically difficult to interpret, and the applied literature is replete with interpretive and computational mistakes. In this article, I review a menu of options to interpret the results of logistic regressions correctly and effectively using Stata. I consider marginal effects, partial effects, (contrasts of) predictive margins, elasticities, and odds and risk ratios. I also show that interaction terms are typically easier to interpret in practice than implied by the recent literature on this topic.
```

### Notes

# Annotations  
(07/06/2022, 17:10:24)

“he logit model always produces predicted probabilities within the meaningful range [0, 1].” (Uberti, 2022, p. 60)

““the most difficult aspect of logit [. . .] models is presenting and interpreting the results” (Wooldridge 2020, chap. 17).” (Uberti, 2022, p. 60)

“To obtain a summary statistic, we could evaluate ∂P/∂xi at the mean values of xi and Xi. This is called marginal effects at the means. Until recently, this was the most common approach in applications:” (Uberti, 2022, p. 62)

“Yet, when some of the covariates (nokid) are binary, the sample means do not describe any particular woman in the sample. Thus, it makes better sense to “average over” the covariates—that is, compute ∂P/∂xi at the values of xi and Xi actually observed in each woman in the sample (asobserved in Stata jargon) and then take an average across observations. The quantity thus obtained measures the average marginal effects.” (Uberti, 2022, p. 62)

“more flexible, user-friendly approach is provided by Royston’s (2013) mcp (or marginscontplot) command,” (Uberti, 2022, p. 62)

“As an alternative (or in addition) to plotting a diagram, users can also obtain a table of predicted probabilities. This can be accomplished with margins—or, more conveniently, with Long and Freese’s (2014) mtable command, which is part of the spost13 suite of commands downloadable from J. Scott Long’s Indiana University webpage (type net search spost13 and select spost13_ado)” (Uberti, 2022, p. 63)

“Of course, when the data-generating process is highly nonlinear, the discrepancy between LPM and logit may be much greater, and the predicted probabilities obtained from LPM highly misleading” (Uberti, 2022, p. 65)

“In nonlinear models, marginal effects provide a good approximation of the impact of a change in xi only if the change is “small”.” (Uberti, 2022, p. 65)

“For a discrete change in xi, researchers should estimate the (average) difference in predicted probabilities:7 P (Yi = 1|xi + δ, Xi) − P (Yi = 1|xi, Xi) = 1 1 + e−[(xi+δ)β+Xiβ] − 1 1 + e−(xiβ+Xiβ)” (Uberti, 2022, p. 65)

“can use the mchange command developed by Long and Freese (2014)” (Uberti, 2022, p. 65)

“For marginal effects, users can request the amount(marginal) option. For the partial effect of a standard-deviation change (= δ) in the specified regressor, the amount(sd) option should be invoke” (Uberti, 2022, p. 65)

“Yet, when the estimated conditional probability is highly nonlinear in the covariates, this back-of-the-envelope calculation may produce seriously misleading estimates” (Uberti, 2022, p. 66)