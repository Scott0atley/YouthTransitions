
/*====================================================================
                        1: Recoding Economic Activity 
====================================================================*/
cd "$fld"

gen ec201=.
replace ec201=1 if(va86sep==5)
replace ec201=1 if(va86sep==6)
replace ec201=1 if(va86sep==7)

replace ec201=2 if(va86sep==4)

replace ec201=3 if(va86sep==3)

replace ec201=4 if(va86sep==1)
replace ec201=4 if(va86sep==2)

gen finalecon=ec201

replace finalecon = econ201 if missing(ec201)

rename econ201 e201

gen econ201=ec201 

replace econ201 = e201 if missing(ec201)

gen econbin=.
replace econbin = 1 if (finalecon==2)
replace econbin = 0 if (finalecon==1)
replace econbin = 0 if (finalecon==3)
replace econbin = 0 if (finalecon==4)


/*====================================================================
                        2: Recoding Educational Attainment 
====================================================================*/
gen bin26=. 
replace bin26=1 if(b960154>4 & b960154<16)

replace bin26=0 if(b960154<5 & b960154>0)

replace bin26=1 if(b960169>4 & b960169<11)

replace bin26=0 if(b960169<5 & b960169>0)

replace bin26=0 if(b960154==. & b960157>0 & b960157<11)

replace bin26=0 if(b960169==. & b960172>0 & b960172<9)

gen o30=edolev1
tab o30
replace o30=. if(o30==98)
replace o30=. if(o30==99)

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

gen obin=.
replace obin=0 if(bin26==0)
replace obin=0 if(bin26==. & obinary==0)

replace obin=1 if(bin26==1)
replace obin=1 if(bin26==. & obinary==1)

/*====================================================================
                        3: Recoding Sex 
====================================================================*/
rename sex sexother

gen sex=. 
replace sex=0 if (a0255==2)
replace sex=1 if (a0255==1)

replace sex=0 if (a0255==. & sexother==2)
replace sex=1 if (a0255==. & sexother==1)

replace sex=0 if (a0255==. & dmsex==2)
replace sex=1 if (a0255==. & dmsex==1)

replace sex=0 if (a0255==. & sex86==2)
replace sex=1 if (a0255==. & sex86==1)

replace sex=0 if (a0255==. & a4a_2==2)
replace sex=1 if (a0255==. & a4a_2==1)

/*====================================================================
                        4: Recoding Housing Tenure 
====================================================================*/
rename tenure tenureother

gen tenure=.
replace tenure=0 if (d2==1)
replace tenure=0 if (d2==2)

replace tenure=1 if (d2==3)
replace tenure=1 if (d2==4)
replace tenure=1 if (d2==5)
replace tenure=1 if (d2==6)
replace tenure=1 if (d2==7)

replace tenure=0 if(tenure==. & of3_1==1) 
replace tenure=0 if(tenure==. & of3_2==1) 

replace tenure=1 if(tenure==. & of3_3==1) 
replace tenure=1 if(tenure==. & of3_4==1) 
replace tenure=1 if(tenure==. & of3_5==1) 

/*====================================================================
                        5: Recoding Social Stratification Measures
====================================================================*/

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

rename nssecm nssecm2000

gen rgscm=.
replace rgscm=1 if (B3MSRGSC==1)
replace rgscm=2 if (B3MSRGSC==2)
replace rgscm=3 if (B3MSRGSC==3.1)
replace rgscm=4 if (B3MSRGSC==3.2)
replace rgscm=5 if (B3MSRGSC==4)
replace rgscm=6 if (B3MSRGSC==5)

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

gen nssec=nssecf2000
replace nssec = nssecm2000 if missing(nssecf2000)

gen nssec90=nssec90f
replace nssec90 = nssecm90 if missing(nssec90f)

gen rgsc=rgscf2000
replace rgsc = rgscm2000 if missing(rgscf2000)

gen rgsc90=rgsc90f
replace rgsc90 = rgscm90 if missing(rgsc90f)

gen camsis=camsisf2000
replace camsis = camsism2000 if missing(camsisf2000)

gen cam90=camsisf90
replace cam90 = camsism90 if missing(camsisf90)

/*====================================================================
                        6: Quasi-Variance Social Stratification
====================================================================*/

gen qvnssec=.
replace qvnssec=1 if(nssec==3)
replace qvnssec=2 if(nssec==1)
replace qvnssec=3 if(nssec==2)
replace qvnssec=4 if(nssec==4)
replace qvnssec=5 if(nssec==5)
replace qvnssec=6 if(nssec==6)
replace qvnssec=7 if(nssec==7)
replace qvnssec=8 if(nssec==8)

gen qvrgsc=.
replace qvrgsc=1 if(rgsc==2)
replace qvrgsc=2 if(rgsc==1)
replace qvrgsc=3 if(rgsc==3)
replace qvrgsc=4 if(rgsc==4)
replace qvrgsc=5 if(rgsc==5)
replace qvrgsc=6 if(rgsc==6)

gen qvnssec90=.
replace qvnssec90=1 if(nssec90==3)
replace qvnssec90=2 if(nssec90==1)
replace qvnssec90=3 if(nssec90==2)
replace qvnssec90=4 if(nssec90==4)
replace qvnssec90=5 if(nssec90==5)
replace qvnssec90=6 if(nssec90==6)
replace qvnssec90=7 if(nssec90==7)
replace qvnssec90=8 if(nssec90==8)

gen qvrgsc90=.
replace qvrgsc90=1 if(rgsc90==2)
replace qvrgsc90=2 if(rgsc90==1)
replace qvrgsc90=3 if(rgsc90==3)
replace qvrgsc90=4 if(rgsc90==4)
replace qvrgsc90=5 if(rgsc90==5)
replace qvrgsc90=6 if(rgsc90==6)

/*====================================================================
                        7: Auxillary Variables 
====================================================================*/

gen pmart=.
replace pmart=0 if (a0012==1)
replace pmart=1 if (a0012==2)
replace pmart=0 if (a0012==3)
replace pmart=0 if (a0012==4)
replace pmart=0 if (a0012==5)

gen parity=.
replace parity=1 if(a0166==0)
replace parity=2 if(a0166==1)
replace parity=3 if(a0166==2)
replace parity=4 if(a0166==3)
replace parity=4 if(a0166>3 & a0166<18)

gen breast=.
replace breast=0 if(a0297==1)
replace breast=1 if(a0297==2)

gen mage=.
replace mage=1 if(a0005a>13 & a0005a<20)
replace mage=2 if(a0005a>19 & a0005a<25)
replace mage=3 if(a0005a>24 & a0005a<30)
replace mage=4 if(a0005a>29 & a0005a<35)
replace mage=5 if(a0005a>34 & a0005a<53)
		
gen med=.
replace med=1 if(a0009>6 & a0009<15)
replace med=2 if(a0009==15)
replace med=3 if(a0009==16)
replace med=4 if(a0009==17)
replace med=5 if(a0009>17 & a0009<32)

gen fed=.
replace fed=1 if(a0010>6 & a0010<15)
replace fed=2 if(a0010==15)
replace fed=3 if(a0010==16)
replace fed=4 if(a0010==17)
replace fed=5 if(a0010>17 & a0010<32)

