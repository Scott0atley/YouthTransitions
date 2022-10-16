/// test do file concerning O-level attainment. 

///Merging 0-3 sweep file with the sweep 4 file. 


cd "C:\Users\scott\Desktop\Stata data and do\NCDS\NCDS Sweep 23\stata\stata9"
 
 merge 1:1 ncdsid using ncds4
 drop _merge
 
///Merging the other two files with the harmonised RG Social Class measure.
 
 cd "C:\Users\scott\Desktop\Stata data and do\NCDS\NCDS Harmonised Socio-Economic Measures\stata\stata13"
 
 merge 1:1 ncdsid using ncds_closer_wp2ses
 drop _merge
 
 ///The varaible 'opass' was constructed using two variables. n4656 is a count variable ranging from 1-9 or more o-levels which would be fine on its own except it doesn't include individuals that didn't get a single o-level (a potentially important group). We thus use the variable n4655 that is a binary of whether or not someone has passed an o-level. Together these make an o-level variable ranging from 0-9 or more. 
 
gen opass=.
replace opass=0 if (n4655==2)
replace opass=1 if (n4656==1)
replace opass=2 if (n4656==2)
replace opass=3 if (n4656==3)
replace opass=4 if (n4656==4)
replace opass=5 if (n4656==5)
replace opass=6 if (n4656==6)
replace opass=7 if (n4656==7)
replace opass=8 if (n4656==8)
replace opass=9 if (n4656==9)

label define opass_lbl 0"0" 1"1" 2"2" 3"3" 4"4" 5"5" 6"6" 7"7" 8"8" 9"9 or More"
label value opass opass_lbl

 /// From the count variable we now create a binary o-level pass variable using the interally valid measure of <5 o-level passes or 5 or more o-level passes. 
 
gen obin=.
replace obin=0 if (opass==0)
replace obin=0 if (opass==1)
replace obin=0 if (opass==2)
replace obin=0 if (opass==3)
replace obin=0 if (opass==4)
replace obin=1 if (opass==5)
replace obin=1 if (opass==6)
replace obin=1 if (opass==7)
replace obin=1 if (opass==8)
replace obin=1 if (opass==9)

label define obin_lbl 0"<5 O-Level Passes" 1"5 or More O-Level Passes" 
label value obin obin_lbl

///Generate Covariates. 

/// generating sex variable from sweep 4
gen female=.
replace female=0 if (n5260==1)
replace female=1 if (n5260==2)

label define female_lbl 0"Female" 1"Male"
label value female female_lbl

/// generating ethnic variable from sweep 3
gen white=.
replace white=0 if (n2017==1)
replace white=1 if (n2017==2)
replace white=1 if (n2017==3)
replace white=1 if (n2017==4)
replace white=1 if (n2017==5)
replace white=1 if (n2017==6)

label define white_lbl 0"White" 1"Non-White"
label value white white_lbl

/// generating fathers social class from the harmonised social class measure dataset from sweep 2 using RGS1990
gen fclass=.
replace fclass=1 if (fclrg90==1)
replace fclass=2 if (fclrg90==2)
replace fclass=3 if (fclrg90==3)
replace fclass=4 if (fclrg90==4)
replace fclass=5 if (fclrg90==5)
replace fclass=6 if (fclrg90==6)

label define fclass_lbl 1"I Professional" 2"II Managerial and technical" 3"IIINM Skilled non-manual" 4"IIIM Skilled manual" 5"IV Partly skilled" 6"V Unskilled"
label value fclass fclass_lbl

/// generating housing tenure
gen tenure=. 
replace tenure=0 if (n1152==1)
replace tenure=1 if (n1152==2)
replace tenure=1 if (n1152==3)
replace tenure=1 if (n1152==4)
replace tenure=1 if (n1152==5)
replace tenure=1 if (n1152==6)

label define tenure_lbl 0"Own Home" 1"Don't Own Home"
label value tenure tenure_lbl

/// generating reading comp score
gen read=n923 
replace read=. if (read==-1)

///generating math comp score
gen math=n926
replace math=. if (math==-1)

///***Need to include descriptive table of statistics***

collect clear

table (var) (), statistic(fvfrequency obin fclass female white tenure) ///
					statistic(fvpercent obin fclass female white tenure) ///
					statistic(mean read math) ///  
					statistic(sd read math) 
					
collect remap result[fvfrequency mean] = Col[1 1] 
	collect remap result[fvpercent sd] = Col[2 2]
    
collect get resname = "Mean", tag(Col[1] var[mylabel]) 
	collect get resname = "SD", tag(Col[2] var[mylabel])
    
collect get empty = "  ", tag(Col[1] var[empty]) 
	collect get empty = "  ", tag(Col[2] var[empty])
    
count
	collect get n = `r(N)', tag(Col[2] var[n])
	
collect layout (var[0.obin 1.obin ///
					1.fclass 2.fclass 3.fclass 4.fclass 5.fclass 6.fclass ///
					0.female 1.female  ///
					0.white 1.white  ////
					0.tenure 1.tenure ////
					empty mylabel ///
					read math ///
					empty n]) (Col[1 2])
					
collect label levels Col 1 "n" 2 "%"
					
collect style header Col, title(hide)

collect style header var[empty mylabel], level(hide)
collect style row stack, nobinder

collect style cell var[obin fclass female white tenure]#Col[1], nformat(%6.0fc) 
collect style cell var[obin fclass female white tenure]#Col[2], nformat(%6.2f) sformat("%s%%") 	
collect style cell var[read math], nformat(%6.2f)


collect style cell border_block[item row-header], border(top, pattern(nil)) 

collect title "Table 1: Descriptive Statistics for O-Level Attainment"

collect note "Data Source: NCDS"

collect preview


///basic model

logit obin i.fclass, or

///full model

logit obin i.fclass i.female i.white i.tenure read math, or

///explore the model further

coefplot, vertical drop(_cons) keep(*.fclass)

margins i.fclass

margins r.fclass

///create and export regression into table format
collect clear

collect label levels colname fclass "Fathers Social Class", modify
collect label levels colname female "Female", modify
collect label levels colname white "White", modify
collect label levels colname tenure "Tenure", modify
collect label levels colname read "Reading Score Age 11", modify
collect label levels colname math "Math Score Age 11", modify


collect label levels etable_depvar 1 "Coef. (SE)", modify
etable, replace cstat(_r_b, nformat(%4.2f))  ///
	cstat(_r_se, nformat(%6.2f))  ///
	showstars showstarsnote  ///
	stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
	mstat(N) mstat(aic) mstat(bic) mstat(r2_a) ///
	title("Table 1: Logistic Regression Model Of O-level Attainment") ///
	titlestyles(font(Arial Narrow, size(14) bold)) ///
	note("Data Source: NCDS") ///
	notestyles(font(Arial Narrow, size(10) italic)) ///
	export("olevel.docx", replace)

	
///Count Model

poisson opass i.fclass i.female i.white i.tenure read math

