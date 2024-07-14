

/*====================================================================
                        1: Isolate Variables for Analysis 
====================================================================*/

keep econbin obin sex tenure nssec rgsc camsis nssec90 rgsc90 cam90 qvnssec qvrgsc qvnssec90 qvrgsc90 pmart parity breast mage med fed bcsid crecords

/*====================================================================
                        2: Save Raw Data
====================================================================*/

cd "$dta_fld"

save bcs_recoded_raw, replace

cd "$fld"