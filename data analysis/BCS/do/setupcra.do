

/*====================================================================
                        1: Create Complete Records Dataset
====================================================================*/
cd "$dta_fld"

drop if missing(crecords)

save bcs_id, replace

keep if !missing(econbin, obin, sex, tenure, nssec, rgsc, camsis, nssec90, rgsc90, cam90, bcsid, crecords)

count

gen id = _n + 8411

save bcs_cra, replace

cd "$fld"