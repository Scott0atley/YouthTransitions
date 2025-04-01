

/*==============================================================================
							1: Model Building
==============================================================================*/

glm $mb1null, family(binomial) link(logit)
estat ic

logit econ i.s_cohort
estat ic 
fitstat

logit econ i.obin#i.s_cohort 
estat ic 
fitstat

logit econ i.female#i.s_cohort 
estat ic 
fitstat

logit econ i.tenure#i.s_cohort 
estat ic 
fitstat

logit econ i.nssec#i.s_cohort 
estat ic 
fitstat

/*==============================================================================
							2: Additive Model Building
==============================================================================*/

glm $mb1null, family(binomial) link(logit)
estat ic

logit econ i.s_cohort
estat ic 
fitstat

logit econ i.obin#i.s_cohort i.s_cohort
estat ic 
fitstat

logit econ i.obin#i.s_cohort i.female#i.s_cohort i.s_cohort
estat ic 
fitstat

logit econ i.obin#i.s_cohort i.female#i.s_cohort i.tenure#i.s_cohort i.s_cohort
estat ic 
fitstat

logit econ i.obin#i.s_cohort i.female#i.s_cohort i.tenure#i.s_cohort i.nssec#i.s_cohort i.s_cohort
estat ic 
fitstat
