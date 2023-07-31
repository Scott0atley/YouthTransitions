# Ordinal Regression Analysis: Fitting the Continuation Ratio Model to Educational Data Using Stata
#### () - Xing Liu
**Journal**: 
**Link**:: 
**DOI**:: 
**Links**:: 
**Tags**:: #paper #Methods #OptimalMatchingAnalysis #ContinuationRatio #ProportionalOddsModel 
**Cite Key**:: [@Liu]

### Abstract

```
Ordinal data are widely available to educational researchers. One of the most commonly used models to analyze ordinal data is the proportional odds (PO) model, which is also known as the cumulative odds model. However, when the research interest is focused on a particular category rather than at or below that category, given that an individual must pass through a lower category before achieving a higher level, the continuation ratio model (Fienberg, 1980; Hardin & Hilbe, 2007; Long & Freese, 2006) is a more appropriate choice than the proportional odds model. The purpose of this paper was to demonstrate the use of the continuation ratio (CR) model to analyze ordinal data in education using Stata, and compare the results of the CR model with the PO model. Ordinal regression analyses are based on a subset of data from the ELS (Educational Longitudinal Study): 2002, in which the ordinal outcome of students’ mathematics proficiency was predicted from a set of students’ classroom practices.
```

### Notes

**Extracted Annotations (14/03/2022, 03:29:28)**

"given that an individual must pass through a lower category before achieving a higher level, the continuation ratio model (Fienberg, 1980; Hardin & Hilbe, 2007; Long & Freese, 2006) is a more appropriate choice than the proportional odds model" ([Liu :30](zotero://open-pdf/library/items/SXC3TNZ5?page=4))

"proportional odds model is used to estimate the cumulative probability of being at or below a particular level of the response variable, or its complementary, the probability of being beyond a particular level." ([Liu :31](zotero://open-pdf/library/items/SXC3TNZ5?page=5))

"he CR model is more appealing than other models when analyzing educational attainment data (Allison, 1999)." ([Liu :31](zotero://open-pdf/library/items/SXC3TNZ5?page=5))

"This model estimates the odds of being in a certain category relative to the odds of being in that category or beyond." ([Liu :32](zotero://open-pdf/library/items/SXC3TNZ5?page=6))

"Assuming a latent variable, Y* exists, we can define Y* as a function of a set of predictor variables and a random error. Let Y* be divided by some cut points (thresholds): α1, α2, α3... αj, and α1<α2<α3...< αj. The values of the observed ordinal variable, Y, fall within the regions divided by these cut points (thresholds). For example, Y = 0, if Y* ≤ α1." ([Liu :33](zotero://open-pdf/library/items/SXC3TNZ5?page=7))

"(2)" ([Liu :34](zotero://open-pdf/library/items/SXC3TNZ5?page=8))

"In Stata, the ordinal logistic regression model assumes that the outcome variable is a latent variable" ([Liu :34](zotero://open-pdf/library/items/SXC3TNZ5?page=8))

"This equal logit slope assumption can be assessed by the Brant test (Brant, 1990)." ([Liu :34](zotero://open-pdf/library/items/SXC3TNZ5?page=8))

"When estimating the conditional probability of being beyond a category given π( that individual has attained that particular category, i.e., Y > j | Y ≥j |), the CO model can be expressed in this form (Agresti, 2007; Allison, 1999; O'Connell, 2006):" ([Liu :35](zotero://open-pdf/library/items/SXC3TNZ5?page=9))

"Stata does not require data" ([Liu :36](zotero://open-pdf/library/items/SXC3TNZ5?page=10))

"restructuring before model fitting, which makes data analysis of the CR model much easier." ([Liu :37](zotero://open-pdf/library/items/SXC3TNZ5?page=11))

"These five proficiency domains were hierarchically structured: mastery of higher proficiency level indicated mastery of all previous levels" ([Liu :37](zotero://open-pdf/library/items/SXC3TNZ5?page=11))

"Those students who failed to pass through level 1 were assigned to level 0." ([Liu :37](zotero://open-pdf/library/items/SXC3TNZ5?page=11))

"We began by fitting the continuation ratio model with a single explanatory variable using Stata OCRATIO command (Wolfe, 1998)" ([Liu :38](zotero://open-pdf/library/items/SXC3TNZ5?page=12))

"The eform option was used to estimate the odds ratios and corresponding standard errors and the confidence intervals" ([Liu :38](zotero://open-pdf/library/items/SXC3TNZ5?page=12))

"The CR model with the complementary log-log link is actually the discrete-time proportional hazards model for the event history analysis or survival analysis (Allison, 1999; O'Connell, 2006). It estimates the hazard ratio (HR) rather than the odds ratio (OR) of being in a particular category relative to advancing to a higher category." ([Liu :39](zotero://open-pdf/library/items/SXC3TNZ5?page=13))

"The MR analysis could be used as a preliminary analysis before the CR model fitting." ([Liu :44](zotero://open-pdf/library/items/SXC3TNZ5?page=18))

"Table 1: Proficiency Categories and Frequencies (Proportions) for the Study Sample, ELS:2002 (" ([Liu :48](zotero://open-pdf/library/items/SXC3TNZ5?page=22))

"Table 2: Category Comparisons for the Continuation Odds Model with Six Mathematics" ([Liu :49](zotero://open-pdf/library/items/SXC3TNZ5?page=23))

"Table 3: Results of the Continuation Ratio Model and the OLS Regression Model (Full" ([Liu :50](zotero://open-pdf/library/items/SXC3TNZ5?page=24))

". ocratio Profmath BYGENDER, link (logit)" ([Liu :51](zotero://open-pdf/library/items/SXC3TNZ5?page=25))

". ocratio Profmath BYGENDER, link (logit) eform" ([Liu :51](zotero://open-pdf/library/items/SXC3TNZ5?page=25))