
/*====================================================================
                        1: Setup merge
====================================================================*/


clear

cd "$dta_bcs_fld"

use "bcs_cra.dta"

cd "$dta_ncds_fld"

merge 1:m id using ncds_cra
drop _merge

cd "$dta_synth_fld"

merge 1:m id using merge_cra_v1 
drop _merge

gen cohort = . 
replace cohort=0 if(id>="REDACTED" & id<="REDACTED")
replace cohort=1 if(id>="REDACTED" & id<="REDACTED")
replace cohort=2 if(s_cohort==1)
replace cohort=3 if(s_cohort==2)
replace cohort=4 if(s_cohort==3)

