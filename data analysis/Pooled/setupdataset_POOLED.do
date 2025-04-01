

/*====================================================================
                        1: Creating CRA Dataset
====================================================================*/

cd "$dta_fld"

save merge_cra_pooled_v1, replace

/*====================================================================
                        2: Creating Imputed Dataset
====================================================================*/


cd "$dta_synth_fld"
use merge_cra_v1, clear 

cd "$dta_ncds_fld"

merge 1:m id using ncds_cra
drop _merge

cd "$dta_bcs_fld"

merge 1:m id using bcs_id
drop _merge 

cd"$dta_fld"


gen cohort = . 
replace cohort=0 if(id>="REDACTED" & id<="REDACTED")
replace cohort=1 if(id>="REDACTED" & id<="REDACTED")
replace cohort=2 if(s_cohort==1)
replace cohort=3 if(s_cohort==2)
replace cohort=4 if(s_cohort==3)

qui{
do "${do_fld}\setupvariableconstruction.do"	
do "${do_fld}\setupdefinelabels.do"	
do "${do_fld}\setupapplylabels.do"	
}

save merge_impute_pooled_v1.dta, replace
