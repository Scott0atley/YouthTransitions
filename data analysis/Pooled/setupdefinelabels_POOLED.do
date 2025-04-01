

/*====================================================================
                        1: Setup label define
====================================================================*/

label define cohort_lbl 0"NCDS 1974" 1"BCS 1986" 2"UKHLS 1991-99" 3"UKHLS 2000-09" 4"UKHLS 2010-13"
label define obinc_lbl 0"<5 O'levels NCDS 1974" 1"≥5 O'levels NCDS 1974"
label define obinc2_lbl 0"<5 O'levels BCS" 1"≥5 O'levels BCS"
label define obinc3_lbl 0"<5 GCSEs UKHLS 1991-99" 1"≥5 GCSEs UKHLS 1991-99"
label define obinc4_lbl 0"<5 GCSEs UKHLS 2000-09" 1"≥5 GCSEs UKHLS 2000-09"
label define obinc5_lbl 0"<5 GCSEs UKHLS 2010-13" 1"≥5 GCSEs UKHLS 2010-13"
label define sexc_lbl 0"Female NCDS" 1"Male NCDS"
label define sexc2_lbl 0"Female BCS" 1"Male BCS"
label define sexc3_lbl 0"Female UKHLS 1991-99" 1"Male UKHLS 1991-99"
label define sexc4_lbl 0"Female UKHLS 2000-09" 1"Male UKHLS 2000-09"
label define sexc5_lbl 0"Female UKHLS 2010-13" 1"Male UKHLS 2010-13"
label define tenurec_lbl 0"Own Home NCDS" 1"Don't Own Home NCDS"
label define tenurec2_lbl 0"Own Home BCS" 1"Don't Own Home BCS"
label define tenurec3_lbl 0"Own Home UKHLS 1991-99" 1"Don't Own Home UKHLS 1991-99"
label define tenurec4_lbl 0"Own Home UKHLS 2000-09" 1"Don't Own Home UKHLS 2000-09"
label define tenurec5_lbl 0"Own Home UKHLS 2010-13" 1"Don't Own Home UKHLS 2010-13"
label define nssecncds_lbl 0"2 NCDS" 1"1.1 NCDS" 2"1.2 NCDS" 3"3 NCDS" 4"4 NCDS" 5"5 NCDS" 6"6 NCDS" 7"7 NCDS"
label define nssecbcs_lbl 0"2 BCS" 1"1.1 BCS" 2"1.2 BCS" 3"3 BCS" 4"4 BCS" 5"5 BCS" 6"6 BCS" 7"7 BCS"
label define nssecsynth1_lbl 0"2 UKHLS 1991-99" 1"1.1 UKHLS 1991-99" 2"1.2 UKHLS 1991-99" 3"3 UKHLS 1991-99" 4"4 UKHLS 1991-99" 5"5 UKHLS 1991-99" 6"6 UKHLS 1991-99" 7"7 UKHLS 1991-99"
label define nssecsynth2_lbl 0"2 UKHLS 2000-09" 1"1.1 UKHLS 2000-09" 2"1.2 UKHLS 2000-09" 3"3 UKHLS 2000-09" 4"4 UKHLS 2000-09" 5"5 UKHLS 2000-09" 6"6 UKHLS 2000-09" 7"7 UKHLS 2000-09"
label define nssecsynth3_lbl 0"2 UKHLS 2010-13" 1"1.1 UKHLS 2010-13" 2"1.2 UKHLS 2010-13" 3"3 UKHLS 2010-13" 4"4 UKHLS 2010-13" 5"5 UKHLS 2010-13" 6"6 UKHLS 2010-13" 7"7 UKHLS 2000-09"

lab drop obin_lbl sex_lbl tenure_lbl nssec_lbl econbin_lbl
label define obin_lbl 0"<5 O'levels/GCSEs" 1"≥5 O'levels/GCSEs"
label define sex_lbl 0"Female" 1"Male" 
label define tenure_lbl 0"Own Home" 1"Don't Own Home" 
labe define nssec_lbl 1"1.1 Large employers and higher managerial occupations" ///
				  2"1.2 Higher professional occupations" ///
				  3"2 Lower managerial and professional occupations" ///
				  4"3 Intermediate occupations" ///
				  5"4 Small employers and own account workers" ///
				  6"5 Lower supervisory and technical occupations" ///
				  7"6 Semi-routine occupations" ///
				  8"7 Routine occupations" 
label define econbin_lbl 0"Don't Continue Schooling" 1"Continue Schooling" 
				  
				  