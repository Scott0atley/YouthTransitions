
/*====================================================================
                        1: Setup merge
====================================================================*/


clear

cd "$dta_bcs_fld"

use "bcs_cra.dta"

cd "$dta_ncds_fld"

merge 1:m id using ncds_cra
drop _merge


