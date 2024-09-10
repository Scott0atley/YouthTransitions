

/*====================================================================
                        1: Creating CRA Dataset
====================================================================*/

cd "$dta_fld"

save merge_cra, replace

/*====================================================================
                        2: Creating Imputed Dataset
====================================================================*/

clear 

cd "$dta_bcs_fld"

use "bcs_id.dta"

gen id = _n + 8411

cd "$dta_ncds_fld"

merge 1:m id using ncds_cra
drop _merge

cd "$dta_fld"

save merge_impute, replace