

/*====================================================================
                        1: Model Building 
====================================================================*/

glm $mb1null, family(binomial) link(logit)
estat ic

logit $mb1edu
estat ic
fitstat

logit $mb1sex
fitstat
estat ic

logit $mb1ten
fitstat
estat ic

logit $mb1nssec
fitstat
estat ic

logit $mb1nssec90
fitstat
estat ic

logit $mb2rgsc
fitstat
estat ic

logit $mb2rgsc90
fitstat
estat ic

logit $mb3camsis
fitstat
estat ic

logit $mb3camsis90
fitstat
estat ic

/*====================================================================
                        2: Model Building Additive
====================================================================*/

logit $mb1a
fitstat
estat ic

logit $mb1b
fitstat
estat ic

logit $mb1c
fitstat
estat ic

logit $mb1c90
fitstat
estat ic

logit $mb2c
fitstat
estat ic

logit $mb2c90
fitstat
estat ic

logit $mb3c
fitstat
estat ic

logit $mb3c90
fitstat
estat ic

/*====================================================================
                        3: KHB
====================================================================*/

khb logit $khb1

khb logit $khb2

khb logit $khb3

khb logit $khb4

khb logit $khb5

khb logit $khb3b

khb logit $khb4b

khb logit $khb5b
