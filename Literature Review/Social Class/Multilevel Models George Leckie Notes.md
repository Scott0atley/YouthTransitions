
tags: #Methods #MLM #RandomEffects #FixedEffects 


For test scores best to translate into a z-score or standard deviation units

-          X-m/s=z

Seeing differences between groups implies similarities in outcomes between individuals within those groups.

The two-level variance components model is used to quantify the degree of clustering in the data. Provides answers to question are there differences between schools. We assume beta 0 to be approximately 0 and the combined total variance to be around 1 due to the z score nature of the transformed test score data.

Model 1 is a model without the school effects residuals – in effect it is a model with only the individual level intercept. We use this model with a likelihood ratio test in order to test the assumption that we need model 2.

Between model 1 and model 2, 175 of age 16 score variation lies between schools, 83% within schools. The correlation in age 16 scores between schoolmates is 0.17. There is substantial clustering or dependence in the data. The likelihood-ratio test indicates that the clustering is also statistically significant.

The deviance is equal to 2xlog likelihood.

Do schools’ age 16 performances still vary, even after accounting for these age 11 intake differences? This question is addressed by including students’ age 11 scores in our model as a covariate. This is referred to as a **random-intercept model**.

This has a fixed part – the overall intercept and the overall slop coefficient.

This has a random effects part – the level-2 effect, and the level-1 effect.

From model 2 to model 3 there is a half drop in between-school variance, mean differences are much better at demonstrating that effects are attributed to baseline differences rather than attributing them to teaching differences like model 2 does.

In each and every school, an increase of 1-unit in age 11 score increases the expected age 16 score by 0.563 units.

46% of the variation in schools’ age 16 performances is explained by school-level differences in their age 11 scores. 33% of the within school variation in students’ age 16 scores is explained by variation in students’ age 11 scores.

14% of the variation in progress lies between schools. There is residual clustering and so we still need a multilevel model. (Strictly we should do a likelihood ratio test for this).

Caterpillar plots can be used to make inferences about individual schools.

The gender difference is statistically significant. Adjusting for student gender reduces both variance components.

The estimates for single sex schooling does suggest a substantively significant estimate but the standard errors are large with p values being non-significant suggesting we should pull back from model 5.

What happens if we ignore the school-level clustering? The deviance for the naïve model gets higher than the model 5. The likelihood ratio test also prefers model 5 to 6. The naïve model also combines the variance again, there is a meaningful between and within variance difference which shouldn’t be ignored. Standard errors for the naïve model are also very small compared to model 5 – suggesting the clustering is required for understanding the true substantive effects of gendered schooling.

Model 6 suggests we need more single-sex schools. Model 5 counters that and shows that methods matter!

**Summary:**

Introduced two-level random-intercept model with covariates at level-1 and level-2.

Calculated R-squared and proportion changing in variation.

Demonstrated consequences of ignoring residual clustering.

**Random-coefficient models**

Are schools differentially effective for different types of students?

-          Are the schools that are best for high initial attainers different from the schools that are best for low initial attainers?

-          Or are some schools uniformly better than others across the entire ability?

Are single-sex schools less egalitarian than mixed-sex schools?

Trellis plots show the different slopes of different schools for 11 scores to 16 scores.

Mentioned ‘borrowing strength’ from other schools when a single school has low observational data?

We can derive the mixed-effects formulation of the model by substituting the two level-2 models into the level-1 model and rearranging. The fixed part of the model describes the average school. The random part of the model at level-2 describes how the 65 schools vary around the average.

We have to expand our assumptions. We already assumed that it was normally distributed, has a beta of 0 and a constant of 0 with a variance of around 1. The intercept and slop random effects are assumed bivariate normal.

Model1 is a random-intercept compared to model 2 of a random-slope. The likelihood ratio test prefers model 2, the residual variance drops from model 1 to model 2.

Some schools have steeper lines than others. In schools with steeper slopes, age 11 scores re more predictive of age 16 scores than they are in schools with shallower slopes. Schools with steeper sloops stretch the attainment distribution (widen initial attainment differences) relative to schools with flatter slopes.

Schools with above average intercepts tend to have above average slopes. The schools which do best for the average student are also the schools which widen initial attainment differences the most. Schools which narrow initial attainment differences seem to do so by restricting the average and high initial attainers rather than by boosting the low initial attainers.

High initial attainers appear more sensitive to which school they go to than do low initial attainers. School choice appears to matter more for high initial attainers. Put differently, the variance between schools increases with increasing xij (heteroskedasticity).

The intercept-slope covariance is most easily interpreted as a correlation. There is a strong positive correlation. Schools with above average intercepts tend to have above average slopes.

Single-sex schools does explain some of the intercept variance but not the slope variance. The interactions would explain the random slope variance.

Writing the model using a two-stage formulation highlights that the main effect of school gender explains the random-intercept variance while the cross-level interaction explains the random-slope variance.

Single-sex schools do not on average have significanly steeper slopes than mixed sex schools.