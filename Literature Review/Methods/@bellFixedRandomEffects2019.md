# Fixed and random effects models: Making an informed choice
#### (2019) - Andrew Bell, Malcolm Fairbrother, Kelvyn Jones
**Journal**: Quality & Quantity
**Link**:: http://link.springer.com/10.1007/s11135-018-0802-x
**DOI**:: 10.1007/s11135-018-0802-x
**Links**:: 
**Tags**:: #paper #Methods #FixedEffects #RandomEffects 
**Cite Key**:: [@bellFixedRandomEffects2019]

### Abstract

```
This paper assesses the options available to researchers analysing multilevel (including longitudinal) data, with the aim of supporting good methodological decision-making. Given the confusion in the literature about the key properties of fixed and random effects (FE and RE) models, we present these models’ capabilities and limitations. We also discuss the within-between RE model, sometimes misleadingly labelled a ‘hybrid’ model, showing that it is the most general of the three, with all the strengths of the other two. As such, and because it allows for important extensions—notably random slopes—we argue it should be used (as a starting point at least) in all multilevel analyses. We develop the argument through simulations, evaluating how these models cope with some likely mis-specifications. These simulations reveal that (1) failing to include random slopes can generate anticonservative standard errors, and (2) assuming random intercepts are Normally distributed, when they are not, introduces only modest biases. These results strengthen the case for the use of, and need for, these models.
```

### Notes

“We also discuss the within-between RE model, sometimes misleadingly labelled a ‘hybrid’ model, showing that it is the most general of the three, with all the strengths of the other two. As such, and because it allows for important extensions—notably random slopes—we argue it should be used (as a starting point at least) in all multilevel analyses” (Bell et al., 2019, p. 1051)

“(1) failing to include random slopes can generate anticonservative standard errors, and (2) assuming random intercepts are Normally distributed, when they are not, introduces only modest biases” (Bell et al., 2019, p. 1051)

“We argue that in most research scenarios, a well-specified RE model provides everything that FE provides and more, making it the superior method for most practitioners (see also Shor et  al. 2007; Western 1998). However, this view is at odds with the common suggestion that FE is often preferable (e.g. Vaisey and Miles 2017), if not the “gold standard” (e.g. Schurer and Yong 2012).” (Bell et al., 2019, p. 1052)

“In broad terms, these can be categorised into two types: cross-sectional data, where individuals are nested within a geographical or social context (e.g. individuals at level 1, within schools or countries at level 2), and longitudinal data, where individuals or social units are measured on a number of occasions” (Bell et al., 2019, p. 1053)

“In the latter context, this means occasions (at level 1) are nested within the individual or entity (now at level 2).” (Bell et al., 2019, p. 1053)

“we can have “within” effects that occur at level 1, and “between” or “contextual” effects that occur at level 2 (Howard 2015), and these three different effects should not be assumed to be the same.” (Bell et al., 2019, p. 1053)

“Sometimes it is the case that within effects are of the greatest interest, especially when policy interventions are evaluated. With panel data, for example, within effects can capture the effect of an independent variable changing over time. Many studies have argued for focusing on the longitudinal relationships because unobserved, time-invariant differences between the level 2 entities are then controlled for (Allison 1994; Halaby 2004, see Sect.  2.3).” (Bell et al., 2019, p. 1053)

“Social science is concerned with understanding the world as it exists, not just dynamic changes within it” (Bell et al., 2019, p. 1053)

“This is, in fact, what is effectively done by the oft-used ‘Hausman test’ (Hausman 1978). Although often (mis)used as a test of whether FE or RE models “should” be used (see Fielding 2004), it is really a test of whether there is a contextual effect, or whether the between and within effects are different.” (Bell et al., 2019, p. 1057)

“Even when within and between effects are slightly different, it may be that the bias in the estimated effect is a price worth paying for the gains in efficiency, depending on the research question at hand (Clark and Linzer 2015).” (Bell et al., 2019, p. 1057)

“All of the models we consider here are subject to a variety of biases, such as if there is selection bias (Delgado-Rodríguez and Llorca 2004), or the direction of causality assumed by the model is wrong (e.g. see Bell, Johnston, and Jones 2015). Most significantly for our present purposes is the possibility of omitted variable bias” (Bell et al., 2019, p. 1059)

“s with fixed effects models, the REWB specification prevents any bias on level 1 coefficients due to omitted variables at level 2. To put it another way, there can be no correlation between level 1 variables included in the model and the level 2 random effects—such biases are absorbed into the between effect, as confirmed by simulation studies (Bell and Jones 2015; Fairbrother 2014). When using panel data with repeated measures on individuals, unchanging and/or unmeasured characteristics of an individual (such as intelligence, ability, etc.) will be controlled out of the estimate of the within effect. However, unobserved time-varying characteristics can still cause biases at level 1 in either an FE or a REWB/Mundlak model. Similarly, in a REWB/Mundlak models, unmeasured level 2 characteristics can cause bias in the estimates of between effects and effects of other level 2 variables” (Bell et al., 2019, p. 1059)

“The view of FE and RE being defined by their assumptions has led many to characterise the REWB model as a ‘hybrid’ between FE and RE, or even a ‘hybrid FE’ model (e.g. Schempf et al. 2011).” (Bell et al., 2019, p. 1062)

“Indeed, Paul Allison, who (we believe) introduced the terminology of the Hybrid model (Allison 2005, 2009) now prefers the terminology of ‘within-between RE’ (Allison 2014).” (Bell et al., 2019, p. 1062)

“So far, all models have assumed homogeneity in the within effect associated with xit. This is often a problematic assumption. First, such models hide important and interesting heterogeneity. And second, estimates from models that assume homogeneity incorrectly will suffer from biased estimates, as we show below. The RE/REWB model as previously described also suffers from this shortcoming, but can more easily avoid it by explicitly modelling such heterogeneity, with the inclusion of random slopes” (Bell et al., 2019, p. 1062)

“. Fixed effects models are not problematic when additional higher levels exist (insofar as they can still estimate a within effect), but they are unable to include a third level (if the levels are hierarchically structured), because the dummy variables at the second level will automatically use up all degrees of freedom for any levels further up the hierarchy” (Bell et al., 2019, p. 1065)

“Do the claims of this paper apply to Generalised Linear models?” (Bell et al., 2019, p. 1066)

“n other words, the inclusion of the group mean in the model does not reliably partition any higher-level processes from the within effect, meaning both within and between estimates of cluster-specific effects16 can be biased.” (Bell et al., 2019, p. 1066)

“Brumback et al. (2010:1651) found that, in running simulations, “it was difficult to find an example in which the problem is severe” (Bell et al., 2019, p. 1066)

“rumback et  al. (2013) did identify one such example, but only with properties unlikely to be found in real life data (Allison 2014)—̄ xi and 𝜐i very highly correlated, and few observations per level-2 entity” (Bell et al., 2019, p. 1067)

“Whether the REWB model should be used, or a conditional likelihood (FE) model should be used instead, depends on three factors: (1) the link function, (2) the nature of the research question, and (3) the researcher’s willingness to accept low levels of bias” (Bell et al., 2019, p. 1067)