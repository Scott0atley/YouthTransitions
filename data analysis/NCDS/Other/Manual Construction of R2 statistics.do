

sysuse census.dta

mlogit region death marriage divorce

fitstat



*** McFadden's R2 ***
// Estimate the full model
mlogit region death marriage divorce

// Store the log-likelihood of the full model
scalar ll_full = e(ll)

display ll_full

// Estimate the null model with only intercept
mlogit region

// Store the log-likelihood of the null model
scalar ll_null = e(ll)

display ll_null

// Calculate McFadden's pseudo R-squared
scalar mcfadden_r2 = 1 - (ll_full / ll_null)

// Display McFadden's pseudo R-squared
display "McFadden's pseudo R-squared: " mcfadden_r2


*** Adjusted R2 ***

scalar r2McFA = 1-(ll_full - 16 )/ll_null 

/// 16 = df + intercept 

display "McFadden's adjusted pseudo R-squared: " r2McFA

fitstat


*** Cox-Snell ***

// Summarize the dataset to get the number of observations
summarize

// Store the number of observations in a scalar
scalar sample_size = r(N)

// Display the sample size scalar
display "Sample size: " sample_size

* Save LR chi-square statistic in a scalar
scalar LR_chi2 = e(chi2)

* Display the LR chi-square statistic
display "LR Chi-square statistic: " LR_chi2

scalar coxsnellr2 = 1-exp(-LR_chi2/sample_size)

display "Cox-Snell pseudo R-squared: " coxsnellr2


*** Nagerlake ***

scalar nagr2a = 1 - (exp(ll_null) / exp(ll_full))^(2 / sample_size) 

display nagr2a

scalar nagr2b = 1 - (exp(ll_null))^(2 / sample_size)

display nagr2b

scalar nagr2c = nagr2a/nagr2b

display "Nagelkerke pseudo R-squared: " nagr2c



*** all pseudo R2 measures ***

display "McFadden's pseudo R-squared: " mcfadden_r2
display "McFadden's adjusted pseudo R-squared: " r2McFA
display "Cox-Snell pseudo R-squared: " coxsnellr2
display "Nagelkerke pseudo R-squared: " nagr2c



*** G2 ***
















