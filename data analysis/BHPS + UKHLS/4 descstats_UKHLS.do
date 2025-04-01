

/*==============================================================================
							1: Table of Analytical Variables
==============================================================================*/

cd "$out_fld"

collect clear 

table (var) (), statistic(fvfrequency econ obin female tenure nssec s_cohort) ///
statistic(fvpercent econ obin female tenure nssec s_cohort) 

collect remap result[fvfrequency] = Col[1]
collect remap result[fvpercent] = Col[2]

count 
collect get n = `r(N)', tag(Col[2] var[n])


collect layout (var[0.econ 1.econ ///
					0.obin 1.obin ///
					0.female 1.female ///
					0.tenure 1.tenure ///
					1.nssec 2.nssec 3.nssec 4.nssec 5.nssec 6.nssec 7.nssec 8.nssec ///
					1.s_cohort 2.s_cohort 3.s_cohort 4.s_cohort 5.s_cohort ///
					empty n]) (Col[1 2])
					
collect label levels Col 1 "n" 2 "%"
collect style header Col, title(hide)
collect style header var[empty mylabel], level(hide)
collect style row stack, nobinder
collect style cell var [econ obin female tenure nssec s_cohort]#Col[1], nformat(%6.0fc)
collect style cell var [econ obin female tenure nssec s_cohort]#Col[2], nformat(%6.2fc) sformat("%s%%")
collect style cell border_block[item row-header], border(top, pattern(nil))
collect title "Table 1: Descriptive Statistics for Economic Activity"
collect note "Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Unweighted N="REDACTED""
collect preview

collect export "Table1_UKHLS_v1.docx", replace 

/*==============================================================================
							2: Desc Stats by Dependent Variable
==============================================================================*/

dtable i.obin i.female i.tenure i.nssec i.s_cohort, by(econ) nformat(%6.2fc) ///
title(Table 2: Descriptive Statistics for Synthetic School Year 12 Cohorts by Economic Activity) ///
note(Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Unweighted N="REDACTED".) ///
export("Table2_UKHLS_v1", as(docx) replace)


dtable i.obin i.female i.tenure i.nssec i.econ, by(s_cohort) nformat(%6.2fc) ///
title(Table 2: Descriptive Statistics for Economic Activity by Synthetic School Year 12 Cohorts by) ///
note(Data Source: Waves 1-18 BHPS, Waves 1-6 UKHLS. SN6676 & SN7642. Unweighted N="REDACTED".) ///
export("Table3_UKHLS_v1", as(docx) replace)