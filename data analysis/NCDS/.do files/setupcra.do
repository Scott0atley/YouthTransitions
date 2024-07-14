

/*====================================================================
                        1: Create Complete Records Dataset
====================================================================*/

keep if !missing(econbin, obin, sex, tenure, nssec, rgsc, camsis, nssec90, rgsc90, cam90)

count

egen id = seq(), from(1)


cd "$dta_fld"

save ncds_cra, replace

cd "$fld"