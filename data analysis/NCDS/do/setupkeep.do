

/*====================================================================
                        1: Isolate Variables for Analysis 
====================================================================*/

keep econ201 econbin obin sex tenure nssec rgsc camsis nssec90 rgsc90 cam90 qvnssec qvrgsc qvnssec90 qvrgsc90 n4118 acatnn0region bconnn99 maw5 aconnn512 acatnn236 bcatnn95 DadNeverReads ccatnn1434 ccatnn1150 genability11 toilet itoilet otoilet cooking water garden dconnn2492 dconnage16dv46 


/*====================================================================
                        2: Save Raw Data
====================================================================*/

cd "$dta_fld"


save ncds_recoded_raw, replace

cd "$fld"