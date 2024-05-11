
cd "G:\Stata data and do\NCDS\Occupation Codes\UKDA-7023-stata9\stata9"
use "G:\Stata data and do\NCDS\Occupation Codes\UKDA-7023-stata9\stata9\ncds2_occupation_coding_father"


cd "G:\Stata data and do\NCDS\NCDS Sweep 16\stata\stata11"


rename NCDSID ncdsid
  
merge 1:1 ncdsid using ncds0123
drop _merge

cd "G:\Stata data and do\NCDS\NCDS Sweep 23\stata\stata9"

merge 1:1 ncdsid using ncds4
drop _merge

cd "G:\Stata data and do\Tables and Figures\Tables and Figuers for Chapter One"

codebook ec201 n4655 n4656 n622_4 n2017 n1152 N2SNSSEC N2SCMSIS N2SRGSC N2SSOC90, compact

tab ec201

collect export "raw.docx", replace

gen econ201=.
replace econ201=. if (ec201==.)
replace econ201=. if (ec201==-1)
replace econ201=1 if (ec201==100)
replace econ201=1 if (ec201==101)
replace econ201=1 if (ec201==200)
replace econ201=1 if (ec201==201)

replace econ201=2 if (ec201==500)
replace econ201=2 if (ec201==800)

replace econ201=3 if (ec201==550)

replace econ201=4 if (ec201==110)
replace econ201=4 if (ec201==111)
replace econ201=4 if (ec201==113)
replace econ201=4 if (ec201==114)
replace econ201=4 if (ec201==120)
replace econ201=4 if (ec201==121)
replace econ201=4 if (ec201==130)
replace econ201=4 if (ec201==131)
replace econ201=4 if (ec201==140)
replace econ201=4 if (ec201==141)
replace econ201=4 if (ec201==150)
replace econ201=4 if (ec201==152)
replace econ201=4 if (ec201==220)
replace econ201=4 if (ec201==300)
replace econ201=4 if (ec201==400)

replace econ201=5 if (ec201==600)
replace econ201=5 if (ec201==601)
replace econ201=5 if (ec201==602)
replace econ201=5 if (ec201==700)
replace econ201=5 if (ec201==701)

label define econ_lbl 1"Employment" 2"Post-Schooling Education" 3"School" 4"Training/Apprenticeships" 5"Unemployment and OLF"
label value econ201 econ_lbl

tab econ201

gen econbin = . 
replace econbin=1 if (econ201==3)
replace econbin=0 if (econ201==1)
replace econbin=0 if (econ201==2)
replace econbin=0 if (econ201==4)
replace econbin=0 if (econ201==5)

label define econbin_lbl 1"Continue Schooling" 0"Don't Contine Schooling"
label values econbin econbin_lbl

gen olevel=.
replace olevel=0 if (n4655==2)
replace olevel=1 if (n4656==1)
replace olevel=2 if (n4656==2)
replace olevel=3 if (n4656==3)
replace olevel=4 if (n4656==4)
replace olevel=5 if (n4656==5)
replace olevel=6 if (n4656==6)
replace olevel=7 if (n4656==7)
replace olevel=8 if (n4656==8)
replace olevel=9 if (n4656==9)

label define olevel_lbl 0"0" 1"1" 2"2" 3"3" 4"4" 5"5" 6"6" 7"7" 8"8" 9"9 or More"
label value olevel olevel_lbl

table ( econ201 ) ( olevel ) (), statistic(sumw) 

collect export "counttable.docx", replace

gen obin=.
replace obin=0 if (olevel==0)
replace obin=0 if (olevel==1)
replace obin=0 if (olevel==2)
replace obin=0 if (olevel==3)
replace obin=0 if (olevel==4)
replace obin=1 if (olevel==5)
replace obin=1 if (olevel==6)
replace obin=1 if (olevel==7)
replace obin=1 if (olevel==8)
replace obin=1 if (olevel==9)

label define obin_lbl 0"<5 O-Levels" 1">5 O-Levels"
label value obin obin_lbl

tab obin

gen sex=. 
replace sex=0 if (n622_4==2)
replace sex=1 if (n622_4==1)

label define sex_lbl 0"Female" 1"Male"
label value sex sex_lbl

tab sex

gen race=.
replace race=0 if (n2017==1)
replace race=1 if (n2017==2)
replace race=1 if (n2017==3)
replace race=1 if (n2017==4)
replace race=1 if (n2017==5)
replace race=1 if (n2017==6)

label define race_lbl 0"White" 1"Non-White"
label value race race_lbl

tab race 

gen tenure=. 
replace tenure=0 if (n1152==1)
replace tenure=1 if (n1152==2)
replace tenure=1 if (n1152==3)
replace tenure=1 if (n1152==4)
replace tenure=1 if (n1152==5)
replace tenure=1 if (n1152==6)

label define tenure_lbl 0"Own Home" 1"Don't Own Home"
label value tenure tenure_lbl

tab tenure

gen nssec=. 
replace nssec=1 if (N2SNSSEC==2)

replace nssec=2 if (N2SNSSEC==3.1)
replace nssec=2 if (N2SNSSEC==3.2)
replace nssec=2 if (N2SNSSEC==3.3)

replace nssec=3 if (N2SNSSEC==4.1)
replace nssec=3 if (N2SNSSEC==4.2)
replace nssec=3 if (N2SNSSEC==4.3)
replace nssec=3 if (N2SNSSEC==5)

replace nssec=4 if (N2SNSSEC==7.1)
replace nssec=4 if (N2SNSSEC==7.2)
replace nssec=4 if (N2SNSSEC==7.3)
replace nssec=4 if (N2SNSSEC==7.4)

replace nssec=5 if (N2SNSSEC==8.1)
replace nssec=5 if (N2SNSSEC==9.1)
replace nssec=5 if (N2SNSSEC==9.2)

replace nssec=6 if (N2SNSSEC==10)
replace nssec=6 if (N2SNSSEC==11.1)
replace nssec=6 if (N2SNSSEC==11.2)

replace nssec=7 if (N2SNSSEC==12.1)
replace nssec=7 if (N2SNSSEC==12.2)
replace nssec=7 if (N2SNSSEC==12.3)
replace nssec=7 if (N2SNSSEC==12.4)
replace nssec=7 if (N2SNSSEC==12.5)
replace nssec=7 if (N2SNSSEC==12.6)
replace nssec=7 if (N2SNSSEC==12.7)

replace nssec=8 if (N2SNSSEC==13.1)
replace nssec=8 if (N2SNSSEC==13.2)
replace nssec=8 if (N2SNSSEC==13.3)
replace nssec=8 if (N2SNSSEC==13.4)
replace nssec=8 if (N2SNSSEC==13.5)

label define nssec_lbl 1"Large Employers and higher managerial occupations" 2"Higher professional occupations" 3"Lower Managerial and professional occupations" 4"Intermediate occupations" 5"Small employers and own account workers" 6"Lower supervisory and technical occupations" 7"Semi-routine occupations" 8"Routine occupations"
label value nssec nssec_lbl

destring N2SSOCC, gen(soc2000) force

gen camsisf=.
replace camsisf=85.6 if soc2000==1111
replace camsisf=71.5 if soc2000==1112
replace camsisf=70.7 if soc2000==1113
replace camsisf=71.01 if soc2000==1114
replace camsisf=57.77 if soc2000==1121
replace camsisf=58.07 if soc2000==1122
replace camsisf=64.88 if soc2000==1123
replace camsisf=71.15 if soc2000==1131
replace camsisf=64.1 if soc2000==1132
replace camsisf=60.97 if soc2000==1133
replace camsisf=70.66 if soc2000==1134
replace camsisf=70.17 if soc2000==1135
replace camsisf=69.58 if soc2000==1136
replace camsisf=69.72 if soc2000==1137
replace camsisf=63.06 if soc2000==1141
replace camsisf=64.88 if soc2000==1151
replace camsisf=64 if soc2000==1152
replace camsisf=55.11 if soc2000==1161
replace camsisf=49.1 if soc2000==1162
replace camsisf=58.68 if soc2000==1163
replace camsisf=77 if soc2000==1171
replace camsisf=60 if soc2000==1172
replace camsisf=68.12 if soc2000==1173
replace camsisf=60.69 if soc2000==1185
replace camsisf=55.4 if soc2000==1211
replace camsisf=58.65 if soc2000==1212
replace camsisf=52.26 if soc2000==1219
replace camsisf=56.5 if soc2000==1221
replace camsisf=54 if soc2000==1223
replace camsisf=50.52 if soc2000==1224
replace camsisf=58.94 if soc2000==1225
replace camsisf=73.2 if soc2000==1226
replace camsisf=67.24 if soc2000==1231
replace camsisf=57.5 if soc2000==1232
replace camsisf=56.9 if soc2000==1233
replace camsisf=57.71 if soc2000==1234
replace camsisf=51.48 if soc2000==1235
replace camsisf=60.16 if soc2000==1239

replace camsisf=73.4 if soc2000==2111
replace camsisf=74.5 if soc2000==2112
replace camsisf=84.22 if soc2000==2113
replace camsisf=65.88 if soc2000==2121
replace camsisf=67.83 if soc2000==2122
replace camsisf=67.54 if soc2000==2123
replace camsisf=67.17 if soc2000==2124
replace camsisf=80.3 if soc2000==2125
replace camsisf=65.54 if soc2000==2126
replace camsisf=55.49 if soc2000==2127
replace camsisf=60.06 if soc2000==2128
replace camsisf=64.84 if soc2000==2129
replace camsisf=78.81 if soc2000==2131
replace camsisf=76.18 if soc2000==2132
replace camsisf=87.4 if soc2000==2211
replace camsisf=94 if soc2000==2212
replace camsisf=73.7 if soc2000==2213
replace camsisf=80.2 if soc2000==2214
replace camsisf=83.7 if soc2000==2215
replace camsisf=79.6 if soc2000==2216
replace camsisf=81.39 if soc2000==2311
replace camsisf=63.8 if soc2000==2312
replace camsisf=79.9 if soc2000==2313
replace camsisf=70.9 if soc2000==2314
replace camsisf=65.5 if soc2000==2315
replace camsisf=65.8 if soc2000==2316
replace camsisf=79.65 if soc2000==2317
replace camsisf=65.53 if soc2000==2319
replace camsisf=77.94 if soc2000==2321
replace camsisf=73.53 if soc2000==2322
replace camsisf=67.09 if soc2000==2329
replace camsisf=84.82 if soc2000==2411
replace camsisf=85.06 if soc2000==2419
replace camsisf=72.5 if soc2000==2421
replace camsisf=68 if soc2000==2422
replace camsisf=76.98 if soc2000==2423
replace camsisf=79.6 if soc2000==2424
replace camsisf=79.6 if soc2000==2431
replace camsisf=86.3 if soc2000==2432
replace camsisf=69.7 if soc2000==2433
replace camsisf=67.24 if soc2000==2434
replace camsisf=69.53 if soc2000==2441
replace camsisf=73.6 if soc2000==2442
replace camsisf=73.6 if soc2000==2443
replace camsisf=82.2 if soc2000==2444
replace camsisf=72.24 if soc2000==2451

replace camsisf=60.96 if soc2000==3111
replace camsisf=49.17 if soc2000==3112
replace camsisf=50.98 if soc2000==3113
replace camsisf=57.52 if soc2000==3114
replace camsisf=52.42 if soc2000==3119
replace camsisf=58.84 if soc2000==3122
replace camsisf=61.54 if soc2000==3123
replace camsisf=68.81 if soc2000==3131
replace camsisf=52.4 if soc2000==3211
replace camsisf=66.9 if soc2000==3215
replace camsisf=46.7 if soc2000==3217
replace camsisf=49.02 if soc2000==3218
replace camsisf=66.1 if soc2000==3221
replace camsisf=61.94 if soc2000==3229
replace camsisf=62.72 if soc2000==3231
replace camsisf=63.49 if soc2000==3232
replace camsisf=45.1 if soc2000==3311
replace camsisf=56.77 if soc2000==3312
replace camsisf=52.7 if soc2000==3313
replace camsisf=48.6 if soc2000==3314
replace camsisf=63.94 if soc2000==3319
replace camsisf=71.9 if soc2000==3411
replace camsisf=75.03 if soc2000==3412
replace camsisf=68.68 if soc2000==3413
replace camsisf=71.56 if soc2000==3415
replace camsisf=70.24 if soc2000==3416
replace camsisf=67.77 if soc2000==3421
replace camsisf=67.27 if soc2000==3422
replace camsisf=75.67 if soc2000==3431
replace camsisf=71.55 if soc2000==3432
replace camsisf=70.7 if soc2000==3433
replace camsisf=64.74 if soc2000==3434
replace camsisf=70.4 if soc2000==3441
replace camsisf=69.44 if soc2000==3511
replace camsisf=73.11 if soc2000==3512
replace camsisf=55.8 if soc2000==3513
replace camsisf=36.5 if soc2000==3514
replace camsisf=64.4 if soc2000==3520
replace camsisf=61.18 if soc2000==3531
replace camsisf=65.6 if soc2000==3532
replace camsisf=63.2 if soc2000==3533
replace camsisf=66.34 if soc2000==3534
replace camsisf=74.1 if soc2000==3535
replace camsisf=60.28 if soc2000==3536
replace camsisf=67.01 if soc2000==3537
replace camsisf=66.57 if soc2000==3539
replace camsisf=56.23 if soc2000==3541
replace camsisf=57.76 if soc2000==3542
replace camsisf=67.66 if soc2000==3543
replace camsisf=67.05 if soc2000==3544
replace camsisf=69.01 if soc2000==3551
replace camsisf=41.36 if soc2000==3552
replace camsisf=69.1 if soc2000==3561
replace camsisf=63.61 if soc2000==3562
replace camsisf=56 if soc2000==3563
replace camsisf=57 if soc2000==3564
replace camsisf=56.29 if soc2000==3565
replace camsisf=64.41 if soc2000==3566
replace camsisf=57.83 if soc2000==3567
replace camsisf=67.9 if soc2000==3568

replace camsisf=64.17 if soc2000==4111
replace camsisf=50.9 if soc2000==4112
replace camsisf=59.06 if soc2000==4113
replace camsisf=71.04 if soc2000==4114
replace camsisf=58.36 if soc2000==4121
replace camsisf=58.82 if soc2000==4122
replace camsisf=54.15 if soc2000==4123
replace camsisf=50.77 if soc2000==4131
replace camsisf=57.63 if soc2000==4132
replace camsisf=42.01 if soc2000==4133
replace camsisf=51.74 if soc2000==4134
replace camsisf=51.86 if soc2000==4136
replace camsisf=51.12 if soc2000==4141
replace camsisf=48.9 if soc2000==4142
replace camsisf=53.2 if soc2000==4150
replace camsisf=66.03 if soc2000==4214
replace camsisf=63.33 if soc2000==4215
replace camsisf=51.6 if soc2000==4216
replace camsisf=60.65 if soc2000==4217

replace camsisf=52.89 if soc2000==5111
replace camsisf=48.24 if soc2000==5112
replace camsisf=38.45 if soc2000==5113
replace camsisf=47 if soc2000==5119
replace camsisf=33.2 if soc2000==5211
replace camsisf=18.3 if soc2000==5212
replace camsisf=38.6 if soc2000==5213
replace camsisf=33.9 if soc2000==5214
replace camsisf=33.3 if soc2000==5215
replace camsisf=43.32 if soc2000==5216
replace camsisf=34.95 if soc2000==5221
replace camsisf=42.73 if soc2000==5222
replace camsisf=41.23 if soc2000==5223
replace camsisf=45.95 if soc2000==5224
replace camsisf=43.63 if soc2000==5231
replace camsisf=39.05 if soc2000==5232
replace camsisf=54.2 if soc2000==5233
replace camsisf=50.3 if soc2000==5234
replace camsisf=46.43 if soc2000==5241
replace camsisf=49.01 if soc2000==5242
replace camsisf=41.5 if soc2000==5243
replace camsisf=47.48 if soc2000==5244
replace camsisf=54.1 if soc2000==5245
replace camsisf=49.16 if soc2000==5249
replace camsisf=31.98 if soc2000==5311
replace camsisf=33.9 if soc2000==5312
replace camsisf=34.2 if soc2000==5313
replace camsisf=43.45 if soc2000==5314
replace camsisf=41.35 if soc2000==5315
replace camsisf=39.1 if soc2000==5316
replace camsisf=40.79 if soc2000==5319
replace camsisf=36.4 if soc2000==5321
replace camsisf=43.23 if soc2000==5322
replace camsisf=38.8 if soc2000==5323
replace camsisf=19.48 if soc2000==5411
replace camsisf=42.18 if soc2000==5412
replace camsisf=39.87 if soc2000==5413
replace camsisf=42.88 if soc2000==5414
replace camsisf=39.32 if soc2000==5419
replace camsisf=46.38 if soc2000==5421
replace camsisf=41.18 if soc2000==5422
replace camsisf=38.48 if soc2000==5423
replace camsisf=33.6 if soc2000==5431
replace camsisf=38.08 if soc2000==5432
replace camsisf=26.15 if soc2000==5433
replace camsisf=45.97 if soc2000==5434
replace camsisf=25.62 if soc2000==5491
replace camsisf=42.84 if soc2000==5492
replace camsisf=39.45 if soc2000==5493
replace camsisf=64.03 if soc2000==5494
replace camsisf=53.93 if soc2000==5495
replace camsisf=51.5 if soc2000==5496
replace camsisf=32.09 if soc2000==5499

replace camsisf=43.76 if soc2000==6111
replace camsisf=46.6 if soc2000==6112
replace camsisf=58.96 if soc2000==6114
replace camsisf=43.97 if soc2000==6115
replace camsisf=54.4 if soc2000==6121
replace camsisf=43.9 if soc2000==6131
replace camsisf=36.02 if soc2000==6139
replace camsisf=44.41 if soc2000==6211
replace camsisf=59.28 if soc2000==6212
replace camsisf=52.48 if soc2000==6214
replace camsisf=35.68 if soc2000==6215
replace camsisf=46.85 if soc2000==6219
replace camsisf=52.6 if soc2000==6221
replace camsisf=35.9 if soc2000==6231
replace camsisf=40.11 if soc2000==6232
replace camsisf=45.24 if soc2000==6291
replace camsisf=43 if soc2000==6292

replace camsisf=51.51 if soc2000==7111
replace camsisf=35.7 if soc2000==7112
replace camsisf=53.2 if soc2000==7113
replace camsisf=42.85 if soc2000==7121
replace camsisf=42.74 if soc2000==7122
replace camsisf=39.7 if soc2000==7123
replace camsisf=46.1 if soc2000==7124
replace camsisf=49.34 if soc2000==7125
replace camsisf=55.32 if soc2000==7129

replace camsisf=31.02 if soc2000==8111
replace camsisf=22.45 if soc2000==8112
replace camsisf=24.28 if soc2000==8113
replace camsisf=33.45 if soc2000==8114
replace camsisf=27.43 if soc2000==8115
replace camsisf=30.18 if soc2000==8116
replace camsisf=30.13 if soc2000==8117
replace camsisf=24.3 if soc2000==8118
replace camsisf=31.68 if soc2000==8119
replace camsisf=33.67 if soc2000==8121
replace camsisf=21.88 if soc2000==8122
replace camsisf=32.61 if soc2000==8123
replace camsisf=34.39 if soc2000==8124
replace camsisf=32.08 if soc2000==8125
replace camsisf=42.72 if soc2000==8126
replace camsisf=35.4 if soc2000==8129
replace camsisf=37.15 if soc2000==8131
replace camsisf=37.5 if soc2000==8132
replace camsisf=38.32 if soc2000==8133
replace camsisf=30.27 if soc2000==8134
replace camsisf=36.23 if soc2000==8135
replace camsisf=33.1 if soc2000==8136
replace camsisf=32.9 if soc2000==8137
replace camsisf=44.09 if soc2000==8138
replace camsisf=28.89 if soc2000==8139
replace camsisf=33.7 if soc2000==8141
replace camsisf=28.19 if soc2000==8142
replace camsisf=25.26 if soc2000==8143
replace camsisf=40.09 if soc2000==8149
replace camsisf=34.5 if soc2000==8211
replace camsisf=46.18 if soc2000==8212
replace camsisf=35.1 if soc2000==8213
replace camsisf=42.3 if soc2000==8214
replace camsisf=54.3 if soc2000==8215
replace camsisf=35.22 if soc2000==8216
replace camsisf=39.81 if soc2000==8217
replace camsisf=32.95 if soc2000==8218
replace camsisf=33.66 if soc2000==8219
replace camsisf=24.3 if soc2000==8221
replace camsisf=29.1 if soc2000==8222
replace camsisf=34.97 if soc2000==8223
replace camsisf=29.73 if soc2000==8229

replace camsisf=32.2 if soc2000==9111
replace camsisf=44.7 if soc2000==9112
replace camsisf=35.26 if soc2000==9119
replace camsisf=30.89 if soc2000==9121
replace camsisf=29.92 if soc2000==9129
replace camsisf=26.28 if soc2000==9131
replace camsisf=33.25 if soc2000==9132
replace camsisf=43.12 if soc2000==9133
replace camsisf=30.2 if soc2000==9134
replace camsisf=29.31 if soc2000==9139
replace camsisf=32.36 if soc2000==9141
replace camsisf=36.47 if soc2000==9149
replace camsisf=41.06 if soc2000==9211
replace camsisf=50.8 if soc2000==9219
replace camsisf=38.5 if soc2000==9221
replace camsisf=43.09 if soc2000==9222
replace camsisf=45.57 if soc2000==9223
replace camsisf=39.47 if soc2000==9224
replace camsisf=35.59 if soc2000==9225
replace camsisf=43.03 if soc2000==9229
replace camsisf=37.6 if soc2000==9231
replace camsisf=32.23 if soc2000==9232
replace camsisf=36.44 if soc2000==9233
replace camsisf=44.04 if soc2000==9234
replace camsisf=26.01 if soc2000==9235
replace camsisf=34.21 if soc2000==9239
replace camsisf=38.92 if soc2000==9241
replace camsisf=40.7 if soc2000==9242
replace camsisf=39.3 if soc2000==9245
replace camsisf=41.32 if soc2000==9249
replace camsisf=35.3 if soc2000==9251

gen rgsc=.
replace rgsc=1 if (N2SRGSC==1)
replace rgsc=2 if (N2SRGSC==2)
replace rgsc=3 if (N2SRGSC==3.1)
replace rgsc=4 if (N2SRGSC==3.2)
replace rgsc=5 if (N2SRGSC==4)
replace rgsc=6 if (N2SRGSC==5)

label define rgsc_lbl 1"Professional" 2"Managerial and Technical" 3"Skilled non-manual" 4"Skilled manual" 5"Partly skilled" 6"Unskilled"
label value rgsc rgsc_lbl

tab nssec

tab camsis

tab rgsc

gen cam90=.
replace cam90=85.6 if N2SSOC90==100
replace cam90=71.5 if N2SSOC90==101
replace cam90=70.7 if N2SSOC90==102
replace cam90=69.3 if N2SSOC90==103
replace cam90=59.5 if N2SSOC90==110
replace cam90=58.2 if N2SSOC90==111
replace cam90=55.4 if N2SSOC90==112
replace cam90=66.2 if N2SSOC90==113
replace cam90=76.4 if N2SSOC90==120
replace cam90=65.9 if N2SSOC90==121
replace cam90=61.5 if N2SSOC90==122
replace cam90=71 if N2SSOC90==123
replace cam90=70.4 if N2SSOC90==124
replace cam90=70.4 if N2SSOC90==125
replace cam90=69.9 if N2SSOC90==126
replace cam90=70 if N2SSOC90==127
replace cam90=58.5 if N2SSOC90==130
replace cam90=65.1 if N2SSOC90==131
replace cam90=64.1 if N2SSOC90==132
replace cam90=63.7 if N2SSOC90==139
replace cam90=57.5 if N2SSOC90==140
replace cam90=50.3 if N2SSOC90==141
replace cam90=48.3 if N2SSOC90==142
replace cam90=77 if N2SSOC90==150
replace cam90=68.6 if N2SSOC90==151
replace cam90=60 if N2SSOC90==152
replace cam90=68.6 if N2SSOC90==153
replace cam90=68.6 if N2SSOC90==154
replace cam90=68.6 if N2SSOC90==155
replace cam90=55.4 if N2SSOC90==160
replace cam90=52.6 if N2SSOC90==169
replace cam90=68.5 if N2SSOC90==170
replace cam90=56.4 if N2SSOC90==171
replace cam90=56.9 if N2SSOC90==172
replace cam90=56.5 if N2SSOC90==173
replace cam90=54 if N2SSOC90==174
replace cam90=50.7 if N2SSOC90==175
replace cam90=58.1 if N2SSOC90==176
replace cam90=73.2 if N2SSOC90==177
replace cam90=49.4 if N2SSOC90==178
replace cam90=59.5 if N2SSOC90==179
replace cam90=71.7 if N2SSOC90==190
replace cam90=82.3 if N2SSOC90==191
replace cam90=63.5 if N2SSOC90==199

replace cam90=73.4 if N2SSOC90==200
replace cam90=74.7 if N2SSOC90==201
replace cam90=84.4 if N2SSOC90==202
replace cam90=81.4 if N2SSOC90==209
replace cam90=66.6 if N2SSOC90==210
replace cam90=68.5 if N2SSOC90==211
replace cam90=68.3 if N2SSOC90==212
replace cam90=67.1 if N2SSOC90==213
replace cam90=81.9 if N2SSOC90==214
replace cam90=80.3 if N2SSOC90==215
replace cam90=64.2 if N2SSOC90==216
replace cam90=55.8 if N2SSOC90==217
replace cam90=60.2 if N2SSOC90==218
replace cam90=64.9 if N2SSOC90==219
replace cam90=87.4 if N2SSOC90==220
replace cam90=73.7 if N2SSOC90==221
replace cam90=80.2 if N2SSOC90==222
replace cam90=83.7 if N2SSOC90==223
replace cam90=79.6 if N2SSOC90==224
replace cam90=82.3 if N2SSOC90==230
replace cam90=63.8 if N2SSOC90==231
replace cam90=79.9 if N2SSOC90==232
replace cam90=70.9 if N2SSOC90==233
replace cam90=65.5 if N2SSOC90==234
replace cam90=65.8 if N2SSOC90==235
replace cam90=66.9 if N2SSOC90==239
replace cam90=85.7 if N2SSOC90==240
replace cam90=87.9 if N2SSOC90==241
replace cam90=85.2 if N2SSOC90==242
replace cam90=72.5 if N2SSOC90==250
replace cam90=68 if N2SSOC90==251
replace cam90=75.3 if N2SSOC90==252
replace cam90=81.6 if N2SSOC90==253
replace cam90=79.6 if N2SSOC90==260
replace cam90=86.3 if N2SSOC90==261
replace cam90=68.1 if N2SSOC90==262
replace cam90=86.2 if N2SSOC90==270
replace cam90=76.5 if N2SSOC90==271
replace cam90=94 if N2SSOC90==290
replace cam90=79.8 if N2SSOC90==291
replace cam90=82.2 if N2SSOC90==292
replace cam90=73.6 if N2SSOC90==293

replace cam90=61.3 if N2SSOC90==300
replace cam90=51.6 if N2SSOC90==301
replace cam90=49.6 if N2SSOC90==302
replace cam90=67.4 if N2SSOC90==303
replace cam90=58.2 if N2SSOC90==304
replace cam90=51.8 if N2SSOC90==309
replace cam90=59.3 if N2SSOC90==310
replace cam90=62.1 if N2SSOC90==311
replace cam90=69.7 if N2SSOC90==312
replace cam90=63.3 if N2SSOC90==313
replace cam90=69.2 if N2SSOC90==320
replace cam90=71.8 if N2SSOC90==330
replace cam90=73.9 if N2SSOC90==331
replace cam90=55.8 if N2SSOC90==332
replace cam90=52.4 if N2SSOC90==340
replace cam90=59.8 if N2SSOC90==341
replace cam90=66.3 if N2SSOC90==342
replace cam90=66.1 if N2SSOC90==343
replace cam90=66.9 if N2SSOC90==344
replace cam90=66.3 if N2SSOC90==345
replace cam90=46.7 if N2SSOC90==346
replace cam90=66.3 if N2SSOC90==347
replace cam90=67.9 if N2SSOC90==348
replace cam90=43.9 if N2SSOC90==349
replace cam90=65.7 if N2SSOC90==350
replace cam90=56.2 if N2SSOC90==360
replace cam90=68.1 if N2SSOC90==361
replace cam90=67.8 if N2SSOC90==362
replace cam90=63.1 if N2SSOC90==363
replace cam90=72.2 if N2SSOC90==364
replace cam90=60.4 if N2SSOC90==370
replace cam90=62.8 if N2SSOC90==371
replace cam90=75.8 if N2SSOC90==380
replace cam90=71.9 if N2SSOC90==381
replace cam90=65.4 if N2SSOC90==382
replace cam90=70.9 if N2SSOC90==383
replace cam90=70.7 if N2SSOC90==384
replace cam90=71.9 if N2SSOC90==385
replace cam90=64.6 if N2SSOC90==386
replace cam90=70.4 if N2SSOC90==387
replace cam90=70.1 if N2SSOC90==390
replace cam90=54.2 if N2SSOC90==391
replace cam90=57 if N2SSOC90==392
replace cam90=54.4 if N2SSOC90==393
replace cam90=53.7 if N2SSOC90==394
replace cam90=69.5 if N2SSOC90==395
replace cam90=58.2 if N2SSOC90==396
replace cam90=61.5 if N2SSOC90==399

replace cam90=50.9 if N2SSOC90==400
replace cam90=57.2 if N2SSOC90==401
replace cam90=58.3 if N2SSOC90==410
replace cam90=53.9 if N2SSOC90==411
replace cam90=42.6 if N2SSOC90==412
replace cam90=50.6 if N2SSOC90==420
replace cam90=50.5 if N2SSOC90==421
replace cam90=51.9 if N2SSOC90==430
replace cam90=36 if N2SSOC90==440
replace cam90=37.5 if N2SSOC90==441
replace cam90=62.6 if N2SSOC90==450
replace cam90=62.6 if N2SSOC90==451
replace cam90=62.6 if N2SSOC90==452
replace cam90=62.3 if N2SSOC90==459
replace cam90=51.4 if N2SSOC90==460
replace cam90=51.4 if N2SSOC90==461
replace cam90=49.3 if N2SSOC90==462
replace cam90=46.5 if N2SSOC90==463
replace cam90=51.6 if N2SSOC90==490
replace cam90=57.6 if N2SSOC90==491

replace cam90=33.9 if N2SSOC90==500
replace cam90=34.2 if N2SSOC90==501
replace cam90=36.4 if N2SSOC90==502
replace cam90=39.7 if N2SSOC90==503
replace cam90=46.5 if N2SSOC90==504
replace cam90=33.7 if N2SSOC90==505
replace cam90=43.2 if N2SSOC90==506
replace cam90=38.8 if N2SSOC90==507
replace cam90=38.4 if N2SSOC90==509
replace cam90=38.6 if N2SSOC90==510
replace cam90=33.7 if N2SSOC90==511
replace cam90=32 if N2SSOC90==512
replace cam90=36.6 if N2SSOC90==513
replace cam90=24.7 if N2SSOC90==514
replace cam90=42.8 if N2SSOC90==515
replace cam90=41.2 if N2SSOC90==516
replace cam90=46.5 if N2SSOC90==517
replace cam90=57.1 if N2SSOC90==518
replace cam90=30.3 if N2SSOC90==519
replace cam90=47.4 if N2SSOC90==520
replace cam90=45.4 if N2SSOC90==521
replace cam90=54.8 if N2SSOC90==522
replace cam90=48.9 if N2SSOC90==523
replace cam90=41.5 if N2SSOC90==524
replace cam90=47.4 if N2SSOC90==525
replace cam90=54.1 if N2SSOC90==526
replace cam90=50.3 if N2SSOC90==529
replace cam90=33.2 if N2SSOC90==530
replace cam90=18.3 if N2SSOC90==531
replace cam90=43.5 if N2SSOC90==532
replace cam90=38.6 if N2SSOC90==533
replace cam90=33.9 if N2SSOC90==534
replace cam90=31.9 if N2SSOC90==535
replace cam90=37.7 if N2SSOC90==536
replace cam90=33.3 if N2SSOC90==537
replace cam90=43.3 if N2SSOC90==540
replace cam90=38.8 if N2SSOC90==541
replace cam90=39.9 if N2SSOC90==542
replace cam90=54.2 if N2SSOC90==543
replace cam90=42.5 if N2SSOC90==544
replace cam90=13.7 if N2SSOC90==550
replace cam90=26.4 if N2SSOC90==551
replace cam90=26.3 if N2SSOC90==552
replace cam90=33.3 if N2SSOC90==553
replace cam90=42.4 if N2SSOC90==554
replace cam90=39.8 if N2SSOC90==555
replace cam90=44.9 if N2SSOC90==556
replace cam90=33.1 if N2SSOC90==557
replace cam90=39.3 if N2SSOC90==559
replace cam90=51.1 if N2SSOC90==560
replace cam90=48.7 if N2SSOC90==561
replace cam90=38.5 if N2SSOC90==562
replace cam90=43.9 if N2SSOC90==563
replace cam90=38.5 if N2SSOC90==569
replace cam90=41.5 if N2SSOC90==570
replace cam90=43.6 if N2SSOC90==571
replace cam90=21.2 if N2SSOC90==572
replace cam90=41.7 if N2SSOC90==573
replace cam90=44.1 if N2SSOC90==579
replace cam90=33.5 if N2SSOC90==580
replace cam90=33.6 if N2SSOC90==581
replace cam90=24.6 if N2SSOC90==582
replace cam90=24.6 if N2SSOC90==590
replace cam90=19.5 if N2SSOC90==591
replace cam90=63.6 if N2SSOC90==592
replace cam90=66 if N2SSOC90==593
replace cam90=37.8 if N2SSOC90==594
replace cam90=39.6 if N2SSOC90==595
replace cam90=36.1 if N2SSOC90==596
replace cam90=17.5 if N2SSOC90==597
replace cam90=50.2 if N2SSOC90==598
replace cam90=31.6 if N2SSOC90==599

replace cam90=45.1 if N2SSOC90==600
replace cam90=46.2 if N2SSOC90==601
replace cam90=57.4 if N2SSOC90==610
replace cam90=52.7 if N2SSOC90==611
replace cam90=48.6 if N2SSOC90==612
replace cam90=81.6 if N2SSOC90==613
replace cam90=43.8 if N2SSOC90==614
replace cam90=38.6 if N2SSOC90==615
replace cam90=43.5 if N2SSOC90==619
replace cam90=42.3 if N2SSOC90==620
replace cam90=38.4 if N2SSOC90==621
replace cam90=36 if N2SSOC90==622
replace cam90=52.2 if N2SSOC90==630
replace cam90=28.7 if N2SSOC90==631
replace cam90=40.4 if N2SSOC90==640
replace cam90=42.5 if N2SSOC90==641
replace cam90=46.6 if N2SSOC90==642
replace cam90=44.8 if N2SSOC90==643
replace cam90=43.5 if N2SSOC90==644
replace cam90=46.5 if N2SSOC90==650
replace cam90=43.7 if N2SSOC90==651
replace cam90=43.5 if N2SSOC90==652
replace cam90=46.7 if N2SSOC90==659
replace cam90=52.6 if N2SSOC90==660
replace cam90=52.6 if N2SSOC90==661
replace cam90=32.8 if N2SSOC90==670
replace cam90=32.8 if N2SSOC90==671
replace cam90=39.5 if N2SSOC90==672
replace cam90=44.1 if N2SSOC90==673
replace cam90=56.4 if N2SSOC90==690
replace cam90=51 if N2SSOC90==691
replace cam90=43 if N2SSOC90==699

replace cam90=57.6 if N2SSOC90==700
replace cam90=53.6 if N2SSOC90==701
replace cam90=61.2 if N2SSOC90==702
replace cam90=60 if N2SSOC90==703
replace cam90=56.6 if N2SSOC90==710
replace cam90=56.9 if N2SSOC90==719
replace cam90=51.5 if N2SSOC90==720
replace cam90=34.4 if N2SSOC90==721
replace cam90=37 if N2SSOC90==722
replace cam90=37.9 if N2SSOC90==730
replace cam90=39.7 if N2SSOC90==731
replace cam90=46.6 if N2SSOC90==732
replace cam90=44 if N2SSOC90==733
replace cam90=42 if N2SSOC90==790
replace cam90=51.5 if N2SSOC90==791
replace cam90=53.3 if N2SSOC90==792

replace cam90=31.3 if N2SSOC90==800
replace cam90=32.3 if N2SSOC90==801
replace cam90=31.1 if N2SSOC90==802
replace cam90=30.7 if N2SSOC90==809
replace cam90=24.4 if N2SSOC90==810
replace cam90=24.3 if N2SSOC90==811
replace cam90=24.5 if N2SSOC90==812
replace cam90=24.8 if N2SSOC90==813
replace cam90=22.5 if N2SSOC90==814
replace cam90=38 if N2SSOC90==820
replace cam90=33 if N2SSOC90==821
replace cam90=35.4 if N2SSOC90==822
replace cam90=13.1 if N2SSOC90==823
replace cam90=27.1 if N2SSOC90==824
replace cam90=30.1 if N2SSOC90==825
replace cam90=36.7 if N2SSOC90==826
replace cam90=31.5 if N2SSOC90==829
replace cam90=27.9 if N2SSOC90==830
replace cam90=31.2 if N2SSOC90==831
replace cam90=29.4 if N2SSOC90==832
replace cam90=29.5 if N2SSOC90==833
replace cam90=24.3 if N2SSOC90==834
replace cam90=31.1 if N2SSOC90==839
replace cam90=37.2 if N2SSOC90==840
replace cam90=31.4 if N2SSOC90==841
replace cam90=31.4 if N2SSOC90==842
replace cam90=23.7 if N2SSOC90==843
replace cam90=21.1 if N2SSOC90==844
replace cam90=37 if N2SSOC90==850
replace cam90=37.5 if N2SSOC90==851
replace cam90=20.6 if N2SSOC90==859
replace cam90=42.2 if N2SSOC90==860
replace cam90=34.3 if N2SSOC90==861
replace cam90=30.2 if N2SSOC90==862
replace cam90=30.1 if N2SSOC90==863
replace cam90=44.6 if N2SSOC90==864
replace cam90=37.1 if N2SSOC90==869
replace cam90=35.1 if N2SSOC90==870
replace cam90=35.1 if N2SSOC90==871
replace cam90=34.5 if N2SSOC90==872
replace cam90=35.1 if N2SSOC90==873
replace cam90=42.3 if N2SSOC90==874
replace cam90=32 if N2SSOC90==875
replace cam90=39.8 if N2SSOC90==880
replace cam90=39.9 if N2SSOC90==881
replace cam90=36.5 if N2SSOC90==882
replace cam90=31.5 if N2SSOC90==883
replace cam90=29.2 if N2SSOC90==884
replace cam90=30.3 if N2SSOC90==885
replace cam90=24.3 if N2SSOC90==886
replace cam90=29.1 if N2SSOC90==887
replace cam90=30 if N2SSOC90==889
replace cam90=28.5 if N2SSOC90==890
replace cam90=44.9 if N2SSOC90==891
replace cam90=42 if N2SSOC90==892
replace cam90=33 if N2SSOC90==893
replace cam90=23.7 if N2SSOC90==894
replace cam90=32 if N2SSOC90==895
replace cam90=40.4 if N2SSOC90==896
replace cam90=33.1 if N2SSOC90==897
replace cam90=35.9 if N2SSOC90==898
replace cam90=35.8 if N2SSOC90==899

replace cam90=32.2 if N2SSOC90==900
replace cam90=35 if N2SSOC90==901
replace cam90=35.9 if N2SSOC90==902
replace cam90=33 if N2SSOC90==903
replace cam90=44.7 if N2SSOC90==904
replace cam90=17.4 if N2SSOC90==910
replace cam90=16 if N2SSOC90==911
replace cam90=24.3 if N2SSOC90==912
replace cam90=31.4 if N2SSOC90==913
replace cam90=23.8 if N2SSOC90==919
replace cam90=30.8 if N2SSOC90==920
replace cam90=29.4 if N2SSOC90==921
replace cam90=24.9 if N2SSOC90==922
replace cam90=26.9 if N2SSOC90==923
replace cam90=31.5 if N2SSOC90==924
replace cam90=29.1 if N2SSOC90==929
replace cam90=32.1 if N2SSOC90==930
replace cam90=33.6 if N2SSOC90==931
replace cam90=32.5 if N2SSOC90==932
replace cam90=19.8 if N2SSOC90==933
replace cam90=32.5 if N2SSOC90==934
replace cam90=38.8 if N2SSOC90==940
replace cam90=43 if N2SSOC90==941
replace cam90=38.5 if N2SSOC90==950
replace cam90=43.1 if N2SSOC90==951
replace cam90=37.9 if N2SSOC90==952
replace cam90=48.3 if N2SSOC90==953
replace cam90=33.8 if N2SSOC90==954
replace cam90=39.3 if N2SSOC90==955
replace cam90=37.6 if N2SSOC90==956
replace cam90=32.5 if N2SSOC90==957
replace cam90=36.4 if N2SSOC90==958
replace cam90=34.6 if N2SSOC90==959
replace cam90=29 if N2SSOC90==990
replace cam90=46.8 if N2SSOC90==999

gen rgsc90=.
replace rgsc90=1 if N2SSOC90==100
replace rgsc90=2 if N2SSOC90==101
replace rgsc90=2 if N2SSOC90==102
replace rgsc90=3 if N2SSOC90==112
replace rgsc90=2 if N2SSOC90==132
replace rgsc90=2 if N2SSOC90==142
replace rgsc90=. if N2SSOC90==150
replace rgsc90=2 if N2SSOC90==152
replace rgsc90=2 if N2SSOC90==160
replace rgsc90=3 if N2SSOC90==172
replace rgsc90=2 if N2SSOC90==173
replace rgsc90=3 if N2SSOC90==174
replace rgsc90=3 if N2SSOC90==176
replace rgsc90=2 if N2SSOC90==177
replace rgsc90=2 if N2SSOC90==179
replace rgsc90=2 if N2SSOC90==199
replace rgsc90=1 if N2SSOC90==200
replace rgsc90=1 if N2SSOC90==201
replace rgsc90=1 if N2SSOC90==202
replace rgsc90=1 if N2SSOC90==210
replace rgsc90=1 if N2SSOC90==211
replace rgsc90=1 if N2SSOC90==212
replace rgsc90=1 if N2SSOC90==213
replace rgsc90=1 if N2SSOC90==215
replace rgsc90=1 if N2SSOC90==216
replace rgsc90=1 if N2SSOC90==218
replace rgsc90=1 if N2SSOC90==219
replace rgsc90=1 if N2SSOC90==220
replace rgsc90=1 if N2SSOC90==221
replace rgsc90=1 if N2SSOC90==222
replace rgsc90=1 if N2SSOC90==223
replace rgsc90=1 if N2SSOC90==224
replace rgsc90=1 if N2SSOC90==230
replace rgsc90=2 if N2SSOC90==231
replace rgsc90=1 if N2SSOC90==232
replace rgsc90=2 if N2SSOC90==233
replace rgsc90=2 if N2SSOC90==234
replace rgsc90=1 if N2SSOC90==250
replace rgsc90=1 if N2SSOC90==253
replace rgsc90=1 if N2SSOC90==260
replace rgsc90=1 if N2SSOC90==261
replace rgsc90=1 if N2SSOC90==290
replace rgsc90=1 if N2SSOC90==292
replace rgsc90=2 if N2SSOC90==293
replace rgsc90=2 if N2SSOC90==300
replace rgsc90=2 if N2SSOC90==309
replace rgsc90=2 if N2SSOC90==311
replace rgsc90=2 if N2SSOC90==312
replace rgsc90=2 if N2SSOC90==313
replace rgsc90=2 if N2SSOC90==320
replace rgsc90=2 if N2SSOC90==332
replace rgsc90=2 if N2SSOC90==340
replace rgsc90=2 if N2SSOC90==343
replace rgsc90=2 if N2SSOC90==344
replace rgsc90=2 if N2SSOC90==346
replace rgsc90=2 if N2SSOC90==347
replace rgsc90=2 if N2SSOC90==348
replace rgsc90=2 if N2SSOC90==349
replace rgsc90=2 if N2SSOC90==350
replace rgsc90=2 if N2SSOC90==360
replace rgsc90=2 if N2SSOC90==361
replace rgsc90=2 if N2SSOC90==362
replace rgsc90=2 if N2SSOC90==364
replace rgsc90=2 if N2SSOC90==370
replace rgsc90=2 if N2SSOC90==371
replace rgsc90=2 if N2SSOC90==381
replace rgsc90=2 if N2SSOC90==383
replace rgsc90=2 if N2SSOC90==384
replace rgsc90=2 if N2SSOC90==385
replace rgsc90=3 if N2SSOC90==387
replace rgsc90=2 if N2SSOC90==390
replace rgsc90=2 if N2SSOC90==391
replace rgsc90=2 if N2SSOC90==392
replace rgsc90=2 if N2SSOC90==393
replace rgsc90=3 if N2SSOC90==399
replace rgsc90=3 if N2SSOC90==400
replace rgsc90=3 if N2SSOC90==401
replace rgsc90=3 if N2SSOC90==410
replace rgsc90=3 if N2SSOC90==411
replace rgsc90=3 if N2SSOC90==420
replace rgsc90=3 if N2SSOC90==430
replace rgsc90=3 if N2SSOC90==441
replace rgsc90=3 if N2SSOC90==452
replace rgsc90=3 if N2SSOC90==459
replace rgsc90=3 if N2SSOC90==462
replace rgsc90=3 if N2SSOC90==463
replace rgsc90=3 if N2SSOC90==490
replace rgsc90=3 if N2SSOC90==491
replace rgsc90=4 if N2SSOC90==500
replace rgsc90=5 if N2SSOC90==501
replace rgsc90=4 if N2SSOC90==502
replace rgsc90=5 if N2SSOC90==505
replace rgsc90=4 if N2SSOC90==507
replace rgsc90=4 if N2SSOC90==516
replace rgsc90=4 if N2SSOC90==521
replace rgsc90=4 if N2SSOC90==522
replace rgsc90=4 if N2SSOC90==524
replace rgsc90=4 if N2SSOC90==526
replace rgsc90=4 if N2SSOC90==529
replace rgsc90=4 if N2SSOC90==530
replace rgsc90=4 if N2SSOC90==531
replace rgsc90=4 if N2SSOC90==532
replace rgsc90=4 if N2SSOC90==533
replace rgsc90=4 if N2SSOC90==534
replace rgsc90=4 if N2SSOC90==535
replace rgsc90=4 if N2SSOC90==537
replace rgsc90=4 if N2SSOC90==540
replace rgsc90=4 if N2SSOC90==542
replace rgsc90=4 if N2SSOC90==543
replace rgsc90=4 if N2SSOC90==551
replace rgsc90=4 if N2SSOC90==554
replace rgsc90=4 if N2SSOC90==555
replace rgsc90=4 if N2SSOC90==557
replace rgsc90=4 if N2SSOC90==559
replace rgsc90=4 if N2SSOC90==579
replace rgsc90=4 if N2SSOC90==580
replace rgsc90=4 if N2SSOC90==581
replace rgsc90=4 if N2SSOC90==582
replace rgsc90=4 if N2SSOC90==590
replace rgsc90=4 if N2SSOC90==593
replace rgsc90=5 if N2SSOC90==594
replace rgsc90=5 if N2SSOC90==596
replace rgsc90=5 if N2SSOC90==599
replace rgsc90=. if N2SSOC90==600
replace rgsc90=3 if N2SSOC90==611
replace rgsc90=5 if N2SSOC90==612
replace rgsc90=5 if N2SSOC90==615
replace rgsc90=5 if N2SSOC90==619
replace rgsc90=4 if N2SSOC90==620
replace rgsc90=5 if N2SSOC90==622
replace rgsc90=4 if N2SSOC90==630
replace rgsc90=4 if N2SSOC90==642
replace rgsc90=5 if N2SSOC90==644
replace rgsc90=4 if N2SSOC90==650
replace rgsc90=5 if N2SSOC90==661
replace rgsc90=5 if N2SSOC90==672
replace rgsc90=5 if N2SSOC90==673
replace rgsc90=5 if N2SSOC90==699
replace rgsc90=2 if N2SSOC90==702
replace rgsc90=2 if N2SSOC90==703
replace rgsc90=3 if N2SSOC90==710
replace rgsc90=3 if N2SSOC90==719
replace rgsc90=3 if N2SSOC90==720
replace rgsc90=3 if N2SSOC90==722
replace rgsc90=5 if N2SSOC90==730
replace rgsc90=4 if N2SSOC90==731
replace rgsc90=5 if N2SSOC90==732
replace rgsc90=3 if N2SSOC90==733
replace rgsc90=3 if N2SSOC90==791
replace rgsc90=3 if N2SSOC90==792
replace rgsc90=5 if N2SSOC90==809
replace rgsc90=5 if N2SSOC90==829
replace rgsc90=4 if N2SSOC90==834
replace rgsc90=4 if N2SSOC90==839
replace rgsc90=5 if N2SSOC90==840
replace rgsc90=5 if N2SSOC90==850
replace rgsc90=5 if N2SSOC90==851
replace rgsc90=5 if N2SSOC90==860
replace rgsc90=5 if N2SSOC90==862
replace rgsc90=5 if N2SSOC90==869
replace rgsc90=4 if N2SSOC90==872
replace rgsc90=4 if N2SSOC90==873
replace rgsc90=4 if N2SSOC90==874
replace rgsc90=5 if N2SSOC90==875
replace rgsc90=5 if N2SSOC90==880
replace rgsc90=4 if N2SSOC90==881
replace rgsc90=4 if N2SSOC90==882
replace rgsc90=4 if N2SSOC90==886
replace rgsc90=4 if N2SSOC90==887
replace rgsc90=4 if N2SSOC90==891
replace rgsc90=5 if N2SSOC90==896
replace rgsc90=4 if N2SSOC90==897
replace rgsc90=5 if N2SSOC90==898
replace rgsc90=5 if N2SSOC90==899
replace rgsc90=5 if N2SSOC90==900
replace rgsc90=5 if N2SSOC90==901
replace rgsc90=5 if N2SSOC90==902
replace rgsc90=5 if N2SSOC90==903
replace rgsc90=5 if N2SSOC90==904
replace rgsc90=5 if N2SSOC90==910
replace rgsc90=5 if N2SSOC90==913
replace rgsc90=5 if N2SSOC90==922
replace rgsc90=5 if N2SSOC90==924
replace rgsc90=6 if N2SSOC90==929
replace rgsc90=6 if N2SSOC90==931
replace rgsc90=4 if N2SSOC90==932
replace rgsc90=6 if N2SSOC90==941
replace rgsc90=5 if N2SSOC90==950
replace rgsc90=5 if N2SSOC90==951
replace rgsc90=5 if N2SSOC90==953
replace rgsc90=5 if N2SSOC90==954
replace rgsc90=6 if N2SSOC90==955
replace rgsc90=6 if N2SSOC90==956
replace rgsc90=6 if N2SSOC90==958
replace rgsc90=5 if N2SSOC90==959
replace rgsc90=6 if N2SSOC90==990
replace rgsc90=4 if N2SSOC90==999

gen nssec90=.
replace nssec90=1 if N2SSOC90==100
replace nssec90=1 if N2SSOC90==101
replace nssec90=1 if N2SSOC90==102
replace nssec90=3 if N2SSOC90==112
replace nssec90=3 if N2SSOC90==132
replace nssec90=3 if N2SSOC90==142
replace nssec90=1 if N2SSOC90==150
replace nssec90=1 if N2SSOC90==152
replace nssec90=5 if N2SSOC90==160
replace nssec90=5 if N2SSOC90==172
replace nssec90=5 if N2SSOC90==173
replace nssec90=3 if N2SSOC90==174
replace nssec90=3 if N2SSOC90==176
replace nssec90=3 if N2SSOC90==177
replace nssec90=3 if N2SSOC90==179
replace nssec90=3 if N2SSOC90==199
replace nssec90=2 if N2SSOC90==200
replace nssec90=2 if N2SSOC90==201
replace nssec90=2 if N2SSOC90==202
replace nssec90=2 if N2SSOC90==210
replace nssec90=2 if N2SSOC90==211
replace nssec90=2 if N2SSOC90==212
replace nssec90=2 if N2SSOC90==213
replace nssec90=2 if N2SSOC90==215
replace nssec90=2 if N2SSOC90==216
replace nssec90=3 if N2SSOC90==218
replace nssec90=2 if N2SSOC90==219
replace nssec90=2 if N2SSOC90==220
replace nssec90=2 if N2SSOC90==221
replace nssec90=2 if N2SSOC90==222
replace nssec90=2 if N2SSOC90==223
replace nssec90=2 if N2SSOC90==224
replace nssec90=2 if N2SSOC90==230
replace nssec90=3 if N2SSOC90==231
replace nssec90=2 if N2SSOC90==232
replace nssec90=3 if N2SSOC90==233
replace nssec90=3 if N2SSOC90==234
replace nssec90=2 if N2SSOC90==250
replace nssec90=2 if N2SSOC90==253
replace nssec90=2 if N2SSOC90==260
replace nssec90=2 if N2SSOC90==261
replace nssec90=2 if N2SSOC90==290
replace nssec90=2 if N2SSOC90==292
replace nssec90=3 if N2SSOC90==293
replace nssec90=3 if N2SSOC90==300
replace nssec90=3 if N2SSOC90==309
replace nssec90=3 if N2SSOC90==311
replace nssec90=3 if N2SSOC90==312
replace nssec90=3 if N2SSOC90==313
replace nssec90=2 if N2SSOC90==320
replace nssec90=3 if N2SSOC90==332
replace nssec90=3 if N2SSOC90==340
replace nssec90=3 if N2SSOC90==343
replace nssec90=3 if N2SSOC90==344
replace nssec90=7 if N2SSOC90==346
replace nssec90=3 if N2SSOC90==347
replace nssec90=2 if N2SSOC90==348
replace nssec90=7 if N2SSOC90==349
replace nssec90=4 if N2SSOC90==350
replace nssec90=3 if N2SSOC90==360
replace nssec90=3 if N2SSOC90==361
replace nssec90=2 if N2SSOC90==362
replace nssec90=2 if N2SSOC90==364
replace nssec90=7 if N2SSOC90==370
replace nssec90=3 if N2SSOC90==371
replace nssec90=5 if N2SSOC90==381
replace nssec90=4 if N2SSOC90==383
replace nssec90=3 if N2SSOC90==384
replace nssec90=3 if N2SSOC90==385
replace nssec90=3 if N2SSOC90==387
replace nssec90=3 if N2SSOC90==390
replace nssec90=3 if N2SSOC90==391
replace nssec90=3 if N2SSOC90==392
replace nssec90=5 if N2SSOC90==393

replace nssec90=3 if N2SSOC90==399
replace nssec90=4 if N2SSOC90==400
replace nssec90=4 if N2SSOC90==401
replace nssec90=4 if N2SSOC90==410
replace nssec90=4 if N2SSOC90==411
replace nssec90=4 if N2SSOC90==420
replace nssec90=4 if N2SSOC90==430
replace nssec90=8 if N2SSOC90==441
replace nssec90=4 if N2SSOC90==452
replace nssec90=4 if N2SSOC90==459
replace nssec90=7 if N2SSOC90==462
replace nssec90=6 if N2SSOC90==463
replace nssec90=4 if N2SSOC90==490
replace nssec90=4 if N2SSOC90==491
replace nssec90=5 if N2SSOC90==500
replace nssec90=5 if N2SSOC90==501
replace nssec90=5 if N2SSOC90==502
replace nssec90=7 if N2SSOC90==505
replace nssec90=5 if N2SSOC90==507
replace nssec90=6 if N2SSOC90==516
replace nssec90=6 if N2SSOC90==521
replace nssec90=6 if N2SSOC90==522
replace nssec90=6 if N2SSOC90==524
replace nssec90=4 if N2SSOC90==526
replace nssec90=4 if N2SSOC90==529
replace nssec90=8 if N2SSOC90==530
replace nssec90=7 if N2SSOC90==531
replace nssec90=6 if N2SSOC90==532
replace nssec90=7 if N2SSOC90==533
replace nssec90=8 if N2SSOC90==534
replace nssec90=7 if N2SSOC90==535
replace nssec90=8 if N2SSOC90==537
replace nssec90=6 if N2SSOC90==540
replace nssec90=6 if N2SSOC90==542
replace nssec90=6 if N2SSOC90==543
replace nssec90=8 if N2SSOC90==551
replace nssec90=8 if N2SSOC90==554
replace nssec90=8 if N2SSOC90==555
replace nssec90=7 if N2SSOC90==557
replace nssec90=8 if N2SSOC90==559
replace nssec90=5 if N2SSOC90==579
replace nssec90=6 if N2SSOC90==580
replace nssec90=8 if N2SSOC90==581
replace nssec90=8 if N2SSOC90==582
replace nssec90=8 if N2SSOC90==590
replace nssec90=5 if N2SSOC90==593
replace nssec90=6 if N2SSOC90==594
replace nssec90=7 if N2SSOC90==596
replace nssec90=6 if N2SSOC90==599
replace nssec90=4 if N2SSOC90==600
replace nssec90=4 if N2SSOC90==611
replace nssec90=3 if N2SSOC90==612
replace nssec90=7 if N2SSOC90==615
replace nssec90=8 if N2SSOC90==619
replace nssec90=7 if N2SSOC90==620
replace nssec90=8 if N2SSOC90==622
replace nssec90=8 if N2SSOC90==630
replace nssec90=4 if N2SSOC90==642
replace nssec90=7 if N2SSOC90==644
replace nssec90=4 if N2SSOC90==650
replace nssec90=5 if N2SSOC90==661
replace nssec90=7 if N2SSOC90==672
replace nssec90=8 if N2SSOC90==673
replace nssec90=7 if N2SSOC90==699
replace nssec90=3 if N2SSOC90==702
replace nssec90=2 if N2SSOC90==703
replace nssec90=3 if N2SSOC90==710
replace nssec90=4 if N2SSOC90==719
replace nssec90=7 if N2SSOC90==720
replace nssec90=7 if N2SSOC90==722
replace nssec90=5 if N2SSOC90==730
replace nssec90=8 if N2SSOC90==731
replace nssec90=5 if N2SSOC90==732
replace nssec90=5 if N2SSOC90==733
replace nssec90=8 if N2SSOC90==791
replace nssec90=7 if N2SSOC90==792
replace nssec90=7 if N2SSOC90==809
replace nssec90=7 if N2SSOC90==829
replace nssec90=7 if N2SSOC90==834
replace nssec90=7 if N2SSOC90==839
replace nssec90=7 if N2SSOC90==840
replace nssec90=7 if N2SSOC90==850
replace nssec90=7 if N2SSOC90==851
replace nssec90=6 if N2SSOC90==860
replace nssec90=8 if N2SSOC90==862
replace nssec90=6 if N2SSOC90==869
replace nssec90=8 if N2SSOC90==872
replace nssec90=8 if N2SSOC90==873
replace nssec90=5 if N2SSOC90==874
replace nssec90=8 if N2SSOC90==875
replace nssec90=7 if N2SSOC90==880
replace nssec90=6 if N2SSOC90==881
replace nssec90=6 if N2SSOC90==882
replace nssec90=7 if N2SSOC90==886
replace nssec90=7 if N2SSOC90==887
replace nssec90=7 if N2SSOC90==891
replace nssec90=6 if N2SSOC90==896
replace nssec90=7 if N2SSOC90==897
replace nssec90=6 if N2SSOC90==898
replace nssec90=7 if N2SSOC90==899
replace nssec90=7 if N2SSOC90==900
replace nssec90=7 if N2SSOC90==901
replace nssec90=8 if N2SSOC90==902
replace nssec90=5 if N2SSOC90==903
replace nssec90=5 if N2SSOC90==904
replace nssec90=8 if N2SSOC90==910
replace nssec90=8 if N2SSOC90==913
replace nssec90=6 if N2SSOC90==922
replace nssec90=5 if N2SSOC90==924
replace nssec90=8 if N2SSOC90==929
replace nssec90=8 if N2SSOC90==931
replace nssec90=8 if N2SSOC90==932
replace nssec90=7 if N2SSOC90==941
replace nssec90=7 if N2SSOC90==950
replace nssec90=8 if N2SSOC90==951
replace nssec90=7 if N2SSOC90==953
replace nssec90=7 if N2SSOC90==954
replace nssec90=8 if N2SSOC90==955
replace nssec90=5 if N2SSOC90==956
replace nssec90=8 if N2SSOC90==958
replace nssec90=8 if N2SSOC90==959
replace nssec90=8 if N2SSOC90==990
replace nssec90=8 if N2SSOC90==999

label values nssec90 nssec_lbl
label values rgsc90 rgsc_lbl

tab nssec90 nssec
tab rgsc90 rgsc 

label variable econ201 "Economic Activity of Respondent on September when they are 16"
label variable econbin "Continue Schooling or not after September when individuals are 16"
label variable obin "Educational Attainment O-levels"
label variable sex "Sex of Respondent"
label variable tenure "Housing Tenure of Respondent when Child"
label variable nssec "NS-SEC Social Class of Father when Respondent Child SOC2000"
label variable rgsc "RGSC Social Class of Father when Respondent Child SOC2000"
label variable camsis "CAMSIS Score of Father when Respondent Child SOC2000"
label variable nssec90 "NS-SEC Social Class of Father when Respondent Child SOC90"
label variable rgsc90 "RGSC Social Class of Father when Respondent Child SOC90"
label variable cam90 "CAMSIS Score of Father when Respondent Child SOC90"


save ncds4_recoded, replace




rename camsisf camsis

keep if !missing(econ201, econbin, obin, sex, tenure, nssec, rgsc, camsis, nssec90, rgsc90, cam90)

count

cd"G:\Stata data and do\Tables and Figures\Tables and Figuers for Chapter One"



collect clear

table (var) (), statistic(fvfrequency econbin obin sex tenure nssec nssec90 rgsc rgsc90) ///
					statistic(fvpercent econbin obin sex tenure nssec nssec90 rgsc rgsc90) ///
					statistic(mean camsis cam90) ///  
					statistic(sd camsis cam90) 			
collect remap result[fvfrequency mean] = Col[1 1] 
	collect remap result[fvpercent sd] = Col[2 2]
collect get resname = "Mean", tag(Col[1] var[mylabel]) 
	collect get resname = "SD", tag(Col[2] var[mylabel])
collect get empty = "  ", tag(Col[1] var[empty]) 
	collect get empty = "  ", tag(Col[2] var[empty])
    
count
	collect get n = `r(N)', tag(Col[2] var[n])
	
collect layout (var[0.econbin 1.econbin ///
					0.obin 1.obin ///
					0.sex 1.sex  ///
					0.tenure 1.tenure ///
					1.nssec 2.nssec 3.nssec 4.nssec 5.nssec 6.nssec 7.nssec 8.nssec ///
					1.rgsc 2.rgsc 3.rgsc 4.rgsc 5.rgsc 6.rgsc ///
                    1.nssec90 2.nssec90 3.nssec90 4.nssec90 5.nssec90 6.nssec90 7.nssec90 8.nssec90 ///
                    1.rgsc90 2.rgsc90 3.rgsc90 4.rgsc90 5.rgsc90 6.rgsc90 ///
					empty mylabel ///
					camsis ///
                    cam90 ///
					empty n]) (Col[1 2])

collect label levels Col 1 "n" 2 "%"			
collect style header Col, title(hide)
collect style header var[empty mylabel], level(hide)
collect style row stack, nobinder
collect style cell var [econbin obin sex tenure nssec nssec90 rgsc rgsc90]#Col[1], nformat(%6.0fc) 
collect style cell var[econbin obin sex tenure nssec nssec90 rgsc rgsc90]#Col[2], nformat(%6.2f) sformat("%s%%") 	
collect style cell var[camsis cam90], nformat(%6.2f)
collect style cell border_block[item row-header], border(top, pattern(nil)) 
collect title "Table 1: Descriptive Statistics for Economic Activity"
collect note "Data Source: NCDS"
collect preview

collect export "Table1.docx", replace


dtable i.obin i.sex i.tenure i.nssec i.rgsc i.nssec90 i.rgsc90 camsis cam90, by(econbin) nformat(%6.2fc) title(Descriptive Statistics by Economic Activity) export("Table2a", as(docx) replace)


dtable i.nssec, by(nssec90) nformat(%6.2fc) title(Descriptive Statistics comparing NS-SEC by SOC2000 and SOC90 codes) export("Table3", as(docx) replace)

dtable i.rgsc, by(rgsc90) nformat(%6.2fc) title(Descriptive Statistics comparing RGSC by SOC2000 and SOC90 codes) export("Table4", as(docx) replace)

summarize camsis, detail

summarize cam90, detail


glm econbin, family(binomial) link(logit)
estat ic

logit econbin i.obin
estat ic
fitstat

logit econbin i.sex
fitstat
estat ic

logit econbin i.tenure
fitstat
estat ic

logit econbin ib(3).nssec
fitstat
estat ic

logit econbin ib(2).rgsc
fitstat
estat ic

logit econbin camsis
fitstat
estat ic


quietly logit econbin

quietly logit econbin i.obin
fitstat
estat ic

quietly logit econbin i.obin i.sex
fitstat
estat ic

quietly logit econbin i.obin i.sex i.tenure
fitstat
estat ic

quietly logit econbin i.obin i.sex i.tenure ib(3).nssec
fitstat
estat ic

quietly logit econbin i.obin i.sex i.tenure ib(2).rgsc
fitstat
estat ic

quietly logit econbin i.obin i.sex i.tenure camsis
fitstat
estat ic

* to get Tjur R2

predict yhatf if e(sample)

ttest yhatf, by(econbin)


* modelling


logit econbin i.obin i.sex i.tenure ib(3).nssec

est store logitnsseca

etable 

fitstat



* qv stats

gen qvnssec=.
replace qvnssec=1 if(nssec==3)
replace qvnssec=2 if(nssec==1)
replace qvnssec=3 if(nssec==2)
replace qvnssec=4 if(nssec==4)
replace qvnssec=5 if(nssec==5)
replace qvnssec=6 if(nssec==6)
replace qvnssec=7 if(nssec==7)
replace qvnssec=8 if(nssec==8)


label define qvnssec_lbl 1"Lower Managerial and professional occupations" 2"Large Employers and higher managerial occupations" 3"Higher professional occupations" 4"Intermediate occupations" 5"Small employers and own account workers" 6"Lower supervisory and technical occupations" 7"Semi-routine occupations" 8"Routine occupations" 
label values qvnssec qvnssec_lbl

*Graph Settings
grstyle clear
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle set color Set1
grstyle yesno draw_major_hgrid yes
grstyle yesno draw_major_ygrid yes
grstyle color major_grid gs8
grstyle linepattern major_grid dot
grstyle color ci_area gs12%50

* graphs
logit econbin i.obin i.sex i.tenure i.qvnssec

estimates store modellogita

estimates restore modellogita

qv i.qvnssec

matrix define LB = e(qvlb)
matrix list LB

gen lba=LB[1,1] if _n==6
gen lbb=LB[2,1] if _n==2
gen lbc=LB[3,1] if _n==4
gen lbd=LB[4,1] if _n==8
gen lbe=LB[5,1] if _n==10
gen lbf=LB[6,1] if _n==12
gen lbg=LB[7,1] if _n==14
gen lbh=LB[8,1] if _n==16
egen quasilower = rowtotal(lba lbb lbc lbd lbe lbf lbg lbh)
replace quasilower=. if(quasilower==0)

matrix define UB = e(qvub)
matrix list UB

gen uba=UB[1,1] if _n==6
gen ubb=UB[2,1] if _n==2
gen ubc=UB[3,1] if _n==4
gen ubd=UB[4,1] if _n==8
gen ube=UB[5,1] if _n==10
gen ubf=UB[6,1] if _n==12
gen ubg=UB[7,1] if _n==14
gen ubh=UB[8,1] if _n==16
egen quasiupper = rowtotal(uba ubb ubc ubd ube ubf ubg ubh)
replace quasiupper=. if(quasiupper==0)

gen b=(quasilower+quasiupper)/2

gen group=_n if _n==6
replace group=_n if _n==2
replace group=_n if _n==4
replace group=_n if _n==8
replace group=_n if _n==10
replace group=_n if _n==12
replace group=_n if _n==14
replace group=_n if _n==16

label variable group "Class"
label define region 2 "1.1" 4 "1.2" 6 "2" 8 "3" 10 "4" 12 "5" 14 "6" 16 "7"
label value group region

graph twoway scatter b group ///
|| rspike quasiupper quasilower group, vert   /// 
xlabel(2 4 6 8 10 12 14 16, valuelabel alternate )

logit econbin i.obin i.sex i.tenure i.qvnssec

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

gen lla=0 if _n==5
gen llb=A[1,8] if _n==1
gen llc=A[1,9] if _n==3
gen lld=A[1,10] if _n==7
gen lle=A[1,11] if _n==9
gen llf=A[1,12] if _n==11
gen llg=A[1,13] if _n==13
gen llh=A[1,14] if _n==15
egen lowerbound = rowtotal(lla llb llc lld lle llf llg llh)

gen ula=0 if _n==5
gen ulb=A[2,8] if _n==1
gen ulc=A[2,9] if _n==3
gen uld=A[2,10] if _n==7
gen ule=A[2,11] if _n==9
gen ulf=A[2,12] if _n==11
gen ulg=A[2,13] if _n==13
gen ulh=A[2,14] if _n==15
egen upperbound = rowtotal(ula ulb ulc uld ule ulf ulg ulh)

gen beta=(lowerbound+upperbound)/2

gen grouping=_n if _n==5
replace grouping=_n if _n==1
replace grouping=_n if _n==3
replace grouping=_n if _n==7
replace grouping=_n if _n==9
replace grouping=_n if _n==11
replace grouping=_n if _n==13
replace grouping=_n if _n==15
label variable grouping "Class"
label define regions 1 "1.1" 3 "1.2" 5 "2" 7 "3" 9 "4" 11 "5" 13 "6" 15 "7"
label value grouping regions

graph twoway scatter beta grouping ///
|| rspike upperbound lowerbound grouping, vert   /// 
xlabel(1 3 5 7 9 11 13 15, valuelabel alternate )

cd "G:\Stata data and do\Tables and Figures\Tables and Figuers for Chapter One\Finished"

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) legend(label(1 "Log Odds Coefficient")) legend(label(2 "Log Odds Confidence Intervals"))) || rspike upperbound lowerbound grouping, lcolor(black) || (scatter b group, msymbol(Dh) mcolor(red) legend(label(3 "Log Odds Coefficient")) legend(label(4 "Quasi-Variance Bounds"))) || rspike quasiupper quasilower group, lcolor(red) ///
title("Predictions of Staying in Schooling versus Not by Parental NS-SEC", size(msmall) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(msmall) color(black)) ///
note("Data Source: NCDS, N=8,411", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, and Housing Tenure included in Model", size(vsmall) color(black)) ///
xtitle("NS-SEC", size(msmall)) ///
xla(1 3 5 7 9 11 13 15, valuelabel alternate ) name(quasi1, replace)

graph export "logitquasigraph.png", width(6000) replace


*Marginal effects graphs
grstyle clear
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle set color Set1
grstyle yesno draw_major_hgrid yes
grstyle yesno draw_major_ygrid yes
grstyle color major_grid gs8
grstyle linepattern major_grid dot
grstyle set legend 4, box inside
grstyle color ci_area gs12%50

logit econbin i.obin i.sex i.tenure i.nssec

margins nssec, atmeans saving(file1, replace)
marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) title("NS-SEC, Predictive Margins", size(msmall)) xtitle("NS-SEC", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) xlabel(1 "1.1" 2"1.2" 3"2" 4"3" 5"4" 6"5" 7"6" 8"7", labsize(msmall)) name(main1, replace) 

margins, dydx(nssec)
marginsplot, recast(line) plotopts(lcolor(black)) ciopt(color(black%20)) recastci(rarea) title("NS-SEC, AMEs of Continuing Schooling", size(msmall)) xtitle("NS-SEC", size(msmall)) ytitle("Continue Schooling", size(msmall)) xlabel(1 "1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", labsize(msmall)) note("Reference Category NS-SEC 2", size(vsmall)) name(diff1, replace)

graph combine main1 diff1, xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental NS-SEC on Continuing Schooling", size(msmall)) note("Data Source: NCDS, N=8,411", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) ycommon name(comb, replace)

cd"G:\Stata data and do\Tables and Figures\Tables and Figuers for Chapter One\Finished"

graph export "ncdsnssecmargins.png", width(6000) replace


margins obin, atmeans saving(file6, replace)
marginsplot, recast(line) ciopt(color(black%100)) title("Educational Attainment, Predictive Margins", size(msmall)) xtitle("Educational Attainment", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) legend(on order(1 "Educational Attainment")) xlabel(0 "<5" 1 "≥5") note("Data Source: NCDS, N=8,411", size(vsmall)) caption("NS-SEC, Sex, and Housing Tenure also included in Model", size(vsmall)) name(main2, replace) 

graph export "ncdsobinmargins.png", width(6000) replace

margins sex, atmeans saving(file11, replace)
marginsplot, recast(line) ciopt(color(black%100)) title("Sex, Predictive Margins", size(msmall)) xtitle("Sex", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) legend(on order(1 "Sex")) xlabel(0 "Female" 1 "Male") note("Data Source: NCDS, N=8,411", size(vsmall)) caption("Educational Attainment, NS-SEC, and Housing Tenure also included in Model", size(vsmall)) name(main2, replace) 

graph export "ncdssexmargins.png", width(6000) replace

margins tenure, atmeans saving(file16, replace)
marginsplot, recast(line) ciopt(color(black%100)) title("Housing Tenure, Predictive Margins", size(msmall)) xtitle("Housing Tenure", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) legend(on order(1 "Housing Tenure")) xlabel(0 "Own" 1 "Don't") note("Data Source: NCDS, N=8,411", size(vsmall)) caption("Educational Attainment, Sex, and NS-SEC also included in Model", size(vsmall)) name(main2, replace) 

graph export "ncdstenuremargins.png", width(6000) replace


quietly logit econbin i.obin i.sex i.tenure ib(3).nssec

margins, dydx(*) post

est store logitnssecccamarg

etable, append


collect style showbase all

collect label levels etable_depvar 1 "NS-SEC Model" ///
										2 "Margins Model", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: NCDS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("logitregressionchapterone.docx", replace)  

** sens analysis


quietly logit econbin camsis

fitstat
estat ic

logit econbin i.obin i.sex i.tenure camsis

fitstat
estat ic

predict yhatc if e(sample)

ttest yhatc, by(econbin)


logit econbin i.obin i.sex i.tenure camsis

est store logitcamsiscca

etable, append

fitstat

quietly logit econbin i.obin i.sex i.tenure camsis

margins, dydx(*) post

est store logitcamsisccamarg

etable, append


quietly logit econbin ib(2).rgsc

fitstat
estat ic

quietly logit econbin i.obin i.sex i.tenure ib(2).rgsc

fitstat
estat ic

predict yhatR if e(sample)

ttest yhatR, by(econbin)

logit econbin i.obin i.sex i.tenure ib(2).rgsc

est store logitrgsccca

etable, append

fitstat

quietly logit econbin i.obin i.sex i.tenure ib(2).rgsc

margins, dydx(*) post

est store logitrgscccamarg

etable, append




collect style showbase all

collect label levels etable_depvar 1 "NS-SEC Model" ///
										2 "CAMSIS Model" ///
										3 "RGSC Model", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: NCDS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("logitregressionchapterone.docx", replace)  

		
*rgsc quasi graph

grstyle clear
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle set color Set1
grstyle yesno draw_major_hgrid yes
grstyle yesno draw_major_ygrid yes
grstyle color major_grid gs8
grstyle linepattern major_grid dot
grstyle color ci_area gs12%50

gen qvrgsc=.
replace qvrgsc=1 if(rgsc==2)
replace qvrgsc=2 if(rgsc==1)
replace qvrgsc=3 if(rgsc==3)
replace qvrgsc=4 if(rgsc==4)
replace qvrgsc=5 if(rgsc==5)
replace qvrgsc=6 if(rgsc==6)

label define qvrgsc_lbl 1"Managerial and Technical" 2"Professional" 3"Skilled non-manual" 4"Skilled manual" 5"Partly skilled" 6"Unskilled"
label values qvrgsc qvrgsc_lbl


logit econbin i.obin i.sex i.tenure i.qvrgsc

qv i.qvrgsc

matrix define LB = e(qvlb)
matrix list LB

drop lba lbb lbc lbd lbe lbf quasilower

gen lba=LB[1,1] if _n==6
gen lbb=LB[2,1] if _n==2
gen lbc=LB[3,1] if _n==4
gen lbd=LB[4,1] if _n==8
gen lbe=LB[5,1] if _n==10
gen lbf=LB[6,1] if _n==12
egen quasilower = rowtotal(lba lbb lbc lbd lbe lbf)
replace quasilower=. if(quasilower==0)

matrix define UB = e(qvub)
matrix list UB

drop uba ubb ubc ubd ube ubf quasiupper b

gen uba=UB[1,1] if _n==6
gen ubb=UB[2,1] if _n==2
gen ubc=UB[3,1] if _n==4
gen ubd=UB[4,1] if _n==8
gen ube=UB[5,1] if _n==10
gen ubf=UB[6,1] if _n==12
egen quasiupper = rowtotal(uba ubb ubc ubd ube ubf)
replace quasiupper=. if(quasiupper==0)

gen b=(quasilower+quasiupper)/2

drop group

gen group=_n if _n==6
replace group=_n if _n==2
replace group=_n if _n==4
replace group=_n if _n==8
replace group=_n if _n==10
replace group=_n if _n==12

label variable group "Class"
label define regionrc 2 "1" 4 "2" 6 "3NM" 8 "3M" 10 "4" 12 "5" 
label value group regionrc

graph twoway scatter b group ///
|| rspike quasiupper quasilower group, vert   /// 
xlabel(2 4 6 8 10 12, valuelabel alternate )

logit econbin i.obin i.sex i.tenure i.qvrgsc

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

drop lla llb llc lld lle llf lowerbound

gen lla=0 if _n==5
gen llb=A[1,8] if _n==1
gen llc=A[1,9] if _n==3
gen lld=A[1,10] if _n==7
gen lle=A[1,11] if _n==9
gen llf=A[1,12] if _n==11
egen lowerbound = rowtotal(lla llb llc lld lle llf)

drop ula ulb ulc uld ule ulf upperbound beta

gen ula=0 if _n==5
gen ulb=A[2,8] if _n==1
gen ulc=A[2,9] if _n==3
gen uld=A[2,10] if _n==7
gen ule=A[2,11] if _n==9
gen ulf=A[2,12] if _n==11
egen upperbound = rowtotal(ula ulb ulc uld ule ulf)

gen beta=(lowerbound+upperbound)/2

drop grouping 

gen grouping=_n if _n==5
replace grouping=_n if _n==1
replace grouping=_n if _n==3
replace grouping=_n if _n==7
replace grouping=_n if _n==9
replace grouping=_n if _n==11
label variable grouping "Class"
label define regionsrc 1 "1" 3 "2" 5 "3NM" 7 "3M" 9 "4" 11 "5" 
label value grouping regionsrc

graph twoway scatter beta grouping ///
|| rspike upperbound lowerbound grouping, vert   /// 
xlabel(1 3 5 7 9 11, valuelabel alternate )

cd "G:\Stata data and do\Tables and Figures\Tables and Figuers for Chapter One\Finished"

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) legend(label(1 "Log Odds Coefficient")) legend(label(2 "Log Odds Confidence Intervals"))) || rspike upperbound lowerbound grouping, lcolor(black) || (scatter b group, msymbol(Dh) mcolor(red) legend(label(3 "Log Odds Coefficient")) legend(label(4 "Quasi-Variance Bounds"))) || rspike quasiupper quasilower group, lcolor(red) ///
title("Predictions of Staying in Schooling versus Not by Parental RGSC", size(msmall) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(msmall) color(black)) ///
note("Data Source: NCDS, N=8,411", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, and Housing Tenure included in Model", size(vsmall) color(black)) ///
xtitle("RGSC", size(msmall)) ///
xla(1"1" 3"2" 5"3NM" 7"3M" 9"4" 11"5", valuelabel alternate ) name(quasi2, replace)

graph export "logitquasigraphrgsc.png", width(6000) replace

graph combine quasi1 quasi2, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Comaprative Log Odds and Quasi-variance Statistics by Parental Social Class", size(msmall)) note("Data Source: NCDS, N=8,411", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(combquasi, replace)

graph export "ncdscombquasi.png", width(6000) replace


*rgsc margins graph

grstyle clear
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle set color Set1
grstyle yesno draw_major_hgrid yes
grstyle yesno draw_major_ygrid yes
grstyle color major_grid gs8
grstyle linepattern major_grid dot
grstyle set legend 4, box inside
grstyle color ci_area gs12%50

quietly logit econbin i.obin i.sex i.tenure ib(2).rgsc

margins rgsc, atmeans saving(file1a, replace)
marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) title("RGSC, Predictive Margins", size(msmall)) xtitle("RGSC", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) xlabel(1 "1" 2"2" 3"3NM" 4"3M" 5"4" 6"5", labsize(msmall)) name(main1a, replace) 

margins, dydx(rgsc)
marginsplot, recast(line) plotopts(lcolor(black)) ciopt(color(black%20)) recastci(rarea) title("RGSC, AMEs of Continuing Schooling", size(msmall)) xtitle("RGSC", size(msmall)) ytitle("Continue Schooling", size(msmall)) xlabel(1 "1" 2"3NM" 3"3M" 4"4" 5"5", labsize(msmall)) note("Reference Category RGSC 2", size(vsmall)) name(diff1a, replace)

graph combine main1a diff1a, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental RGSC on Continuing Schooling", size(msmall)) note("Data Source: NCDS, N=8,411", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb, replace)

graph export "ncdsRGSCmargins.png", width(6000) replace

*camsis margins graph 

quietly logit econbin i.obin i.sex i.tenure camsis 

margins, at(camsis =(0(1)88)) saving(file1b, replace)
marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) title("CAMSIS, Predictive Margins", size(msmall)) xtitle("CAMSIS", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) name(main1b, replace) 

margins, dydx(camsis) at(camsis =(0(1)88))
marginsplot, recast(line) plotopts(lcolor(black)) ciopt(color(black%20)) recastci(rarea) title("CAMSIS, AMEs of Continuing Schooling", size(msmall)) xtitle("CAMSIS", size(msmall)) ytitle("Continue Schooling", size(msmall)) name(diff1b, replace) 

graph combine main1b diff1b, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental CAMSIS on Continuing Schooling", size(msmall)) note("Data Source: NCDS, N=8,411", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb, replace)

graph export "ncdsCAMSISmargins.png", width(6000) replace


graph combine main1 main1a main1b diff1 diff1a diff1b, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental Social Stratification Measures on Continuing Schooling", size(msmall)) note("Data Source: NCDS, N=8,411", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb, replace)

graph export "ncdssocstratmargins.png", width(6000) replace


* Sensitivity analysis of SOC measures

logit econbin nssec90 
estat ic
fitstat

logit econbin i.obin i.sex i.tenure ib(3).nssec90
estat ic
fitstat

logit econbin i.obin i.sex i.tenure ib(3).nssec90
est store logitnssecb

etable, append 

* qv stats

gen qvnssec90=.
replace qvnssec90=1 if(nssec90==3)
replace qvnssec90=2 if(nssec90==1)
replace qvnssec90=3 if(nssec90==2)
replace qvnssec90=4 if(nssec90==4)
replace qvnssec90=5 if(nssec90==5)
replace qvnssec90=6 if(nssec90==6)
replace qvnssec90=7 if(nssec90==7)
replace qvnssec90=8 if(nssec90==8)


label define qvnssec90_lbl 1"Lower Managerial and professional occupations" 2"Large Employers and higher managerial occupations" 3"Higher professional occupations" 4"Intermediate occupations" 5"Small employers and own account workers" 6"Lower supervisory and technical occupations" 7"Semi-routine occupations" 8"Routine occupations" 
label values qvnssec90 qvnssec90_lbl

*Graph Settings
grstyle clear
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle set color Set1
grstyle yesno draw_major_hgrid yes
grstyle yesno draw_major_ygrid yes
grstyle color major_grid gs8
grstyle linepattern major_grid dot
grstyle color ci_area gs12%50

* graphs
logit econbin i.obin i.sex i.tenure i.qvnssec90

estimates store modellogitab

estimates restore modellogitab

qv i.qvnssec90

matrix define LB = e(qvlb)
matrix list LB

drop lba lbb lbc lbd lbe lbf lbg lbh quasilower
gen lba=LB[1,1] if _n==6
gen lbb=LB[2,1] if _n==2
gen lbc=LB[3,1] if _n==4
gen lbd=LB[4,1] if _n==8
gen lbe=LB[5,1] if _n==10
gen lbf=LB[6,1] if _n==12
gen lbg=LB[7,1] if _n==14
gen lbh=LB[8,1] if _n==16
egen quasilower = rowtotal(lba lbb lbc lbd lbe lbf lbg lbh)
replace quasilower=. if(quasilower==0)

matrix define UB = e(qvub)
matrix list UB

drop uba ubb ubc ubd ube ubf ubg ubh quasiupper b

gen uba=UB[1,1] if _n==6
gen ubb=UB[2,1] if _n==2
gen ubc=UB[3,1] if _n==4
gen ubd=UB[4,1] if _n==8
gen ube=UB[5,1] if _n==10
gen ubf=UB[6,1] if _n==12
gen ubg=UB[7,1] if _n==14
gen ubh=UB[8,1] if _n==16
egen quasiupper = rowtotal(uba ubb ubc ubd ube ubf ubg ubh)
replace quasiupper=. if(quasiupper==0)

gen b=(quasilower+quasiupper)/2

drop group 
gen group=_n if _n==6
replace group=_n if _n==2
replace group=_n if _n==4
replace group=_n if _n==8
replace group=_n if _n==10
replace group=_n if _n==12
replace group=_n if _n==14
replace group=_n if _n==16

label variable group "Class"
label define regionb 2 "1.1" 4 "1.2" 6 "2" 8 "3" 10 "4" 12 "5" 14 "6" 16 "7"
label value group regionb

graph twoway scatter b group ///
|| rspike quasiupper quasilower group, vert   /// 
xlabel(2 4 6 8 10 12 14 16, valuelabel alternate )

logit econbin i.obin i.sex i.tenure i.qvnssec90

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

drop lla llb llc lld lle llf llg llh lowerbound
gen lla=0 if _n==5
gen llb=A[1,8] if _n==1
gen llc=A[1,9] if _n==3
gen lld=A[1,10] if _n==7
gen lle=A[1,11] if _n==9
gen llf=A[1,12] if _n==11
gen llg=A[1,13] if _n==13
gen llh=A[1,14] if _n==15
egen lowerbound = rowtotal(lla llb llc lld lle llf llg llh)

drop ula ulb ulc uld ule ulf ulg ulh upperbound beta
gen ula=0 if _n==5
gen ulb=A[2,8] if _n==1
gen ulc=A[2,9] if _n==3
gen uld=A[2,10] if _n==7
gen ule=A[2,11] if _n==9
gen ulf=A[2,12] if _n==11
gen ulg=A[2,13] if _n==13
gen ulh=A[2,14] if _n==15
egen upperbound = rowtotal(ula ulb ulc uld ule ulf ulg ulh)

gen beta=(lowerbound+upperbound)/2

drop grouping 
gen grouping=_n if _n==5
replace grouping=_n if _n==1
replace grouping=_n if _n==3
replace grouping=_n if _n==7
replace grouping=_n if _n==9
replace grouping=_n if _n==11
replace grouping=_n if _n==13
replace grouping=_n if _n==15
label variable grouping "Class"
label define regionsb 1 "1.1" 3 "1.2" 5 "2" 7 "3" 9 "4" 11 "5" 13 "6" 15 "7"
label value grouping regionsb

graph twoway scatter beta grouping ///
|| rspike upperbound lowerbound grouping, vert   /// 
xlabel(1 3 5 7 9 11 13 15, valuelabel alternate )

cd "G:\Stata data and do\Tables and Figures\Tables and Figuers for Chapter One\Finished"

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) legend(label(1 "Log Odds Coefficient")) legend(label(2 "Log Odds Confidence Intervals"))) || rspike upperbound lowerbound grouping, lcolor(black) || (scatter b group, msymbol(Dh) mcolor(red) legend(label(3 "Log Odds Coefficient")) legend(label(4 "Quasi-Variance Bounds"))) || rspike quasiupper quasilower group, lcolor(red) ///
title("Predictions of Staying in Schooling versus Not by Parental NS-SEC (SOC90)", size(msmall) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(msmall) color(black)) ///
note("Data Source: NCDS, N=8,411", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, and Housing Tenure included in Model", size(vsmall) color(black)) ///
xtitle("NS-SEC", size(msmall)) ///
xla(1 3 5 7 9 11 13 15, valuelabel alternate ) name(quasi1b, replace)

graph export "logitquasibgraph.png", width(6000) replace


graph combine quasi1 quasi1b, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Comaprative Log Odds and Quasi-variance Statistics by SOC construction of Parental NS-SEC", size(msmall)) note("Data Source: NCDS, N=8,411", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(combquasi, replace)

graph export "logitquasibcombgraph.png", width(6000) replace



logit econbin i.obin i.sex i.tenure ib(3).nssec90
estat ic
fitstat
predict yhatn9 if e(sample)

ttest yhatn9, by(econbin)

est store logitnssecb
etable, append 

logit econbin i.obin i.sex i.tenure ib(3).nssec90
margins, dydx(*) post
est store logitnssecbmargins
etable, append 


collect style showbase all

collect label levels etable_depvar 1 "NS-SEC 2000 Model" ///
										2 "NS-SEC 90 Model" /// 
										3 "NS-SEC 90 MARGINS", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: NCDS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("logitregressionchapteroneb.docx", replace)  
		
		
logit econbin i.obin i.sex i.tenure ib(2).rgsc90

estat ic
fitstat
predict yhatn9b if e(sample)

ttest yhatn9b, by(econbin)
est store logitnssecba
etable, append 

logit econbin i.obin i.sex i.tenure ib(2).rgsc90
margins, dydx(*) post
est store logitnssecbmarginsa
etable, append 

*rgsc90 graph
*rgsc quasi graph

grstyle clear
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle set color Set1
grstyle yesno draw_major_hgrid yes
grstyle yesno draw_major_ygrid yes
grstyle color major_grid gs8
grstyle linepattern major_grid dot
grstyle color ci_area gs12%50

gen qvrgsc90=.
replace qvrgsc90=1 if(rgsc90==2)
replace qvrgsc90=2 if(rgsc90==1)
replace qvrgsc90=3 if(rgsc90==3)
replace qvrgsc90=4 if(rgsc90==4)
replace qvrgsc90=5 if(rgsc90==5)
replace qvrgsc90=6 if(rgsc90==6)

label define qvrgsc90_lbl 1"Managerial and Technical" 2"Professional" 3"Skilled non-manual" 4"Skilled manual" 5"Partly skilled" 6"Unskilled"
label values qvrgsc90 qvrgsc90_lbl


logit econbin i.obin i.sex i.tenure i.qvrgsc90

qv i.qvrgsc90

matrix define LB = e(qvlb)
matrix list LB

drop lba lbb lbc lbd lbe lbf quasilower

gen lba=LB[1,1] if _n==6
gen lbb=LB[2,1] if _n==2
gen lbc=LB[3,1] if _n==4
gen lbd=LB[4,1] if _n==8
gen lbe=LB[5,1] if _n==10
gen lbf=LB[6,1] if _n==12
egen quasilower = rowtotal(lba lbb lbc lbd lbe lbf)
replace quasilower=. if(quasilower==0)

matrix define UB = e(qvub)
matrix list UB

drop uba ubb ubc ubd ube ubf quasiupper b

gen uba=UB[1,1] if _n==6
gen ubb=UB[2,1] if _n==2
gen ubc=UB[3,1] if _n==4
gen ubd=UB[4,1] if _n==8
gen ube=UB[5,1] if _n==10
gen ubf=UB[6,1] if _n==12
egen quasiupper = rowtotal(uba ubb ubc ubd ube ubf)
replace quasiupper=. if(quasiupper==0)

gen b=(quasilower+quasiupper)/2

drop group

gen group=_n if _n==6
replace group=_n if _n==2
replace group=_n if _n==4
replace group=_n if _n==8
replace group=_n if _n==10
replace group=_n if _n==12

label variable group "Class"
label define regionrac 2 "1" 4 "2" 6 "3NM" 8 "3M" 10 "4" 12 "5" 
label value group regionrc

graph twoway scatter b group ///
|| rspike quasiupper quasilower group, vert   /// 
xlabel(2 4 6 8 10 12, valuelabel alternate )

logit econbin i.obin i.sex i.tenure i.qvrgsc90

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

drop lla llb llc lld lle llf lowerbound

gen lla=0 if _n==5
gen llb=A[1,8] if _n==1
gen llc=A[1,9] if _n==3
gen lld=A[1,10] if _n==7
gen lle=A[1,11] if _n==9
gen llf=A[1,12] if _n==11
egen lowerbound = rowtotal(lla llb llc lld lle llf)

drop ula ulb ulc uld ule ulf upperbound beta

gen ula=0 if _n==5
gen ulb=A[2,8] if _n==1
gen ulc=A[2,9] if _n==3
gen uld=A[2,10] if _n==7
gen ule=A[2,11] if _n==9
gen ulf=A[2,12] if _n==11
egen upperbound = rowtotal(ula ulb ulc uld ule ulf)

gen beta=(lowerbound+upperbound)/2

drop grouping 

gen grouping=_n if _n==5
replace grouping=_n if _n==1
replace grouping=_n if _n==3
replace grouping=_n if _n==7
replace grouping=_n if _n==9
replace grouping=_n if _n==11
label variable grouping "Class"
label define regionsrac 1 "1" 3 "2" 5 "3NM" 7 "3M" 9 "4" 11 "5" 
label value grouping regionsrc

graph twoway scatter beta grouping ///
|| rspike upperbound lowerbound grouping, vert   /// 
xlabel(1 3 5 7 9 11, valuelabel alternate )

cd "G:\Stata data and do\Tables and Figures\Tables and Figuers for Chapter One\Finished"

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) legend(label(1 "Log Odds Coefficient")) legend(label(2 "Log Odds Confidence Intervals"))) || rspike upperbound lowerbound grouping, lcolor(black) || (scatter b group, msymbol(Dh) mcolor(red) legend(label(3 "Log Odds Coefficient")) legend(label(4 "Quasi-Variance Bounds"))) || rspike quasiupper quasilower group, lcolor(red) ///
title("Predictions of Staying in Schooling versus Not by Parental RGSC (SOC 90)", size(msmall) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(msmall) color(black)) ///
note("Data Source: NCDS, N=8,411", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, and Housing Tenure included in Model", size(vsmall) color(black)) ///
xtitle("RGSC", size(msmall)) ///
xla(1"1" 3"2" 5"3NM" 7"3M" 9"4" 11"5", valuelabel alternate ) name(quasi2b, replace)

graph export "logitquasigraphrgsc90.png", width(6000) replace


graph combine quasi2 quasi2b, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Comaprative Log Odds and Quasi-variance Statistics by SOC construction of Parental RGSC", size(msmall)) note("Data Source: NCDS, N=8,411", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(combquasi2, replace)

graph export "logitquasigraphrgsccomb.png", width(6000) replace


*camsis 

logit econbin i.obin i.sex i.tenure cam90
estat ic 
fitstat 
predict yhatn9bc if e(sample)

ttest yhatn9bc, by(econbin)

est store logitnssecbaa
etable, append 

logit econbin i.obin i.sex i.tenure cam90
margins, dydx(*) post
est store logitnssecbmarginsaa
etable, append 


collect style showbase all

collect label levels etable_depvar 1 "NS-SEC 2000 Model" ///
										2 "NS-SEC 90 Model" /// 
										3 "NS-SEC 90 MARGINS" ///
										4 "rgsc90" ///
										5 "rgsc90 margins" ///
										6 "cam90" ///
										7 "cam90 margins", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: NCDS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("logitregressionchapteroneba.docx", replace)  


* margins graphs for soc90 
grstyle clear
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle set color Set1
grstyle yesno draw_major_hgrid yes
grstyle yesno draw_major_ygrid yes
grstyle color major_grid gs8
grstyle linepattern major_grid dot
grstyle set legend 4, box inside
grstyle color ci_area gs12%50

logit econbin i.obin i.sex i.tenure i.nssec90
margins nssec90, atmeans saving(file190, replace) post

marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) title("NS-SEC, Predictive Margins", size(msmall)) xtitle("NS-SEC (SOC90)", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) xlabel(1 "1.1" 2"1.2" 3"2" 4"3" 5"4" 6"5" 7"6" 8"7", labsize(msmall)) name(main190, replace) 

logit econbin i.obin i.sex i.tenure i.nssec90
margins, dydx(nssec90)
marginsplot, recast(line) plotopts(lcolor(black)) ciopt(color(black%20)) recastci(rarea) title("NS-SEC, AMEs of Continuing Schooling", size(msmall)) xtitle("NS-SEC (SOC 90)", size(msmall)) ytitle("Continue Schooling", size(msmall)) xlabel(1 "1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", labsize(msmall)) note("Reference Category NS-SEC 2", size(vsmall)) name(diff190, replace)

graph combine main1 main190 diff1 diff190, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental NS-SEC on Continuing Schooling by SOC Codes", size(msmall)) note("Data Source: NCDS, N=8,411, SOC 2000 on left, SOC 90 on right", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb1a, replace)

cd"G:\Stata data and do\Tables and Figures\Tables and Figuers for Chapter One\Finished"

graph export "ncdsnssecmarginscomb.png", width(6000) replace



quietly logit econbin i.obin i.sex i.tenure ib(2).rgsc90

margins rgsc90, atmeans saving(file1a, replace)
marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) title("RGSC, Predictive Margins", size(msmall)) xtitle("RGSC (S0C 90)", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) xlabel(1 "1" 2"2" 3"3NM" 4"3M" 5"4" 6"5", labsize(msmall)) name(main1ab, replace) 

quietly logit econbin i.obin i.sex i.tenure ib(2).rgsc90
margins, dydx(rgsc90)
marginsplot, recast(line) plotopts(lcolor(black)) ciopt(color(black%20)) recastci(rarea) title("RGSC, AMEs of Continuing Schooling", size(msmall)) xtitle("RGSC (SOC 90)", size(msmall)) ytitle("Continue Schooling", size(msmall)) xlabel(1 "1" 2"3NM" 3"3M" 4"4" 5"5", labsize(msmall)) note("Reference Category RGSC 2", size(vsmall)) name(diff1ab, replace)

graph combine main1a main1ab diff1a diff1ab, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental RGSC on Continuing Schooling by SOC Codes", size(msmall)) note("Data Source: NCDS, N=8,411, SOC 2000 on left, SOC 90 on right", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb2a, replace)

graph export "ncdsRGSCmarginscomb.png", width(6000) replace

*camsis margins graph 

quietly logit econbin i.obin i.sex i.tenure cam90 

margins, at(cam90 =(0(1)88)) saving(file1b, replace)
marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) title("CAMSIS, Predictive Margins", size(msmall)) xtitle("CAMSIS (SOC 90)", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) name(main1bb, replace) 

quietly logit econbin i.obin i.sex i.tenure cam90 
margins, dydx(cam90) at(cam90 =(0(1)88))
marginsplot, recast(line) plotopts(lcolor(black)) ciopt(color(black%20)) recastci(rarea) title("CAMSIS, AMEs of Continuing Schooling", size(msmall)) xtitle("CAMSIS (SOC 90)", size(msmall)) ytitle("Continue Schooling", size(msmall)) name(diff1bb, replace) 

graph combine main1b main1bb diff1b diff1bb, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental CAMSIS on Continuing Schooling by SOC Codes", size(msmall)) note("Data Source: NCDS, N=8,411, SOC 2000 on left, SOC 90 on right", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb3a, replace)

graph export "ncdsCAMSISmarginscomb.png", width(6000) replace


graph combine main190 main1ab main1bb diff190 diff1ab diff1bb, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Social Stratification Measures on Continuing Schooling by SOC 90", size(msmall)) note("Data Source: NCDS, N=8,411", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb4a, replace)

graph export "ncdscombmarginscomb90.png", width(6000) replace


graph combine comb comb4a, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Social Stratification Measures on Continuing Schooling by SOC 90", size(msmall)) note("Data Source: NCDS, N=8,411", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb3a, replace)


* Missing Data, Simulation followed by real data then FIN and move to BCS* 

cd "G:\Stata data and do\Tables and Figures\Tables and Figuers for Chapter One"

save ncdslogit, replace

use "G:\Stata data and do\Tables and Figures\Tables and Figuers for Chapter One\ncds4_recoded"


drop if missing(n4118)

misstable summarize econbin obin sex tenure nssec 

misstable patterns econbin obin sex tenure nssec

logit econbin i.obin i.sex i.tenure ib(3).nssec 

gen cc= e(sample)

foreach var in econbin obin sex tenure nssec {
	tab `var' cc, col
}

tab n0region

gen acatnn0region = n0region
replace acatnn0region=. if (acatnn0region==-2)
replace acatnn0region=0 if (acatnn0region==1)
replace acatnn0region=1 if (acatnn0region==2)
replace acatnn0region=1 if (acatnn0region==3)
replace acatnn0region=1 if (acatnn0region==4)
replace acatnn0region=1 if (acatnn0region==5)
replace acatnn0region=1 if (acatnn0region==6)
replace acatnn0region=1 if (acatnn0region==7)
replace acatnn0region=1 if (acatnn0region==8)
replace acatnn0region=1 if (acatnn0region==9)
replace acatnn0region=1 if (acatnn0region==10)
replace acatnn0region=1 if (acatnn0region==11)

tab acatnn0region 

tab n99

gen bconnn99 = n99
replace bconnn99=. if (bconnn99==-1)
replace bconnn99=0 if (bconnn99==1)
replace bconnn99=1 if (bconnn99==2)
replace bconnn99=1 if (bconnn99==3)
replace bconnn99=1 if (bconnn99==4)
replace bconnn99=1 if (bconnn99==5)
replace bconnn99=1 if (bconnn99==6)
replace bconnn99=1 if (bconnn99==7)
replace bconnn99=1 if (bconnn99==8)
replace bconnn99=1 if (bconnn99==9)
replace bconnn99=1 if (bconnn99==10)
replace bconnn99=1 if (bconnn99==11)
replace bconnn99=1 if (bconnn99==12)
replace bconnn99=1 if (bconnn99==13)
replace bconnn99=1 if (bconnn99==14)

tab bconnn99

tab n197

gen maw5 = n197
replace maw5=. if (maw5==-1)
replace maw5=0 if (maw5==1)
replace maw5=1 if (maw5==2)
replace maw5=1 if (maw5==3)
replace maw5=1 if (maw5==4)

tab maw5

tab n512

gen aconnn512 = n512
replace aconnn512=. if (aconnn512==-1)
replace aconnn512=0 if (aconnn512==1)
replace aconnn512=1 if (aconnn512==2)
replace aconnn512=1 if (aconnn512==3)
replace aconnn512=1 if (aconnn512==4)
replace aconnn512=1 if (aconnn512==5)
replace aconnn512=1 if (aconnn512==6)

tab aconnn512

tab n236

gen acatnn236 = n236
replace acatnn236=. if (n236==-1)

tab acatnn236

tab n95

gen bcatnn95 = n95
replace bcatnn95=. if (bcatnn95==-1)
replace bcatnn95=0 if (bcatnn95==1)
replace bcatnn95=0 if (bcatnn95==2)
replace bcatnn95=0 if (bcatnn95==3)
replace bcatnn95=0 if (bcatnn95==4)
replace bcatnn95=1 if (bcatnn95==5)
replace bcatnn95=1 if (bcatnn95==6)
replace bcatnn95=1 if (bcatnn95==7)
replace bcatnn95=1 if (bcatnn95==8)
replace bcatnn95=1 if (bcatnn95==9)
replace bcatnn95=1 if (bcatnn95==10)
replace bcatnn95=1 if (bcatnn95==11)
replace bcatnn95=1 if (bcatnn95==12)
replace bcatnn95=1 if (bcatnn95==13)
replace bcatnn95=1 if (bcatnn95==14)
replace bcatnn95=1 if (bcatnn95==15)
replace bcatnn95=1 if (bcatnn95==16)
replace bcatnn95=1 if (bcatnn95==17)
replace bcatnn95=1 if (bcatnn95==18)
replace bcatnn95=1 if (bcatnn95==19)
replace bcatnn95=1 if (bcatnn95==20)
replace bcatnn95=1 if (bcatnn95==21)
replace bcatnn95=1 if (bcatnn95==22)

tab bcatnn95

tab n180

gen DadNeverReads = n180
replace DadNeverReads=. if (DadNeverReads==-1)
replace DadNeverReads=0 if (DadNeverReads==1)
replace DadNeverReads=1 if (DadNeverReads==2)
replace DadNeverReads=1 if (DadNeverReads==3)
replace DadNeverReads=1 if (DadNeverReads==4)

tab DadNeverReads

tab n1434

gen ccatnn1434 = n1434
replace ccatnn1434=. if (ccatnn1434==-1)
replace ccatnn1434=0 if (ccatnn1434==1)
replace ccatnn1434=1 if (ccatnn1434==2)
replace ccatnn1434=1 if (ccatnn1434==3)
replace ccatnn1434=1 if (ccatnn1434==4)
replace ccatnn1434=1 if (ccatnn1434==5)
replace ccatnn1434=1 if (ccatnn1434==6)
replace ccatnn1434=1 if (ccatnn1434==7)
replace ccatnn1434=1 if (ccatnn1434==8)
replace ccatnn1434=1 if (ccatnn1434==9)

tab ccatnn1434

tab n1150

gen ccatnn1150 = n1150
replace ccatnn1150=. if (ccatnn1150==-1)
replace ccatnn1150=0 if (ccatnn1150==1)
replace ccatnn1150=0 if (ccatnn1150==2)
replace ccatnn1150=0 if (ccatnn1150==3)
replace ccatnn1150=1 if (ccatnn1150==4)
replace ccatnn1150=1 if (ccatnn1150==5)
replace ccatnn1150=1 if (ccatnn1150==6)
replace ccatnn1150=1 if (ccatnn1150==7)
replace ccatnn1150=1 if (ccatnn1150==8)
replace ccatnn1150=1 if (ccatnn1150==9)

tab ccatnn1150

pca n914 n917
gen genability11= e(sample)

tab genability11

tab n204

gen toilet = n204
replace toilet=. if (toilet==-1)
replace toilet=. if (toilet==1)
replace toilet=0 if (toilet==2)
replace toilet=1 if (toilet==3)
replace toilet=1 if (toilet==4)

tab toilet

gen itoilet = n205
replace itoilet=. if (itoilet==-1)
replace itoilet=. if (itoilet==1)
replace itoilet=0 if (itoilet==2)
replace itoilet=1 if (itoilet==3)
replace itoilet=1 if (itoilet==4)

tab itoilet

gen otoilet = n206
replace otoilet=. if (otoilet==-1)
replace otoilet=. if (otoilet==1)
replace otoilet=0 if (otoilet==2)
replace otoilet=1 if (otoilet==3)
replace otoilet=1 if (otoilet==4)

tab otoilet

gen cooking = n207
replace cooking=. if (cooking==-1)
replace cooking=. if (cooking==1)
replace cooking=0 if (cooking==2)
replace cooking=1 if (cooking==3)
replace cooking=1 if (cooking==4)

tab cooking

gen water = n208
replace water=. if (water==-1)
replace water=. if (water==1)
replace water=0 if (water==2)
replace water=1 if (water==3)
replace water=1 if (water==4)

tab water

gen garden = n209
replace garden=. if (garden==-1)
replace garden=. if (garden==1)
replace garden=0 if (garden==2)
replace garden=1 if (garden==3)
replace garden=1 if (garden==4)

tab garden

tab n2492

gen dconnn2492 = n2492
replace dconnn2492=. if (dconnn2492==-1)
replace dconnn2492=0 if (dconnn2492==0)
replace dconnn2492=1 if (dconnn2492==1)
replace dconnn2492=1 if (dconnn2492==2)
replace dconnn2492=1 if (dconnn2492==3)
replace dconnn2492=1 if (dconnn2492==4)
replace dconnn2492=1 if (dconnn2492==5)
replace dconnn2492=1 if (dconnn2492==6)
replace dconnn2492=1 if (dconnn2492==7)
replace dconnn2492=1 if (dconnn2492==8)
replace dconnn2492=1 if (dconnn2492==9)

tab dconnn2492

tab n2825

gen dconnage16dv46 = n2825
replace dconnage16dv46=. if(dconnage16dv46==-1)
replace dconnage16dv46=0 if(dconnage16dv46==1)
replace dconnage16dv46=1 if(dconnage16dv46==2)
replace dconnage16dv46=1 if(dconnage16dv46==3)
replace dconnage16dv46=1 if(dconnage16dv46==4)
replace dconnage16dv46=1 if(dconnage16dv46==5)
replace dconnage16dv46=1 if(dconnage16dv46==6)

tab dconnage16dv46

		
foreach var in acatnn0region bconnn99 maw5 aconnn512 acatnn236 bcatnn95 DadNeverReads ccatnn1434 ccatnn1150 genability11 toilet itoilet otoilet cooking water garden dconnn2492 dconnage16dv46{
	regress econ201 `var'
	testparm `var'
}	
		

mi set wide

mi register imputed econbin obin sex tenure nssec maw5 aconnn512 genability11 toilet itoilet cooking water dconnn2492
tab _mi_miss

mi impute chained ///
///
(logit, augment) obin sex tenure maw5 aconnn512 genability11 toilet itoilet cooking water dconnn2492 econbin ///
///
(mlogit, augment) nssec ///
///
, rseed(12346) dots force add(50) burnin(20) savetrace(MI_test_trace, replace)
		
		
mi estimate, post dots: logit econbin i.obin i.sex i.tenure ib(3).nssec

est store imputed

etable

estat ic
fitstat
		
mimrgns, dydx(*) predict(pr) 


collect style showbase all

collect label levels etable_depvar 1 "imp" ///
								   2 "margins", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Imputation Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: NCDS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("impute.docx", replace)  
		
		
		
mi estimate, post vartable nocitable 

mi estimate, post dftable nocitable 
		
		
save ncds_mi, replace

use "G:\Stata data and do\NCDS\NCDS Sweep 23\stata\stata9\MI_test_trace"

cd "G:\Stata data and do\Tables and Figures\Tables and Figuers for Chapter One"

tsline econ201_mean*, name(mice1,replace)legend(off) ytitle("Mean of Economic Activity")
tsline econ201_sd*, name(mice2, replace) legend(off) ytitle("SD of Economic Activity")
graph combine mice1 mice2, xcommon cols(1) title(Trace plots of summaries of imputed values)
graph save "miecon201l.gph", replace
graph export "miecon201l.png", width(6000) replace


tsline obin_mean*, name(mice3,replace)legend(off) ytitle("Mean of Educational Attainment")
tsline obin_sd*, name(mice4, replace) legend(off) ytitle("SD of Educational Attainment")
graph combine mice3 mice4, xcommon cols(1) title(Trace plots of summaries of imputed values)
graph save "miedl.gph", replace
graph export "miedl.png", width(6000) replace

tsline tenure_mean*, name(mice7,replace)legend(off) ytitle("Mean of Housing Tenure")
tsline tenure_sd*, name(mice8, replace) legend(off) ytitle("SD of Housing Tenure")
graph combine mice7 mice8, xcommon cols(1) title(Trace plots of summaries of imputed values)
graph save "mitenurel.gph", replace
graph export "mitenurel.png", width(6000) replace

tsline nssec_mean*, name(mice9,replace)legend(off) ytitle("Mean of NS-SEC")
tsline nssec_sd*, name(mice10, replace) legend(off) ytitle("SD of NS-SEC")
graph combine mice9 mice10, xcommon cols(1) title(Trace plots of summaries of imputed values)
graph save "minssecl.gph", replace
graph export "minssecl.png", width(6000) replace

save MI_test_trace, replace 



* Create ID variable 

use"G:\Stata data and do\Tables and Figures\Tables and Figuers for Chapter One\ncdslogit"

egen id = seq(), from(1)


cd"G:\Stata data and do\merging"

save ncds4_cca, replace

*** BCS

cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two"

use "G:\Stata data and do\BCS\BCS Sample Survey 21\stata\stata11\bcs21yearsample"

codebook va86sep

tab va86sep

collect export "raw.docx", replace

gen econ201=.
replace econ201=1 if(va86sep==5)
replace econ201=1 if(va86sep==6)
replace econ201=1 if(va86sep==7)

replace econ201=2 if(va86sep==4)

replace econ201=3 if(va86sep==3)

replace econ201=4 if(va86sep==1)
replace econ201=4 if(va86sep==2)

label define econ201_lbl 1"Employment" 2"Education" 3"Training & Apprenticeships" 4"Unemployment & OLF"
label values econ201 econ201_lbl

tab econ201

gen econbin = .
replace econbin=1 if (econ201==2)
replace econbin=0 if (econ201==1)
replace econbin=0 if (econ201==3)
replace econbin=0 if (econ201==4)

label define econbin_lbl 1"Continuing Schooling" 0"Not Continuing Schooling"
label values econbin econbin_lbl

gen female=.
replace female=0 if(sex==2)
replace female=1 if(sex==1)

label define female_lbl 0"Female" 1"Male"
label values female female_lbl

gen crecords=bcsid

tab crecords

cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two"
save subsample_test, replace

use "G:\Stata data and do\NCDS\Occupation Codes\UKDA-7023-stata9\stata9\bcs3_occupation_coding_father"

gen nssecf=. 
replace nssecf=1 if (B3FSNSSEC==2)

replace nssecf=2 if (B3FSNSSEC==3.1)
replace nssecf=2 if (B3FSNSSEC==3.2)
replace nssecf=2 if (B3FSNSSEC==3.3)

replace nssecf=3 if (B3FSNSSEC==4.1)
replace nssecf=3 if (B3FSNSSEC==4.2)
replace nssecf=3 if (B3FSNSSEC==4.3)
replace nssecf=3 if (B3FSNSSEC==5)

replace nssecf=4 if (B3FSNSSEC==7.1)
replace nssecf=4 if (B3FSNSSEC==7.2)
replace nssecf=4 if (B3FSNSSEC==7.3)
replace nssecf=4 if (B3FSNSSEC==7.4)

replace nssecf=5 if (B3FSNSSEC==8.1)
replace nssecf=5 if (B3FSNSSEC==9.1)
replace nssecf=5 if (B3FSNSSEC==9.2)

replace nssecf=6 if (B3FSNSSEC==10)
replace nssecf=6 if (B3FSNSSEC==11.1)
replace nssecf=6 if (B3FSNSSEC==11.2)

replace nssecf=7 if (B3FSNSSEC==12.1)
replace nssecf=7 if (B3FSNSSEC==12.2)
replace nssecf=7 if (B3FSNSSEC==12.3)
replace nssecf=7 if (B3FSNSSEC==12.4)
replace nssecf=7 if (B3FSNSSEC==12.5)
replace nssecf=7 if (B3FSNSSEC==12.6)
replace nssecf=7 if (B3FSNSSEC==12.7)

replace nssecf=8 if (B3FSNSSEC==13.1)
replace nssecf=8 if (B3FSNSSEC==13.2)
replace nssecf=8 if (B3FSNSSEC==13.3)
replace nssecf=8 if (B3FSNSSEC==13.4)
replace nssecf=8 if (B3FSNSSEC==13.5)

label define nssec_lbl 1"Large Employers and higher managerial occupations" 2"Higher professional occupations" 3"Lower Managerial and professional occupations" 4"Intermediate occupations" 5"Small employers and own account workers" 6"Lower supervisory and technical occupations" 7"Semi-routine occupations" 8"Routine occupations"
label value nssecf nssec_lbl

tab nssecf

rename nssecf nssecf2000

destring B3FSSOCC, gen(soc2000) force

gen camsisf=.
replace camsisf=85.6 if soc2000==1111
replace camsisf=71.5 if soc2000==1112
replace camsisf=70.7 if soc2000==1113
replace camsisf=71.01 if soc2000==1114
replace camsisf=57.77 if soc2000==1121
replace camsisf=58.07 if soc2000==1122
replace camsisf=64.88 if soc2000==1123
replace camsisf=71.15 if soc2000==1131
replace camsisf=64.1 if soc2000==1132
replace camsisf=60.97 if soc2000==1133
replace camsisf=70.66 if soc2000==1134
replace camsisf=70.17 if soc2000==1135
replace camsisf=69.58 if soc2000==1136
replace camsisf=69.72 if soc2000==1137
replace camsisf=63.06 if soc2000==1141
replace camsisf=63.65 if soc2000==1142
replace camsisf=64.88 if soc2000==1151
replace camsisf=64 if soc2000==1152
replace camsisf=55.11 if soc2000==1161
replace camsisf=49.1 if soc2000==1162
replace camsisf=58.68 if soc2000==1163
replace camsisf=77 if soc2000==1171
replace camsisf=60 if soc2000==1172
replace camsisf=68.12 if soc2000==1173
replace camsisf=59.66 if soc2000==1174
replace camsisf=61.96 if soc2000==1181
replace camsisf=72.42 if soc2000==1182
replace camsisf=60.69 if soc2000==1185
replace camsisf=55.4 if soc2000==1211
replace camsisf=58.65 if soc2000==1212
replace camsisf=52.26 if soc2000==1219
replace camsisf=56.5 if soc2000==1221
replace camsisf=54 if soc2000==1223
replace camsisf=50.52 if soc2000==1224
replace camsisf=58.94 if soc2000==1225
replace camsisf=73.2 if soc2000==1226
replace camsisf=67.24 if soc2000==1231
replace camsisf=57.5 if soc2000==1232
replace camsisf=56.9 if soc2000==1233
replace camsisf=57.71 if soc2000==1234
replace camsisf=51.48 if soc2000==1235
replace camsisf=60.16 if soc2000==1239

replace camsisf=73.4 if soc2000==2111
replace camsisf=74.5 if soc2000==2112
replace camsisf=84.22 if soc2000==2113
replace camsisf=65.88 if soc2000==2121
replace camsisf=67.83 if soc2000==2122
replace camsisf=67.54 if soc2000==2123
replace camsisf=67.17 if soc2000==2124
replace camsisf=80.3 if soc2000==2125
replace camsisf=65.54 if soc2000==2126
replace camsisf=55.49 if soc2000==2127
replace camsisf=60.06 if soc2000==2128
replace camsisf=64.84 if soc2000==2129
replace camsisf=78.81 if soc2000==2131
replace camsisf=76.18 if soc2000==2132
replace camsisf=87.4 if soc2000==2211
replace camsisf=94 if soc2000==2212
replace camsisf=73.7 if soc2000==2213
replace camsisf=80.2 if soc2000==2214
replace camsisf=83.7 if soc2000==2215
replace camsisf=79.6 if soc2000==2216
replace camsisf=81.39 if soc2000==2311
replace camsisf=63.8 if soc2000==2312
replace camsisf=79.9 if soc2000==2313
replace camsisf=70.9 if soc2000==2314
replace camsisf=65.5 if soc2000==2315
replace camsisf=65.8 if soc2000==2316
replace camsisf=79.65 if soc2000==2317
replace camsisf=65.53 if soc2000==2319
replace camsisf=77.94 if soc2000==2321
replace camsisf=73.53 if soc2000==2322
replace camsisf=67.09 if soc2000==2329
replace camsisf=84.82 if soc2000==2411
replace camsisf=85.06 if soc2000==2419
replace camsisf=72.5 if soc2000==2421
replace camsisf=68 if soc2000==2422
replace camsisf=76.98 if soc2000==2423
replace camsisf=79.6 if soc2000==2424
replace camsisf=79.6 if soc2000==2431
replace camsisf=86.3 if soc2000==2432
replace camsisf=69.7 if soc2000==2433
replace camsisf=67.24 if soc2000==2434
replace camsisf=69.53 if soc2000==2441
replace camsisf=73.6 if soc2000==2442
replace camsisf=73.6 if soc2000==2443
replace camsisf=82.2 if soc2000==2444
replace camsisf=72.24 if soc2000==2451
replace camsisf=76.5 if soc2000==2452


replace camsisf=60.96 if soc2000==3111
replace camsisf=49.17 if soc2000==3112
replace camsisf=50.98 if soc2000==3113
replace camsisf=57.52 if soc2000==3114
replace camsisf=54.25 if soc2000==3115
replace camsisf=52.42 if soc2000==3119
replace camsisf=67.4 if soc2000==3121

replace camsisf=58.84 if soc2000==3122
replace camsisf=61.54 if soc2000==3123
replace camsisf=68.81 if soc2000==3131
replace camsisf=52.4 if soc2000==3211
replace camsisf=66.3 if soc2000==3214
replace camsisf=66.9 if soc2000==3215
replace camsisf=66.3 if soc2000==3216
replace camsisf=46.7 if soc2000==3217
replace camsisf=49.02 if soc2000==3218
replace camsisf=66.1 if soc2000==3221
replace camsisf=61.94 if soc2000==3229
replace camsisf=62.72 if soc2000==3231
replace camsisf=63.49 if soc2000==3232
replace camsisf=45.1 if soc2000==3311
replace camsisf=56.77 if soc2000==3312
replace camsisf=52.7 if soc2000==3313
replace camsisf=48.6 if soc2000==3314
replace camsisf=63.94 if soc2000==3319
replace camsisf=71.9 if soc2000==3411
replace camsisf=75.03 if soc2000==3412
replace camsisf=68.68 if soc2000==3413
replace camsisf=71.56 if soc2000==3415
replace camsisf=70.24 if soc2000==3416
replace camsisf=67.77 if soc2000==3421
replace camsisf=67.27 if soc2000==3422
replace camsisf=75.67 if soc2000==3431
replace camsisf=71.55 if soc2000==3432
replace camsisf=70.7 if soc2000==3433
replace camsisf=64.74 if soc2000==3434
replace camsisf=70.4 if soc2000==3441
replace camsisf=67.48 if soc2000==3442
replace camsisf=67.4 if soc2000==3443

replace camsisf=69.44 if soc2000==3511
replace camsisf=73.11 if soc2000==3512
replace camsisf=55.8 if soc2000==3513
replace camsisf=36.5 if soc2000==3514
replace camsisf=64.4 if soc2000==3520
replace camsisf=61.18 if soc2000==3531
replace camsisf=65.6 if soc2000==3532
replace camsisf=63.2 if soc2000==3533
replace camsisf=66.34 if soc2000==3534
replace camsisf=74.1 if soc2000==3535
replace camsisf=60.28 if soc2000==3536
replace camsisf=67.01 if soc2000==3537
replace camsisf=66.57 if soc2000==3539
replace camsisf=56.23 if soc2000==3541
replace camsisf=57.76 if soc2000==3542
replace camsisf=67.66 if soc2000==3543
replace camsisf=67.05 if soc2000==3544
replace camsisf=69.01 if soc2000==3551
replace camsisf=41.36 if soc2000==3552
replace camsisf=69.1 if soc2000==3561
replace camsisf=63.61 if soc2000==3562
replace camsisf=56 if soc2000==3563
replace camsisf=57 if soc2000==3564
replace camsisf=56.29 if soc2000==3565
replace camsisf=64.41 if soc2000==3566
replace camsisf=57.83 if soc2000==3567
replace camsisf=67.9 if soc2000==3568

replace camsisf=64.17 if soc2000==4111
replace camsisf=50.9 if soc2000==4112
replace camsisf=59.06 if soc2000==4113
replace camsisf=71.04 if soc2000==4114
replace camsisf=58.36 if soc2000==4121
replace camsisf=58.82 if soc2000==4122
replace camsisf=54.15 if soc2000==4123
replace camsisf=50.77 if soc2000==4131
replace camsisf=57.63 if soc2000==4132
replace camsisf=42.01 if soc2000==4133
replace camsisf=51.74 if soc2000==4134
replace camsisf=51.86 if soc2000==4136
replace camsisf=51.12 if soc2000==4141
replace camsisf=48.9 if soc2000==4142
replace camsisf=53.2 if soc2000==4150
replace camsisf=66.03 if soc2000==4214
replace camsisf=63.33 if soc2000==4215
replace camsisf=51.6 if soc2000==4216
replace camsisf=60.65 if soc2000==4217

replace camsisf=52.89 if soc2000==5111
replace camsisf=48.24 if soc2000==5112
replace camsisf=38.45 if soc2000==5113
replace camsisf=47 if soc2000==5119
replace camsisf=33.2 if soc2000==5211
replace camsisf=18.3 if soc2000==5212
replace camsisf=38.6 if soc2000==5213
replace camsisf=33.9 if soc2000==5214
replace camsisf=33.3 if soc2000==5215
replace camsisf=43.32 if soc2000==5216
replace camsisf=34.95 if soc2000==5221
replace camsisf=42.73 if soc2000==5222
replace camsisf=41.23 if soc2000==5223
replace camsisf=45.95 if soc2000==5224
replace camsisf=43.63 if soc2000==5231
replace camsisf=39.05 if soc2000==5232
replace camsisf=54.2 if soc2000==5233
replace camsisf=50.3 if soc2000==5234
replace camsisf=46.43 if soc2000==5241
replace camsisf=49.01 if soc2000==5242
replace camsisf=41.5 if soc2000==5243
replace camsisf=47.48 if soc2000==5244
replace camsisf=54.1 if soc2000==5245
replace camsisf=49.16 if soc2000==5249
replace camsisf=31.98 if soc2000==5311
replace camsisf=33.9 if soc2000==5312
replace camsisf=34.2 if soc2000==5313
replace camsisf=43.45 if soc2000==5314
replace camsisf=41.35 if soc2000==5315
replace camsisf=39.1 if soc2000==5316
replace camsisf=40.79 if soc2000==5319
replace camsisf=36.4 if soc2000==5321
replace camsisf=43.23 if soc2000==5322
replace camsisf=38.8 if soc2000==5323
replace camsisf=19.48 if soc2000==5411
replace camsisf=42.18 if soc2000==5412
replace camsisf=39.87 if soc2000==5413
replace camsisf=42.88 if soc2000==5414
replace camsisf=39.32 if soc2000==5419
replace camsisf=46.38 if soc2000==5421
replace camsisf=41.18 if soc2000==5422
replace camsisf=38.48 if soc2000==5423
replace camsisf=43.35 if soc2000==5424

replace camsisf=33.6 if soc2000==5431
replace camsisf=38.08 if soc2000==5432
replace camsisf=26.15 if soc2000==5433
replace camsisf=45.97 if soc2000==5434
replace camsisf=25.62 if soc2000==5491
replace camsisf=42.84 if soc2000==5492
replace camsisf=39.45 if soc2000==5493
replace camsisf=64.03 if soc2000==5494
replace camsisf=53.93 if soc2000==5495
replace camsisf=51.5 if soc2000==5496
replace camsisf=32.09 if soc2000==5499

replace camsisf=43.76 if soc2000==6111
replace camsisf=46.6 if soc2000==6112
replace camsisf=45.01 if soc2000==6113

replace camsisf=58.96 if soc2000==6114
replace camsisf=43.97 if soc2000==6115
replace camsisf=54.4 if soc2000==6121
replace camsisf=43.5 if soc2000==6124

replace camsisf=43.9 if soc2000==6131
replace camsisf=36.02 if soc2000==6139
replace camsisf=44.41 if soc2000==6211
replace camsisf=59.28 if soc2000==6212
replace camsisf=52.48 if soc2000==6214
replace camsisf=35.68 if soc2000==6215
replace camsisf=46.85 if soc2000==6219
replace camsisf=52.6 if soc2000==6221
replace camsisf=35.9 if soc2000==6231
replace camsisf=40.11 if soc2000==6232
replace camsisf=45.24 if soc2000==6291
replace camsisf=43 if soc2000==6292

replace camsisf=51.51 if soc2000==7111
replace camsisf=35.7 if soc2000==7112
replace camsisf=53.2 if soc2000==7113
replace camsisf=42.85 if soc2000==7121
replace camsisf=42.74 if soc2000==7122
replace camsisf=39.7 if soc2000==7123
replace camsisf=46.1 if soc2000==7124
replace camsisf=49.34 if soc2000==7125
replace camsisf=55.32 if soc2000==7129
replace camsisf=52.21 if soc2000==7212


replace camsisf=31.02 if soc2000==8111
replace camsisf=22.45 if soc2000==8112
replace camsisf=24.28 if soc2000==8113
replace camsisf=33.45 if soc2000==8114
replace camsisf=27.43 if soc2000==8115
replace camsisf=30.18 if soc2000==8116
replace camsisf=30.13 if soc2000==8117
replace camsisf=24.3 if soc2000==8118
replace camsisf=31.68 if soc2000==8119
replace camsisf=33.67 if soc2000==8121
replace camsisf=21.88 if soc2000==8122
replace camsisf=32.61 if soc2000==8123
replace camsisf=34.39 if soc2000==8124
replace camsisf=32.08 if soc2000==8125
replace camsisf=42.72 if soc2000==8126
replace camsisf=35.4 if soc2000==8129
replace camsisf=37.15 if soc2000==8131
replace camsisf=37.5 if soc2000==8132
replace camsisf=38.32 if soc2000==8133
replace camsisf=30.27 if soc2000==8134
replace camsisf=36.23 if soc2000==8135
replace camsisf=33.1 if soc2000==8136
replace camsisf=32.9 if soc2000==8137
replace camsisf=44.09 if soc2000==8138
replace camsisf=28.89 if soc2000==8139
replace camsisf=33.7 if soc2000==8141
replace camsisf=28.19 if soc2000==8142
replace camsisf=25.26 if soc2000==8143
replace camsisf=40.09 if soc2000==8149
replace camsisf=34.5 if soc2000==8211
replace camsisf=46.18 if soc2000==8212
replace camsisf=35.1 if soc2000==8213
replace camsisf=42.3 if soc2000==8214
replace camsisf=54.3 if soc2000==8215
replace camsisf=35.22 if soc2000==8216
replace camsisf=39.81 if soc2000==8217
replace camsisf=32.95 if soc2000==8218
replace camsisf=33.66 if soc2000==8219
replace camsisf=24.3 if soc2000==8221
replace camsisf=29.1 if soc2000==8222
replace camsisf=34.97 if soc2000==8223
replace camsisf=29.73 if soc2000==8229

replace camsisf=32.2 if soc2000==9111
replace camsisf=44.7 if soc2000==9112
replace camsisf=35.26 if soc2000==9119
replace camsisf=30.89 if soc2000==9121
replace camsisf=29.92 if soc2000==9129
replace camsisf=26.28 if soc2000==9131
replace camsisf=33.25 if soc2000==9132
replace camsisf=43.12 if soc2000==9133
replace camsisf=30.2 if soc2000==9134
replace camsisf=29.31 if soc2000==9139
replace camsisf=32.36 if soc2000==9141
replace camsisf=36.47 if soc2000==9149
replace camsisf=41.06 if soc2000==9211
replace camsisf=50.8 if soc2000==9219
replace camsisf=38.5 if soc2000==9221
replace camsisf=43.09 if soc2000==9222
replace camsisf=45.57 if soc2000==9223
replace camsisf=39.47 if soc2000==9224
replace camsisf=35.59 if soc2000==9225
replace camsisf=42.72 if soc2000==9226
replace camsisf=43.03 if soc2000==9229
replace camsisf=37.6 if soc2000==9231
replace camsisf=32.23 if soc2000==9232
replace camsisf=36.44 if soc2000==9233
replace camsisf=44.04 if soc2000==9234
replace camsisf=26.01 if soc2000==9235
replace camsisf=34.21 if soc2000==9239
replace camsisf=38.92 if soc2000==9241
replace camsisf=40.7 if soc2000==9242
replace camsisf=43.5 if soc2000==9243
replace camsisf=39.3 if soc2000==9245
replace camsisf=41.32 if soc2000==9249
replace camsisf=35.3 if soc2000==9251

rename camsisf camsisf2000

gen rgscf=.
replace rgscf=1 if (B3FSRGSC==1)
replace rgscf=2 if (B3FSRGSC==2)
replace rgscf=3 if (B3FSRGSC==3.1)
replace rgscf=4 if (B3FSRGSC==3.2)
replace rgscf=5 if (B3FSRGSC==4)
replace rgscf=6 if (B3FSRGSC==5)

label define rgsc_lbl 1"Professional" 2"Managerial and Technical" 3"Skilled non-manual" 4"Skilled manual" 5"Partly skilled" 6"Unskilled"
label value rgscf rgsc_lbl

tab rgscf

rename rgscf rgscf2000

gen cam90=.
replace cam90=85.6 if B3FSSOC90==100
replace cam90=71.5 if B3FSSOC90==101
replace cam90=70.7 if B3FSSOC90==102
replace cam90=69.3 if B3FSSOC90==103
replace cam90=59.5 if B3FSSOC90==110
replace cam90=58.2 if B3FSSOC90==111
replace cam90=55.4 if B3FSSOC90==112
replace cam90=66.2 if B3FSSOC90==113
replace cam90=76.4 if B3FSSOC90==120
replace cam90=65.9 if B3FSSOC90==121
replace cam90=61.5 if B3FSSOC90==122
replace cam90=71 if B3FSSOC90==123
replace cam90=70.4 if B3FSSOC90==124
replace cam90=70.4 if B3FSSOC90==125
replace cam90=69.9 if B3FSSOC90==126
replace cam90=70 if B3FSSOC90==127
replace cam90=58.5 if B3FSSOC90==130
replace cam90=65.1 if B3FSSOC90==131
replace cam90=64.1 if B3FSSOC90==132
replace cam90=63.7 if B3FSSOC90==139
replace cam90=57.5 if B3FSSOC90==140
replace cam90=50.3 if B3FSSOC90==141
replace cam90=48.3 if B3FSSOC90==142
replace cam90=77 if B3FSSOC90==150
replace cam90=68.6 if B3FSSOC90==151
replace cam90=60 if B3FSSOC90==152
replace cam90=68.6 if B3FSSOC90==153
replace cam90=68.6 if B3FSSOC90==154
replace cam90=68.6 if B3FSSOC90==155
replace cam90=55.4 if B3FSSOC90==160
replace cam90=52.6 if B3FSSOC90==169
replace cam90=68.5 if B3FSSOC90==170
replace cam90=56.4 if B3FSSOC90==171
replace cam90=56.9 if B3FSSOC90==172
replace cam90=56.5 if B3FSSOC90==173
replace cam90=54 if B3FSSOC90==174
replace cam90=50.7 if B3FSSOC90==175
replace cam90=58.1 if B3FSSOC90==176
replace cam90=73.2 if B3FSSOC90==177
replace cam90=49.4 if B3FSSOC90==178
replace cam90=59.5 if B3FSSOC90==179
replace cam90=71.7 if B3FSSOC90==190
replace cam90=82.3 if B3FSSOC90==191
replace cam90=63.5 if B3FSSOC90==199


replace cam90=73.4 if B3FSSOC90==200
replace cam90=74.7 if B3FSSOC90==201
replace cam90=84.4 if B3FSSOC90==202
replace cam90=81.4 if B3FSSOC90==209
replace cam90=66.6 if B3FSSOC90==210
replace cam90=68.5 if B3FSSOC90==211
replace cam90=68.3 if B3FSSOC90==212
replace cam90=67.1 if B3FSSOC90==213
replace cam90=81.9 if B3FSSOC90==214
replace cam90=80.3 if B3FSSOC90==215
replace cam90=64.2 if B3FSSOC90==216
replace cam90=55.8 if B3FSSOC90==217
replace cam90=60.2 if B3FSSOC90==218
replace cam90=64.9 if B3FSSOC90==219
replace cam90=87.4 if B3FSSOC90==220
replace cam90=73.7 if B3FSSOC90==221
replace cam90=80.2 if B3FSSOC90==222
replace cam90=83.7 if B3FSSOC90==223
replace cam90=79.6 if B3FSSOC90==224
replace cam90=82.3 if B3FSSOC90==230
replace cam90=63.8 if B3FSSOC90==231
replace cam90=79.9 if B3FSSOC90==232
replace cam90=70.9 if B3FSSOC90==233
replace cam90=65.5 if B3FSSOC90==234
replace cam90=65.8 if B3FSSOC90==235
replace cam90=66.9 if B3FSSOC90==239
replace cam90=85.7 if B3FSSOC90==240
replace cam90=87.9 if B3FSSOC90==241
replace cam90=85.2 if B3FSSOC90==242
replace cam90=72.5 if B3FSSOC90==250
replace cam90=68 if B3FSSOC90==251
replace cam90=75.3 if B3FSSOC90==252
replace cam90=81.6 if B3FSSOC90==253
replace cam90=79.6 if B3FSSOC90==260
replace cam90=86.3 if B3FSSOC90==261
replace cam90=68.1 if B3FSSOC90==262
replace cam90=86.2 if B3FSSOC90==270
replace cam90=76.5 if B3FSSOC90==271
replace cam90=94 if B3FSSOC90==290
replace cam90=79.8 if B3FSSOC90==291
replace cam90=82.2 if B3FSSOC90==292
replace cam90=73.6 if B3FSSOC90==293

replace cam90=61.3 if B3FSSOC90==300
replace cam90=51.6 if B3FSSOC90==301
replace cam90=49.6 if B3FSSOC90==302
replace cam90=67.4 if B3FSSOC90==303
replace cam90=58.2 if B3FSSOC90==304
replace cam90=51.8 if B3FSSOC90==309
replace cam90=59.3 if B3FSSOC90==310
replace cam90=62.1 if B3FSSOC90==311
replace cam90=69.7 if B3FSSOC90==312
replace cam90=63.3 if B3FSSOC90==313
replace cam90=69.2 if B3FSSOC90==320
replace cam90=71.8 if B3FSSOC90==330
replace cam90=73.9 if B3FSSOC90==331
replace cam90=55.8 if B3FSSOC90==332
replace cam90=52.4 if B3FSSOC90==340
replace cam90=59.8 if B3FSSOC90==341
replace cam90=66.3 if B3FSSOC90==342
replace cam90=66.1 if B3FSSOC90==343
replace cam90=66.9 if B3FSSOC90==344
replace cam90=66.3 if B3FSSOC90==345
replace cam90=46.7 if B3FSSOC90==346
replace cam90=66.3 if B3FSSOC90==347
replace cam90=67.9 if B3FSSOC90==348
replace cam90=43.9 if B3FSSOC90==349
replace cam90=65.7 if B3FSSOC90==350
replace cam90=56.2 if B3FSSOC90==360
replace cam90=68.1 if B3FSSOC90==361
replace cam90=67.8 if B3FSSOC90==362
replace cam90=63.1 if B3FSSOC90==363
replace cam90=72.2 if B3FSSOC90==364
replace cam90=60.4 if B3FSSOC90==370
replace cam90=62.8 if B3FSSOC90==371
replace cam90=75.8 if B3FSSOC90==380
replace cam90=71.9 if B3FSSOC90==381
replace cam90=65.4 if B3FSSOC90==382
replace cam90=70.9 if B3FSSOC90==383
replace cam90=70.7 if B3FSSOC90==384
replace cam90=71.9 if B3FSSOC90==385
replace cam90=64.6 if B3FSSOC90==386
replace cam90=70.4 if B3FSSOC90==387
replace cam90=70.1 if B3FSSOC90==390
replace cam90=54.2 if B3FSSOC90==391
replace cam90=57 if B3FSSOC90==392
replace cam90=54.4 if B3FSSOC90==393
replace cam90=53.7 if B3FSSOC90==394
replace cam90=69.5 if B3FSSOC90==395
replace cam90=58.2 if B3FSSOC90==396
replace cam90=61.5 if B3FSSOC90==399

replace cam90=50.9 if B3FSSOC90==400
replace cam90=57.2 if B3FSSOC90==401
replace cam90=58.3 if B3FSSOC90==410
replace cam90=53.9 if B3FSSOC90==411
replace cam90=42.6 if B3FSSOC90==412
replace cam90=50.6 if B3FSSOC90==420
replace cam90=50.5 if B3FSSOC90==421
replace cam90=51.9 if B3FSSOC90==430
replace cam90=36 if B3FSSOC90==440
replace cam90=37.5 if B3FSSOC90==441
replace cam90=62.6 if B3FSSOC90==450
replace cam90=62.6 if B3FSSOC90==451
replace cam90=62.6 if B3FSSOC90==452
replace cam90=62.3 if B3FSSOC90==459
replace cam90=51.4 if B3FSSOC90==460
replace cam90=51.4 if B3FSSOC90==461
replace cam90=49.3 if B3FSSOC90==462
replace cam90=46.5 if B3FSSOC90==463
replace cam90=51.6 if B3FSSOC90==490
replace cam90=57.6 if B3FSSOC90==491

replace cam90=33.9 if B3FSSOC90==500
replace cam90=34.2 if B3FSSOC90==501
replace cam90=36.4 if B3FSSOC90==502
replace cam90=39.7 if B3FSSOC90==503
replace cam90=46.5 if B3FSSOC90==504
replace cam90=33.7 if B3FSSOC90==505
replace cam90=43.2 if B3FSSOC90==506
replace cam90=38.8 if B3FSSOC90==507
replace cam90=38.4 if B3FSSOC90==509
replace cam90=38.6 if B3FSSOC90==510
replace cam90=33.7 if B3FSSOC90==511
replace cam90=32 if B3FSSOC90==512
replace cam90=36.6 if B3FSSOC90==513
replace cam90=24.7 if B3FSSOC90==514
replace cam90=42.8 if B3FSSOC90==515
replace cam90=41.2 if B3FSSOC90==516
replace cam90=46.5 if B3FSSOC90==517
replace cam90=57.1 if B3FSSOC90==518
replace cam90=30.3 if B3FSSOC90==519
replace cam90=47.4 if B3FSSOC90==520
replace cam90=45.4 if B3FSSOC90==521
replace cam90=54.8 if B3FSSOC90==522
replace cam90=48.9 if B3FSSOC90==523
replace cam90=41.5 if B3FSSOC90==524
replace cam90=47.4 if B3FSSOC90==525
replace cam90=54.1 if B3FSSOC90==526
replace cam90=50.3 if B3FSSOC90==529
replace cam90=33.2 if B3FSSOC90==530
replace cam90=18.3 if B3FSSOC90==531
replace cam90=43.5 if B3FSSOC90==532
replace cam90=38.6 if B3FSSOC90==533
replace cam90=33.9 if B3FSSOC90==534
replace cam90=31.9 if B3FSSOC90==535
replace cam90=37.7 if B3FSSOC90==536
replace cam90=33.3 if B3FSSOC90==537
replace cam90=43.3 if B3FSSOC90==540
replace cam90=38.8 if B3FSSOC90==541
replace cam90=39.9 if B3FSSOC90==542
replace cam90=54.2 if B3FSSOC90==543
replace cam90=42.5 if B3FSSOC90==544
replace cam90=13.7 if B3FSSOC90==550
replace cam90=26.4 if B3FSSOC90==551
replace cam90=26.3 if B3FSSOC90==552
replace cam90=33.3 if B3FSSOC90==553
replace cam90=42.4 if B3FSSOC90==554
replace cam90=39.8 if B3FSSOC90==555
replace cam90=44.9 if B3FSSOC90==556
replace cam90=33.1 if B3FSSOC90==557
replace cam90=39.3 if B3FSSOC90==559
replace cam90=51.1 if B3FSSOC90==560
replace cam90=48.7 if B3FSSOC90==561
replace cam90=38.5 if B3FSSOC90==562
replace cam90=43.9 if B3FSSOC90==563
replace cam90=38.5 if B3FSSOC90==569
replace cam90=41.5 if B3FSSOC90==570
replace cam90=43.6 if B3FSSOC90==571
replace cam90=21.2 if B3FSSOC90==572
replace cam90=41.7 if B3FSSOC90==573
replace cam90=44.1 if B3FSSOC90==579
replace cam90=33.5 if B3FSSOC90==580
replace cam90=33.6 if B3FSSOC90==581
replace cam90=24.6 if B3FSSOC90==582
replace cam90=24.6 if B3FSSOC90==590
replace cam90=19.5 if B3FSSOC90==591
replace cam90=63.6 if B3FSSOC90==592
replace cam90=66 if B3FSSOC90==593
replace cam90=37.8 if B3FSSOC90==594
replace cam90=39.6 if B3FSSOC90==595
replace cam90=36.1 if B3FSSOC90==596
replace cam90=17.5 if B3FSSOC90==597
replace cam90=50.2 if B3FSSOC90==598
replace cam90=31.6 if B3FSSOC90==599

replace cam90=45.1 if B3FSSOC90==600
replace cam90=46.2 if B3FSSOC90==601
replace cam90=57.4 if B3FSSOC90==610
replace cam90=52.7 if B3FSSOC90==611
replace cam90=48.6 if B3FSSOC90==612
replace cam90=81.6 if B3FSSOC90==613
replace cam90=43.8 if B3FSSOC90==614
replace cam90=38.6 if B3FSSOC90==615
replace cam90=43.5 if B3FSSOC90==619
replace cam90=42.3 if B3FSSOC90==620
replace cam90=38.4 if B3FSSOC90==621
replace cam90=36 if B3FSSOC90==622
replace cam90=52.2 if B3FSSOC90==630
replace cam90=28.7 if B3FSSOC90==631
replace cam90=40.4 if B3FSSOC90==640
replace cam90=42.5 if B3FSSOC90==641
replace cam90=46.6 if B3FSSOC90==642
replace cam90=44.8 if B3FSSOC90==643
replace cam90=43.5 if B3FSSOC90==644
replace cam90=46.5 if B3FSSOC90==650
replace cam90=43.7 if B3FSSOC90==651
replace cam90=43.5 if B3FSSOC90==652
replace cam90=46.7 if B3FSSOC90==659
replace cam90=52.6 if B3FSSOC90==660
replace cam90=52.6 if B3FSSOC90==661
replace cam90=32.8 if B3FSSOC90==670
replace cam90=32.8 if B3FSSOC90==671
replace cam90=39.5 if B3FSSOC90==672
replace cam90=44.1 if B3FSSOC90==673
replace cam90=56.4 if B3FSSOC90==690
replace cam90=51 if B3FSSOC90==691
replace cam90=43 if B3FSSOC90==699

replace cam90=57.6 if B3FSSOC90==700
replace cam90=53.6 if B3FSSOC90==701
replace cam90=61.2 if B3FSSOC90==702
replace cam90=60 if B3FSSOC90==703
replace cam90=56.6 if B3FSSOC90==710
replace cam90=56.9 if B3FSSOC90==719
replace cam90=51.5 if B3FSSOC90==720
replace cam90=34.4 if B3FSSOC90==721
replace cam90=37 if B3FSSOC90==722
replace cam90=37.9 if B3FSSOC90==730
replace cam90=39.7 if B3FSSOC90==731
replace cam90=46.6 if B3FSSOC90==732
replace cam90=44 if B3FSSOC90==733
replace cam90=42 if B3FSSOC90==790
replace cam90=51.5 if B3FSSOC90==791
replace cam90=53.3 if B3FSSOC90==792

replace cam90=31.3 if B3FSSOC90==800
replace cam90=32.3 if B3FSSOC90==801
replace cam90=31.1 if B3FSSOC90==802
replace cam90=30.7 if B3FSSOC90==809
replace cam90=24.4 if B3FSSOC90==810
replace cam90=24.3 if B3FSSOC90==811
replace cam90=24.5 if B3FSSOC90==812
replace cam90=24.8 if B3FSSOC90==813
replace cam90=22.5 if B3FSSOC90==814
replace cam90=38 if B3FSSOC90==820
replace cam90=33 if B3FSSOC90==821
replace cam90=35.4 if B3FSSOC90==822
replace cam90=13.1 if B3FSSOC90==823
replace cam90=27.1 if B3FSSOC90==824
replace cam90=30.1 if B3FSSOC90==825
replace cam90=36.7 if B3FSSOC90==826
replace cam90=31.5 if B3FSSOC90==829
replace cam90=27.9 if B3FSSOC90==830
replace cam90=31.2 if B3FSSOC90==831
replace cam90=29.4 if B3FSSOC90==832
replace cam90=29.5 if B3FSSOC90==833
replace cam90=24.3 if B3FSSOC90==834
replace cam90=31.1 if B3FSSOC90==839
replace cam90=37.2 if B3FSSOC90==840
replace cam90=31.4 if B3FSSOC90==841
replace cam90=31.4 if B3FSSOC90==842
replace cam90=23.7 if B3FSSOC90==843
replace cam90=21.1 if B3FSSOC90==844
replace cam90=37 if B3FSSOC90==850
replace cam90=37.5 if B3FSSOC90==851
replace cam90=20.6 if B3FSSOC90==859
replace cam90=42.2 if B3FSSOC90==860
replace cam90=34.3 if B3FSSOC90==861
replace cam90=30.2 if B3FSSOC90==862
replace cam90=30.1 if B3FSSOC90==863
replace cam90=44.6 if B3FSSOC90==864
replace cam90=37.1 if B3FSSOC90==869
replace cam90=35.1 if B3FSSOC90==870
replace cam90=35.1 if B3FSSOC90==871
replace cam90=34.5 if B3FSSOC90==872
replace cam90=35.1 if B3FSSOC90==873
replace cam90=42.3 if B3FSSOC90==874
replace cam90=32 if B3FSSOC90==875
replace cam90=39.8 if B3FSSOC90==880
replace cam90=39.9 if B3FSSOC90==881
replace cam90=36.5 if B3FSSOC90==882
replace cam90=31.5 if B3FSSOC90==883
replace cam90=29.2 if B3FSSOC90==884
replace cam90=30.3 if B3FSSOC90==885
replace cam90=24.3 if B3FSSOC90==886
replace cam90=29.1 if B3FSSOC90==887
replace cam90=30 if B3FSSOC90==889
replace cam90=28.5 if B3FSSOC90==890
replace cam90=44.9 if B3FSSOC90==891
replace cam90=42 if B3FSSOC90==892
replace cam90=33 if B3FSSOC90==893
replace cam90=23.7 if B3FSSOC90==894
replace cam90=32 if B3FSSOC90==895
replace cam90=40.4 if B3FSSOC90==896
replace cam90=33.1 if B3FSSOC90==897
replace cam90=35.9 if B3FSSOC90==898
replace cam90=35.8 if B3FSSOC90==899

replace cam90=32.2 if B3FSSOC90==900
replace cam90=35 if B3FSSOC90==901
replace cam90=35.9 if B3FSSOC90==902
replace cam90=33 if B3FSSOC90==903
replace cam90=44.7 if B3FSSOC90==904
replace cam90=17.4 if B3FSSOC90==910
replace cam90=16 if B3FSSOC90==911
replace cam90=24.3 if B3FSSOC90==912
replace cam90=31.4 if B3FSSOC90==913
replace cam90=23.8 if B3FSSOC90==919
replace cam90=30.8 if B3FSSOC90==920
replace cam90=29.4 if B3FSSOC90==921
replace cam90=24.9 if B3FSSOC90==922
replace cam90=26.9 if B3FSSOC90==923
replace cam90=31.5 if B3FSSOC90==924
replace cam90=29.1 if B3FSSOC90==929
replace cam90=32.1 if B3FSSOC90==930
replace cam90=33.6 if B3FSSOC90==931
replace cam90=32.5 if B3FSSOC90==932
replace cam90=19.8 if B3FSSOC90==933
replace cam90=32.5 if B3FSSOC90==934
replace cam90=38.8 if B3FSSOC90==940
replace cam90=43 if B3FSSOC90==941
replace cam90=38.5 if B3FSSOC90==950
replace cam90=43.1 if B3FSSOC90==951
replace cam90=37.9 if B3FSSOC90==952
replace cam90=48.3 if B3FSSOC90==953
replace cam90=33.8 if B3FSSOC90==954
replace cam90=39.3 if B3FSSOC90==955
replace cam90=37.6 if B3FSSOC90==956
replace cam90=32.5 if B3FSSOC90==957
replace cam90=36.4 if B3FSSOC90==958
replace cam90=34.6 if B3FSSOC90==959
replace cam90=29 if B3FSSOC90==990
replace cam90=46.8 if B3FSSOC90==999

rename cam90 camsisf90


gen rgsc90=.
replace rgsc90=1 if B3FSSOC90==100
replace rgsc90=2 if B3FSSOC90==101
replace rgsc90=2 if B3FSSOC90==102
replace rgsc90=3 if B3FSSOC90==112
replace rgsc90=2 if B3FSSOC90==132
replace rgsc90=2 if B3FSSOC90==142
replace rgsc90=. if B3FSSOC90==150
replace rgsc90=2 if B3FSSOC90==152
replace rgsc90=2 if B3FSSOC90==160
replace rgsc90=3 if B3FSSOC90==172
replace rgsc90=2 if B3FSSOC90==173
replace rgsc90=3 if B3FSSOC90==174
replace rgsc90=3 if B3FSSOC90==176
replace rgsc90=2 if B3FSSOC90==177
replace rgsc90=2 if B3FSSOC90==179
replace rgsc90=2 if B3FSSOC90==199
replace rgsc90=1 if B3FSSOC90==200
replace rgsc90=1 if B3FSSOC90==201
replace rgsc90=1 if B3FSSOC90==202
replace rgsc90=1 if B3FSSOC90==210
replace rgsc90=1 if B3FSSOC90==211
replace rgsc90=1 if B3FSSOC90==212
replace rgsc90=1 if B3FSSOC90==213
replace rgsc90=1 if B3FSSOC90==215
replace rgsc90=1 if B3FSSOC90==216
replace rgsc90=1 if B3FSSOC90==218
replace rgsc90=1 if B3FSSOC90==219
replace rgsc90=1 if B3FSSOC90==220
replace rgsc90=1 if B3FSSOC90==221
replace rgsc90=1 if B3FSSOC90==222
replace rgsc90=1 if B3FSSOC90==223
replace rgsc90=1 if B3FSSOC90==224
replace rgsc90=1 if B3FSSOC90==230
replace rgsc90=2 if B3FSSOC90==231
replace rgsc90=1 if B3FSSOC90==232
replace rgsc90=2 if B3FSSOC90==233
replace rgsc90=2 if B3FSSOC90==234
replace rgsc90=1 if B3FSSOC90==250
replace rgsc90=1 if B3FSSOC90==253
replace rgsc90=1 if B3FSSOC90==260
replace rgsc90=1 if B3FSSOC90==261
replace rgsc90=1 if B3FSSOC90==290
replace rgsc90=1 if B3FSSOC90==292
replace rgsc90=2 if B3FSSOC90==293
replace rgsc90=2 if B3FSSOC90==300
replace rgsc90=2 if B3FSSOC90==309
replace rgsc90=2 if B3FSSOC90==311
replace rgsc90=2 if B3FSSOC90==312
replace rgsc90=2 if B3FSSOC90==313
replace rgsc90=2 if B3FSSOC90==320
replace rgsc90=2 if B3FSSOC90==332
replace rgsc90=2 if B3FSSOC90==340
replace rgsc90=2 if B3FSSOC90==343
replace rgsc90=2 if B3FSSOC90==344
replace rgsc90=2 if B3FSSOC90==346
replace rgsc90=2 if B3FSSOC90==347
replace rgsc90=2 if B3FSSOC90==348
replace rgsc90=2 if B3FSSOC90==349
replace rgsc90=2 if B3FSSOC90==350
replace rgsc90=2 if B3FSSOC90==360
replace rgsc90=2 if B3FSSOC90==361
replace rgsc90=2 if B3FSSOC90==362
replace rgsc90=2 if B3FSSOC90==364
replace rgsc90=2 if B3FSSOC90==370
replace rgsc90=2 if B3FSSOC90==371
replace rgsc90=2 if B3FSSOC90==381
replace rgsc90=2 if B3FSSOC90==383
replace rgsc90=2 if B3FSSOC90==384
replace rgsc90=2 if B3FSSOC90==385
replace rgsc90=3 if B3FSSOC90==387
replace rgsc90=2 if B3FSSOC90==390
replace rgsc90=2 if B3FSSOC90==391
replace rgsc90=2 if B3FSSOC90==392
replace rgsc90=2 if B3FSSOC90==393
replace rgsc90=3 if B3FSSOC90==399
replace rgsc90=3 if B3FSSOC90==400
replace rgsc90=3 if B3FSSOC90==401
replace rgsc90=3 if B3FSSOC90==410
replace rgsc90=3 if B3FSSOC90==411
replace rgsc90=3 if B3FSSOC90==420
replace rgsc90=3 if B3FSSOC90==430
replace rgsc90=3 if B3FSSOC90==441
replace rgsc90=3 if B3FSSOC90==452
replace rgsc90=3 if B3FSSOC90==459
replace rgsc90=3 if B3FSSOC90==462
replace rgsc90=3 if B3FSSOC90==463
replace rgsc90=3 if B3FSSOC90==490
replace rgsc90=3 if B3FSSOC90==491
replace rgsc90=4 if B3FSSOC90==500
replace rgsc90=5 if B3FSSOC90==501
replace rgsc90=4 if B3FSSOC90==502
replace rgsc90=5 if B3FSSOC90==505
replace rgsc90=4 if B3FSSOC90==507
replace rgsc90=4 if B3FSSOC90==516
replace rgsc90=4 if B3FSSOC90==521
replace rgsc90=4 if B3FSSOC90==522
replace rgsc90=4 if B3FSSOC90==524
replace rgsc90=4 if B3FSSOC90==526
replace rgsc90=4 if B3FSSOC90==529
replace rgsc90=4 if B3FSSOC90==530
replace rgsc90=4 if B3FSSOC90==531
replace rgsc90=4 if B3FSSOC90==532
replace rgsc90=4 if B3FSSOC90==533
replace rgsc90=4 if B3FSSOC90==534
replace rgsc90=4 if B3FSSOC90==535
replace rgsc90=4 if B3FSSOC90==537
replace rgsc90=4 if B3FSSOC90==540
replace rgsc90=4 if B3FSSOC90==542
replace rgsc90=4 if B3FSSOC90==543
replace rgsc90=4 if B3FSSOC90==551
replace rgsc90=4 if B3FSSOC90==554
replace rgsc90=4 if B3FSSOC90==555
replace rgsc90=4 if B3FSSOC90==557
replace rgsc90=4 if B3FSSOC90==559
replace rgsc90=4 if B3FSSOC90==579
replace rgsc90=4 if B3FSSOC90==580
replace rgsc90=4 if B3FSSOC90==581
replace rgsc90=4 if B3FSSOC90==582
replace rgsc90=4 if B3FSSOC90==590
replace rgsc90=4 if B3FSSOC90==593
replace rgsc90=5 if B3FSSOC90==594
replace rgsc90=5 if B3FSSOC90==596
replace rgsc90=5 if B3FSSOC90==599
replace rgsc90=. if B3FSSOC90==600
replace rgsc90=3 if B3FSSOC90==611
replace rgsc90=5 if B3FSSOC90==612
replace rgsc90=5 if B3FSSOC90==615
replace rgsc90=5 if B3FSSOC90==619
replace rgsc90=4 if B3FSSOC90==620
replace rgsc90=5 if B3FSSOC90==622
replace rgsc90=4 if B3FSSOC90==630
replace rgsc90=4 if B3FSSOC90==642
replace rgsc90=5 if B3FSSOC90==644
replace rgsc90=4 if B3FSSOC90==650
replace rgsc90=5 if B3FSSOC90==661
replace rgsc90=5 if B3FSSOC90==672
replace rgsc90=5 if B3FSSOC90==673
replace rgsc90=5 if B3FSSOC90==699
replace rgsc90=2 if B3FSSOC90==702
replace rgsc90=2 if B3FSSOC90==703
replace rgsc90=3 if B3FSSOC90==710
replace rgsc90=3 if B3FSSOC90==719
replace rgsc90=3 if B3FSSOC90==720
replace rgsc90=3 if B3FSSOC90==722
replace rgsc90=5 if B3FSSOC90==730
replace rgsc90=4 if B3FSSOC90==731
replace rgsc90=5 if B3FSSOC90==732
replace rgsc90=3 if B3FSSOC90==733
replace rgsc90=3 if B3FSSOC90==791
replace rgsc90=3 if B3FSSOC90==792
replace rgsc90=5 if B3FSSOC90==809
replace rgsc90=5 if B3FSSOC90==829
replace rgsc90=4 if B3FSSOC90==834
replace rgsc90=4 if B3FSSOC90==839
replace rgsc90=5 if B3FSSOC90==840
replace rgsc90=5 if B3FSSOC90==850
replace rgsc90=5 if B3FSSOC90==851
replace rgsc90=5 if B3FSSOC90==860
replace rgsc90=5 if B3FSSOC90==862
replace rgsc90=5 if B3FSSOC90==869
replace rgsc90=4 if B3FSSOC90==872
replace rgsc90=4 if B3FSSOC90==873
replace rgsc90=4 if B3FSSOC90==874
replace rgsc90=5 if B3FSSOC90==875
replace rgsc90=5 if B3FSSOC90==880
replace rgsc90=4 if B3FSSOC90==881
replace rgsc90=4 if B3FSSOC90==882
replace rgsc90=4 if B3FSSOC90==886
replace rgsc90=4 if B3FSSOC90==887
replace rgsc90=4 if B3FSSOC90==891
replace rgsc90=5 if B3FSSOC90==896
replace rgsc90=4 if B3FSSOC90==897
replace rgsc90=5 if B3FSSOC90==898
replace rgsc90=5 if B3FSSOC90==899
replace rgsc90=5 if B3FSSOC90==900
replace rgsc90=5 if B3FSSOC90==901
replace rgsc90=5 if B3FSSOC90==902
replace rgsc90=5 if B3FSSOC90==903
replace rgsc90=5 if B3FSSOC90==904
replace rgsc90=5 if B3FSSOC90==910
replace rgsc90=5 if B3FSSOC90==913
replace rgsc90=5 if B3FSSOC90==922
replace rgsc90=5 if B3FSSOC90==924
replace rgsc90=6 if B3FSSOC90==929
replace rgsc90=6 if B3FSSOC90==931
replace rgsc90=4 if B3FSSOC90==932
replace rgsc90=6 if B3FSSOC90==941
replace rgsc90=5 if B3FSSOC90==950
replace rgsc90=5 if B3FSSOC90==951
replace rgsc90=5 if B3FSSOC90==953
replace rgsc90=5 if B3FSSOC90==954
replace rgsc90=6 if B3FSSOC90==955
replace rgsc90=6 if B3FSSOC90==956
replace rgsc90=6 if B3FSSOC90==958
replace rgsc90=5 if B3FSSOC90==959
replace rgsc90=6 if B3FSSOC90==990
replace rgsc90=4 if B3FSSOC90==999

replace rgsc90=1 if B3FSSOC90==241
replace rgsc90=1 if B3FSSOC90==242
replace rgsc90=2 if B3FSSOC90==251
replace rgsc90=1 if B3FSSOC90==252
replace rgsc90=1 if B3FSSOC90==262
replace rgsc90=2 if B3FSSOC90==270
replace rgsc90=. if B3FSSOC90==271
replace rgsc90=1 if B3FSSOC90==291
replace rgsc90=2 if B3FSSOC90==301
replace rgsc90=2 if B3FSSOC90==302
replace rgsc90=2 if B3FSSOC90==303
replace rgsc90=. if B3FSSOC90==304
replace rgsc90=3 if B3FSSOC90==310
replace rgsc90=. if B3FSSOC90==330
replace rgsc90=2 if B3FSSOC90==331
replace rgsc90=2 if B3FSSOC90==342
replace rgsc90=2 if B3FSSOC90==345
replace rgsc90=2 if B3FSSOC90==363
replace rgsc90=2 if B3FSSOC90==380
replace rgsc90=2 if B3FSSOC90==382
replace rgsc90=3 if B3FSSOC90==386
replace rgsc90=2 if B3FSSOC90==394
replace rgsc90=2 if B3FSSOC90==395
replace rgsc90=2 if B3FSSOC90==396
replace rgsc90=3 if B3FSSOC90==412
replace rgsc90=3 if B3FSSOC90==440
replace rgsc90=3 if B3FSSOC90==460
replace rgsc90=5 if B3FSSOC90==503
replace rgsc90=4 if B3FSSOC90==504
replace rgsc90=4 if B3FSSOC90==506
replace rgsc90=5 if B3FSSOC90==509
replace rgsc90=4 if B3FSSOC90==510
replace rgsc90=5 if B3FSSOC90==511
replace rgsc90=5 if B3FSSOC90==512
replace rgsc90=5 if B3FSSOC90==513
replace rgsc90=4 if B3FSSOC90==514
replace rgsc90=4 if B3FSSOC90==515
replace rgsc90=4 if B3FSSOC90==517
replace rgsc90=4 if B3FSSOC90==518
replace rgsc90=4 if B3FSSOC90==519
replace rgsc90=4 if B3FSSOC90==520
replace rgsc90=4 if B3FSSOC90==523
replace rgsc90=4 if B3FSSOC90==525
replace rgsc90=4 if B3FSSOC90==536
replace rgsc90=4 if B3FSSOC90==541
replace rgsc90=5 if B3FSSOC90==544
replace rgsc90=4 if B3FSSOC90==550
replace rgsc90=4 if B3FSSOC90==552
replace rgsc90=5 if B3FSSOC90==553
replace rgsc90=4 if B3FSSOC90==556
replace rgsc90=4 if B3FSSOC90==560
replace rgsc90=4 if B3FSSOC90==561
replace rgsc90=4 if B3FSSOC90==562
replace rgsc90=4 if B3FSSOC90==563
replace rgsc90=4 if B3FSSOC90==569
replace rgsc90=4 if B3FSSOC90==570
replace rgsc90=4 if B3FSSOC90==571
replace rgsc90=4 if B3FSSOC90==572
replace rgsc90=4 if B3FSSOC90==573
replace rgsc90=4 if B3FSSOC90==591
replace rgsc90=4 if B3FSSOC90==592
replace rgsc90=5 if B3FSSOC90==595
replace rgsc90=4 if B3FSSOC90==597
replace rgsc90=4 if B3FSSOC90==598
replace rgsc90=3 if B3FSSOC90==610
replace rgsc90=2 if B3FSSOC90==613
replace rgsc90=5 if B3FSSOC90==614
replace rgsc90=5 if B3FSSOC90==621
replace rgsc90=6 if B3FSSOC90==631
replace rgsc90=2 if B3FSSOC90==640
replace rgsc90=5 if B3FSSOC90==641
replace rgsc90=5 if B3FSSOC90==652
replace rgsc90=4 if B3FSSOC90==660
replace rgsc90=4 if B3FSSOC90==670
replace rgsc90=2 if B3FSSOC90==690
replace rgsc90=2 if B3FSSOC90==691
replace rgsc90=2 if B3FSSOC90==700
replace rgsc90=2 if B3FSSOC90==701
replace rgsc90=3 if B3FSSOC90==721
replace rgsc90=3 if B3FSSOC90==790
replace rgsc90=4 if B3FSSOC90==800
replace rgsc90=4 if B3FSSOC90==801
replace rgsc90=5 if B3FSSOC90==802
replace rgsc90=4 if B3FSSOC90==810
replace rgsc90=5 if B3FSSOC90==811
replace rgsc90=5 if B3FSSOC90==812
replace rgsc90=5 if B3FSSOC90==813
replace rgsc90=5 if B3FSSOC90==814
replace rgsc90=5 if B3FSSOC90==820
replace rgsc90=4 if B3FSSOC90==821
replace rgsc90=4 if B3FSSOC90==822
replace rgsc90=4 if B3FSSOC90==823
replace rgsc90=4 if B3FSSOC90==824
replace rgsc90=5 if B3FSSOC90==825
replace rgsc90=5 if B3FSSOC90==826
replace rgsc90=4 if B3FSSOC90==830
replace rgsc90=4 if B3FSSOC90==831
replace rgsc90=4 if B3FSSOC90==832
replace rgsc90=5 if B3FSSOC90==833
replace rgsc90=5 if B3FSSOC90==841
replace rgsc90=4 if B3FSSOC90==842
replace rgsc90=5 if B3FSSOC90==843
replace rgsc90=5 if B3FSSOC90==844
replace rgsc90=5 if B3FSSOC90==859
replace rgsc90=4 if B3FSSOC90==861
replace rgsc90=5 if B3FSSOC90==863
replace rgsc90=4 if B3FSSOC90==864
replace rgsc90=4 if B3FSSOC90==870
replace rgsc90=4 if B3FSSOC90==871
replace rgsc90=4 if B3FSSOC90==883
replace rgsc90=4 if B3FSSOC90==884
replace rgsc90=4 if B3FSSOC90==885
replace rgsc90=4 if B3FSSOC90==889
replace rgsc90=5 if B3FSSOC90==890
replace rgsc90=6 if B3FSSOC90==892
replace rgsc90=5 if B3FSSOC90==893
replace rgsc90=4 if B3FSSOC90==894
replace rgsc90=5 if B3FSSOC90==895
replace rgsc90=6 if B3FSSOC90==911
replace rgsc90=6 if B3FSSOC90==912
replace rgsc90=6 if B3FSSOC90==919
replace rgsc90=4 if B3FSSOC90==920
replace rgsc90=5 if B3FSSOC90==921
replace rgsc90=6 if B3FSSOC90==923
replace rgsc90=6 if B3FSSOC90==930
replace rgsc90=6 if B3FSSOC90==933
replace rgsc90=6 if B3FSSOC90==934
replace rgsc90=5 if B3FSSOC90==940
replace rgsc90=6 if B3FSSOC90==952
replace rgsc90=6 if B3FSSOC90==957

replace rgsc90=2 if B3FSSOC90==103
replace rgsc90=3 if B3FSSOC90==110
replace rgsc90=2 if B3FSSOC90==111
replace rgsc90=2 if B3FSSOC90==113
replace rgsc90=2 if B3FSSOC90==120
replace rgsc90=2 if B3FSSOC90==121
replace rgsc90=2 if B3FSSOC90==122
replace rgsc90=2 if B3FSSOC90==123
replace rgsc90=2 if B3FSSOC90==124
replace rgsc90=2 if B3FSSOC90==125
replace rgsc90=2 if B3FSSOC90==126
replace rgsc90=2 if B3FSSOC90==127
replace rgsc90=2 if B3FSSOC90==130
replace rgsc90=2 if B3FSSOC90==131
replace rgsc90=2 if B3FSSOC90==139
replace rgsc90=2 if B3FSSOC90==140
replace rgsc90=2 if B3FSSOC90==141
replace rgsc90=. if B3FSSOC90==150
replace rgsc90=2 if B3FSSOC90==153
replace rgsc90=2 if B3FSSOC90==154
replace rgsc90=2 if B3FSSOC90==169
replace rgsc90=2 if B3FSSOC90==170
replace rgsc90=2 if B3FSSOC90==171
replace rgsc90=2 if B3FSSOC90==175
replace rgsc90=2 if B3FSSOC90==178
replace rgsc90=2 if B3FSSOC90==190
replace rgsc90=2 if B3FSSOC90==191
replace rgsc90=1 if B3FSSOC90==209
replace rgsc90=1 if B3FSSOC90==214
replace rgsc90=1 if B3FSSOC90==217
replace rgsc90=2 if B3FSSOC90==235
replace rgsc90=2 if B3FSSOC90==239
replace rgsc90=2 if B3FSSOC90==271
replace rgsc90=2 if B3FSSOC90==304
replace rgsc90=2 if B3FSSOC90==330
replace rgsc90=. if B3FSSOC90==600

rename rgsc90 rgsc90f

gen nssec90=.
replace nssec90=1 if B3FSSOC90==100
replace nssec90=1 if B3FSSOC90==101
replace nssec90=1 if B3FSSOC90==102
replace nssec90=3 if B3FSSOC90==112
replace nssec90=3 if B3FSSOC90==132
replace nssec90=3 if B3FSSOC90==142
replace nssec90=1 if B3FSSOC90==150
replace nssec90=1 if B3FSSOC90==152
replace nssec90=5 if B3FSSOC90==160
replace nssec90=5 if B3FSSOC90==172
replace nssec90=5 if B3FSSOC90==173
replace nssec90=3 if B3FSSOC90==174
replace nssec90=3 if B3FSSOC90==176
replace nssec90=3 if B3FSSOC90==177
replace nssec90=3 if B3FSSOC90==179
replace nssec90=3 if B3FSSOC90==199
replace nssec90=2 if B3FSSOC90==200
replace nssec90=2 if B3FSSOC90==201
replace nssec90=2 if B3FSSOC90==202
replace nssec90=2 if B3FSSOC90==210
replace nssec90=2 if B3FSSOC90==211
replace nssec90=2 if B3FSSOC90==212
replace nssec90=2 if B3FSSOC90==213
replace nssec90=2 if B3FSSOC90==215
replace nssec90=2 if B3FSSOC90==216
replace nssec90=3 if B3FSSOC90==218
replace nssec90=2 if B3FSSOC90==219
replace nssec90=2 if B3FSSOC90==220
replace nssec90=2 if B3FSSOC90==221
replace nssec90=2 if B3FSSOC90==222
replace nssec90=2 if B3FSSOC90==223
replace nssec90=2 if B3FSSOC90==224
replace nssec90=2 if B3FSSOC90==230
replace nssec90=3 if B3FSSOC90==231
replace nssec90=2 if B3FSSOC90==232
replace nssec90=3 if B3FSSOC90==233
replace nssec90=3 if B3FSSOC90==234
replace nssec90=2 if B3FSSOC90==250
replace nssec90=2 if B3FSSOC90==253
replace nssec90=2 if B3FSSOC90==260
replace nssec90=2 if B3FSSOC90==261
replace nssec90=2 if B3FSSOC90==290
replace nssec90=2 if B3FSSOC90==292
replace nssec90=3 if B3FSSOC90==293
replace nssec90=3 if B3FSSOC90==300
replace nssec90=3 if B3FSSOC90==309
replace nssec90=3 if B3FSSOC90==311
replace nssec90=3 if B3FSSOC90==312
replace nssec90=3 if B3FSSOC90==313
replace nssec90=2 if B3FSSOC90==320
replace nssec90=3 if B3FSSOC90==332
replace nssec90=3 if B3FSSOC90==340
replace nssec90=3 if B3FSSOC90==343
replace nssec90=3 if B3FSSOC90==344
replace nssec90=7 if B3FSSOC90==346
replace nssec90=3 if B3FSSOC90==347
replace nssec90=2 if B3FSSOC90==348
replace nssec90=7 if B3FSSOC90==349
replace nssec90=4 if B3FSSOC90==350
replace nssec90=3 if B3FSSOC90==360
replace nssec90=3 if B3FSSOC90==361
replace nssec90=2 if B3FSSOC90==362
replace nssec90=2 if B3FSSOC90==364
replace nssec90=7 if B3FSSOC90==370
replace nssec90=3 if B3FSSOC90==371
replace nssec90=5 if B3FSSOC90==381
replace nssec90=4 if B3FSSOC90==383
replace nssec90=3 if B3FSSOC90==384
replace nssec90=3 if B3FSSOC90==385
replace nssec90=3 if B3FSSOC90==387
replace nssec90=3 if B3FSSOC90==390
replace nssec90=3 if B3FSSOC90==391
replace nssec90=3 if B3FSSOC90==392
replace nssec90=5 if B3FSSOC90==393

replace nssec90=3 if B3FSSOC90==399
replace nssec90=4 if B3FSSOC90==400
replace nssec90=4 if B3FSSOC90==401
replace nssec90=4 if B3FSSOC90==410
replace nssec90=4 if B3FSSOC90==411
replace nssec90=4 if B3FSSOC90==420
replace nssec90=4 if B3FSSOC90==430
replace nssec90=8 if B3FSSOC90==441
replace nssec90=4 if B3FSSOC90==452
replace nssec90=4 if B3FSSOC90==459
replace nssec90=7 if B3FSSOC90==462
replace nssec90=6 if B3FSSOC90==463
replace nssec90=4 if B3FSSOC90==490
replace nssec90=4 if B3FSSOC90==491
replace nssec90=5 if B3FSSOC90==500
replace nssec90=5 if B3FSSOC90==501
replace nssec90=5 if B3FSSOC90==502
replace nssec90=7 if B3FSSOC90==505
replace nssec90=5 if B3FSSOC90==507
replace nssec90=6 if B3FSSOC90==516
replace nssec90=6 if B3FSSOC90==521
replace nssec90=6 if B3FSSOC90==522
replace nssec90=6 if B3FSSOC90==524
replace nssec90=4 if B3FSSOC90==526
replace nssec90=4 if B3FSSOC90==529
replace nssec90=8 if B3FSSOC90==530
replace nssec90=7 if B3FSSOC90==531
replace nssec90=6 if B3FSSOC90==532
replace nssec90=7 if B3FSSOC90==533
replace nssec90=8 if B3FSSOC90==534
replace nssec90=7 if B3FSSOC90==535
replace nssec90=8 if B3FSSOC90==537
replace nssec90=6 if B3FSSOC90==540
replace nssec90=6 if B3FSSOC90==542
replace nssec90=6 if B3FSSOC90==543
replace nssec90=8 if B3FSSOC90==551
replace nssec90=8 if B3FSSOC90==554
replace nssec90=8 if B3FSSOC90==555
replace nssec90=7 if B3FSSOC90==557
replace nssec90=8 if B3FSSOC90==559
replace nssec90=5 if B3FSSOC90==579
replace nssec90=6 if B3FSSOC90==580
replace nssec90=8 if B3FSSOC90==581
replace nssec90=8 if B3FSSOC90==582
replace nssec90=8 if B3FSSOC90==590
replace nssec90=5 if B3FSSOC90==593
replace nssec90=6 if B3FSSOC90==594
replace nssec90=7 if B3FSSOC90==596
replace nssec90=6 if B3FSSOC90==599
replace nssec90=4 if B3FSSOC90==600
replace nssec90=4 if B3FSSOC90==611
replace nssec90=3 if B3FSSOC90==612
replace nssec90=7 if B3FSSOC90==615
replace nssec90=8 if B3FSSOC90==619
replace nssec90=7 if B3FSSOC90==620
replace nssec90=8 if B3FSSOC90==622
replace nssec90=8 if B3FSSOC90==630
replace nssec90=4 if B3FSSOC90==642
replace nssec90=7 if B3FSSOC90==644
replace nssec90=4 if B3FSSOC90==650
replace nssec90=5 if B3FSSOC90==661
replace nssec90=7 if B3FSSOC90==672
replace nssec90=8 if B3FSSOC90==673
replace nssec90=7 if B3FSSOC90==699
replace nssec90=3 if B3FSSOC90==702
replace nssec90=2 if B3FSSOC90==703
replace nssec90=3 if B3FSSOC90==710
replace nssec90=4 if B3FSSOC90==719
replace nssec90=7 if B3FSSOC90==720
replace nssec90=7 if B3FSSOC90==722
replace nssec90=5 if B3FSSOC90==730
replace nssec90=8 if B3FSSOC90==731
replace nssec90=5 if B3FSSOC90==732
replace nssec90=5 if B3FSSOC90==733
replace nssec90=8 if B3FSSOC90==791
replace nssec90=7 if B3FSSOC90==792
replace nssec90=7 if B3FSSOC90==809
replace nssec90=7 if B3FSSOC90==829
replace nssec90=7 if B3FSSOC90==834
replace nssec90=7 if B3FSSOC90==839
replace nssec90=7 if B3FSSOC90==840
replace nssec90=7 if B3FSSOC90==850
replace nssec90=7 if B3FSSOC90==851
replace nssec90=6 if B3FSSOC90==860
replace nssec90=8 if B3FSSOC90==862
replace nssec90=6 if B3FSSOC90==869
replace nssec90=8 if B3FSSOC90==872
replace nssec90=8 if B3FSSOC90==873
replace nssec90=5 if B3FSSOC90==874
replace nssec90=8 if B3FSSOC90==875
replace nssec90=7 if B3FSSOC90==880
replace nssec90=6 if B3FSSOC90==881
replace nssec90=6 if B3FSSOC90==882
replace nssec90=7 if B3FSSOC90==886
replace nssec90=7 if B3FSSOC90==887
replace nssec90=7 if B3FSSOC90==891
replace nssec90=6 if B3FSSOC90==896
replace nssec90=7 if B3FSSOC90==897
replace nssec90=6 if B3FSSOC90==898
replace nssec90=7 if B3FSSOC90==899
replace nssec90=7 if B3FSSOC90==900
replace nssec90=7 if B3FSSOC90==901
replace nssec90=8 if B3FSSOC90==902
replace nssec90=5 if B3FSSOC90==903
replace nssec90=5 if B3FSSOC90==904
replace nssec90=8 if B3FSSOC90==910
replace nssec90=8 if B3FSSOC90==913
replace nssec90=6 if B3FSSOC90==922
replace nssec90=5 if B3FSSOC90==924
replace nssec90=8 if B3FSSOC90==929
replace nssec90=8 if B3FSSOC90==931
replace nssec90=8 if B3FSSOC90==932
replace nssec90=7 if B3FSSOC90==941
replace nssec90=7 if B3FSSOC90==950
replace nssec90=8 if B3FSSOC90==951
replace nssec90=7 if B3FSSOC90==953
replace nssec90=7 if B3FSSOC90==954
replace nssec90=8 if B3FSSOC90==955
replace nssec90=5 if B3FSSOC90==956
replace nssec90=8 if B3FSSOC90==958
replace nssec90=8 if B3FSSOC90==959
replace nssec90=8 if B3FSSOC90==990
replace nssec90=8 if B3FSSOC90==999

replace nssec90=3 if B3FSSOC90==103
replace nssec90=1 if B3FSSOC90==110
replace nssec90=3 if B3FSSOC90==111
replace nssec90=1 if B3FSSOC90==113
replace nssec90=1 if B3FSSOC90==120
replace nssec90=1 if B3FSSOC90==121
replace nssec90=1 if B3FSSOC90==122
replace nssec90=1 if B3FSSOC90==123
replace nssec90=1 if B3FSSOC90==124
replace nssec90=1 if B3FSSOC90==125
replace nssec90=1 if B3FSSOC90==126
replace nssec90=4 if B3FSSOC90==127
replace nssec90=4 if B3FSSOC90==130
replace nssec90=3 if B3FSSOC90==131
replace nssec90=3 if B3FSSOC90==139
replace nssec90=3 if B3FSSOC90==140
replace nssec90=7 if B3FSSOC90==141
replace nssec90=1 if B3FSSOC90==153
replace nssec90=1 if B3FSSOC90==154
replace nssec90=5 if B3FSSOC90==169
replace nssec90=3 if B3FSSOC90==170
replace nssec90=5 if B3FSSOC90==171
replace nssec90=3 if B3FSSOC90==175
replace nssec90=5 if B3FSSOC90==178
replace nssec90=3 if B3FSSOC90==190
replace nssec90=2 if B3FSSOC90==191
replace nssec90=2 if B3FSSOC90==209
replace nssec90=2 if B3FSSOC90==214
replace nssec90=2 if B3FSSOC90==217
replace nssec90=2 if B3FSSOC90==235
replace nssec90=5 if B3FSSOC90==239

replace nssec90=2 if B3FSSOC90==241
replace nssec90=2 if B3FSSOC90==242
replace nssec90=2 if B3FSSOC90==251
replace nssec90=2 if B3FSSOC90==252
replace nssec90=2 if B3FSSOC90==262
replace nssec90=3 if B3FSSOC90==270
replace nssec90=3 if B3FSSOC90==271
replace nssec90=2 if B3FSSOC90==291
replace nssec90=3 if B3FSSOC90==301
replace nssec90=4 if B3FSSOC90==302
replace nssec90=3 if B3FSSOC90==303
replace nssec90=3 if B3FSSOC90==304
replace nssec90=4 if B3FSSOC90==310
replace nssec90=3 if B3FSSOC90==330
replace nssec90=3 if B3FSSOC90==331
replace nssec90=3 if B3FSSOC90==342
replace nssec90=4 if B3FSSOC90==345
replace nssec90=3 if B3FSSOC90==363
replace nssec90=3 if B3FSSOC90==380
replace nssec90=5 if B3FSSOC90==382
replace nssec90=4 if B3FSSOC90==386
replace nssec90=3 if B3FSSOC90==394
replace nssec90=3 if B3FSSOC90==395
replace nssec90=3 if B3FSSOC90==396
replace nssec90=4 if B3FSSOC90==412
replace nssec90=7 if B3FSSOC90==440
replace nssec90=7 if B3FSSOC90==460
replace nssec90=8 if B3FSSOC90==503
replace nssec90=5 if B3FSSOC90==504
replace nssec90=5 if B3FSSOC90==506
replace nssec90=5 if B3FSSOC90==509
replace nssec90=7 if B3FSSOC90==510
replace nssec90=7 if B3FSSOC90==511
replace nssec90=7 if B3FSSOC90==512
replace nssec90=7 if B3FSSOC90==513
replace nssec90=6 if B3FSSOC90==514
replace nssec90=6 if B3FSSOC90==515
replace nssec90=6 if B3FSSOC90==517
replace nssec90=6 if B3FSSOC90==518
replace nssec90=7 if B3FSSOC90==519
replace nssec90=6 if B3FSSOC90==520
replace nssec90=4 if B3FSSOC90==523
replace nssec90=6 if B3FSSOC90==525
replace nssec90=5 if B3FSSOC90==536
replace nssec90=6 if B3FSSOC90==541
replace nssec90=7 if B3FSSOC90==544
replace nssec90=8 if B3FSSOC90==550
replace nssec90=8 if B3FSSOC90==552
replace nssec90=8 if B3FSSOC90==553
replace nssec90=5 if B3FSSOC90==556
replace nssec90=6 if B3FSSOC90==560
replace nssec90=6 if B3FSSOC90==561
replace nssec90=8 if B3FSSOC90==562
replace nssec90=6 if B3FSSOC90==563
replace nssec90=6 if B3FSSOC90==569
replace nssec90=5 if B3FSSOC90==570
replace nssec90=8 if B3FSSOC90==571
replace nssec90=7 if B3FSSOC90==572
replace nssec90=6 if B3FSSOC90==573
replace nssec90=8 if B3FSSOC90==591
replace nssec90=4 if B3FSSOC90==592
replace nssec90=7 if B3FSSOC90==595
replace nssec90=8 if B3FSSOC90==597
replace nssec90=4 if B3FSSOC90==598
replace nssec90=4 if B3FSSOC90==610
replace nssec90=3 if B3FSSOC90==613
replace nssec90=7 if B3FSSOC90==614
replace nssec90=8 if B3FSSOC90==621
replace nssec90=6 if B3FSSOC90==631
replace nssec90=4 if B3FSSOC90==640
replace nssec90=4 if B3FSSOC90==641
replace nssec90=7 if B3FSSOC90==652
replace nssec90=8 if B3FSSOC90==660
replace nssec90=7 if B3FSSOC90==670
replace nssec90=7 if B3FSSOC90==690
replace nssec90=3 if B3FSSOC90==691
replace nssec90=3 if B3FSSOC90==700
replace nssec90=3 if B3FSSOC90==701
replace nssec90=7 if B3FSSOC90==721
replace nssec90=4 if B3FSSOC90==790
replace nssec90=7 if B3FSSOC90==800
replace nssec90=7 if B3FSSOC90==801
replace nssec90=7 if B3FSSOC90==802
replace nssec90=6 if B3FSSOC90==810
replace nssec90=8 if B3FSSOC90==811
replace nssec90=8 if B3FSSOC90==812
replace nssec90=8 if B3FSSOC90==813
replace nssec90=8 if B3FSSOC90==814
replace nssec90=6 if B3FSSOC90==820
replace nssec90=7 if B3FSSOC90==821
replace nssec90=7 if B3FSSOC90==822
replace nssec90=7 if B3FSSOC90==823
replace nssec90=7 if B3FSSOC90==824
replace nssec90=7 if B3FSSOC90==825
replace nssec90=6 if B3FSSOC90==826
replace nssec90=7 if B3FSSOC90==830
replace nssec90=7 if B3FSSOC90==831
replace nssec90=7 if B3FSSOC90==832
replace nssec90=7 if B3FSSOC90==833
replace nssec90=7 if B3FSSOC90==841
replace nssec90=7 if B3FSSOC90==842
replace nssec90=7 if B3FSSOC90==843
replace nssec90=7 if B3FSSOC90==844
replace nssec90=8 if B3FSSOC90==859
replace nssec90=6 if B3FSSOC90==861
replace nssec90=8 if B3FSSOC90==863
replace nssec90=4 if B3FSSOC90==864
replace nssec90=6 if B3FSSOC90==870
replace nssec90=6 if B3FSSOC90==871
replace nssec90=6 if B3FSSOC90==883
replace nssec90=6 if B3FSSOC90==884
replace nssec90=8 if B3FSSOC90==885
replace nssec90=8 if B3FSSOC90==889
replace nssec90=6 if B3FSSOC90==890
replace nssec90=6 if B3FSSOC90==892
replace nssec90=7 if B3FSSOC90==893
replace nssec90=7 if B3FSSOC90==894
replace nssec90=8 if B3FSSOC90==895
replace nssec90=8 if B3FSSOC90==911
replace nssec90=8 if B3FSSOC90==912
replace nssec90=8 if B3FSSOC90==919
replace nssec90=8 if B3FSSOC90==920
replace nssec90=5 if B3FSSOC90==921
replace nssec90=6 if B3FSSOC90==923
replace nssec90=8 if B3FSSOC90==930
replace nssec90=8 if B3FSSOC90==933
replace nssec90=8 if B3FSSOC90==934
replace nssec90=7 if B3FSSOC90==940
replace nssec90=7 if B3FSSOC90==952
replace nssec90=8 if B3FSSOC90==957

rename nssec90 nssec90f

cd "G:\Stata data and do\NCDS\Occupation Codes\UKDA-7023-stata9\stata9"

merge 1:1 BCSID using bcs3_occupation_coding_mother

drop _merge

gen nssecm=. 
replace nssecm=1 if (B3MSNSSEC==2)

replace nssecm=2 if (B3MSNSSEC==3.1)
replace nssecm=2 if (B3MSNSSEC==3.2)
replace nssecm=2 if (B3MSNSSEC==3.3)

replace nssecm=3 if (B3MSNSSEC==4.1)
replace nssecm=3 if (B3MSNSSEC==4.2)
replace nssecm=3 if (B3MSNSSEC==4.3)
replace nssecm=3 if (B3MSNSSEC==5)

replace nssecm=4 if (B3MSNSSEC==7.1)
replace nssecm=4 if (B3MSNSSEC==7.2)
replace nssecm=4 if (B3MSNSSEC==7.3)
replace nssecm=4 if (B3MSNSSEC==7.4)

replace nssecm=5 if (B3MSNSSEC==8.1)
replace nssecm=5 if (B3MSNSSEC==9.1)
replace nssecm=5 if (B3MSNSSEC==9.2)

replace nssecm=6 if (B3MSNSSEC==10)
replace nssecm=6 if (B3MSNSSEC==11.1)
replace nssecm=6 if (B3MSNSSEC==11.2)

replace nssecm=7 if (B3MSNSSEC==12.1)
replace nssecm=7 if (B3MSNSSEC==12.2)
replace nssecm=7 if (B3MSNSSEC==12.3)
replace nssecm=7 if (B3MSNSSEC==12.4)
replace nssecm=7 if (B3MSNSSEC==12.5)
replace nssecm=7 if (B3MSNSSEC==12.6)
replace nssecm=7 if (B3MSNSSEC==12.7)

replace nssecm=8 if (B3MSNSSEC==13.1)
replace nssecm=8 if (B3MSNSSEC==13.2)
replace nssecm=8 if (B3MSNSSEC==13.3)
replace nssecm=8 if (B3MSNSSEC==13.4)
replace nssecm=8 if (B3MSNSSEC==13.5)

label value nssecm nssec_lbl

tab nssecm

rename nssecm nssecm2000

gen rgscm=.
replace rgscm=1 if (B3MSRGSC==1)
replace rgscm=2 if (B3MSRGSC==2)
replace rgscm=3 if (B3MSRGSC==3.1)
replace rgscm=4 if (B3MSRGSC==3.2)
replace rgscm=5 if (B3MSRGSC==4)
replace rgscm=6 if (B3MSRGSC==5)

label value rgscm rgsc_lbl

tab rgscm

rename rgscm rgscm2000

rename soc2000 soc2000f

destring B3MSSOCC, gen(soc2000) force

gen camsisf=.
replace camsisf=67.9 if soc2000==1111
replace camsisf=63 if soc2000==1113
replace camsisf=69.78 if soc2000==1114
replace camsisf=55.68 if soc2000==1121
replace camsisf=67.01 if soc2000==1131
replace camsisf=63.46 if soc2000==1132
replace camsisf=79.47 if soc2000==1134
replace camsisf=66.27 if soc2000==1135
replace camsisf=62.58 if soc2000==1136
replace camsisf=62.46 if soc2000==1141
replace camsisf=59.85 if soc2000==1151
replace camsisf=63.78 if soc2000==1152
replace camsisf=54.99 if soc2000==1161
replace camsisf=47.74 if soc2000==1162
replace camsisf=52.69 if soc2000==1163
replace camsisf=63.1 if soc2000==1171
replace camsisf=53.69 if soc2000==1185
replace camsisf=59.1 if soc2000==1211
replace camsisf=62.21 if soc2000==1212
replace camsisf=61.71 if soc2000==1219
replace camsisf=51.9 if soc2000==1221
replace camsisf=47.1 if soc2000==1223
replace camsisf=39.43 if soc2000==1224
replace camsisf=67.29 if soc2000==1225
replace camsisf=61.4 if soc2000==1226
replace camsisf=71.17 if soc2000==1231
replace camsisf=56.3 if soc2000==1232
replace camsisf=45.4 if soc2000==1233
replace camsisf=52.43 if soc2000==1234
replace camsisf=57.88 if soc2000==1239

replace camsisf=81.6 if soc2000==2111
replace camsisf=79.13 if soc2000==2112
replace camsisf=81.5 if soc2000==2113
replace camsisf=80.57 if soc2000==2122
replace camsisf=83.93 if soc2000==2129
replace camsisf=77.99 if soc2000==2131
replace camsisf=76.26 if soc2000==2132
replace camsisf=88.2 if soc2000==2211
replace camsisf=83.2 if soc2000==2213
replace camsisf=90.7 if soc2000==2214
replace camsisf=90.8 if soc2000==2215
replace camsisf=88.4 if soc2000==2216
replace camsisf=94.21 if soc2000==2311
replace camsisf=78.6 if soc2000==2312
replace camsisf=80.6 if soc2000==2314
replace camsisf=73.9 if soc2000==2315
replace camsisf=75.2 if soc2000==2316
replace camsisf=73.52 if soc2000==2319
replace camsisf=63.7 if soc2000==2322
replace camsisf=72.26 if soc2000==2329
replace camsisf=89.38 if soc2000==2411
replace camsisf=76.02 if soc2000==2423
replace camsisf=67.2 if soc2000==2441
replace camsisf=56 if soc2000==2442
replace camsisf=70.88 if soc2000==2451
replace camsisf=86.1 if soc2000==2452

replace camsisf=61.28 if soc2000==3111
replace camsisf=55.93 if soc2000==3119
replace camsisf=83.8 if soc2000==3121
replace camsisf=67.91 if soc2000==3122
replace camsisf=78.82 if soc2000==3123
replace camsisf=69.97 if soc2000==3131
replace camsisf=71.2 if soc2000==3132
replace camsisf=59.4 if soc2000==3211
replace camsisf=42.2 if soc2000==3212
replace camsisf=73.8 if soc2000==3214
replace camsisf=70.1 if soc2000==3215
replace camsisf=73.7 if soc2000==3216
replace camsisf=60.9 if soc2000==3217
replace camsisf=53.56 if soc2000==3218
replace camsisf=78 if soc2000==3221
replace camsisf=74.27 if soc2000==3229
replace camsisf=58.56 if soc2000==3231
replace camsisf=58.76 if soc2000==3232
replace camsisf=56.1 if soc2000==3311
replace camsisf=60.65 if soc2000==3312
replace camsisf=59 if soc2000==3314
replace camsisf=70 if soc2000==3411
replace camsisf=84.12 if soc2000==3412
replace camsisf=66.29 if soc2000==3413
replace camsisf=70.95 if soc2000==3414
replace camsisf=75.09 if soc2000==3415
replace camsisf=67.1 if soc2000==3416
replace camsisf=66.63 if soc2000==3421
replace camsisf=72.69 if soc2000==3422
replace camsisf=85.15 if soc2000==3431
replace camsisf=70.26 if soc2000==3432
replace camsisf=78.21 if soc2000==3433
replace camsisf=63.84 if soc2000==3434
replace camsisf=71.64 if soc2000==3442
replace camsisf=74.54 if soc2000==3443
replace camsisf=69.95 if soc2000==3520
replace camsisf=61.69 if soc2000==3531
replace camsisf=62.13 if soc2000==3532
replace camsisf=60.54 if soc2000==3533
replace camsisf=68.5 if soc2000==3537
replace camsisf=64.92 if soc2000==3539
replace camsisf=63.23 if soc2000==3541
replace camsisf=59.99 if soc2000==3542
replace camsisf=70.57 if soc2000==3543
replace camsisf=72.88 if soc2000==3544
replace camsisf=66.89 if soc2000==3561
replace camsisf=66.29 if soc2000==3562
replace camsisf=66.12 if soc2000==3563
replace camsisf=67.2 if soc2000==3564
replace camsisf=67.2 if soc2000==3565
replace camsisf=65.52 if soc2000==3566
replace camsisf=68.04 if soc2000==3567
replace camsisf=54 if soc2000==3568

replace camsisf=59.62 if soc2000==4111
replace camsisf=51 if soc2000==4112
replace camsisf=57.33 if soc2000==4113
replace camsisf=69.65 if soc2000==4114
replace camsisf=54.56 if soc2000==4121
replace camsisf=55.18 if soc2000==4122
replace camsisf=52.64 if soc2000==4123
replace camsisf=58.18 if soc2000==4131
replace camsisf=55.79 if soc2000==4132
replace camsisf=45.82 if soc2000==4133
replace camsisf=55.18 if soc2000==4134
replace camsisf=65 if soc2000==4135
replace camsisf=49.24 if soc2000==4136
replace camsisf=55.12 if soc2000==4137
replace camsisf=50.33 if soc2000==4141
replace camsisf=50.78 if soc2000==4142
replace camsisf=54.3 if soc2000==4150
replace camsisf=65.8 if soc2000==4211
replace camsisf=54.8 if soc2000==4212
replace camsisf=58.3 if soc2000==4213
replace camsisf=67.53 if soc2000==4214
replace camsisf=62.85 if soc2000==4215
replace camsisf=55.86 if soc2000==4216
replace camsisf=53.59 if soc2000==4217

replace camsisf=56.52 if soc2000==5111
replace camsisf=55.71 if soc2000==5112
replace camsisf=60.31 if soc2000==5113
replace camsisf=53.88 if soc2000==5119
replace camsisf=28.6 if soc2000==5212
replace camsisf=29.2 if soc2000==5213
replace camsisf=28.7 if soc2000==5215
replace camsisf=31.44 if soc2000==5221
replace camsisf=29.95 if soc2000==5223
replace camsisf=40.44 if soc2000==5224
replace camsisf=49.7 if soc2000==5232
replace camsisf=49.7 if soc2000==5233
replace camsisf=30.2 if soc2000==5234
replace camsisf=41.45 if soc2000==5241
replace camsisf=54.26 if soc2000==5242
replace camsisf=42.9 if soc2000==5243
replace camsisf=56.9 if soc2000==5244
replace camsisf=42.36 if soc2000==5249
replace camsisf=40.9 if soc2000==5315
replace camsisf=44.08 if soc2000==5322
replace camsisf=50.1 if soc2000==5323
replace camsisf=26.82 if soc2000==5411
replace camsisf=40.7 if soc2000==5412
replace camsisf=31.08 if soc2000==5413
replace camsisf=39.27 if soc2000==5414
replace camsisf=30.27 if soc2000==5419
replace camsisf=51.37 if soc2000==5421
replace camsisf=36.51 if soc2000==5422
replace camsisf=33.16 if soc2000==5423
replace camsisf=36.1 if soc2000==5424
replace camsisf=35 if soc2000==5431
replace camsisf=41.91 if soc2000==5432
replace camsisf=26.85 if soc2000==5433
replace camsisf=41.75 if soc2000==5434
replace camsisf=29.38 if soc2000==5491
replace camsisf=44.49 if soc2000==5492
replace camsisf=41.66 if soc2000==5494
replace camsisf=39.58 if soc2000==5495
replace camsisf=54.7 if soc2000==5496
replace camsisf=34.86 if soc2000==5499

replace camsisf=45.63 if soc2000==6111
replace camsisf=42.2 if soc2000==6112
replace camsisf=52.36 if soc2000==6113
replace camsisf=50.44 if soc2000==6114
replace camsisf=37.72 if soc2000==6115
replace camsisf=56.73 if soc2000==6121
replace camsisf=49.7 if soc2000==6122
replace camsisf=55.78 if soc2000==6123
replace camsisf=57.2 if soc2000==6124
replace camsisf=54 if soc2000==6131
replace camsisf=40.51 if soc2000==6139
replace camsisf=41.57 if soc2000==6211
replace camsisf=59.41 if soc2000==6212
replace camsisf=55.81 if soc2000==6214
replace camsisf=47.93 if soc2000==6219
replace camsisf=46.45 if soc2000==6221
replace camsisf=57.91 if soc2000==6222
replace camsisf=40.7 if soc2000==6231
replace camsisf=27.52 if soc2000==6232
replace camsisf=43.3 if soc2000==6291

replace camsisf=42.82 if soc2000==7111
replace camsisf=39.99 if soc2000==7112
replace camsisf=48.94 if soc2000==7113
replace camsisf=53.33 if soc2000==7121
replace camsisf=41.27 if soc2000==7122
replace camsisf=42.9 if soc2000==7123
replace camsisf=41.97 if soc2000==7124
replace camsisf=55.38 if soc2000==7125
replace camsisf=58.08 if soc2000==7129
replace camsisf=54.1 if soc2000==7212

replace camsisf=28.66 if soc2000==8111
replace camsisf=26.88 if soc2000==8112
replace camsisf=23.11 if soc2000==8113
replace camsisf=30.24 if soc2000==8114
replace camsisf=27.83 if soc2000==8115
replace camsisf=28.83 if soc2000==8116
replace camsisf=31.46 if soc2000==8117
replace camsisf=25.37 if soc2000==8121
replace camsisf=38.6 if soc2000==8123
replace camsisf=29.34 if soc2000==8124
replace camsisf=24.21 if soc2000==8125
replace camsisf=39.62 if soc2000==8126
replace camsisf=28.94 if soc2000==8129
replace camsisf=32.42 if soc2000==8131
replace camsisf=29.2 if soc2000==8132
replace camsisf=32.9 if soc2000==8133
replace camsisf=27.09 if soc2000==8134
replace camsisf=19.7 if soc2000==8136
replace camsisf=28.26 if soc2000==8137
replace camsisf=51.23 if soc2000==8138
replace camsisf=31.55 if soc2000==8139
replace camsisf=44.1 if soc2000==8141
replace camsisf=39.23 if soc2000==8149
replace camsisf=46.2 if soc2000==8211
replace camsisf=45.26 if soc2000==8212
replace camsisf=46.1 if soc2000==8213
replace camsisf=50.5 if soc2000==8214
replace camsisf=65.5 if soc2000==8215
replace camsisf=34.99 if soc2000==8216
replace camsisf=37.34 if soc2000==8219
replace camsisf=30.1 if soc2000==8221

replace camsisf=35.3 if soc2000==9111
replace camsisf=41.24 if soc2000==9119
replace camsisf=34.79 if soc2000==9129
replace camsisf=29.55 if soc2000==9131
replace camsisf=32.94 if soc2000==9132
replace camsisf=39.21 if soc2000==9133
replace camsisf=28.3 if soc2000==9134
replace camsisf=30.12 if soc2000==9139
replace camsisf=33.06 if soc2000==9141
replace camsisf=36.91 if soc2000==9149
replace camsisf=38.86 if soc2000==9211
replace camsisf=50.5 if soc2000==9219
replace camsisf=50.7 if soc2000==9221
replace camsisf=35.06 if soc2000==9223
replace camsisf=38.52 if soc2000==9224
replace camsisf=36.74 if soc2000==9225
replace camsisf=41.28 if soc2000==9226
replace camsisf=43.99 if soc2000==9229
replace camsisf=27.15 if soc2000==9232
replace camsisf=26.93 if soc2000==9233
replace camsisf=27.26 if soc2000==9234
replace camsisf=35.9 if soc2000==9235
replace camsisf=35.21 if soc2000==9239
replace camsisf=48.18 if soc2000==9241
replace camsisf=29.6 if soc2000==9243
replace camsisf=43.74 if soc2000==9244
replace camsisf=25 if soc2000==9245
replace camsisf=34.35 if soc2000==9249
replace camsisf=34.35 if soc2000==9251

replace camsisf=61.46 if soc2000==1142
replace camsisf=78.1 if soc2000==3222
replace camsisf=78.1 if soc2000==3223
replace camsisf=56.58 if soc2000==6213

rename camsisf camsism2000

gen camsism=.
replace camsism=67.9 if B3MSSOC90==100
replace camsism=64.5 if B3MSSOC90==101
replace camsism=63 if B3MSSOC90==102
replace camsism=67.9 if B3MSSOC90==103
replace camsism=57.7 if B3MSSOC90==110
replace camsism=49 if B3MSSOC90==111
replace camsism=56.7 if B3MSSOC90==112
replace camsism=57.7 if B3MSSOC90==113
replace camsism=70.7 if B3MSSOC90==120
replace camsism=64.3 if B3MSSOC90==121
replace camsism=63.6 if B3MSSOC90==122
replace camsism=80.3 if B3MSSOC90==123
replace camsism=66.1 if B3MSSOC90==124
replace camsism=66.1 if B3MSSOC90==125
replace camsism=62.8 if B3MSSOC90==126
replace camsism=67.9 if B3MSSOC90==127
replace camsism=54.7 if B3MSSOC90==130
replace camsism=58.8 if B3MSSOC90==131
replace camsism=59.5 if B3MSSOC90==132
replace camsism=62.9 if B3MSSOC90==139
replace camsism=57.1 if B3MSSOC90==140
replace camsism=50.8 if B3MSSOC90==141
replace camsism=45.7 if B3MSSOC90==142
replace camsism=63.1 if B3MSSOC90==150
replace camsism=59.2 if B3MSSOC90==151
replace camsism=63.1 if B3MSSOC90==152
replace camsism=59.2 if B3MSSOC90==153
replace camsism=59.2 if B3MSSOC90==154
replace camsism=70.7 if B3MSSOC90==155
replace camsism=59.1 if B3MSSOC90==160
replace camsism=62.6 if B3MSSOC90==169
replace camsism=74.9 if B3MSSOC90==170
replace camsism=56.7 if B3MSSOC90==171
replace camsism=45.4 if B3MSSOC90==172
replace camsism=51.9 if B3MSSOC90==173
replace camsism=47.1 if B3MSSOC90==174
replace camsism=38.6 if B3MSSOC90==175
replace camsism=66.8 if B3MSSOC90==176
replace camsism=61.4 if B3MSSOC90==177
replace camsism=56.2 if B3MSSOC90==178
replace camsism=52.4 if B3MSSOC90==179
replace camsism=70.6 if B3MSSOC90==190
replace camsism=71.2 if B3MSSOC90==191
replace camsism=61.9 if B3MSSOC90==199

replace camsism=81.6 if B3MSSOC90==200
replace camsism=79.4 if B3MSSOC90==201
replace camsism=81.5 if B3MSSOC90==202
replace camsism=80.1 if B3MSSOC90==209
replace camsism=83.4 if B3MSSOC90==210
replace camsism=84.1 if B3MSSOC90==211
replace camsism=79.6 if B3MSSOC90==212
replace camsism=79.6 if B3MSSOC90==213
replace camsism=79.7 if B3MSSOC90==214
replace camsism=76.4 if B3MSSOC90==215
replace camsism=76.4 if B3MSSOC90==216
replace camsism=79.6 if B3MSSOC90==217
replace camsism=60.5 if B3MSSOC90==218
replace camsism=84.2 if B3MSSOC90==219
replace camsism=88.2 if B3MSSOC90==220
replace camsism=83.2 if B3MSSOC90==221
replace camsism=90.7 if B3MSSOC90==222
replace camsism=90.8 if B3MSSOC90==223
replace camsism=88.4 if B3MSSOC90==224
replace camsism=95.4 if B3MSSOC90==230
replace camsism=78.6 if B3MSSOC90==231
replace camsism=87 if B3MSSOC90==232
replace camsism=80.6 if B3MSSOC90==233
replace camsism=73.9 if B3MSSOC90==234
replace camsism=75.2 if B3MSSOC90==235
replace camsism=74.7 if B3MSSOC90==239
replace camsism=90.8 if B3MSSOC90==240
replace camsism=90.8 if B3MSSOC90==241
replace camsism=90.8 if B3MSSOC90==242
replace camsism=75.9 if B3MSSOC90==250
replace camsism=74.5 if B3MSSOC90==251
replace camsism=73.9 if B3MSSOC90==252
replace camsism=82.7 if B3MSSOC90==253
replace camsism=77.9 if B3MSSOC90==260
replace camsism=77.9 if B3MSSOC90==261
replace camsism=77.9 if B3MSSOC90==262
replace camsism=78.6 if B3MSSOC90==270
replace camsism=86.1 if B3MSSOC90==271
replace camsism=86.4 if B3MSSOC90==290
replace camsism=58.8 if B3MSSOC90==291
replace camsism=86.4 if B3MSSOC90==292
replace camsism=56 if B3MSSOC90==293

replace camsism=61.5 if B3MSSOC90==300
replace camsism=61.2 if B3MSSOC90==301
replace camsism=55.6 if B3MSSOC90==302
replace camsism=83.8 if B3MSSOC90==303
replace camsism=83.8 if B3MSSOC90==304
replace camsism=55.4 if B3MSSOC90==309
replace camsism=69.4 if B3MSSOC90==310
replace camsism=83.8 if B3MSSOC90==311
replace camsism=83.5 if B3MSSOC90==312
replace camsism=68.4 if B3MSSOC90==313
replace camsism=71.2 if B3MSSOC90==320
replace camsism=67 if B3MSSOC90==330
replace camsism=67.5 if B3MSSOC90==331
replace camsism=65.1 if B3MSSOC90==332
replace camsism=59.4 if B3MSSOC90==340
replace camsism=64.5 if B3MSSOC90==341
replace camsism=73.8 if B3MSSOC90==342
replace camsism=78 if B3MSSOC90==343
replace camsism=70.1 if B3MSSOC90==344
replace camsism=73.7 if B3MSSOC90==345
replace camsism=60.9 if B3MSSOC90==346
replace camsism=78.1 if B3MSSOC90==347
replace camsism=54 if B3MSSOC90==348
replace camsism=54 if B3MSSOC90==349
replace camsism=71.7 if B3MSSOC90==350
replace camsism=60.2 if B3MSSOC90==360
replace camsism=61.9 if B3MSSOC90==361
replace camsism=65.4 if B3MSSOC90==362
replace camsism=66.2 if B3MSSOC90==363
replace camsism=66.5 if B3MSSOC90==364
replace camsism=51.2 if B3MSSOC90==370
replace camsism=58.8 if B3MSSOC90==371
replace camsism=85.6 if B3MSSOC90==380
replace camsism=70 if B3MSSOC90==381
replace camsism=72.9 if B3MSSOC90==382
replace camsism=74.3 if B3MSSOC90==383
replace camsism=67.2 if B3MSSOC90==384
replace camsism=75.3 if B3MSSOC90==385
replace camsism=63.9 if B3MSSOC90==386
replace camsism=73.6 if B3MSSOC90==387
replace camsism=69.7 if B3MSSOC90==390
replace camsism=65.8 if B3MSSOC90==391
replace camsism=67.2 if B3MSSOC90==392
replace camsism=65.2 if B3MSSOC90==393
replace camsism=69.3 if B3MSSOC90==394
replace camsism=69.3 if B3MSSOC90==395
replace camsism=69.3 if B3MSSOC90==396
replace camsism=68.2 if B3MSSOC90==399

replace camsism=51 if B3MSSOC90==400
replace camsism=56.5 if B3MSSOC90==401
replace camsism=54.5 if B3MSSOC90==410
replace camsism=52.5 if B3MSSOC90==411
replace camsism=41.2 if B3MSSOC90==412
replace camsism=58.3 if B3MSSOC90==420
replace camsism=65 if B3MSSOC90==421
replace camsism=53.3 if B3MSSOC90==430
replace camsism=48.9 if B3MSSOC90==440
replace camsism=35.7 if B3MSSOC90==441
replace camsism=65.8 if B3MSSOC90==450
replace camsism=54.8 if B3MSSOC90==451
replace camsism=52.9 if B3MSSOC90==452
replace camsism=63 if B3MSSOC90==459
replace camsism=56.7 if B3MSSOC90==460
replace camsism=54.7 if B3MSSOC90==461
replace camsism=48.6 if B3MSSOC90==462
replace camsism=49.3 if B3MSSOC90==463
replace camsism=48.3 if B3MSSOC90==490
replace camsism=55.7 if B3MSSOC90==491

replace camsism=44.1 if B3MSSOC90==500
replace camsism=44.1 if B3MSSOC90==501
replace camsism=44.1 if B3MSSOC90==502
replace camsism=44.1 if B3MSSOC90==503
replace camsism=55.1 if B3MSSOC90==504
replace camsism=44.1 if B3MSSOC90==505
replace camsism=44.1 if B3MSSOC90==506
replace camsism=50.1 if B3MSSOC90==507
replace camsism=45.9 if B3MSSOC90==509
replace camsism=29.7 if B3MSSOC90==510
replace camsism=29.7 if B3MSSOC90==511
replace camsism=33.7 if B3MSSOC90==512
replace camsism=32.3 if B3MSSOC90==513
replace camsism=29.7 if B3MSSOC90==514
replace camsism=30 if B3MSSOC90==515
replace camsism=29.7 if B3MSSOC90==516
replace camsism=40.9 if B3MSSOC90==517
replace camsism=40.1 if B3MSSOC90==518
replace camsism=29.7 if B3MSSOC90==519
replace camsism=31.1 if B3MSSOC90==520
replace camsism=46.9 if B3MSSOC90==521
replace camsism=46.2 if B3MSSOC90==522
replace camsism=56.7 if B3MSSOC90==523
replace camsism=42.9 if B3MSSOC90==524
replace camsism=57.2 if B3MSSOC90==525
replace camsism=56.7 if B3MSSOC90==526
replace camsism=47.1 if B3MSSOC90==529
replace camsism=29 if B3MSSOC90==530
replace camsism=28.6 if B3MSSOC90==531
replace camsism=40.3 if B3MSSOC90==532
replace camsism=29.2 if B3MSSOC90==533
replace camsism=28.6 if B3MSSOC90==534
replace camsism=29 if B3MSSOC90==535
replace camsism=31 if B3MSSOC90==536
replace camsism=28.7 if B3MSSOC90==537
replace camsism=50 if B3MSSOC90==540
replace camsism=49.7 if B3MSSOC90==541
replace camsism=49.7 if B3MSSOC90==542
replace camsism=49.7 if B3MSSOC90==543
replace camsism=49.7 if B3MSSOC90==544
replace camsism=26.1 if B3MSSOC90==550
replace camsism=27.7 if B3MSSOC90==551
replace camsism=28.2 if B3MSSOC90==552
replace camsism=28.3 if B3MSSOC90==553
replace camsism=41 if B3MSSOC90==554
replace camsism=31 if B3MSSOC90==555
replace camsism=43.3 if B3MSSOC90==556
replace camsism=19.7 if B3MSSOC90==557
replace camsism=29.5 if B3MSSOC90==559
replace camsism=61.4 if B3MSSOC90==560
replace camsism=41.2 if B3MSSOC90==561
replace camsism=31.5 if B3MSSOC90==562
replace camsism=35.9 if B3MSSOC90==563
replace camsism=34.4 if B3MSSOC90==569
replace camsism=41 if B3MSSOC90==570
replace camsism=48.2 if B3MSSOC90==571
replace camsism=36.9 if B3MSSOC90==572
replace camsism=36.9 if B3MSSOC90==573
replace camsism=43.7 if B3MSSOC90==579
replace camsism=39.1 if B3MSSOC90==580
replace camsism=35 if B3MSSOC90==581
replace camsism=24.9 if B3MSSOC90==582
replace camsism=25.7 if B3MSSOC90==590
replace camsism=33.7 if B3MSSOC90==591
replace camsism=34.4 if B3MSSOC90==592
replace camsism=41.8 if B3MSSOC90==593
replace camsism=60.1 if B3MSSOC90==594
replace camsism=52.5 if B3MSSOC90==595
replace camsism=30.2 if B3MSSOC90==596
replace camsism=29.3 if B3MSSOC90==597
replace camsism=29.3 if B3MSSOC90==598
replace camsism=34.7 if B3MSSOC90==599

replace camsism=56.1 if B3MSSOC90==600
replace camsism=56.1 if B3MSSOC90==601
replace camsism=60.8 if B3MSSOC90==610
replace camsism=60.8 if B3MSSOC90==611
replace camsism=59 if B3MSSOC90==612
replace camsism=60.8 if B3MSSOC90==613
replace camsism=38.2 if B3MSSOC90==614
replace camsism=48.4 if B3MSSOC90==615
replace camsism=29.6 if B3MSSOC90==619
replace camsism=39.3 if B3MSSOC90==620
replace camsism=38.9 if B3MSSOC90==621
replace camsism=36.6 if B3MSSOC90==622
replace camsism=55.9 if B3MSSOC90==630
replace camsism=29.6 if B3MSSOC90==631
replace camsism=40.2 if B3MSSOC90==640
replace camsism=44.3 if B3MSSOC90==641
replace camsism=42.2 if B3MSSOC90==642
replace camsism=51.3 if B3MSSOC90==643
replace camsism=37.2 if B3MSSOC90==644
replace camsism=56.6 if B3MSSOC90==650
replace camsism=65.1 if B3MSSOC90==651
replace camsism=57.2 if B3MSSOC90==652
replace camsism=49.7 if B3MSSOC90==659
replace camsism=43.3 if B3MSSOC90==660
replace camsism=62.2 if B3MSSOC90==661
replace camsism=39 if B3MSSOC90==670
replace camsism=42 if B3MSSOC90==671
replace camsism=26.5 if B3MSSOC90==672
replace camsism=27.2 if B3MSSOC90==673
replace camsism=40.9 if B3MSSOC90==690
replace camsism=36.2 if B3MSSOC90==691
replace camsism=41.6 if B3MSSOC90==699

replace camsism=74.6 if B3MSSOC90==700
replace camsism=58.3 if B3MSSOC90==701
replace camsism=63.5 if B3MSSOC90==702
replace camsism=62.9 if B3MSSOC90==703
replace camsism=59.8 if B3MSSOC90==710
replace camsism=58.8 if B3MSSOC90==719
replace camsism=42.8 if B3MSSOC90==720
replace camsism=40.6 if B3MSSOC90==721
replace camsism=38 if B3MSSOC90==722
replace camsism=51.4 if B3MSSOC90==730
replace camsism=42.9 if B3MSSOC90==731
replace camsism=42.7 if B3MSSOC90==732
replace camsism=42.9 if B3MSSOC90==733
replace camsism=54.1 if B3MSSOC90==790
replace camsism=54.7 if B3MSSOC90==791
replace camsism=48.6 if B3MSSOC90==792

replace camsism=27.4 if B3MSSOC90==800
replace camsism=35.3 if B3MSSOC90==801
replace camsism=35.5 if B3MSSOC90==802
replace camsism=26.7 if B3MSSOC90==809
replace camsism=18.1 if B3MSSOC90==810
replace camsism=18.2 if B3MSSOC90==811
replace camsism=17.2 if B3MSSOC90==812
replace camsism=17.2 if B3MSSOC90==813
replace camsism=25.2 if B3MSSOC90==814
replace camsism=35.2 if B3MSSOC90==820
replace camsism=25.6 if B3MSSOC90==821
replace camsism=25.3 if B3MSSOC90==822
replace camsism=26.3 if B3MSSOC90==823
replace camsism=27.8 if B3MSSOC90==824
replace camsism=28.9 if B3MSSOC90==825
replace camsism=30.7 if B3MSSOC90==826
replace camsism=28.1 if B3MSSOC90==829
replace camsism=29.7 if B3MSSOC90==830
replace camsism=32.3 if B3MSSOC90==831
replace camsism=29.7 if B3MSSOC90==832
replace camsism=40.3 if B3MSSOC90==833
replace camsism=26.4 if B3MSSOC90==834
replace camsism=31.1 if B3MSSOC90==839
replace camsism=25.9 if B3MSSOC90==840
replace camsism=22.8 if B3MSSOC90==841
replace camsism=22.8 if B3MSSOC90==842
replace camsism=22.8 if B3MSSOC90==843
replace camsism=23.1 if B3MSSOC90==844
replace camsism=32.5 if B3MSSOC90==850
replace camsism=29.2 if B3MSSOC90==851
replace camsism=29 if B3MSSOC90==859
replace camsism=33.4 if B3MSSOC90==860
replace camsism=29.9 if B3MSSOC90==861
replace camsism=28.3 if B3MSSOC90==862
replace camsism=26.9 if B3MSSOC90==863
replace camsism=52.1 if B3MSSOC90==864
replace camsism=36.8 if B3MSSOC90==869
replace camsism=46.5 if B3MSSOC90==870
replace camsism=46.5 if B3MSSOC90==871
replace camsism=46.2 if B3MSSOC90==872
replace camsism=46.1 if B3MSSOC90==873
replace camsism=50.5 if B3MSSOC90==874
replace camsism=30.1 if B3MSSOC90==875
replace camsism=33.4 if B3MSSOC90==880
replace camsism=43.9 if B3MSSOC90==881
replace camsism=30.1 if B3MSSOC90==882
replace camsism=30.1 if B3MSSOC90==883
replace camsism=30.1 if B3MSSOC90==884
replace camsism=30.1 if B3MSSOC90==885
replace camsism=30.1 if B3MSSOC90==886
replace camsism=30.2 if B3MSSOC90==887
replace camsism=32 if B3MSSOC90==889
replace camsism=28.1 if B3MSSOC90==890
replace camsism=41 if B3MSSOC90==891
replace camsism=37.8 if B3MSSOC90==892
replace camsism=28.1 if B3MSSOC90==893
replace camsism=28.1 if B3MSSOC90==894
replace camsism=28.3 if B3MSSOC90==895
replace camsism=40.2 if B3MSSOC90==896
replace camsism=17 if B3MSSOC90==897
replace camsism=47.7 if B3MSSOC90==898
replace camsism=28.4 if B3MSSOC90==899

replace camsism=35.3 if B3MSSOC90==900
replace camsism=37.9 if B3MSSOC90==901
replace camsism=40.5 if B3MSSOC90==902
replace camsism=37.9 if B3MSSOC90==903
replace camsism=39.8 if B3MSSOC90==904
replace camsism=25.3 if B3MSSOC90==910
replace camsism=20.8 if B3MSSOC90==911
replace camsism=20.8 if B3MSSOC90==912
replace camsism=28 if B3MSSOC90==913
replace camsism=28.4 if B3MSSOC90==919
replace camsism=29.5 if B3MSSOC90==920
replace camsism=39.4 if B3MSSOC90==921
replace camsism=32.5 if B3MSSOC90==922
replace camsism=59.2 if B3MSSOC90==923
replace camsism=43.4 if B3MSSOC90==924
replace camsism=34.2 if B3MSSOC90==929
replace camsism=31.6 if B3MSSOC90==930
replace camsism=38.9 if B3MSSOC90==931
replace camsism=43.4 if B3MSSOC90==932
replace camsism=38.3 if B3MSSOC90==933
replace camsism=38.1 if B3MSSOC90==934
replace camsism=38.3 if B3MSSOC90==940
replace camsism=38.7 if B3MSSOC90==941
replace camsism=50.7 if B3MSSOC90==950
replace camsism=39.1 if B3MSSOC90==951
replace camsism=33.3 if B3MSSOC90==952
replace camsism=35.4 if B3MSSOC90==953
replace camsism=37.8 if B3MSSOC90==954
replace camsism=25 if B3MSSOC90==955
replace camsism=38.9 if B3MSSOC90==956
replace camsism=27.3 if B3MSSOC90==957
replace camsism=26.8 if B3MSSOC90==958
replace camsism=39.7 if B3MSSOC90==959
replace camsism=25.4 if B3MSSOC90==990
replace camsism=52.3 if B3MSSOC90==999

rename camsism camsism90 

gen rgsc90=.
replace rgsc90=1 if B3MSSOC90==100
replace rgsc90=2 if B3MSSOC90==102
replace rgsc90=3 if B3MSSOC90==112
replace rgsc90=2 if B3MSSOC90==132
replace rgsc90=2 if B3MSSOC90==142
replace rgsc90=. if B3MSSOC90==150
replace rgsc90=2 if B3MSSOC90==152
replace rgsc90=2 if B3MSSOC90==160
replace rgsc90=3 if B3MSSOC90==172
replace rgsc90=2 if B3MSSOC90==173
replace rgsc90=3 if B3MSSOC90==174
replace rgsc90=3 if B3MSSOC90==176
replace rgsc90=2 if B3MSSOC90==177
replace rgsc90=2 if B3MSSOC90==179
replace rgsc90=2 if B3MSSOC90==199
replace rgsc90=1 if B3MSSOC90==200
replace rgsc90=1 if B3MSSOC90==201
replace rgsc90=1 if B3MSSOC90==202
replace rgsc90=1 if B3MSSOC90==210
replace rgsc90=1 if B3MSSOC90==211
replace rgsc90=1 if B3MSSOC90==212
replace rgsc90=1 if B3MSSOC90==213
replace rgsc90=1 if B3MSSOC90==215
replace rgsc90=1 if B3MSSOC90==216
replace rgsc90=1 if B3MSSOC90==218
replace rgsc90=1 if B3MSSOC90==219
replace rgsc90=1 if B3MSSOC90==220
replace rgsc90=1 if B3MSSOC90==221
replace rgsc90=1 if B3MSSOC90==222
replace rgsc90=1 if B3MSSOC90==223
replace rgsc90=1 if B3MSSOC90==224
replace rgsc90=1 if B3MSSOC90==230
replace rgsc90=2 if B3MSSOC90==231
replace rgsc90=1 if B3MSSOC90==232
replace rgsc90=2 if B3MSSOC90==233
replace rgsc90=2 if B3MSSOC90==234
replace rgsc90=1 if B3MSSOC90==250
replace rgsc90=1 if B3MSSOC90==253
replace rgsc90=1 if B3MSSOC90==260
replace rgsc90=1 if B3MSSOC90==261
replace rgsc90=1 if B3MSSOC90==290
replace rgsc90=1 if B3MSSOC90==292
replace rgsc90=2 if B3MSSOC90==293
replace rgsc90=2 if B3MSSOC90==300
replace rgsc90=2 if B3MSSOC90==309
replace rgsc90=2 if B3MSSOC90==311
replace rgsc90=2 if B3MSSOC90==312
replace rgsc90=2 if B3MSSOC90==313
replace rgsc90=2 if B3MSSOC90==320
replace rgsc90=2 if B3MSSOC90==332
replace rgsc90=2 if B3MSSOC90==340
replace rgsc90=2 if B3MSSOC90==343
replace rgsc90=2 if B3MSSOC90==344
replace rgsc90=2 if B3MSSOC90==346
replace rgsc90=2 if B3MSSOC90==347
replace rgsc90=2 if B3MSSOC90==348
replace rgsc90=2 if B3MSSOC90==349
replace rgsc90=2 if B3MSSOC90==350
replace rgsc90=2 if B3MSSOC90==360
replace rgsc90=2 if B3MSSOC90==361
replace rgsc90=2 if B3MSSOC90==362
replace rgsc90=2 if B3MSSOC90==364
replace rgsc90=2 if B3MSSOC90==370
replace rgsc90=2 if B3MSSOC90==371
replace rgsc90=2 if B3MSSOC90==381
replace rgsc90=2 if B3MSSOC90==383
replace rgsc90=2 if B3MSSOC90==384
replace rgsc90=2 if B3MSSOC90==385
replace rgsc90=3 if B3MSSOC90==387
replace rgsc90=2 if B3MSSOC90==390
replace rgsc90=2 if B3MSSOC90==391
replace rgsc90=2 if B3MSSOC90==392
replace rgsc90=2 if B3MSSOC90==393
replace rgsc90=3 if B3MSSOC90==399
replace rgsc90=3 if B3MSSOC90==400
replace rgsc90=3 if B3MSSOC90==401
replace rgsc90=3 if B3MSSOC90==410
replace rgsc90=3 if B3MSSOC90==411
replace rgsc90=3 if B3MSSOC90==420
replace rgsc90=3 if B3MSSOC90==430
replace rgsc90=3 if B3MSSOC90==441
replace rgsc90=3 if B3MSSOC90==452
replace rgsc90=3 if B3MSSOC90==459
replace rgsc90=3 if B3MSSOC90==462
replace rgsc90=3 if B3MSSOC90==463
replace rgsc90=3 if B3MSSOC90==490
replace rgsc90=3 if B3MSSOC90==491
replace rgsc90=4 if B3MSSOC90==500
replace rgsc90=5 if B3MSSOC90==501
replace rgsc90=4 if B3MSSOC90==502
replace rgsc90=5 if B3MSSOC90==505
replace rgsc90=4 if B3MSSOC90==507
replace rgsc90=4 if B3MSSOC90==516
replace rgsc90=4 if B3MSSOC90==521
replace rgsc90=4 if B3MSSOC90==522
replace rgsc90=4 if B3MSSOC90==524
replace rgsc90=4 if B3MSSOC90==526
replace rgsc90=4 if B3MSSOC90==529
replace rgsc90=4 if B3MSSOC90==530
replace rgsc90=4 if B3MSSOC90==531
replace rgsc90=4 if B3MSSOC90==532
replace rgsc90=4 if B3MSSOC90==533
replace rgsc90=4 if B3MSSOC90==534
replace rgsc90=4 if B3MSSOC90==535
replace rgsc90=4 if B3MSSOC90==537
replace rgsc90=4 if B3MSSOC90==540
replace rgsc90=4 if B3MSSOC90==542
replace rgsc90=4 if B3MSSOC90==543
replace rgsc90=4 if B3MSSOC90==551
replace rgsc90=4 if B3MSSOC90==554
replace rgsc90=4 if B3MSSOC90==555
replace rgsc90=4 if B3MSSOC90==557
replace rgsc90=4 if B3MSSOC90==559
replace rgsc90=4 if B3MSSOC90==579
replace rgsc90=4 if B3MSSOC90==580
replace rgsc90=4 if B3MSSOC90==581
replace rgsc90=4 if B3MSSOC90==582
replace rgsc90=4 if B3MSSOC90==590
replace rgsc90=4 if B3MSSOC90==593
replace rgsc90=5 if B3MSSOC90==594
replace rgsc90=5 if B3MSSOC90==596
replace rgsc90=5 if B3MSSOC90==599
replace rgsc90=. if B3MSSOC90==600
replace rgsc90=3 if B3MSSOC90==611
replace rgsc90=5 if B3MSSOC90==612
replace rgsc90=5 if B3MSSOC90==615
replace rgsc90=5 if B3MSSOC90==619
replace rgsc90=4 if B3MSSOC90==620
replace rgsc90=5 if B3MSSOC90==622
replace rgsc90=4 if B3MSSOC90==630
replace rgsc90=4 if B3MSSOC90==642
replace rgsc90=5 if B3MSSOC90==644
replace rgsc90=4 if B3MSSOC90==650
replace rgsc90=5 if B3MSSOC90==661
replace rgsc90=5 if B3MSSOC90==672
replace rgsc90=5 if B3MSSOC90==673
replace rgsc90=5 if B3MSSOC90==699
replace rgsc90=2 if B3MSSOC90==702
replace rgsc90=2 if B3MSSOC90==703
replace rgsc90=3 if B3MSSOC90==710
replace rgsc90=3 if B3MSSOC90==719
replace rgsc90=3 if B3MSSOC90==720
replace rgsc90=3 if B3MSSOC90==722
replace rgsc90=5 if B3MSSOC90==730
replace rgsc90=4 if B3MSSOC90==731
replace rgsc90=5 if B3MSSOC90==732
replace rgsc90=3 if B3MSSOC90==733
replace rgsc90=3 if B3MSSOC90==791
replace rgsc90=3 if B3MSSOC90==792
replace rgsc90=5 if B3MSSOC90==809
replace rgsc90=5 if B3MSSOC90==829
replace rgsc90=4 if B3MSSOC90==834
replace rgsc90=4 if B3MSSOC90==839
replace rgsc90=5 if B3MSSOC90==840
replace rgsc90=5 if B3MSSOC90==850
replace rgsc90=5 if B3MSSOC90==851
replace rgsc90=5 if B3MSSOC90==860
replace rgsc90=5 if B3MSSOC90==862
replace rgsc90=5 if B3MSSOC90==869
replace rgsc90=4 if B3MSSOC90==872
replace rgsc90=4 if B3MSSOC90==873
replace rgsc90=4 if B3MSSOC90==874
replace rgsc90=5 if B3MSSOC90==875
replace rgsc90=5 if B3MSSOC90==880
replace rgsc90=4 if B3MSSOC90==881
replace rgsc90=4 if B3MSSOC90==882
replace rgsc90=4 if B3MSSOC90==886
replace rgsc90=4 if B3MSSOC90==887
replace rgsc90=4 if B3MSSOC90==891
replace rgsc90=5 if B3MSSOC90==896
replace rgsc90=4 if B3MSSOC90==897
replace rgsc90=5 if B3MSSOC90==898
replace rgsc90=5 if B3MSSOC90==899
replace rgsc90=5 if B3MSSOC90==900
replace rgsc90=5 if B3MSSOC90==901
replace rgsc90=5 if B3MSSOC90==902
replace rgsc90=5 if B3MSSOC90==903
replace rgsc90=5 if B3MSSOC90==904
replace rgsc90=5 if B3MSSOC90==910
replace rgsc90=5 if B3MSSOC90==913
replace rgsc90=5 if B3MSSOC90==922
replace rgsc90=5 if B3MSSOC90==924
replace rgsc90=6 if B3MSSOC90==929
replace rgsc90=6 if B3MSSOC90==931
replace rgsc90=4 if B3MSSOC90==932
replace rgsc90=6 if B3MSSOC90==941
replace rgsc90=5 if B3MSSOC90==950
replace rgsc90=5 if B3MSSOC90==951
replace rgsc90=5 if B3MSSOC90==953
replace rgsc90=5 if B3MSSOC90==954
replace rgsc90=6 if B3MSSOC90==955
replace rgsc90=6 if B3MSSOC90==956
replace rgsc90=6 if B3MSSOC90==958
replace rgsc90=5 if B3MSSOC90==959
replace rgsc90=6 if B3MSSOC90==990
replace rgsc90=4 if B3MSSOC90==999

replace rgsc90=1 if B3MSSOC90==241
replace rgsc90=1 if B3MSSOC90==242
replace rgsc90=2 if B3MSSOC90==251
replace rgsc90=1 if B3MSSOC90==252
replace rgsc90=1 if B3MSSOC90==262
replace rgsc90=2 if B3MSSOC90==270
replace rgsc90=. if B3MSSOC90==271
replace rgsc90=1 if B3MSSOC90==291
replace rgsc90=2 if B3MSSOC90==301
replace rgsc90=2 if B3MSSOC90==302
replace rgsc90=2 if B3MSSOC90==303
replace rgsc90=. if B3MSSOC90==304
replace rgsc90=3 if B3MSSOC90==310
replace rgsc90=. if B3MSSOC90==330
replace rgsc90=2 if B3MSSOC90==331
replace rgsc90=2 if B3MSSOC90==342
replace rgsc90=2 if B3MSSOC90==345
replace rgsc90=2 if B3MSSOC90==363
replace rgsc90=2 if B3MSSOC90==380
replace rgsc90=2 if B3MSSOC90==382
replace rgsc90=3 if B3MSSOC90==386
replace rgsc90=2 if B3MSSOC90==394
replace rgsc90=2 if B3MSSOC90==395
replace rgsc90=2 if B3MSSOC90==396
replace rgsc90=3 if B3MSSOC90==412
replace rgsc90=3 if B3MSSOC90==440
replace rgsc90=3 if B3MSSOC90==460
replace rgsc90=5 if B3MSSOC90==503
replace rgsc90=4 if B3MSSOC90==504
replace rgsc90=4 if B3MSSOC90==506
replace rgsc90=5 if B3MSSOC90==509
replace rgsc90=4 if B3MSSOC90==510
replace rgsc90=5 if B3MSSOC90==511
replace rgsc90=5 if B3MSSOC90==512
replace rgsc90=5 if B3MSSOC90==513
replace rgsc90=4 if B3MSSOC90==514
replace rgsc90=4 if B3MSSOC90==515
replace rgsc90=4 if B3MSSOC90==517
replace rgsc90=4 if B3MSSOC90==518
replace rgsc90=4 if B3MSSOC90==519
replace rgsc90=4 if B3MSSOC90==520
replace rgsc90=4 if B3MSSOC90==523
replace rgsc90=4 if B3MSSOC90==525
replace rgsc90=4 if B3MSSOC90==536
replace rgsc90=4 if B3MSSOC90==541
replace rgsc90=5 if B3MSSOC90==544
replace rgsc90=4 if B3MSSOC90==550
replace rgsc90=4 if B3MSSOC90==552
replace rgsc90=5 if B3MSSOC90==553
replace rgsc90=4 if B3MSSOC90==556
replace rgsc90=4 if B3MSSOC90==560
replace rgsc90=4 if B3MSSOC90==561
replace rgsc90=4 if B3MSSOC90==562
replace rgsc90=4 if B3MSSOC90==563
replace rgsc90=4 if B3MSSOC90==569
replace rgsc90=4 if B3MSSOC90==570
replace rgsc90=4 if B3MSSOC90==571
replace rgsc90=4 if B3MSSOC90==572
replace rgsc90=4 if B3MSSOC90==573
replace rgsc90=4 if B3MSSOC90==591
replace rgsc90=4 if B3MSSOC90==592
replace rgsc90=5 if B3MSSOC90==595
replace rgsc90=4 if B3MSSOC90==597
replace rgsc90=4 if B3MSSOC90==598
replace rgsc90=3 if B3MSSOC90==610
replace rgsc90=2 if B3MSSOC90==613
replace rgsc90=5 if B3MSSOC90==614
replace rgsc90=5 if B3MSSOC90==621
replace rgsc90=6 if B3MSSOC90==631
replace rgsc90=2 if B3MSSOC90==640
replace rgsc90=5 if B3MSSOC90==641
replace rgsc90=5 if B3MSSOC90==652
replace rgsc90=4 if B3MSSOC90==660
replace rgsc90=4 if B3MSSOC90==670
replace rgsc90=2 if B3MSSOC90==690
replace rgsc90=2 if B3MSSOC90==691
replace rgsc90=2 if B3MSSOC90==700
replace rgsc90=2 if B3MSSOC90==701
replace rgsc90=3 if B3MSSOC90==721
replace rgsc90=3 if B3MSSOC90==790
replace rgsc90=4 if B3MSSOC90==800
replace rgsc90=4 if B3MSSOC90==801
replace rgsc90=5 if B3MSSOC90==802
replace rgsc90=4 if B3MSSOC90==810
replace rgsc90=5 if B3MSSOC90==811
replace rgsc90=5 if B3MSSOC90==812
replace rgsc90=5 if B3MSSOC90==813
replace rgsc90=5 if B3MSSOC90==814
replace rgsc90=5 if B3MSSOC90==820
replace rgsc90=4 if B3MSSOC90==821
replace rgsc90=4 if B3MSSOC90==822
replace rgsc90=4 if B3MSSOC90==823
replace rgsc90=4 if B3MSSOC90==824
replace rgsc90=5 if B3MSSOC90==825
replace rgsc90=5 if B3MSSOC90==826
replace rgsc90=4 if B3MSSOC90==830
replace rgsc90=4 if B3MSSOC90==831
replace rgsc90=4 if B3MSSOC90==832
replace rgsc90=5 if B3MSSOC90==833
replace rgsc90=5 if B3MSSOC90==841
replace rgsc90=4 if B3MSSOC90==842
replace rgsc90=5 if B3MSSOC90==843
replace rgsc90=5 if B3MSSOC90==844
replace rgsc90=5 if B3MSSOC90==859
replace rgsc90=4 if B3MSSOC90==861
replace rgsc90=5 if B3MSSOC90==863
replace rgsc90=4 if B3MSSOC90==864
replace rgsc90=4 if B3MSSOC90==870
replace rgsc90=4 if B3MSSOC90==871
replace rgsc90=4 if B3MSSOC90==883
replace rgsc90=4 if B3MSSOC90==884
replace rgsc90=4 if B3MSSOC90==885
replace rgsc90=4 if B3MSSOC90==889
replace rgsc90=5 if B3MSSOC90==890
replace rgsc90=6 if B3MSSOC90==892
replace rgsc90=5 if B3MSSOC90==893
replace rgsc90=4 if B3MSSOC90==894
replace rgsc90=5 if B3MSSOC90==895
replace rgsc90=6 if B3MSSOC90==911
replace rgsc90=6 if B3MSSOC90==912
replace rgsc90=6 if B3MSSOC90==919
replace rgsc90=4 if B3MSSOC90==920
replace rgsc90=5 if B3MSSOC90==921
replace rgsc90=6 if B3MSSOC90==923
replace rgsc90=6 if B3MSSOC90==930
replace rgsc90=6 if B3MSSOC90==933
replace rgsc90=6 if B3MSSOC90==934
replace rgsc90=5 if B3MSSOC90==940
replace rgsc90=6 if B3MSSOC90==952
replace rgsc90=6 if B3MSSOC90==957

replace rgsc90=2 if B3MSSOC90==103
replace rgsc90=3 if B3MSSOC90==110
replace rgsc90=2 if B3MSSOC90==111
replace rgsc90=2 if B3MSSOC90==113
replace rgsc90=2 if B3MSSOC90==120
replace rgsc90=2 if B3MSSOC90==121
replace rgsc90=2 if B3MSSOC90==122
replace rgsc90=2 if B3MSSOC90==123
replace rgsc90=2 if B3MSSOC90==124
replace rgsc90=2 if B3MSSOC90==125
replace rgsc90=2 if B3MSSOC90==126
replace rgsc90=2 if B3MSSOC90==127
replace rgsc90=2 if B3MSSOC90==130
replace rgsc90=2 if B3MSSOC90==131
replace rgsc90=2 if B3MSSOC90==139
replace rgsc90=2 if B3MSSOC90==140
replace rgsc90=2 if B3MSSOC90==141
replace rgsc90=. if B3MSSOC90==150
replace rgsc90=2 if B3MSSOC90==153
replace rgsc90=2 if B3MSSOC90==154
replace rgsc90=2 if B3MSSOC90==169
replace rgsc90=2 if B3MSSOC90==170
replace rgsc90=2 if B3MSSOC90==171
replace rgsc90=2 if B3MSSOC90==175
replace rgsc90=2 if B3MSSOC90==178
replace rgsc90=2 if B3MSSOC90==190
replace rgsc90=2 if B3MSSOC90==191
replace rgsc90=1 if B3MSSOC90==209
replace rgsc90=1 if B3MSSOC90==214
replace rgsc90=1 if B3MSSOC90==217
replace rgsc90=2 if B3MSSOC90==235
replace rgsc90=2 if B3MSSOC90==239
replace rgsc90=2 if B3MSSOC90==271
replace rgsc90=2 if B3MSSOC90==304
replace rgsc90=2 if B3MSSOC90==330
replace rgsc90=. if B3MSSOC90==600

replace rgsc90=2 if B3MSSOC90==341
replace rgsc90=3 if B3MSSOC90==421
replace rgsc90=3 if B3MSSOC90==450
replace rgsc90=3 if B3MSSOC90==451
replace rgsc90=3 if B3MSSOC90==461
replace rgsc90=2 if B3MSSOC90==643
replace rgsc90=3 if B3MSSOC90==651
replace rgsc90=5 if B3MSSOC90==659
replace rgsc90=4 if B3MSSOC90==671


rename rgsc90 rgscm90

gen nssec90=.
replace nssec90=1 if B3MSSOC90==100
replace nssec90=1 if B3MSSOC90==101
replace nssec90=1 if B3MSSOC90==102
replace nssec90=3 if B3MSSOC90==112
replace nssec90=3 if B3MSSOC90==132
replace nssec90=3 if B3MSSOC90==142
replace nssec90=1 if B3MSSOC90==150
replace nssec90=1 if B3MSSOC90==152
replace nssec90=5 if B3MSSOC90==160
replace nssec90=5 if B3MSSOC90==172
replace nssec90=5 if B3MSSOC90==173
replace nssec90=3 if B3MSSOC90==174
replace nssec90=3 if B3MSSOC90==176
replace nssec90=3 if B3MSSOC90==177
replace nssec90=3 if B3MSSOC90==179
replace nssec90=3 if B3MSSOC90==199
replace nssec90=2 if B3MSSOC90==200
replace nssec90=2 if B3MSSOC90==201
replace nssec90=2 if B3MSSOC90==202
replace nssec90=2 if B3MSSOC90==210
replace nssec90=2 if B3MSSOC90==211
replace nssec90=2 if B3MSSOC90==212
replace nssec90=2 if B3MSSOC90==213
replace nssec90=2 if B3MSSOC90==215
replace nssec90=2 if B3MSSOC90==216
replace nssec90=3 if B3MSSOC90==218
replace nssec90=2 if B3MSSOC90==219
replace nssec90=2 if B3MSSOC90==220
replace nssec90=2 if B3MSSOC90==221
replace nssec90=2 if B3MSSOC90==222
replace nssec90=2 if B3MSSOC90==223
replace nssec90=2 if B3MSSOC90==224
replace nssec90=2 if B3MSSOC90==230
replace nssec90=3 if B3MSSOC90==231
replace nssec90=2 if B3MSSOC90==232
replace nssec90=3 if B3MSSOC90==233
replace nssec90=3 if B3MSSOC90==234
replace nssec90=2 if B3MSSOC90==250
replace nssec90=2 if B3MSSOC90==253
replace nssec90=2 if B3MSSOC90==260
replace nssec90=2 if B3MSSOC90==261
replace nssec90=2 if B3MSSOC90==290
replace nssec90=2 if B3MSSOC90==292
replace nssec90=3 if B3MSSOC90==293
replace nssec90=3 if B3MSSOC90==300
replace nssec90=3 if B3MSSOC90==309
replace nssec90=3 if B3MSSOC90==311
replace nssec90=3 if B3MSSOC90==312
replace nssec90=3 if B3MSSOC90==313
replace nssec90=2 if B3MSSOC90==320
replace nssec90=3 if B3MSSOC90==332
replace nssec90=3 if B3MSSOC90==340
replace nssec90=3 if B3MSSOC90==343
replace nssec90=3 if B3MSSOC90==344
replace nssec90=7 if B3MSSOC90==346
replace nssec90=3 if B3MSSOC90==347
replace nssec90=2 if B3MSSOC90==348
replace nssec90=7 if B3MSSOC90==349
replace nssec90=4 if B3MSSOC90==350
replace nssec90=3 if B3MSSOC90==360
replace nssec90=3 if B3MSSOC90==361
replace nssec90=2 if B3MSSOC90==362
replace nssec90=2 if B3MSSOC90==364
replace nssec90=7 if B3MSSOC90==370
replace nssec90=3 if B3MSSOC90==371
replace nssec90=5 if B3MSSOC90==381
replace nssec90=4 if B3MSSOC90==383
replace nssec90=3 if B3MSSOC90==384
replace nssec90=3 if B3MSSOC90==385
replace nssec90=3 if B3MSSOC90==387
replace nssec90=3 if B3MSSOC90==390
replace nssec90=3 if B3MSSOC90==391
replace nssec90=3 if B3MSSOC90==392
replace nssec90=5 if B3MSSOC90==393

replace nssec90=3 if B3MSSOC90==399
replace nssec90=4 if B3MSSOC90==400
replace nssec90=4 if B3MSSOC90==401
replace nssec90=4 if B3MSSOC90==410
replace nssec90=4 if B3MSSOC90==411
replace nssec90=4 if B3MSSOC90==420
replace nssec90=4 if B3MSSOC90==430
replace nssec90=8 if B3MSSOC90==441
replace nssec90=4 if B3MSSOC90==452
replace nssec90=4 if B3MSSOC90==459
replace nssec90=7 if B3MSSOC90==462
replace nssec90=6 if B3MSSOC90==463
replace nssec90=4 if B3MSSOC90==490
replace nssec90=4 if B3MSSOC90==491
replace nssec90=5 if B3MSSOC90==500
replace nssec90=5 if B3MSSOC90==501
replace nssec90=5 if B3MSSOC90==502
replace nssec90=7 if B3MSSOC90==505
replace nssec90=5 if B3MSSOC90==507
replace nssec90=6 if B3MSSOC90==516
replace nssec90=6 if B3MSSOC90==521
replace nssec90=6 if B3MSSOC90==522
replace nssec90=6 if B3MSSOC90==524
replace nssec90=4 if B3MSSOC90==526
replace nssec90=4 if B3MSSOC90==529
replace nssec90=8 if B3MSSOC90==530
replace nssec90=7 if B3MSSOC90==531
replace nssec90=6 if B3MSSOC90==532
replace nssec90=7 if B3MSSOC90==533
replace nssec90=8 if B3MSSOC90==534
replace nssec90=7 if B3MSSOC90==535
replace nssec90=8 if B3MSSOC90==537
replace nssec90=6 if B3MSSOC90==540
replace nssec90=6 if B3MSSOC90==542
replace nssec90=6 if B3MSSOC90==543
replace nssec90=8 if B3MSSOC90==551
replace nssec90=8 if B3MSSOC90==554
replace nssec90=8 if B3MSSOC90==555
replace nssec90=7 if B3MSSOC90==557
replace nssec90=8 if B3MSSOC90==559
replace nssec90=5 if B3MSSOC90==579
replace nssec90=6 if B3MSSOC90==580
replace nssec90=8 if B3MSSOC90==581
replace nssec90=8 if B3MSSOC90==582
replace nssec90=8 if B3MSSOC90==590
replace nssec90=5 if B3MSSOC90==593
replace nssec90=6 if B3MSSOC90==594
replace nssec90=7 if B3MSSOC90==596
replace nssec90=6 if B3MSSOC90==599
replace nssec90=4 if B3MSSOC90==600
replace nssec90=4 if B3MSSOC90==611
replace nssec90=3 if B3MSSOC90==612
replace nssec90=7 if B3MSSOC90==615
replace nssec90=8 if B3MSSOC90==619
replace nssec90=7 if B3MSSOC90==620
replace nssec90=8 if B3MSSOC90==622
replace nssec90=8 if B3MSSOC90==630
replace nssec90=4 if B3MSSOC90==642
replace nssec90=7 if B3MSSOC90==644
replace nssec90=4 if B3MSSOC90==650
replace nssec90=5 if B3MSSOC90==661
replace nssec90=7 if B3MSSOC90==672
replace nssec90=8 if B3MSSOC90==673
replace nssec90=7 if B3MSSOC90==699
replace nssec90=3 if B3MSSOC90==702
replace nssec90=2 if B3MSSOC90==703
replace nssec90=3 if B3MSSOC90==710
replace nssec90=4 if B3MSSOC90==719
replace nssec90=7 if B3MSSOC90==720
replace nssec90=7 if B3MSSOC90==722
replace nssec90=5 if B3MSSOC90==730
replace nssec90=8 if B3MSSOC90==731
replace nssec90=5 if B3MSSOC90==732
replace nssec90=5 if B3MSSOC90==733
replace nssec90=8 if B3MSSOC90==791
replace nssec90=7 if B3MSSOC90==792
replace nssec90=7 if B3MSSOC90==809
replace nssec90=7 if B3MSSOC90==829
replace nssec90=7 if B3MSSOC90==834
replace nssec90=7 if B3MSSOC90==839
replace nssec90=7 if B3MSSOC90==840
replace nssec90=7 if B3MSSOC90==850
replace nssec90=7 if B3MSSOC90==851
replace nssec90=6 if B3MSSOC90==860
replace nssec90=8 if B3MSSOC90==862
replace nssec90=6 if B3MSSOC90==869
replace nssec90=8 if B3MSSOC90==872
replace nssec90=8 if B3MSSOC90==873
replace nssec90=5 if B3MSSOC90==874
replace nssec90=8 if B3MSSOC90==875
replace nssec90=7 if B3MSSOC90==880
replace nssec90=6 if B3MSSOC90==881
replace nssec90=6 if B3MSSOC90==882
replace nssec90=7 if B3MSSOC90==886
replace nssec90=7 if B3MSSOC90==887
replace nssec90=7 if B3MSSOC90==891
replace nssec90=6 if B3MSSOC90==896
replace nssec90=7 if B3MSSOC90==897
replace nssec90=6 if B3MSSOC90==898
replace nssec90=7 if B3MSSOC90==899
replace nssec90=7 if B3MSSOC90==900
replace nssec90=7 if B3MSSOC90==901
replace nssec90=8 if B3MSSOC90==902
replace nssec90=5 if B3MSSOC90==903
replace nssec90=5 if B3MSSOC90==904
replace nssec90=8 if B3MSSOC90==910
replace nssec90=8 if B3MSSOC90==913
replace nssec90=6 if B3MSSOC90==922
replace nssec90=5 if B3MSSOC90==924
replace nssec90=8 if B3MSSOC90==929
replace nssec90=8 if B3MSSOC90==931
replace nssec90=8 if B3MSSOC90==932
replace nssec90=7 if B3MSSOC90==941
replace nssec90=7 if B3MSSOC90==950
replace nssec90=8 if B3MSSOC90==951
replace nssec90=7 if B3MSSOC90==953
replace nssec90=7 if B3MSSOC90==954
replace nssec90=8 if B3MSSOC90==955
replace nssec90=5 if B3MSSOC90==956
replace nssec90=8 if B3MSSOC90==958
replace nssec90=8 if B3MSSOC90==959
replace nssec90=8 if B3MSSOC90==990
replace nssec90=8 if B3MSSOC90==999

replace nssec90=3 if B3MSSOC90==103
replace nssec90=1 if B3MSSOC90==110
replace nssec90=3 if B3MSSOC90==111
replace nssec90=1 if B3MSSOC90==113
replace nssec90=1 if B3MSSOC90==120
replace nssec90=1 if B3MSSOC90==121
replace nssec90=1 if B3MSSOC90==122
replace nssec90=1 if B3MSSOC90==123
replace nssec90=1 if B3MSSOC90==124
replace nssec90=1 if B3MSSOC90==125
replace nssec90=1 if B3MSSOC90==126
replace nssec90=4 if B3MSSOC90==127
replace nssec90=4 if B3MSSOC90==130
replace nssec90=3 if B3MSSOC90==131
replace nssec90=3 if B3MSSOC90==139
replace nssec90=3 if B3MSSOC90==140
replace nssec90=7 if B3MSSOC90==141
replace nssec90=1 if B3MSSOC90==153
replace nssec90=1 if B3MSSOC90==154
replace nssec90=5 if B3MSSOC90==169
replace nssec90=3 if B3MSSOC90==170
replace nssec90=5 if B3MSSOC90==171
replace nssec90=3 if B3MSSOC90==175
replace nssec90=5 if B3MSSOC90==178
replace nssec90=3 if B3MSSOC90==190
replace nssec90=2 if B3MSSOC90==191
replace nssec90=2 if B3MSSOC90==209
replace nssec90=2 if B3MSSOC90==214
replace nssec90=2 if B3MSSOC90==217
replace nssec90=2 if B3MSSOC90==235
replace nssec90=5 if B3MSSOC90==239

replace nssec90=2 if B3MSSOC90==241
replace nssec90=2 if B3MSSOC90==242
replace nssec90=2 if B3MSSOC90==251
replace nssec90=2 if B3MSSOC90==252
replace nssec90=2 if B3MSSOC90==262
replace nssec90=3 if B3MSSOC90==270
replace nssec90=3 if B3MSSOC90==271
replace nssec90=2 if B3MSSOC90==291
replace nssec90=3 if B3MSSOC90==301
replace nssec90=4 if B3MSSOC90==302
replace nssec90=3 if B3MSSOC90==303
replace nssec90=3 if B3MSSOC90==304
replace nssec90=4 if B3MSSOC90==310
replace nssec90=3 if B3MSSOC90==330
replace nssec90=3 if B3MSSOC90==331
replace nssec90=3 if B3MSSOC90==342
replace nssec90=4 if B3MSSOC90==345
replace nssec90=3 if B3MSSOC90==363
replace nssec90=3 if B3MSSOC90==380
replace nssec90=5 if B3MSSOC90==382
replace nssec90=4 if B3MSSOC90==386
replace nssec90=3 if B3MSSOC90==394
replace nssec90=3 if B3MSSOC90==395
replace nssec90=3 if B3MSSOC90==396
replace nssec90=4 if B3MSSOC90==412
replace nssec90=7 if B3MSSOC90==440
replace nssec90=7 if B3MSSOC90==460
replace nssec90=8 if B3MSSOC90==503
replace nssec90=5 if B3MSSOC90==504
replace nssec90=5 if B3MSSOC90==506
replace nssec90=5 if B3MSSOC90==509
replace nssec90=7 if B3MSSOC90==510
replace nssec90=7 if B3MSSOC90==511
replace nssec90=7 if B3MSSOC90==512
replace nssec90=7 if B3MSSOC90==513
replace nssec90=6 if B3MSSOC90==514
replace nssec90=6 if B3MSSOC90==515
replace nssec90=6 if B3MSSOC90==517
replace nssec90=6 if B3MSSOC90==518
replace nssec90=7 if B3MSSOC90==519
replace nssec90=6 if B3MSSOC90==520
replace nssec90=4 if B3MSSOC90==523
replace nssec90=6 if B3MSSOC90==525
replace nssec90=5 if B3MSSOC90==536
replace nssec90=6 if B3MSSOC90==541
replace nssec90=7 if B3MSSOC90==544
replace nssec90=8 if B3MSSOC90==550
replace nssec90=8 if B3MSSOC90==552
replace nssec90=8 if B3MSSOC90==553
replace nssec90=5 if B3MSSOC90==556
replace nssec90=6 if B3MSSOC90==560
replace nssec90=6 if B3MSSOC90==561
replace nssec90=8 if B3MSSOC90==562
replace nssec90=6 if B3MSSOC90==563
replace nssec90=6 if B3MSSOC90==569
replace nssec90=5 if B3MSSOC90==570
replace nssec90=8 if B3MSSOC90==571
replace nssec90=7 if B3MSSOC90==572
replace nssec90=6 if B3MSSOC90==573
replace nssec90=8 if B3MSSOC90==591
replace nssec90=4 if B3MSSOC90==592
replace nssec90=7 if B3MSSOC90==595
replace nssec90=8 if B3MSSOC90==597
replace nssec90=4 if B3MSSOC90==598
replace nssec90=4 if B3MSSOC90==610
replace nssec90=3 if B3MSSOC90==613
replace nssec90=7 if B3MSSOC90==614
replace nssec90=8 if B3MSSOC90==621
replace nssec90=6 if B3MSSOC90==631
replace nssec90=4 if B3MSSOC90==640
replace nssec90=4 if B3MSSOC90==641
replace nssec90=7 if B3MSSOC90==652
replace nssec90=8 if B3MSSOC90==660
replace nssec90=7 if B3MSSOC90==670
replace nssec90=7 if B3MSSOC90==690
replace nssec90=3 if B3MSSOC90==691
replace nssec90=3 if B3MSSOC90==700
replace nssec90=3 if B3MSSOC90==701
replace nssec90=7 if B3MSSOC90==721
replace nssec90=4 if B3MSSOC90==790
replace nssec90=7 if B3MSSOC90==800
replace nssec90=7 if B3MSSOC90==801
replace nssec90=7 if B3MSSOC90==802
replace nssec90=6 if B3MSSOC90==810
replace nssec90=8 if B3MSSOC90==811
replace nssec90=8 if B3MSSOC90==812
replace nssec90=8 if B3MSSOC90==813
replace nssec90=8 if B3MSSOC90==814
replace nssec90=6 if B3MSSOC90==820
replace nssec90=7 if B3MSSOC90==821
replace nssec90=7 if B3MSSOC90==822
replace nssec90=7 if B3MSSOC90==823
replace nssec90=7 if B3MSSOC90==824
replace nssec90=7 if B3MSSOC90==825
replace nssec90=6 if B3MSSOC90==826
replace nssec90=7 if B3MSSOC90==830
replace nssec90=7 if B3MSSOC90==831
replace nssec90=7 if B3MSSOC90==832
replace nssec90=7 if B3MSSOC90==833
replace nssec90=7 if B3MSSOC90==841
replace nssec90=7 if B3MSSOC90==842
replace nssec90=7 if B3MSSOC90==843
replace nssec90=7 if B3MSSOC90==844
replace nssec90=8 if B3MSSOC90==859
replace nssec90=6 if B3MSSOC90==861
replace nssec90=8 if B3MSSOC90==863
replace nssec90=4 if B3MSSOC90==864
replace nssec90=6 if B3MSSOC90==870
replace nssec90=6 if B3MSSOC90==871
replace nssec90=6 if B3MSSOC90==883
replace nssec90=6 if B3MSSOC90==884
replace nssec90=8 if B3MSSOC90==885
replace nssec90=8 if B3MSSOC90==889
replace nssec90=6 if B3MSSOC90==890
replace nssec90=6 if B3MSSOC90==892
replace nssec90=7 if B3MSSOC90==893
replace nssec90=7 if B3MSSOC90==894
replace nssec90=8 if B3MSSOC90==895
replace nssec90=8 if B3MSSOC90==911
replace nssec90=8 if B3MSSOC90==912
replace nssec90=8 if B3MSSOC90==919
replace nssec90=8 if B3MSSOC90==920
replace nssec90=5 if B3MSSOC90==921
replace nssec90=6 if B3MSSOC90==923
replace nssec90=8 if B3MSSOC90==930
replace nssec90=8 if B3MSSOC90==933
replace nssec90=8 if B3MSSOC90==934
replace nssec90=7 if B3MSSOC90==940
replace nssec90=7 if B3MSSOC90==952
replace nssec90=8 if B3MSSOC90==957

replace nssec90=3 if B3MSSOC90==341
replace nssec90=4 if B3MSSOC90==421
replace nssec90=4 if B3MSSOC90==450
replace nssec90=4 if B3MSSOC90==451
replace nssec90=7 if B3MSSOC90==461
replace nssec90=7 if B3MSSOC90==643
replace nssec90=7 if B3MSSOC90==651
replace nssec90=1 if B3MSSOC90==659
replace nssec90=6 if B3MSSOC90==671

rename nssec90 nssecm90

gen nssecdom2000=nssecf2000
replace nssecdom2000 = nssecm2000 if missing(nssecf2000)

label values nssecdom2000 nssec_lbl


gen nssecdom90=nssec90f
replace nssecdom90 = nssecm90 if missing(nssec90f)

label values nssecdom90 nssec_lbl


gen rgscdom2000=rgscf2000
replace rgscdom2000 = rgscm2000 if missing(rgscf2000)

label values rgscdom rgsc_lbl

gen rgscdom90=rgsc90f
replace rgscdom90 = rgscm90 if missing(rgsc90f)

label values rgscdom90 rgsc_lbl


gen camsisdom2000=camsisf2000
replace camsisdom2000 = camsism2000 if missing(camsisf2000)

gen camsisdom90=camsisf90
replace camsisdom90 = camsism90 if missing(camsisf90)

tab nssecdom2000
tab nssecdom90
tab rgscdom2000
tab rgscdom90
summarize camsisdom2000
summarize camsisdom90

rename BCSID bcsid
keep bcsid nssecdom2000 nssecdom90 rgscdom2000 rgscdom90 camsisdom2000 camsisdom90 


cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two"

merge 1:m bcsid using subsample_test

keep bcsid econ201 econbin nssecdom2000 nssecdom90 rgscdom2000 rgscdom90 camsisdom2000 camsisdom90 crecords female 

save subsample_test, replace

cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two"

save subsample_test, replace

use "G:\Stata data and do\BCS\BCS Birth\stata9\bcs7072a"

gen pmart=.
replace pmart=0 if (a0012==1)
replace pmart=1 if (a0012==2)
replace pmart=0 if (a0012==3)
replace pmart=0 if (a0012==4)
replace pmart=0 if (a0012==5)

label define pmart_lbl 0"Single" 1"Married"
label values pmart pmart_lbl

gen parity=.
replace parity=1 if(a0166==0)
replace parity=2 if(a0166==1)
replace parity=3 if(a0166==2)
replace parity=4 if(a0166==3)
replace parity=4 if(a0166>3 & a0166<18)

label define parity_lbl 1"0" 2"1" 3"2" 4"3+"
label values parity parity_lbl

gen breast=.
replace breast=0 if(a0297==1)
replace breast=1 if(a0297==2)

label define breast_lbl 0"Attempted" 1"Not Attempted"
label values breast breast_lbl

gen mage=.
replace mage=1 if(a0005a>13 & a0005a<20)
replace mage=2 if(a0005a>19 & a0005a<25)
replace mage=3 if(a0005a>24 & a0005a<30)
replace mage=4 if(a0005a>29 & a0005a<35)
replace mage=5 if(a0005a>34 & a0005a<53)

label define mage_lbl 1"less than 20" 2"20-24" 3"25-29" 4"30-34" 5"35 or more"
label values mage mage_lbl

gen med=.
replace med=1 if(a0009>6 & a0009<15)
replace med=2 if(a0009==15)
replace med=3 if(a0009==16)
replace med=4 if(a0009==17)
replace med=5 if(a0009>17 & a0009<32)

label define med 1"14 or less" 2"15" 3"16" 4"17" 5"18 or more"
label values med med_lbl 

gen fed=.
replace fed=1 if(a0010>6 & a0010<15)
replace fed=2 if(a0010==15)
replace fed=3 if(a0010==16)
replace fed=4 if(a0010==17)
replace fed=5 if(a0010>17 & a0010<32)

label define fed 1"14 or less" 2"15" 3"16" 4"17" 5"18 or more"
label values fed fed_lbl

keep bcsid pmart parity breast mage med fed

merge 1:m bcsid using subsample_test

drop _merge

save subsample_test, replace

use "G:\Stata data and do\BCS\BCS Sweep 10\UKDA-3723-stata\stata\stata11_se\sn3723"

gen htenure=.
replace htenure=0 if (d2==1)
replace htenure=0 if (d2==2)

replace htenure=1 if (d2==3)
replace htenure=1 if (d2==4)
replace htenure=1 if (d2==5)
replace htenure=1 if (d2==6)
replace htenure=1 if (d2==7)

label define tenure_lbl 0"Own Home" 1"Don't Own Home"
label value htenure tenure_lbl

tab htenure

keep bcsid htenure

cd "G:\Stata data and do\BCS\BCS Sweep 16\stata\stata11_se"

merge 1:m bcsid using bcs7016x

drop _merge

replace htenure=0 if(htenure==. & of3_1==1) 
replace htenure=0 if(htenure==. & of3_2==1) 

replace htenure=1 if(htenure==. & of3_3==1) 
replace htenure=1 if(htenure==. & of3_4==1) 
replace htenure=1 if(htenure==. & of3_5==1) 

tab htenure 

cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two"

keep bcsid htenure

merge 1:m bcsid using subsample_test

drop _merge

save subsample_test, replace

use "G:\Stata data and do\BCS\BCS Sweep 26\stata\stata11\bcs96x"

gen bin26=. 
replace bin26=1 if(b960154>4 & b960154<16)

replace bin26=0 if(b960154<5 & b960154>0)

replace bin26=1 if(b960169>4 & b960169<11)

replace bin26=0 if(b960169<5 & b960169>0)

replace bin26=0 if(b960154==. & b960157>0 & b960157<11)

replace bin26=0 if(b960169==. & b960172>0 & b960172<9)

tab bin26

keep bcsid bin26 

cd "G:\Stata data and do\BCS\BCS Sweep 30\UKDA-5558-stata\stata\stata11_se"

merge 1:m bcsid using bcs2000

gen o30=edolev1
tab o30
replace o30=. if(o30==98)
replace o30=. if(o30==99)

list bin26 o30 in 1/100


gen obinary=.
replace obinary=0 if(o30==0)
replace obinary=0 if(o30==1)
replace obinary=0 if(o30==2)
replace obinary=0 if(o30==3)
replace obinary=0 if(o30==4)

replace obinary=1 if(o30==5)
replace obinary=1 if(o30==6)
replace obinary=1 if(o30==7)
replace obinary=1 if(o30==8)
replace obinary=1 if(o30==9)
replace obinary=1 if(o30==10)
replace obinary=1 if(o30==11)
replace obinary=1 if(o30==12)
replace obinary=1 if(o30==13)
replace obinary=1 if(o30==14)
replace obinary=1 if(o30==15)

tab obinary


gen obin=.
replace obin=0 if(bin26==0)
replace obin=0 if(bin26==. & obinary==0)


replace obin=1 if(bin26==1)
replace obin=1 if(bin26==. & obinary==1)

label define obin_lbl 0"Less than Five O'Levels" 1"Five or More O'Levels"
label values obin obin_lbl

tab obin

keep bcsid obin 

cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two"

merge 1:m bcsid using subsample_test

drop _merge

save subsample_test, replace

label variable econ201 "Economic Activity of Respondent"
label variable obin "Educational Attainment O'levels"
label variable female "Sex of Respondent"
label variable htenure "Housing Tenure of Respondent when a Child"
label variable nssecdom2000 "Semi-Dominant NS-SEC Social Class of Parents when Respondent was 10 SOC2000"
label variable nssecdom90 "Semi-Dominant NS-SEC Social Class of Parents when Respondent was 10 SOC90"
label variable rgscdom2000 "Semi-Dominant RGSC Social Class of Parents when Respondent was 10 SOC2000"
label variable rgscdom90 "Semi-Dominant RGSC Social Class of Parents when Respondent was 10 SOC90"
label variable camsisdom2000 "Semi-Dominant CAMSIS Respondent was 10 SOC2000"
label variable camsisdom90 "Semi-Dominant CAMSIS Respondent was 10 SOC90"

keep if !missing(crecords)

count

misstable summarize econ201 obin htenure female nssecdom2000 rgscdom2000 camsisdom2000 

misstable patterns econ201 obin htenure female nssecdom2000 rgscdom2000 camsisdom2000 

misstable patterns econ201 obin htenure female nssecdom2000 rgscdom2000 camsisdom2000, frequency

cd "G:\Stata data and do\do files\PhD Chapters\Chapter Two"

save BCS_Variables_Complete, replace

keep if !missing(econ201, econbin, obin, female, htenure, nssecdom2000, nssecdom90, rgscdom2000, rgscdom90, camsisdom2000, camsisdom90)

count

cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two"

collect clear

table (var) (), statistic(fvfrequency econbin obin female htenure nssecdom2000 nssecdom90 rgscdom2000 rgscdom90) ///
					statistic(fvpercent econbin obin female htenure nssecdom2000 nssecdom90 rgscdom2000 rgscdom90) /// 
					statistic(mean camsisdom2000 camsisdom90) ///  
					statistic(sd camsisdom2000 camsisdom90) 			
collect remap result[fvfrequency mean] = Col[1 1] 
	collect remap result[fvpercent sd] = Col[2 2]
collect get resname = "Mean", tag(Col[1] var[mylabel]) 
	collect get resname = "SD", tag(Col[2] var[mylabel])
collect get empty = "  ", tag(Col[1] var[empty]) 
	collect get empty = "  ", tag(Col[2] var[empty])
    
count
	collect get n = `r(N)', tag(Col[2] var[n])
	
collect layout (var[0.econbin 1.econbin ///
					0.obin 1.obin ///
					0.female 1.female  ///
					0.htenure 1.htenure ///
					1.nssecdom2000 2.nssecdom2000 3.nssecdom2000 4.nssecdom2000 5.nssecdom2000 6.nssecdom2000 7.nssecdom2000 8.nssecdom2000 ///
                    1.nssecdom90 2.nssecdom90 3.nssecdom90 4.nssecdom90 5.nssecdom90 6.nssecdom90 7.nssecdom90 8.nssecdom90 ///
					1.rgscdom2000 2.rgscdom2000 3.rgscdom2000 4.rgscdom2000 5.rgscdom2000 6.rgscdom2000 ///
                    1.rgscdom90 2.rgscdom90 3.rgscdom90 4.rgscdom90 5.rgscdom90 6.rgscdom90 ///
					empty mylabel ///
					camsisdom2000 ///
                    camsisdom90 ///
					empty n]) (Col[1 2])

collect label levels Col 1 "n" 2 "%"			
collect style header Col, title(hide)
collect style header var[empty mylabel], level(hide)
collect style row stack, nobinder
collect style cell var[econbin obin female htenure nssecdom2000 nssecdom90 rgscdom2000 rgscdom90]#Col[1], nformat(%6.0fc) 
collect style cell var[econbin obin female htenure nssecdom2000 nssecdom90 rgscdom2000 rgscdom90]#Col[2], nformat(%6.2f) sformat("%s%%") 	
collect style cell var[camsisdom2000 camsisdom90], nformat(%6.2f)
collect style cell border_block[item row-header], border(top, pattern(nil)) 
collect title "Table 1: Descriptive Statistics for Economic Activity"
collect note "Data Source: BCS [Sweeps 0-4]"
collect preview

collect export "Table1BCS.docx", replace


save subsample_test2, replace

dtable i.obin i.female i.htenure i.nssecdom2000 i.nssecdom90 i.rgscdom2000 i.rgscdom90 camsisdom2000 camsisdom90, by(econbin) nformat(%6.2fc) title(Descriptive Statistics by Economic Activity) export("Table2BCSa", as(docx) replace)

dtable i.nssecdom2000, by(nssecdom90) nformat(%6.2fc) title(Descriptive Statistics comparing NS-SEC by SOC2000 and SOC90 codes) export("Table3", as(docx) replace)

dtable i.rgscdom2000, by(rgscdom90) nformat(%6.2fc) title(Descriptive Statistics comparing RGSC by SOC2000 and SOC90 codes) export("Table4", as(docx) replace)

summarize camsisdom2000, detail

summarize camsisdom90, detail

rename female sex
rename htenure tenure 
rename nssecdom2000 nssec 
rename nssecdom90 nssec90 
rename camsisdom2000 camsis 
rename camsisdom90 cam90 
rename rgscdom2000 rgsc 
rename rgscdom90 rgsc90 

egen id = seq(), from(9134)


* model building 

glm econbin, family(binomial) link(logit)
estat ic
 

logit econbin obin 
estat ic
fitstat 

logit econbin sex 
estat ic
fitstat 

logit econbin tenure 
estat ic
fitstat 

logit econbin ib(3).nssec 
estat ic
fitstat 


logit econbin obin sex 
estat ic
fitstat 

logit econbin obin sex tenure
estat ic
fitstat 

logit econbin obin sex tenure ib(3).nssec
estat ic
fitstat 

logit econbin ib(2).rgsc 
estat ic
fitstat 

logit econbin obin sex tenure ib(2).rgsc
estat ic
fitstat 

logit econbin camsis
estat ic
fitstat 

logit econbin obin sex tenure camsis
estat ic
fitstat 

*Models 

logit econbin i.obin i.sex i.tenure ib(3).nssec

est store logitnssecabcs

etable 

fitstat



* qv stats

gen qvnssec=.
replace qvnssec=1 if(nssec==3)
replace qvnssec=2 if(nssec==1)
replace qvnssec=3 if(nssec==2)
replace qvnssec=4 if(nssec==4)
replace qvnssec=5 if(nssec==5)
replace qvnssec=6 if(nssec==6)
replace qvnssec=7 if(nssec==7)
replace qvnssec=8 if(nssec==8)


label define qvnssec_lbl 1"Lower Managerial and professional occupations" 2"Large Employers and higher managerial occupations" 3"Higher professional occupations" 4"Intermediate occupations" 5"Small employers and own account workers" 6"Lower supervisory and technical occupations" 7"Semi-routine occupations" 8"Routine occupations" 
label values qvnssec qvnssec_lbl

*Graph Settings
grstyle clear
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle set color Set1
grstyle yesno draw_major_hgrid yes
grstyle yesno draw_major_ygrid yes
grstyle color major_grid gs8
grstyle linepattern major_grid dot
grstyle color ci_area gs12%50

* graphs
logit econbin i.obin i.sex i.tenure i.qvnssec

estimates store modellogitabcs

estimates restore modellogitabcs

qv i.qvnssec

matrix define LB = e(qvlb)
matrix list LB

gen lba=LB[1,1] if _n==6
gen lbb=LB[2,1] if _n==2
gen lbc=LB[3,1] if _n==4
gen lbd=LB[4,1] if _n==8
gen lbe=LB[5,1] if _n==10
gen lbf=LB[6,1] if _n==12
gen lbg=LB[7,1] if _n==14
gen lbh=LB[8,1] if _n==16
egen quasilower = rowtotal(lba lbb lbc lbd lbe lbf lbg lbh)
replace quasilower=. if(quasilower==0)

matrix define UB = e(qvub)
matrix list UB

gen uba=UB[1,1] if _n==6
gen ubb=UB[2,1] if _n==2
gen ubc=UB[3,1] if _n==4
gen ubd=UB[4,1] if _n==8
gen ube=UB[5,1] if _n==10
gen ubf=UB[6,1] if _n==12
gen ubg=UB[7,1] if _n==14
gen ubh=UB[8,1] if _n==16
egen quasiupper = rowtotal(uba ubb ubc ubd ube ubf ubg ubh)
replace quasiupper=. if(quasiupper==0)

gen b=(quasilower+quasiupper)/2

gen group=_n if _n==6
replace group=_n if _n==2
replace group=_n if _n==4
replace group=_n if _n==8
replace group=_n if _n==10
replace group=_n if _n==12
replace group=_n if _n==14
replace group=_n if _n==16

label variable group "Class"
label define region 2 "1.1" 4 "1.2" 6 "2" 8 "3" 10 "4" 12 "5" 14 "6" 16 "7"
label value group region

graph twoway scatter b group ///
|| rspike quasiupper quasilower group, vert   /// 
xlabel(2 4 6 8 10 12 14 16, valuelabel alternate )

logit econbin i.obin i.sex i.tenure i.qvnssec

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

gen lla=0 if _n==5
gen llb=A[1,8] if _n==1
gen llc=A[1,9] if _n==3
gen lld=A[1,10] if _n==7
gen lle=A[1,11] if _n==9
gen llf=A[1,12] if _n==11
gen llg=A[1,13] if _n==13
gen llh=A[1,14] if _n==15
egen lowerbound = rowtotal(lla llb llc lld lle llf llg llh)

gen ula=0 if _n==5
gen ulb=A[2,8] if _n==1
gen ulc=A[2,9] if _n==3
gen uld=A[2,10] if _n==7
gen ule=A[2,11] if _n==9
gen ulf=A[2,12] if _n==11
gen ulg=A[2,13] if _n==13
gen ulh=A[2,14] if _n==15
egen upperbound = rowtotal(ula ulb ulc uld ule ulf ulg ulh)

gen beta=(lowerbound+upperbound)/2

gen grouping=_n if _n==5
replace grouping=_n if _n==1
replace grouping=_n if _n==3
replace grouping=_n if _n==7
replace grouping=_n if _n==9
replace grouping=_n if _n==11
replace grouping=_n if _n==13
replace grouping=_n if _n==15
label variable grouping "Class"
label define regions 1 "1.1" 3 "1.2" 5 "2" 7 "3" 9 "4" 11 "5" 13 "6" 15 "7"
label value grouping regions

graph twoway scatter beta grouping ///
|| rspike upperbound lowerbound grouping, vert   /// 
xlabel(1 3 5 7 9 11 13 15, valuelabel alternate )

cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two\Final"

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) legend(label(1 "Log Odds Coefficient")) legend(label(2 "Log Odds Confidence Intervals"))) || rspike upperbound lowerbound grouping, lcolor(black) || (scatter b group, msymbol(Dh) mcolor(red) legend(label(3 "Log Odds Coefficient")) legend(label(4 "Quasi-Variance Bounds"))) || rspike quasiupper quasilower group, lcolor(red) ///
title("Predictions of Staying in Schooling versus Not by Parental NS-SEC", size(msmall) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(msmall) color(black)) ///
note("Data Source: BCS, N=723", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, and Housing Tenure included in Model", size(vsmall) color(black)) ///
xtitle("NS-SEC", size(msmall)) ///
xla(1 3 5 7 9 11 13 15, valuelabel alternate ) name(quasi1bcs, replace)

graph export "logitquasigraphbcs.png", width(6000) replace


*Marginal effects graphs
grstyle clear
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle set color Set1
grstyle yesno draw_major_hgrid yes
grstyle yesno draw_major_ygrid yes
grstyle color major_grid gs8
grstyle linepattern major_grid dot
grstyle set legend 4, box inside
grstyle color ci_area gs12%50

logit econbin i.obin i.sex i.tenure ib(3).nssec

margins nssec, atmeans saving(file1, replace)
marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) title("NS-SEC, Predictive Margins", size(msmall)) xtitle("NS-SEC", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) xlabel(1 "1.1" 2"1.2" 3"2" 4"3" 5"4" 6"5" 7"6" 8"7", labsize(msmall)) name(main1bcs, replace) 

margins, dydx(nssec)
marginsplot, recast(line) plotopts(lcolor(black)) ciopt(color(black%20)) recastci(rarea) title("NS-SEC, AMEs of Continuing Schooling", size(msmall)) xtitle("NS-SEC", size(msmall)) ytitle("Continue Schooling", size(msmall)) xlabel(1 "1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", labsize(msmall)) note("Reference Category NS-SEC 2", size(vsmall)) name(diff1bcs, replace)

graph combine main1 diff1, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental NS-SEC on Continuing Schooling", size(msmall)) note("Data Source: BCS, N=723", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(combbcs, replace)

cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two\Final"

graph export "nssecmarginsbcs.png", width(6000) replace


margins obin, atmeans saving(file6, replace)
marginsplot, recast(line) ciopt(color(black%100)) title("Educational Attainment, Predictive Margins", size(msmall)) xtitle("Educational Attainment", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) legend(on order(1 "Educational Attainment")) xlabel(0 "<5" 1 "≥5") note("Data Source: BCS, N=723", size(vsmall)) caption("NS-SEC, Sex, and Housing Tenure also included in Model", size(vsmall)) name(main2abcs, replace) 

graph export "obinmarginsbcs.png", width(6000) replace

margins sex, atmeans saving(file11, replace)
marginsplot, recast(line) ciopt(color(black%100)) title("Sex, Predictive Margins", size(msmall)) xtitle("Sex", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) legend(on order(1 "Sex")) xlabel(0 "Female" 1 "Male") note("Data Source: BCS, N=723", size(vsmall)) caption("Educational Attainment, NS-SEC, and Housing Tenure also included in Model", size(vsmall)) name(main2bbcs, replace) 

graph export "sexmarginsbcs.png", width(6000) replace

margins tenure, atmeans saving(file16, replace)
marginsplot, recast(line) ciopt(color(black%100)) title("Housing Tenure, Predictive Margins", size(msmall)) xtitle("Housing Tenure", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) legend(on order(1 "Housing Tenure")) xlabel(0 "Own" 1 "Don't") note("Data Source: BCS, N=723", size(vsmall)) caption("Educational Attainment, Sex, and NS-SEC also included in Model", size(vsmall)) name(main2cbcs, replace) 

graph export "tenuremarginsbcs.png", width(6000) replace


quietly logit econbin i.obin i.sex i.tenure ib(3).nssec
estat ic 
fitstat
predict yhat if e(sample)

ttest yhat, by(econbin)

margins, dydx(*) post

est store logitnssecccamarg

etable, append


collect style showbase all

collect label levels etable_depvar 1 "NS-SEC Model" ///
										2 "Margins Model", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: NCDS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("logitregressionchaptertwo.docx", replace)  
		
		
logit econbin i.obin i.sex i.tenure ib(2).rgsc
etable, append
estat ic 
fitstat
predict yhat2 if e(sample)

ttest yhat2, by(econbin)

margins, dydx(*) post

etable, append

logit econbin i.obin i.sex i.tenure camsis
etable, append
estat ic 
fitstat
predict yhat3 if e(sample)

ttest yhat3, by(econbin)

margins, dydx(*) post

etable, append


collect style showbase all

collect label levels etable_depvar 1 "NS-SEC Model" ///
										2 "Margins Model" ///
										3 "RGSC" ///
										4 "Margins" ///
										5 "CAMSIS" ///
										6 "Margins", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: NCDS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("logitregressionchaptertwob.docx", replace)  

		
		
		
		
		
		
*qv for rgsc 
grstyle clear
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle set color Set1
grstyle yesno draw_major_hgrid yes
grstyle yesno draw_major_ygrid yes
grstyle color major_grid gs8
grstyle linepattern major_grid dot
grstyle color ci_area gs12%50

gen qvrgsc=.
replace qvrgsc=1 if(rgsc==2)
replace qvrgsc=2 if(rgsc==1)
replace qvrgsc=3 if(rgsc==3)
replace qvrgsc=4 if(rgsc==4)
replace qvrgsc=5 if(rgsc==5)
replace qvrgsc=6 if(rgsc==6)

label define qvrgsc_lbl 1"Managerial and Technical" 2"Professional" 3"Skilled non-manual" 4"Skilled manual" 5"Partly skilled" 6"Unskilled"
label values qvrgsc qvrgsc_lbl


logit econbin i.obin i.sex i.tenure i.qvrgsc

qv i.qvrgsc

matrix define LB = e(qvlb)
matrix list LB

drop lba lbb lbc lbd lbe lbf quasilower

gen lba=LB[1,1] if _n==6
gen lbb=LB[2,1] if _n==2
gen lbc=LB[3,1] if _n==4
gen lbd=LB[4,1] if _n==8
gen lbe=LB[5,1] if _n==10
gen lbf=LB[6,1] if _n==12
egen quasilower = rowtotal(lba lbb lbc lbd lbe lbf)
replace quasilower=. if(quasilower==0)

matrix define UB = e(qvub)
matrix list UB

drop uba ubb ubc ubd ube ubf quasiupper b

gen uba=UB[1,1] if _n==6
gen ubb=UB[2,1] if _n==2
gen ubc=UB[3,1] if _n==4
gen ubd=UB[4,1] if _n==8
gen ube=UB[5,1] if _n==10
gen ubf=UB[6,1] if _n==12
egen quasiupper = rowtotal(uba ubb ubc ubd ube ubf)
replace quasiupper=. if(quasiupper==0)

gen b=(quasilower+quasiupper)/2

drop group

gen group=_n if _n==6
replace group=_n if _n==2
replace group=_n if _n==4
replace group=_n if _n==8
replace group=_n if _n==10
replace group=_n if _n==12

label variable group "Class"
label define regionrc 2 "1" 4 "2" 6 "3NM" 8 "3M" 10 "4" 12 "5" 
label value group regionrc

graph twoway scatter b group ///
|| rspike quasiupper quasilower group, vert   /// 
xlabel(2 4 6 8 10 12, valuelabel alternate )

logit econbin i.obin i.sex i.tenure i.qvrgsc

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

drop lla llb llc lld lle llf lowerbound

gen lla=0 if _n==5
gen llb=A[1,8] if _n==1
gen llc=A[1,9] if _n==3
gen lld=A[1,10] if _n==7
gen lle=A[1,11] if _n==9
gen llf=A[1,12] if _n==11
egen lowerbound = rowtotal(lla llb llc lld lle llf)

drop ula ulb ulc uld ule ulf upperbound beta

gen ula=0 if _n==5
gen ulb=A[2,8] if _n==1
gen ulc=A[2,9] if _n==3
gen uld=A[2,10] if _n==7
gen ule=A[2,11] if _n==9
gen ulf=A[2,12] if _n==11
egen upperbound = rowtotal(ula ulb ulc uld ule ulf)

gen beta=(lowerbound+upperbound)/2

drop grouping 

gen grouping=_n if _n==5
replace grouping=_n if _n==1
replace grouping=_n if _n==3
replace grouping=_n if _n==7
replace grouping=_n if _n==9
replace grouping=_n if _n==11
label variable grouping "Class"
label define regionsrc 1 "1" 3 "2" 5 "3NM" 7 "3M" 9 "4" 11 "5" 
label value grouping regionsrc

graph twoway scatter beta grouping ///
|| rspike upperbound lowerbound grouping, vert   /// 
xlabel(1 3 5 7 9 11, valuelabel alternate )

cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two\Final"

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) legend(label(1 "Log Odds Coefficient")) legend(label(2 "Log Odds Confidence Intervals"))) || rspike upperbound lowerbound grouping, lcolor(black) || (scatter b group, msymbol(Dh) mcolor(red) legend(label(3 "Log Odds Coefficient")) legend(label(4 "Quasi-Variance Bounds"))) || rspike quasiupper quasilower group, lcolor(red) ///
title("Predictions of Staying in Schooling versus Not by Parental RGSC", size(msmall) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(msmall) color(black)) ///
note("Data Source: BCS, N=723", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, and Housing Tenure included in Model", size(vsmall) color(black)) ///
xtitle("RGSC", size(msmall)) ///
xla(1"1" 3"2" 5"3NM" 7"3M" 9"4" 11"5", valuelabel alternate ) name(quasi2bcs, replace)

graph export "logitquasigraphrgsc.png", width(6000) replace

graph combine quasi1bcs quasi2bcs, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Comaprative Log Odds and Quasi-variance Statistics by Parental Social Class", size(msmall)) note("Data Source: BCS, N=723", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(combquasibcs, replace)

graph export "bcscombquasi.png", width(6000) replace


*rgsc margins graph

grstyle clear
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle set color Set1
grstyle yesno draw_major_hgrid yes
grstyle yesno draw_major_ygrid yes
grstyle color major_grid gs8
grstyle linepattern major_grid dot
grstyle set legend 4, box inside
grstyle color ci_area gs12%50

quietly logit econbin i.obin i.sex i.tenure ib(2).rgsc

margins rgsc, atmeans saving(file1a, replace)
marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) title("RGSC, Predictive Margins", size(msmall)) xtitle("RGSC", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) xlabel(1 "1" 2"2" 3"3NM" 4"3M" 5"4" 6"5", labsize(msmall)) name(main1abcs, replace) 

margins, dydx(rgsc)
marginsplot, recast(line) plotopts(lcolor(black)) ciopt(color(black%20)) recastci(rarea) title("RGSC, AMEs of Continuing Schooling", size(msmall)) xtitle("RGSC", size(msmall)) ytitle("Continue Schooling", size(msmall)) xlabel(1 "1" 2"3NM" 3"3M" 4"4" 5"5", labsize(msmall)) note("Reference Category RGSC 2", size(vsmall)) name(diff1abcs, replace)

graph combine main1abcs diff1abcs, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental RGSC on Continuing Schooling", size(msmall)) note("Data Source: BCS, N=723", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(combbcs, replace)

graph export "bcsRGSCmargins.png", width(6000) replace

*camsis margins graph 

quietly logit econbin i.obin i.sex i.tenure camsis 

margins, at(camsis =(0(1)88)) saving(file1b, replace)
marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) title("CAMSIS, Predictive Margins", size(msmall)) xtitle("CAMSIS", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) name(main1bbcs, replace) 

margins, dydx(camsis) at(camsis =(0(1)88))
marginsplot, recast(line) plotopts(lcolor(black)) ciopt(color(black%20)) recastci(rarea) title("CAMSIS, AMEs of Continuing Schooling", size(msmall)) xtitle("CAMSIS", size(msmall)) ytitle("Continue Schooling", size(msmall)) name(diff1bbcs, replace) 

graph combine main1bbcs diff1bbcs, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental CAMSIS on Continuing Schooling", size(msmall)) note("Data Source: BCS, N=723", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb1bcs, replace)

graph export "bcsCAMSISmargins.png", width(6000) replace


graph combine main1bcs main1abcs main1bbcs diff1bcs diff1abcs diff1bbcs, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental Social Stratification Measures on Continuing Schooling", size(msmall)) note("Data Source: BCS, N=723", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb2bcs, replace)

graph export "bcssocstratmargins.png", width(6000) replace


* SOC CODES... *

logit econbin ib(3).nssec90 
estat ic 
fitstat 

logit econbin obin sex tenure ib(3).nssec90
estat ic 
fitstat 

logit econbin ib(2).rgsc90 
estat ic
fitstat 

logit econbin obin sex tenure ib(3).rgsc90 
estat ic
fitstat 

logit econbin cam90
estat ic
fitstat 

logit econbin obin sex tenure cam90
estat ic
fitstat 


logit econbin i.obin i.sex i.tenure ib(3).nssec90
estat ic
fitstat
predict yhatn9b if e(sample)

ttest yhatn9b, by(econbin)

est store logitnssecb
etable, append 

logit econbin i.obin i.sex i.tenure ib(3).nssec90
margins, dydx(*) post
est store logitnssecbmargins
etable, append 


collect style showbase all

collect label levels etable_depvar 1 "NS-SEC 2000 Model" ///
										2 "NS-SEC 90 Model" /// 
										3 "NS-SEC 90 MARGINS", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: NCDS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("logitregressionchapteroneb.docx", replace) 


* qv stats

gen qvnssec90=.
replace qvnssec90=1 if(nssec90==3)
replace qvnssec90=2 if(nssec90==1)
replace qvnssec90=3 if(nssec90==2)
replace qvnssec90=4 if(nssec90==4)
replace qvnssec90=5 if(nssec90==5)
replace qvnssec90=6 if(nssec90==6)
replace qvnssec90=7 if(nssec90==7)
replace qvnssec90=8 if(nssec90==8)


label define qvnssec90_lbl 1"Lower Managerial and professional occupations" 2"Large Employers and higher managerial occupations" 3"Higher professional occupations" 4"Intermediate occupations" 5"Small employers and own account workers" 6"Lower supervisory and technical occupations" 7"Semi-routine occupations" 8"Routine occupations" 
label values qvnssec90 qvnssec90_lbl

*Graph Settings
grstyle clear
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle set color Set1
grstyle yesno draw_major_hgrid yes
grstyle yesno draw_major_ygrid yes
grstyle color major_grid gs8
grstyle linepattern major_grid dot
grstyle color ci_area gs12%50

* graphs
logit econbin i.obin i.sex i.tenure i.qvnssec90

estimates store modellogitab

estimates restore modellogitab

qv i.qvnssec90

matrix define LB = e(qvlb)
matrix list LB

drop lba lbb lbc lbd lbe lbf lbg lbh quasilower
gen lba=LB[1,1] if _n==6
gen lbb=LB[2,1] if _n==2
gen lbc=LB[3,1] if _n==4
gen lbd=LB[4,1] if _n==8
gen lbe=LB[5,1] if _n==10
gen lbf=LB[6,1] if _n==12
gen lbg=LB[7,1] if _n==14
gen lbh=LB[8,1] if _n==16
egen quasilower = rowtotal(lba lbb lbc lbd lbe lbf lbg lbh)
replace quasilower=. if(quasilower==0)

matrix define UB = e(qvub)
matrix list UB

drop uba ubb ubc ubd ube ubf ubg ubh quasiupper b

gen uba=UB[1,1] if _n==6
gen ubb=UB[2,1] if _n==2
gen ubc=UB[3,1] if _n==4
gen ubd=UB[4,1] if _n==8
gen ube=UB[5,1] if _n==10
gen ubf=UB[6,1] if _n==12
gen ubg=UB[7,1] if _n==14
gen ubh=UB[8,1] if _n==16
egen quasiupper = rowtotal(uba ubb ubc ubd ube ubf ubg ubh)
replace quasiupper=. if(quasiupper==0)

gen b=(quasilower+quasiupper)/2

drop group 
gen group=_n if _n==6
replace group=_n if _n==2
replace group=_n if _n==4
replace group=_n if _n==8
replace group=_n if _n==10
replace group=_n if _n==12
replace group=_n if _n==14
replace group=_n if _n==16

label variable group "Class"
label define regionb 2 "1.1" 4 "1.2" 6 "2" 8 "3" 10 "4" 12 "5" 14 "6" 16 "7"
label value group regionb

graph twoway scatter b group ///
|| rspike quasiupper quasilower group, vert   /// 
xlabel(2 4 6 8 10 12 14 16, valuelabel alternate )

logit econbin i.obin i.sex i.tenure i.qvnssec90

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

drop lla llb llc lld lle llf llg llh lowerbound
gen lla=0 if _n==5
gen llb=A[1,8] if _n==1
gen llc=A[1,9] if _n==3
gen lld=A[1,10] if _n==7
gen lle=A[1,11] if _n==9
gen llf=A[1,12] if _n==11
gen llg=A[1,13] if _n==13
gen llh=A[1,14] if _n==15
egen lowerbound = rowtotal(lla llb llc lld lle llf llg llh)

drop ula ulb ulc uld ule ulf ulg ulh upperbound beta
gen ula=0 if _n==5
gen ulb=A[2,8] if _n==1
gen ulc=A[2,9] if _n==3
gen uld=A[2,10] if _n==7
gen ule=A[2,11] if _n==9
gen ulf=A[2,12] if _n==11
gen ulg=A[2,13] if _n==13
gen ulh=A[2,14] if _n==15
egen upperbound = rowtotal(ula ulb ulc uld ule ulf ulg ulh)

gen beta=(lowerbound+upperbound)/2

drop grouping 
gen grouping=_n if _n==5
replace grouping=_n if _n==1
replace grouping=_n if _n==3
replace grouping=_n if _n==7
replace grouping=_n if _n==9
replace grouping=_n if _n==11
replace grouping=_n if _n==13
replace grouping=_n if _n==15
label variable grouping "Class"
label define regionsb 1 "1.1" 3 "1.2" 5 "2" 7 "3" 9 "4" 11 "5" 13 "6" 15 "7"
label value grouping regionsb

graph twoway scatter beta grouping ///
|| rspike upperbound lowerbound grouping, vert   /// 
xlabel(1 3 5 7 9 11 13 15, valuelabel alternate )

cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two\Final"

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) legend(label(1 "Log Odds Coefficient")) legend(label(2 "Log Odds Confidence Intervals"))) || rspike upperbound lowerbound grouping, lcolor(black) || (scatter b group, msymbol(Dh) mcolor(red) legend(label(3 "Log Odds Coefficient")) legend(label(4 "Quasi-Variance Bounds"))) || rspike quasiupper quasilower group, lcolor(red) ///
title("Predictions of Staying in Schooling versus Not by Parental NS-SEC (SOC90)", size(msmall) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(msmall) color(black)) ///
note("Data Source: BCS, N=723", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, and Housing Tenure included in Model", size(vsmall) color(black)) ///
xtitle("NS-SEC", size(msmall)) ///
xla(1 3 5 7 9 11 13 15, valuelabel alternate ) name(quasi1bbcs, replace)

graph export "logitquasibgraphbcs.png", width(6000) replace


graph combine quasi1bcs quasi1bbcs, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Comaprative Log Odds and Quasi-variance Statistics by SOC construction of Parental NS-SEC", size(msmall)) note("Data Source: BCS, N=723", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(combquasibcs, replace)

graph export "logitquasibcombgraphbcs.png", width(6000) replace

*rgsc90 graph
*rgsc quasi graph

grstyle clear
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle set color Set1
grstyle yesno draw_major_hgrid yes
grstyle yesno draw_major_ygrid yes
grstyle color major_grid gs8
grstyle linepattern major_grid dot
grstyle color ci_area gs12%50

gen qvrgsc90=.
replace qvrgsc90=1 if(rgsc90==2)
replace qvrgsc90=2 if(rgsc90==1)
replace qvrgsc90=3 if(rgsc90==3)
replace qvrgsc90=4 if(rgsc90==4)
replace qvrgsc90=5 if(rgsc90==5)
replace qvrgsc90=6 if(rgsc90==6)

label define qvrgsc90_lbl 1"Managerial and Technical" 2"Professional" 3"Skilled non-manual" 4"Skilled manual" 5"Partly skilled" 6"Unskilled"
label values qvrgsc90 qvrgsc90_lbl


logit econbin i.obin i.sex i.tenure i.qvrgsc90

qv i.qvrgsc90

matrix define LB = e(qvlb)
matrix list LB

drop lba lbb lbc lbd lbe lbf quasilower

gen lba=LB[1,1] if _n==6
gen lbb=LB[2,1] if _n==2
gen lbc=LB[3,1] if _n==4
gen lbd=LB[4,1] if _n==8
gen lbe=LB[5,1] if _n==10
gen lbf=LB[6,1] if _n==12
egen quasilower = rowtotal(lba lbb lbc lbd lbe lbf)
replace quasilower=. if(quasilower==0)

matrix define UB = e(qvub)
matrix list UB

drop uba ubb ubc ubd ube ubf quasiupper b

gen uba=UB[1,1] if _n==6
gen ubb=UB[2,1] if _n==2
gen ubc=UB[3,1] if _n==4
gen ubd=UB[4,1] if _n==8
gen ube=UB[5,1] if _n==10
gen ubf=UB[6,1] if _n==12
egen quasiupper = rowtotal(uba ubb ubc ubd ube ubf)
replace quasiupper=. if(quasiupper==0)

gen b=(quasilower+quasiupper)/2

drop group

gen group=_n if _n==6
replace group=_n if _n==2
replace group=_n if _n==4
replace group=_n if _n==8
replace group=_n if _n==10
replace group=_n if _n==12

label variable group "Class"
label define regionrac 2 "1" 4 "2" 6 "3NM" 8 "3M" 10 "4" 12 "5" 
label value group regionrc

graph twoway scatter b group ///
|| rspike quasiupper quasilower group, vert   /// 
xlabel(2 4 6 8 10 12, valuelabel alternate )

logit econbin i.obin i.sex i.tenure i.qvrgsc90

matrix list e(b)
matrix list r(table)
matrix define A = r(table)
matrix define A = A["ll".."ul", 1...]
matrix list A

drop lla llb llc lld lle llf lowerbound

gen lla=0 if _n==5
gen llb=A[1,8] if _n==1
gen llc=A[1,9] if _n==3
gen lld=A[1,10] if _n==7
gen lle=A[1,11] if _n==9
gen llf=A[1,12] if _n==11
egen lowerbound = rowtotal(lla llb llc lld lle llf)

drop ula ulb ulc uld ule ulf upperbound beta

gen ula=0 if _n==5
gen ulb=A[2,8] if _n==1
gen ulc=A[2,9] if _n==3
gen uld=A[2,10] if _n==7
gen ule=A[2,11] if _n==9
gen ulf=A[2,12] if _n==11
egen upperbound = rowtotal(ula ulb ulc uld ule ulf)

gen beta=(lowerbound+upperbound)/2

drop grouping 

gen grouping=_n if _n==5
replace grouping=_n if _n==1
replace grouping=_n if _n==3
replace grouping=_n if _n==7
replace grouping=_n if _n==9
replace grouping=_n if _n==11
label variable grouping "Class"
label define regionsrac 1 "1" 3 "2" 5 "3NM" 7 "3M" 9 "4" 11 "5" 
label value grouping regionsrcsub

graph twoway scatter beta grouping ///
|| rspike upperbound lowerbound grouping, vert   /// 
xlabel(1 3 5 7 9 11, valuelabel alternate )

cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two\Final"

graph twoway (scatter beta grouping, symbol(Oh) mcolor(black) legend(label(1 "Log Odds Coefficient")) legend(label(2 "Log Odds Confidence Intervals"))) || rspike upperbound lowerbound grouping, lcolor(black) || (scatter b group, msymbol(Dh) mcolor(red) legend(label(3 "Log Odds Coefficient")) legend(label(4 "Quasi-Variance Bounds"))) || rspike quasiupper quasilower group, lcolor(red) ///
title("Predictions of Staying in Schooling versus Not by Parental RGSC (SOC 90)", size(msmall) color(black)) ///
subtitle("Confidence intervals of regression coefficients, by estimation method", size(msmall) color(black)) ///
note("Data Source: BCS, N=723", size(vsmall) color(black)) ///
caption("Educational Attainment, Sex, and Housing Tenure included in Model", size(vsmall) color(black)) ///
xtitle("RGSC", size(msmall)) ///
xla(1"1" 3"2" 5"3NM" 7"3M" 9"4" 11"5", valuelabel alternate ) name(quasi2bbcs, replace)

graph export "logitquasigraphrgsc90bcs.png", width(6000) replace


graph combine quasi2bcs quasi2bbcs, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Comaprative Log Odds and Quasi-variance Statistics by SOC construction of Parental RGSC", size(msmall)) note("Data Source: BCS, N=723", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(combquasi2bcs, replace)

graph export "logitquasigraphrgsccombbcs.png", width(6000) replace

		
logit econbin i.obin i.sex i.tenure ib(2).rgsc90
estat ic
fitstat
predict yhatn9bbcs if e(sample)

ttest yhatn9bbcs, by(econbin)
etable, append 

logit econbin i.obin i.sex i.tenure ib(2).rgsc90
margins, dydx(*) post
etable, append 

logit econbin i.obin i.sex i.tenure cam90
estat ic
fitstat
predict yhatn9cbcs if e(sample)

ttest yhatn9cbcs, by(econbin)
etable, append 

logit econbin i.obin i.sex i.tenure cam90
margins, dydx(*) post
etable, append 


collect style showbase all

collect label levels etable_depvar 1 "NS-SEC 2000 Model" ///
										2 "NS-SEC 90 Model" /// 
										3 "NS-SEC 90 MARGINS", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: NCDS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("logitregressionchapteroneb.docx", replace) 
		
		

* margins graphs for soc90 
grstyle clear
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle set color Set1
grstyle yesno draw_major_hgrid yes
grstyle yesno draw_major_ygrid yes
grstyle color major_grid gs8
grstyle linepattern major_grid dot
grstyle set legend 4, box inside
grstyle color ci_area gs12%50

logit econbin i.obin i.sex i.tenure i.nssec90
margins nssec90, atmeans saving(file190bcs, replace) post

marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) title("NS-SEC, Predictive Margins", size(msmall)) xtitle("NS-SEC (SOC90)", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) xlabel(1 "1.1" 2"1.2" 3"2" 4"3" 5"4" 6"5" 7"6" 8"7", labsize(msmall)) name(main190bcs, replace) 

logit econbin i.obin i.sex i.tenure i.nssec90
margins, dydx(nssec90)
marginsplot, recast(line) plotopts(lcolor(black)) ciopt(color(black%20)) recastci(rarea) title("NS-SEC, AMEs of Continuing Schooling", size(msmall)) xtitle("NS-SEC (SOC 90)", size(msmall)) ytitle("Continue Schooling", size(msmall)) xlabel(1 "1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", labsize(msmall)) note("Reference Category NS-SEC 2", size(vsmall)) name(diff190bcs, replace)

graph combine main1 main190 diff1 diff190, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental NS-SEC on Continuing Schooling by SOC Codes", size(msmall)) note("Data Source: BCS, N=723, SOC 2000 on left, SOC 90 on right", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb1abcs, replace)

cd"G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two\Final"

graph export "ncdsnssecmarginscombbcs.png", width(6000) replace



quietly logit econbin i.obin i.sex i.tenure ib(2).rgsc90

margins rgsc90, atmeans saving(file1abcs, replace)
marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) title("RGSC, Predictive Margins", size(msmall)) xtitle("RGSC (S0C 90)", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) xlabel(1 "1" 2"2" 3"3NM" 4"3M" 5"4" 6"5", labsize(msmall)) name(main1abbcs, replace) 

quietly logit econbin i.obin i.sex i.tenure ib(2).rgsc90
margins, dydx(rgsc90)
marginsplot, recast(line) plotopts(lcolor(black)) ciopt(color(black%20)) recastci(rarea) title("RGSC, AMEs of Continuing Schooling", size(msmall)) xtitle("RGSC (SOC 90)", size(msmall)) ytitle("Continue Schooling", size(msmall)) xlabel(1 "1" 2"3NM" 3"3M" 4"4" 5"5", labsize(msmall)) note("Reference Category RGSC 2", size(vsmall)) name(diff1abbcs, replace)

graph combine main1abcs main1abbcs diff1abcs diff1abbcs, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental RGSC on Continuing Schooling by SOC Codes", size(msmall)) note("Data Source: BCS, N=723, SOC 2000 on left, SOC 90 on right", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb2abcs, replace)

graph export "ncdsRGSCmarginscombbcs.png", width(6000) replace

*camsis margins graph 

quietly logit econbin i.obin i.sex i.tenure cam90 

margins, at(cam90 =(0(1)88)) saving(file1bbcs, replace)
marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) title("CAMSIS, Predictive Margins", size(msmall)) xtitle("CAMSIS (SOC 90)", size(msmall)) ytitle("Continuing Schooling", size(msmall)) plotopts(lcolor(black) lpattern("l")) name(main1bbbcs, replace) 

quietly logit econbin i.obin i.sex i.tenure cam90 
margins, dydx(cam90) at(cam90 =(0(1)88))
marginsplot, recast(line) plotopts(lcolor(black)) ciopt(color(black%20)) recastci(rarea) title("CAMSIS, AMEs of Continuing Schooling", size(msmall)) xtitle("CAMSIS (SOC 90)", size(msmall)) ytitle("Continue Schooling", size(msmall)) name(diff1bbbcs, replace) 

graph combine main1bbcs main1bbbcs diff1bbcs diff1bbbcs, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Parental CAMSIS on Continuing Schooling by SOC Codes", size(msmall)) note("Data Source: BCS, N=723, SOC 2000 on left, SOC 90 on right", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb3abcs, replace)

graph export "ncdsCAMSISmarginscombbcs.png", width(6000) replace


graph combine main190bcs main1abbcs main1bbbcs diff190bcs diff1abbcs diff1bbbcs, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Social Stratification Measures on Continuing Schooling by SOC 90", size(msmall)) note("Data Source: BCS, N=723", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb4abcs, replace)

graph export "ncdscombmarginscomb90bcs.png", width(6000) replace


graph combine comb2bcs comb4abcs, ycommon xsize(6.5) ysize(2.7) iscale(.8) title("Predictive and Average Marginal Effects of Social Stratification Measures on Continuing Schooling by SOC 90", size(msmall)) note("Data Source: BCS, N=723", size(vsmall)) caption("Educational Attainment, Sex, and Housing Tenure also included in Model", size(vsmall)) name(comb3abcs, replace)
		
save bcscomplete, replace 
		
* Missing Data 

cd "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two"

use "G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two\subsample_test"

keep if !missing(crecords)

egen all_missing = rowmiss(econ201 obin female htenure nssecdom2000)

tab all_missing
		
pwcorr econbin obin female htenure nssecdom2000 pmart parity breast mage med fed, obs 

foreach var in pmart parity breast mage med fed{
	regress econbin `var'
	testparm `var'
}
		

mi set wide

mi register imputed econbin obin female htenure nssecdom2000 parity breast mage med fed
tab _mi_miss
		

cd"G:\Stata data and do\BCS"

mi impute chained ///
///
(logit, augment) econbin obin female htenure breast ///
///
(ologit, augment) med fed mage parity ///
///
(mlogit, augment) nssecdom2000 ///
///
, rseed(12346) dots force add(50) burnin(20) savetrace(subsample_testimpute, replace)

		
mi estimate, post dots: logit econbin i.obin i.female i.htenure ib(3).nssecdom2000
est store imp
etable
		
mimrgns, dydx(*) predict(pr) 


collect style showbase all

collect label levels etable_depvar 1 "imp", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Imputation Regression Models") ///
		titlestyles(font(Arial Narrow, size(14) bold)) ///
		note("Data Source: BCS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("impute.docx", replace)  
		
		
		
mi estimate, post vartable nocitable 

mi estimate, post dftable nocitable 
		

save imputebcs, replace
		
*merged cohorts
use"G:\Stata data and do\Tables and Figures\Tables and Figures for Chapter Two\Final\bcscomplete"


cd"G:\Stata data and do\merging"

save bcsmerge, replace

merge 1:m id using ncds4_cca

gen cohort = . 
replace cohort=0 if(id>=1 & id<=8411)
replace cohort=1 if(id>=8412 & id<=9134)

label define cohort_lbl 0"NCDS" 1"BCS"
label values cohort cohort_lbl

tab cohort

keep econbin sex tenure obin nssec nssec90 camsis cam90 rgsc rgsc90 id cohort


logit econbin i.obin i.sex i.tenure ib(3).nssec if cohort==0
estat ic
fitstat

predict yhat1 if e(sample)

ttest yhat1, by(econbin)

etable

logit econbin i.obin i.sex i.tenure ib(3).nssec if cohort==1
estat ic
fitstat

predict yhat2 if e(sample)

ttest yhat2, by(econbin)

etable, append

logit econbin i.obin i.sex i.tenure ib(3).nssec 
estat ic
fitstat

predict yhat3 if e(sample)

ttest yhat3, by(econbin)

etable, append

logit econbin i.obin i.sex i.tenure ib(3).nssec i.cohort
estat ic
fitstat

predict yhat4 if e(sample)

ttest yhat4, by(econbin)

etable, append

logit econbin obin##cohort i.sex i.tenure ib(3).nssec 
estat ic
fitstat

predict yhat5 if e(sample)

ttest yhat5, by(econbin)

etable, append

logit econbin obin##cohort sex##cohort i.tenure ib(3).nssec 
estat ic
fitstat

predict yhat6 if e(sample)

ttest yhat6, by(econbin)

etable, append

logit econbin obin##cohort sex##cohort tenure##cohort ib(3).nssec 
estat ic
fitstat

predict yhat7 if e(sample)

ttest yhat7, by(econbin)

etable, append

logit econbin obin##cohort sex##cohort tenure##cohort ib(3).nssec##cohort 
estat ic
fitstat

predict yhat8 if e(sample)

ttest yhat8, by(econbin)

etable, append


***
margins, dydx(*) post
**est store marginslogit
**etable, append
***



collect style showbase all

collect label levels etable_depvar 1 "NCDS Model" ///
										2 "BCS Model" ///
										3 "Combined Model" ///
										4 "Cohort Model" ///
										5 "Education Interaction" ///
										6 "+ Sex Interaction" ///
										7 "+ Tenure Interaction" ///
										8 "+ NS-SEC Interaction", modify

collect style cell, font(Times New Roman)

etable, replay column(depvar) ///
cstat(_r_b, nformat(%4.2f))  ///
		cstat(_r_se, nformat(%6.2f))  ///
		showstars showstarsnote  ///
		stars(.05 "*" .01 "**" .001 "***", attach(_r_b)) ///
		mstat(N) mstat(aic) mstat(bic) mstat(r2_a)	///
		title("Table 2: Regression Models") ///
		titlestyles(font(Arial Narrow, size(10) bold)) ///
		note("Data Source: NCDS and BCS") ///
		notestyles(font(Arial Narrow, size(10) italic)) ///
		export("PartOneLogit.docx", replace)  
		
		
		
		
		
		
		
*Marginal effects graphs
grstyle clear
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle set color Set1
grstyle yesno draw_major_hgrid yes
grstyle yesno draw_major_ygrid yes
grstyle color major_grid gs8
grstyle linepattern major_grid dot
grstyle set legend 4, box inside
grstyle color ci_area gs12%50

logit econbin obin##cohort sex##cohort tenure##cohort ib(3).nssec##cohort


margins if cohort==0, dydx(nssec) saving(fileinteract1, replace)

margins if cohort==1, dydx(nssec) saving(fileinteract2, replace)


save marginsmerge, replace

use fileinteract1, clear
append using fileinteract2, nolabel

merge 1:1 _n using marginsmerge 

gen n= _n

list n _margin _ci_ub _ci_lb in 1/14

gen mar1a = _margin if (n==1)
gen mar2a = _margin if (n==2)
gen mar3a = _margin if (n==3)
gen mar4a = _margin if (n==4)
gen mar5a = _margin if (n==5)
gen mar6a = _margin if (n==6)
gen mar7a = _margin if (n==7)
egen margins1a = rowtotal(mar1a mar2a mar3a mar4a mar5a mar6a mar7a)
replace margins1a=. if(margins1a==0)

tab margins1a

gen mar1uba = _ci_ub if (n==1)
gen mar2uba = _ci_ub if (n==2)
gen mar3uba = _ci_ub if (n==3)
gen mar4uba = _ci_ub if (n==4)
gen mar5uba = _ci_ub if (n==5)
gen mar6uba = _ci_ub if (n==6)
gen mar7uba = _ci_ub if (n==7)
egen margins1uba = rowtotal(mar1uba mar2uba mar3uba mar4uba mar5uba mar6uba mar7uba)
replace margins1uba=. if(margins1uba==0)

tab margins1uba

gen mar1lba = _ci_lb if (n==1)
gen mar2lba = _ci_lb if (n==2)
gen mar3lba = _ci_lb if (n==3)
gen mar4lba = _ci_lb if (n==4)
gen mar5lba = _ci_lb if (n==5)
gen mar6lba = _ci_lb if (n==6)
gen mar7lba = _ci_lb if (n==7)
egen margins1lba = rowtotal(mar1lba mar2lba mar3lba mar4lba mar5lba mar6lba mar7lba)
replace margins1lba=. if(margins1lba==0)

tab margins1lba

gen grouping=_n if _n==1
replace grouping=_n if _n==2
replace grouping=_n if _n==3
replace grouping=_n if _n==4
replace grouping=_n if _n==5
replace grouping=_n if _n==6
replace grouping=_n if _n==7
label variable grouping "Class"
label define regionsmarg 1 "1" 2 "2" 3"3" 4 "4" 5 "5" 6 "6" 7 "7"
label value grouping regionsmarg

graph twoway (line margins1a grouping, lcolor(black%100)) ///
             (rarea margins1uba margins1lba grouping, vert fcolor(black%20) lcolor(black%20)) ///
             , xlabel(1"1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", valuelabel alternate) ///
			 xtitle("NS-SEC", size(msmall)) ///
			 ytitle("Continuing Schooling", size(msmall)) ///
			 title("NS-SEC, AMEs", size(msmall)) ///
			 caption("Educational Attainment, Sex, Housing Tenure, and interactions with Cohorts also included in Model.", size(vsmall)) ///
			 note("Data Source: NCDS & BCS, N= 9134, Reference Category NS-SEC 2", size(vsmall)) ///
			 legend(label(1 "NCDS AMEs") label(2 "NCDS AME CIs")) ///
			 name(nssecdydxa, replace)
			 
			 
			 
replace _margin = .0977226 if (_n==1)
replace _margin = .077439 if (_n==2)
replace _margin = -.0061238 if (_n==3)
replace _margin = -.1569498 if (_n==4)
replace _margin = -.1632271 if (_n==5)
replace _margin = -.1088084 if (_n==6)
replace _margin = -.1071612 if (_n==7)


gen mar1b = _margin if (n==1)
gen mar2b = _margin if (n==2)
gen mar3b = _margin if (n==3)
gen mar4b = _margin if (n==4)
gen mar5b = _margin if (n==5)
gen mar6b = _margin if (n==6)
gen mar7b = _margin if (n==7)
egen margins1b = rowtotal(mar1b mar2b mar3b mar4b mar5b mar6b mar7b)
replace margins1b=. if(margins1b==0)

tab margins1b

replace _ci_ub = .2403149 if (_n==1)
replace _ci_ub = .2136167 if (_n==2)
replace _ci_ub = .116063 if (_n==3)
replace _ci_ub = -.0280375 if (_n==4)
replace _ci_ub = -.0535589 if (_n==5)
replace _ci_ub = .0122917 if (_n==6)
replace _ci_ub = .0046623 if (_n==7)

gen mar1ubb = _ci_ub if (n==1)
gen mar2ubb = _ci_ub if (n==2)
gen mar3ubb = _ci_ub if (n==3)
gen mar4ubb = _ci_ub if (n==4)
gen mar5ubb = _ci_ub if (n==5)
gen mar6ubb = _ci_ub if (n==6)
gen mar7ubb = _ci_ub if (n==7)
egen margins1ubb = rowtotal(mar1ubb mar2ubb mar3ubb mar4ubb mar5ubb mar6ubb mar7ubb)
replace margins1ubb=. if(margins1ubb==0)

tab margins1ubb

replace _ci_lb = -.0448696 if (_n==1)
replace _ci_lb = -.0587387 if (_n==2)
replace _ci_lb = -.1283107 if (_n==3)
replace _ci_lb = -.2858622 if (_n==4)
replace _ci_lb = -.2728953 if (_n==5)
replace _ci_lb = -.2299085 if (_n==6)
replace _ci_lb = -.2189847 if (_n==7)

gen mar1lbb = _ci_lb if (n==1)
gen mar2lbb = _ci_lb if (n==2)
gen mar3lbb = _ci_lb if (n==3)
gen mar4lbb = _ci_lb if (n==4)
gen mar5lbb = _ci_lb if (n==5)
gen mar6lbb = _ci_lb if (n==6)
gen mar7lbb = _ci_lb if (n==7)
egen margins1lbb = rowtotal(mar1lbb mar2lbb mar3lbb mar4lbb mar5lbb mar6lbb mar7lbb)
replace margins1lbb=. if(margins1lbb==0)

tab margins1lbb

gen groupingb=_n if _n==1
replace groupingb=_n if _n==2
replace groupingb=_n if _n==3
replace groupingb=_n if _n==4
replace groupingb=_n if _n==5
replace groupingb=_n if _n==6
replace groupingb=_n if _n==7
label variable groupingb "Class"
label define regionsmargb 1 "1" 2 "2" 3"3" 4 "4" 5 "5" 6 "6" 7 "7"
label value groupingb regionsmargb


graph twoway (line margins1b groupingb, lcolor(black%100)) ///
             (rarea margins1ubb margins1lbb groupingb, vert fcolor(black%20) lcolor(black%20)) ///
             , xlabel(1"1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", valuelabel alternate) ///
			 xtitle("NS-SEC", size(msmall)) ///
			 ytitle("Continuing Schooling", size(msmall)) ///
			 title("NS-SEC, AMEs", size(msmall)) ///
			 caption("Educational Attainment, Sex, Housing Tenure, and interactions with Cohorts also included in Model.", size(vsmall)) ///
			 note("Data Source: NCDS & BCS, N= 9134, Reference Category NS-SEC 2", size(vsmall)) ///
			 legend(label(1 "BCS AMEs") label(2 "BCS AME CIs"))	///
			 name(nssecdydxb, replace)

			 
grstyle clear
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle set color Set1
grstyle yesno draw_major_hgrid yes
grstyle yesno draw_major_ygrid yes
grstyle color major_grid gs8
grstyle linepattern major_grid dot
grstyle set legend 4, box inside
grstyle color ci_area gs12%50
			 

graph twoway (line margins1a grouping, lcolor(black%100) lpattern(l)) || (rarea margins1uba margins1lba grouping, vert fcolor(black%20) lcolor(black%20)) || (line margins1b groupingb, lcolor(black%100) lpattern(-)) || (rarea margins1ubb margins1lbb groupingb, vert fcolor(black%20) lcolor(black%20)) ///
             , xlabel(1"1.1" 2"1.2" 3"3" 4"4" 5"5" 6"6" 7"7", valuelabel alternate) ///
			 legend(rows(2)) ///
			 legend(order(1 "NCDS" 3 "BCS")) ///
			 xtitle("NS-SEC", size(msmall)) ///
			 ytitle("Continuing Schooling", size(msmall)) ///
			 title("AMEs", size(msmall)) ///
			 name(nssecdydxbcomb, replace) ///
			 saving(nssecdydxbcomb, replace)
			 

logit econbin obin##cohort sex##cohort tenure##cohort ib(3).nssec##cohort

margins cohort, at(nssec=(1 2 3 4 5 6 7 8))

marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) ///
    title("Predictive Margins", size(msmall)) ///
    xtitle("NS-SEC", size(msmall)) ///
    ytitle("Continuing Schooling", size(msmall)) ///
    plot1opts(lcolor(black) lpattern("l")) ///
	plot2opts(lcolor(black) lpattern("-")) ///
    xlabel(1 "1.1" 2 "1.2" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7", labsize(msmall)) ///
	name(nssecpredcomb, replace) ///
	saving(nssecpredcomb, replace)
	
	
graph combine nssecdydxbcomb.gph nssecpredcomb.gph, ///
title("Predictive and Average Marginal Effects of NS-SEC on Continuing Schooling by Cohorts", size(small)) ///
caption("Educational Attainment, Sex, Housing Tenure, and interactions with Cohorts also included in Model.", size(vsmall)) ///
note("Data Source: NCDS & BCS, N= 9134, Reference Category NS-SEC 2 for AMEs", size(vsmall)) ///
ycommon 

cd"G:\Stata data and do\Tables and Figures\Merged NCDS and BCS\Final"

graph export "nsseccombcohort.png", width(6000) replace

			 
			 
margins cohort, at(obin=(0 1))
marginsplot

margins cohort, at(sex=(0 1))
marginsplot

margins cohort, at(tenure=(0 1))
marginsplot			 
			 
			 
			 	
		

margins cohort, atmeans 

marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) ///
    title("Predictive Margins", size(msmall)) ///
    xtitle("Cohorts", size(msmall)) ///
    ytitle("Continuing Schooling", size(msmall)) ///
    plot1opts(lcolor(black) lpattern("l")) ///
	name(cohortpredcomb, replace) ///
	saving(cohortpredcomb, replace)

		
margins cohort, at(obin=(0 1)) vsquish

marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) ///
    title("Predictive Margins", size(msmall)) ///
    xtitle("Educational Attainment", size(msmall)) ///
    ytitle("Continuing Schooling", size(msmall)) ///
    plot1opts(lcolor(black) lpattern("l")) ///
	plot2opts(lcolor(black) lpattern("-")) ///
    xlabel(0 "<5" 1 "≥5", labsize(msmall)) ///
	name(obinpredcomb, replace) ///
	saving(obinpredcomb, replace)
	
graph export "obincombcohort.png", width(6000) replace


margins cohort, at(sex=(0 1)) vsquish

marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) ///
    title("Predictive Margins", size(msmall)) ///
    xtitle("Sex", size(msmall)) ///
    ytitle("Continuing Schooling", size(msmall)) ///
    plot1opts(lcolor(black) lpattern("l")) ///
	plot2opts(lcolor(black) lpattern("-")) ///
    xlabel(0 "Female" 1 "Male", labsize(msmall)) ///
	name(sexpredcomb, replace) ///
	saving(sexpredcomb, replace)
	
graph export "sexcombcohort.png", width(6000) replace


margins cohort, at(tenure=(0 1)) vsquish

marginsplot, recast(line) ciopt(color(black%20)) recastci(rarea) ///
    title("Predictive Margins", size(msmall)) ///
    xtitle("Housing Tenure", size(msmall)) ///
    ytitle("Continuing Schooling", size(msmall)) ///
    plot1opts(lcolor(black) lpattern("l")) ///
	plot2opts(lcolor(black) lpattern("-")) ///
    xlabel(0 "Own Home" 1 "Don't", labsize(msmall)) ///
	name(tenurepredcomb, replace) ///
	saving(tenurepredcomb, replace)

graph export "tenurecombcohort.png", width(6000) replace



/// Why do interactions not have marginal effects? The marginal effect of a discrete explanatory variable is defined as the expected outcome difference associated with a unit change in that explanatory variable. Now, what is a unit change in, say, 2.time#1.strict? It could be a change from time = 1 (or 3) and strict = 1 to time = 2 and strict = 1. Or it could be a change from time = 2 and strict = 0 to time = 2 and strict = 1. Any of those three possibilities produces a unit change of 2.time#1.strict from 0 to 1. But those three ways of changing 2.time#1.strict will, in general, have different associated changes in the outcome. In fact, the only situation in which those three things will not have different changes in the outcome is if the outcome does not depend on time or strict! So the "marginal effect" of 2.time#1.strict is ill-defined because it could be any of three different values. (With continuous variables the situation is infinitely worse.) The same reasoning just applied to 2.time#1.strict applies similarly to any of the interactions.
///

