

cd "/Users/ScottOatley/Documents/NCDSClass/stata9"
use "/Users/ScottOatley/Documents/NCDSClass/stata9/ncds2_occupation_coding_father"


cd "/Users/ScottOatley/Documents/NCDS Sweep 16/stata/stata11"


rename NCDSID ncdsid
  
merge 1:1 ncdsid using ncds0123
drop _merge


cd "/Users/ScottOatley/Documents/NCDS Sweep 23/stata/stata9"


merge 1:1 ncdsid using ncds4
drop _merge


codebook ec201 n4655 n4656 n622_4 n2017 n1152 N2SNSSEC N2SCMSIS N2SRGSC n923 n926, compact


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

gen camsisf=.
replace camsisf=85.6 if N2SSOC90==100
replace camsisf=71.5 if N2SSOC90==101
replace camsisf=70.7 if N2SSOC90==102
replace camsisf=69.3 if N2SSOC90==103
replace camsisf=59.5 if N2SSOC90==110
replace camsisf=58.2 if N2SSOC90==111
replace camsisf=55.4 if N2SSOC90==112
replace camsisf=66.2 if N2SSOC90==113
replace camsisf=76.4 if N2SSOC90==120
replace camsisf=65.9 if N2SSOC90==121
replace camsisf=61.5 if N2SSOC90==122
replace camsisf=71 if N2SSOC90==123
replace camsisf=70.4 if N2SSOC90==124
replace camsisf=70.4 if N2SSOC90==125
replace camsisf=69.9 if N2SSOC90==126
replace camsisf=70 if N2SSOC90==127
replace camsisf=58.5 if N2SSOC90==130
replace camsisf=65.1 if N2SSOC90==131
replace camsisf=64.1 if N2SSOC90==132
replace camsisf=63.7 if N2SSOC90==139
replace camsisf=57.5 if N2SSOC90==140
replace camsisf=50.3 if N2SSOC90==141
replace camsisf=48.3 if N2SSOC90==142
replace camsisf=77 if N2SSOC90==150
replace camsisf=68.6 if N2SSOC90==151
replace camsisf=60 if N2SSOC90==152
replace camsisf=68.6 if N2SSOC90==153
replace camsisf=68.6 if N2SSOC90==154
replace camsisf=68.6 if N2SSOC90==155
replace camsisf=55.4 if N2SSOC90==160
replace camsisf=52.6 if N2SSOC90==169
replace camsisf=68.5 if N2SSOC90==170
replace camsisf=56.4 if N2SSOC90==171
replace camsisf=56.9 if N2SSOC90==172
replace camsisf=56.5 if N2SSOC90==173
replace camsisf=54 if N2SSOC90==174
replace camsisf=50.7 if N2SSOC90==175
replace camsisf=58.1 if N2SSOC90==176
replace camsisf=73.2 if N2SSOC90==177
replace camsisf=49.4 if N2SSOC90==178
replace camsisf=59.5 if N2SSOC90==179
replace camsisf=71.7 if N2SSOC90==190
replace camsisf=82.3 if N2SSOC90==191
replace camsisf=63.5 if N2SSOC90==199

replace camsisf=73.4 if N2SSOC90==200
replace camsisf=74.7 if N2SSOC90==201
replace camsisf=84.4 if N2SSOC90==202
replace camsisf=81.4 if N2SSOC90==209
replace camsisf=66.6 if N2SSOC90==210
replace camsisf=68.5 if N2SSOC90==211
replace camsisf=68.3 if N2SSOC90==212
replace camsisf=67.1 if N2SSOC90==213
replace camsisf=81.9 if N2SSOC90==214
replace camsisf=80.3 if N2SSOC90==215
replace camsisf=64.2 if N2SSOC90==216
replace camsisf=55.8 if N2SSOC90==217
replace camsisf=60.2 if N2SSOC90==218
replace camsisf=64.9 if N2SSOC90==219
replace camsisf=87.4 if N2SSOC90==220
replace camsisf=73.7 if N2SSOC90==221
replace camsisf=80.2 if N2SSOC90==222
replace camsisf=83.7 if N2SSOC90==223
replace camsisf=79.6 if N2SSOC90==224
replace camsisf=82.3 if N2SSOC90==230
replace camsisf=63.8 if N2SSOC90==231
replace camsisf=79.9 if N2SSOC90==232
replace camsisf=70.9 if N2SSOC90==233
replace camsisf=65.5 if N2SSOC90==234
replace camsisf=65.8 if N2SSOC90==235
replace camsisf=66.9 if N2SSOC90==239
replace camsisf=85.7 if N2SSOC90==240
replace camsisf=87.9 if N2SSOC90==241
replace camsisf=85.2 if N2SSOC90==242
replace camsisf=72.5 if N2SSOC90==250
replace camsisf=68 if N2SSOC90==251
replace camsisf=75.3 if N2SSOC90==252
replace camsisf=81.6 if N2SSOC90==253
replace camsisf=79.6 if N2SSOC90==260
replace camsisf=86.3 if N2SSOC90==261
replace camsisf=68.1 if N2SSOC90==262
replace camsisf=86.2 if N2SSOC90==270
replace camsisf=76.5 if N2SSOC90==271
replace camsisf=94 if N2SSOC90==290
replace camsisf=79.8 if N2SSOC90==291
replace camsisf=82.2 if N2SSOC90==292
replace camsisf=73.6 if N2SSOC90==293

replace camsisf=61.3 if N2SSOC90==300
replace camsisf=51.6 if N2SSOC90==301
replace camsisf=49.6 if N2SSOC90==302
replace camsisf=67.4 if N2SSOC90==303
replace camsisf=58.2 if N2SSOC90==304
replace camsisf=51.8 if N2SSOC90==309
replace camsisf=59.3 if N2SSOC90==310
replace camsisf=62.1 if N2SSOC90==311
replace camsisf=69.7 if N2SSOC90==312
replace camsisf=63.3 if N2SSOC90==313
replace camsisf=69.2 if N2SSOC90==320
replace camsisf=71.8 if N2SSOC90==330
replace camsisf=73.9 if N2SSOC90==331
replace camsisf=55.8 if N2SSOC90==332
replace camsisf=52.4 if N2SSOC90==340
replace camsisf=59.8 if N2SSOC90==341
replace camsisf=66.3 if N2SSOC90==342
replace camsisf=66.1 if N2SSOC90==343
replace camsisf=66.9 if N2SSOC90==344
replace camsisf=66.3 if N2SSOC90==345
replace camsisf=46.7 if N2SSOC90==346
replace camsisf=66.3 if N2SSOC90==347
replace camsisf=67.9 if N2SSOC90==348
replace camsisf=43.9 if N2SSOC90==349
replace camsisf=65.7 if N2SSOC90==350
replace camsisf=56.2 if N2SSOC90==360
replace camsisf=68.1 if N2SSOC90==361
replace camsisf=67.8 if N2SSOC90==362
replace camsisf=63.1 if N2SSOC90==363
replace camsisf=72.2 if N2SSOC90==364
replace camsisf=60.4 if N2SSOC90==370
replace camsisf=62.8 if N2SSOC90==371
replace camsisf=75.8 if N2SSOC90==380
replace camsisf=71.9 if N2SSOC90==381
replace camsisf=65.4 if N2SSOC90==382
replace camsisf=70.9 if N2SSOC90==383
replace camsisf=70.7 if N2SSOC90==384
replace camsisf=71.9 if N2SSOC90==385
replace camsisf=64.6 if N2SSOC90==386
replace camsisf=70.4 if N2SSOC90==387
replace camsisf=70.1 if N2SSOC90==390
replace camsisf=54.2 if N2SSOC90==391
replace camsisf=57 if N2SSOC90==392
replace camsisf=54.4 if N2SSOC90==393
replace camsisf=53.7 if N2SSOC90==394
replace camsisf=69.5 if N2SSOC90==395
replace camsisf=58.2 if N2SSOC90==396
replace camsisf=61.5 if N2SSOC90==399

replace camsisf=50.9 if N2SSOC90==400
replace camsisf=57.2 if N2SSOC90==401
replace camsisf=58.3 if N2SSOC90==410
replace camsisf=53.9 if N2SSOC90==411
replace camsisf=42.6 if N2SSOC90==412
replace camsisf=50.6 if N2SSOC90==420
replace camsisf=50.5 if N2SSOC90==421
replace camsisf=51.9 if N2SSOC90==430
replace camsisf=36 if N2SSOC90==440
replace camsisf=37.5 if N2SSOC90==441
replace camsisf=62.6 if N2SSOC90==450
replace camsisf=62.6 if N2SSOC90==451
replace camsisf=62.6 if N2SSOC90==452
replace camsisf=62.3 if N2SSOC90==459
replace camsisf=51.4 if N2SSOC90==460
replace camsisf=51.4 if N2SSOC90==461
replace camsisf=49.3 if N2SSOC90==462
replace camsisf=46.5 if N2SSOC90==463
replace camsisf=51.6 if N2SSOC90==490
replace camsisf=57.6 if N2SSOC90==491

replace camsisf=33.9 if N2SSOC90==500
replace camsisf=34.2 if N2SSOC90==501
replace camsisf=36.4 if N2SSOC90==502
replace camsisf=39.7 if N2SSOC90==503
replace camsisf=46.5 if N2SSOC90==504
replace camsisf=33.7 if N2SSOC90==505
replace camsisf=43.2 if N2SSOC90==506
replace camsisf=38.8 if N2SSOC90==507
replace camsisf=38.4 if N2SSOC90==509
replace camsisf=38.6 if N2SSOC90==510
replace camsisf=33.7 if N2SSOC90==511
replace camsisf=32 if N2SSOC90==512
replace camsisf=36.6 if N2SSOC90==513
replace camsisf=24.7 if N2SSOC90==514
replace camsisf=42.8 if N2SSOC90==515
replace camsisf=41.2 if N2SSOC90==516
replace camsisf=46.5 if N2SSOC90==517
replace camsisf=57.1 if N2SSOC90==518
replace camsisf=30.3 if N2SSOC90==519
replace camsisf=47.4 if N2SSOC90==520
replace camsisf=45.4 if N2SSOC90==521
replace camsisf=54.8 if N2SSOC90==522
replace camsisf=48.9 if N2SSOC90==523
replace camsisf=41.5 if N2SSOC90==524
replace camsisf=47.4 if N2SSOC90==525
replace camsisf=54.1 if N2SSOC90==526
replace camsisf=50.3 if N2SSOC90==529
replace camsisf=33.2 if N2SSOC90==530
replace camsisf=18.3 if N2SSOC90==531
replace camsisf=43.5 if N2SSOC90==532
replace camsisf=38.6 if N2SSOC90==533
replace camsisf=33.9 if N2SSOC90==534
replace camsisf=31.9 if N2SSOC90==535
replace camsisf=37.7 if N2SSOC90==536
replace camsisf=33.3 if N2SSOC90==537
replace camsisf=43.3 if N2SSOC90==540
replace camsisf=38.8 if N2SSOC90==541
replace camsisf=39.9 if N2SSOC90==542
replace camsisf=54.2 if N2SSOC90==543
replace camsisf=42.5 if N2SSOC90==544
replace camsisf=13.7 if N2SSOC90==550
replace camsisf=26.4 if N2SSOC90==551
replace camsisf=26.3 if N2SSOC90==552
replace camsisf=33.3 if N2SSOC90==553
replace camsisf=42.4 if N2SSOC90==554
replace camsisf=39.8 if N2SSOC90==555
replace camsisf=44.9 if N2SSOC90==556
replace camsisf=33.1 if N2SSOC90==557
replace camsisf=39.3 if N2SSOC90==559
replace camsisf=51.1 if N2SSOC90==560
replace camsisf=48.7 if N2SSOC90==561
replace camsisf=38.5 if N2SSOC90==562
replace camsisf=43.9 if N2SSOC90==563
replace camsisf=38.5 if N2SSOC90==569
replace camsisf=41.5 if N2SSOC90==570
replace camsisf=43.6 if N2SSOC90==571
replace camsisf=21.2 if N2SSOC90==572
replace camsisf=41.7 if N2SSOC90==573
replace camsisf=44.1 if N2SSOC90==579
replace camsisf=33.5 if N2SSOC90==580
replace camsisf=33.6 if N2SSOC90==581
replace camsisf=24.6 if N2SSOC90==582
replace camsisf=24.6 if N2SSOC90==590
replace camsisf=19.5 if N2SSOC90==591
replace camsisf=63.6 if N2SSOC90==592
replace camsisf=66 if N2SSOC90==593
replace camsisf=37.8 if N2SSOC90==594
replace camsisf=39.6 if N2SSOC90==595
replace camsisf=36.1 if N2SSOC90==596
replace camsisf=17.5 if N2SSOC90==597
replace camsisf=50.2 if N2SSOC90==598
replace camsisf=31.6 if N2SSOC90==599

replace camsisf=45.1 if N2SSOC90==600
replace camsisf=46.2 if N2SSOC90==601
replace camsisf=57.4 if N2SSOC90==610
replace camsisf=52.7 if N2SSOC90==611
replace camsisf=48.6 if N2SSOC90==612
replace camsisf=81.6 if N2SSOC90==613
replace camsisf=43.8 if N2SSOC90==614
replace camsisf=38.6 if N2SSOC90==615
replace camsisf=43.5 if N2SSOC90==619
replace camsisf=42.3 if N2SSOC90==620
replace camsisf=38.4 if N2SSOC90==621
replace camsisf=36 if N2SSOC90==622
replace camsisf=52.2 if N2SSOC90==630
replace camsisf=28.7 if N2SSOC90==631
replace camsisf=40.4 if N2SSOC90==640
replace camsisf=42.5 if N2SSOC90==641
replace camsisf=46.6 if N2SSOC90==642
replace camsisf=44.8 if N2SSOC90==643
replace camsisf=43.5 if N2SSOC90==644
replace camsisf=46.5 if N2SSOC90==650
replace camsisf=43.7 if N2SSOC90==651
replace camsisf=43.5 if N2SSOC90==652
replace camsisf=46.7 if N2SSOC90==659
replace camsisf=52.6 if N2SSOC90==660
replace camsisf=52.6 if N2SSOC90==661
replace camsisf=32.8 if N2SSOC90==670
replace camsisf=32.8 if N2SSOC90==671
replace camsisf=39.5 if N2SSOC90==672
replace camsisf=44.1 if N2SSOC90==673
replace camsisf=56.4 if N2SSOC90==690
replace camsisf=51 if N2SSOC90==691
replace camsisf=43 if N2SSOC90==699

replace camsisf=57.6 if N2SSOC90==700
replace camsisf=53.6 if N2SSOC90==701
replace camsisf=61.2 if N2SSOC90==702
replace camsisf=60 if N2SSOC90==703
replace camsisf=56.6 if N2SSOC90==710
replace camsisf=56.9 if N2SSOC90==719
replace camsisf=51.5 if N2SSOC90==720
replace camsisf=34.4 if N2SSOC90==721
replace camsisf=37 if N2SSOC90==722
replace camsisf=37.9 if N2SSOC90==730
replace camsisf=39.7 if N2SSOC90==731
replace camsisf=46.6 if N2SSOC90==732
replace camsisf=44 if N2SSOC90==733
replace camsisf=42 if N2SSOC90==790
replace camsisf=51.5 if N2SSOC90==791
replace camsisf=53.3 if N2SSOC90==792

replace camsisf=31.3 if N2SSOC90==800
replace camsisf=32.3 if N2SSOC90==801
replace camsisf=31.1 if N2SSOC90==802
replace camsisf=30.7 if N2SSOC90==809
replace camsisf=24.4 if N2SSOC90==810
replace camsisf=24.3 if N2SSOC90==811
replace camsisf=24.5 if N2SSOC90==812
replace camsisf=24.8 if N2SSOC90==813
replace camsisf=22.5 if N2SSOC90==814
replace camsisf=38 if N2SSOC90==820
replace camsisf=33 if N2SSOC90==821
replace camsisf=35.4 if N2SSOC90==822
replace camsisf=13.1 if N2SSOC90==823
replace camsisf=27.1 if N2SSOC90==824
replace camsisf=30.1 if N2SSOC90==825
replace camsisf=36.7 if N2SSOC90==826
replace camsisf=31.5 if N2SSOC90==829
replace camsisf=27.9 if N2SSOC90==830
replace camsisf=31.2 if N2SSOC90==831
replace camsisf=29.4 if N2SSOC90==832
replace camsisf=29.5 if N2SSOC90==833
replace camsisf=24.3 if N2SSOC90==834
replace camsisf=31.1 if N2SSOC90==839
replace camsisf=37.2 if N2SSOC90==840
replace camsisf=31.4 if N2SSOC90==841
replace camsisf=31.4 if N2SSOC90==842
replace camsisf=23.7 if N2SSOC90==843
replace camsisf=21.1 if N2SSOC90==844
replace camsisf=37 if N2SSOC90==850
replace camsisf=37.5 if N2SSOC90==851
replace camsisf=20.6 if N2SSOC90==859
replace camsisf=42.2 if N2SSOC90==860
replace camsisf=34.3 if N2SSOC90==861
replace camsisf=30.2 if N2SSOC90==862
replace camsisf=30.1 if N2SSOC90==863
replace camsisf=44.6 if N2SSOC90==864
replace camsisf=37.1 if N2SSOC90==869

replace camsisf=35.1 if N2SSOC90==870
replace camsisf=35.1 if N2SSOC90==871
replace camsisf=34.5 if N2SSOC90==872
replace camsisf=35.1 if N2SSOC90==873
replace camsisf=42.3 if N2SSOC90==874
replace camsisf=32 if N2SSOC90==875
replace camsisf=39.8 if N2SSOC90==880
replace camsisf=39.9 if N2SSOC90==881
replace camsisf=36.5 if N2SSOC90==882
replace camsisf=31.5 if N2SSOC90==883
replace camsisf=29.2 if N2SSOC90==884
replace camsisf=30.3 if N2SSOC90==885
replace camsisf=24.3 if N2SSOC90==886
replace camsisf=29.1 if N2SSOC90==887
replace camsisf=30 if N2SSOC90==889
replace camsisf=28.5 if N2SSOC90==890
replace camsisf=44.9 if N2SSOC90==891
replace camsisf=42 if N2SSOC90==892
replace camsisf=33 if N2SSOC90==893
replace camsisf=23.7 if N2SSOC90==894
replace camsisf=32 if N2SSOC90==895
replace camsisf=40.4 if N2SSOC90==896
replace camsisf=33.1 if N2SSOC90==897
replace camsisf=35.9 if N2SSOC90==898
replace camsisf=35.8 if N2SSOC90==899

replace camsisf=32.2 if N2SSOC90==900
replace camsisf=35 if N2SSOC90==901
replace camsisf=35.9 if N2SSOC90==902
replace camsisf=33 if N2SSOC90==903
replace camsisf=44.7 if N2SSOC90==904
replace camsisf=17.4 if N2SSOC90==910
replace camsisf=16 if N2SSOC90==911
replace camsisf=24.3 if N2SSOC90==912
replace camsisf=31.4 if N2SSOC90==913
replace camsisf=23.8 if N2SSOC90==919
replace camsisf=30.8 if N2SSOC90==920
replace camsisf=29.4 if N2SSOC90==921
replace camsisf=24.9 if N2SSOC90==922
replace camsisf=26.9 if N2SSOC90==923
replace camsisf=31.5 if N2SSOC90==924
replace camsisf=29.1 if N2SSOC90==929
replace camsisf=32.1 if N2SSOC90==930
replace camsisf=33.6 if N2SSOC90==931
replace camsisf=32.5 if N2SSOC90==932
replace camsisf=19.8 if N2SSOC90==933
replace camsisf=32.5 if N2SSOC90==934
replace camsisf=38.8 if N2SSOC90==940
replace camsisf=43 if N2SSOC90==941
replace camsisf=38.5 if N2SSOC90==950
replace camsisf=43.1 if N2SSOC90==951
replace camsisf=37.9 if N2SSOC90==952
replace camsisf=48.3 if N2SSOC90==953
replace camsisf=33.8 if N2SSOC90==954
replace camsisf=39.3 if N2SSOC90==955
replace camsisf=37.6 if N2SSOC90==956
replace camsisf=32.5 if N2SSOC90==957
replace camsisf=36.4 if N2SSOC90==958
replace camsisf=34.6 if N2SSOC90==959
replace camsisf=29 if N2SSOC90==990
replace camsisf=46.8 if N2SSOC90==999

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

gen reading=n923
replace reading=. if (reading==-1)

gen maths=n926
replace maths=. if (maths==-1)


tab reading

tab maths

label variable econ201 "Economic Activity of Respondent on September when they are 16"
label variable obin "Educational Attainment O-levels"
label variable sex "Sex of Respondent"
label variable tenure "Housing Tenure of Respondent when Child"
label variable nssec "NS-SEC Social Class of Father when Respondent Child"
label variable rgsc "RGSC Social Class of Father when Respondent Child"
label variable camsisf "CAMSIS Score of Father when Respondent Child"
label variable reading "Reading Score"
label variable maths "Maths Score"

save ncds4_recoded, replace


keep if !missing(econ201, obin, sex, tenure, nssec, rgsc, camsisf)

count


collect clear

table (var) (), statistic(fvfrequency econ201 obin sex tenure nssec rgsc) ///
					statistic(fvpercent econ201 obin sex tenure nssec rgsc) ///
					statistic(mean camsisf) ///  
					statistic(sd camsisf) 			
collect remap result[fvfrequency mean] = Col[1 1] 
	collect remap result[fvpercent sd] = Col[2 2]
collect get resname = "Mean", tag(Col[1] var[mylabel]) 
	collect get resname = "SD", tag(Col[2] var[mylabel])
collect get empty = "  ", tag(Col[1] var[empty]) 
	collect get empty = "  ", tag(Col[2] var[empty])
    
count
	collect get n = `r(N)', tag(Col[2] var[n])
	
collect layout (var[1.econ201 2.econ201 3.econ201 4.econ201 5.econ201 ///
					0.obin 1.obin ///
					0.sex 1.sex  ///
					0.tenure 1.tenure ///
					1.nssec 2.nssec 3.nssec 4.nssec 5.nssec 6.nssec 7.nssec 8.nssec ///
					1.rgsc 2.rgsc 3.rgsc 4.rgsc 5.rgsc 6.rgsc ///
					empty mylabel ///
					camsisf ///
					empty n]) (Col[1 2])

collect label levels Col 1 "n" 2 "%"			
collect style header Col, title(hide)
collect style header var[empty mylabel], level(hide)
collect style row stack, nobinder
collect style cell var[econ201 obin sex tenure nssec rgsc]#Col[1], nformat(%6.0fc) 
collect style cell var[econ201 obin sex tenure nssec rgsc]#Col[2], nformat(%6.2f) sformat("%s%%") 	
collect style cell var[camsisf], nformat(%6.2f)
collect style cell border_block[item row-header], border(top, pattern(nil)) 
collect title "Table 1: Descriptive Statistics for Economic Activity"
collect note "Data Source: NCDS"
collect preview

collect export "Table1.docx", replace



quietly mlogit econ201, b(3)

fitstat
estat ic

quietly mlogit econ201 i.obin, b(3)

fitstat
estat ic

quietly mlogit econ201 i.sex, b(3)

fitstat
estat ic

quietly mlogit econ201 i.tenure, b(3)

fitstat
estat ic

quietly mlogit econ201 i.nssec, b(3)

fitstat
estat ic


quietly mlogit econ201, b(3)

fitstat
estat ic

quietly mlogit econ201 i.obin, b(3)

fitstat
estat ic

quietly mlogit econ201 i.obin i.sex, b(3)

fitstat
estat ic

quietly mlogit econ201 i.obin i.sex i.tenure, b(3)

fitstat
estat ic

quietly mlogit econ201 i.obin i.sex i.tenure i.nssec, b(3) 

fitstat
estat ic



mlogit econ201 i.obin i.sex i.tenure ib(8).nssec, b(3)

est store nsseccca

etable 

fitstat


mlogit econ201 i.obin i.sex i.tenure ib(8).nssec, b(3)

set scheme s1color, permanent 
margins nssec, atmeans predict(outcome(1))
marginsplot, name(emmean1)
margins nssec, atmeans predict(outcome(2))
marginsplot, name(smmean1)
margins nssec, atmeans predict(outcome(3))
marginsplot, name(edmmean1)
margins nssec, atmeans predict(outcome(4))
marginsplot, name(tmmean1)
margins nssec, atmeans predict(outcome(5))
marginsplot, name(ummean1)

graph combine emmean1 smmean1 edmmean1 tmmean1 ummean1, ycommon

graph save "nssecnssec.gph", replace


mlogit econ201 i.obin i.sex i.tenure ib(8).nssec, b(3)

margins sex, atmeans predict(outcome(1))
marginsplot, name(semmean1)
margins sex, atmeans predict(outcome(2))
marginsplot, name(ssmmean1)
margins sex, atmeans predict(outcome(3))
marginsplot, name(sedmmean1)
margins sex, atmeans predict(outcome(4))
marginsplot, name(stmmean1)
margins sex, atmeans predict(outcome(5))
marginsplot, name(summean1)

graph combine semmean1 ssmmean1 sedmmean1 stmmean1 summean1, ycommon

graph save "sexnssec.gph", replace

mlogit econ201 i.obin i.sex i.tenure ib(8).nssec, b(3)

margins obin, atmeans predict(outcome(1))
marginsplot, name(oemmean1)
margins obin, atmeans predict(outcome(2))
marginsplot, name(osmmean1)
margins obin, atmeans predict(outcome(3))
marginsplot, name(oedmmean1)
margins obin, atmeans predict(outcome(4))
marginsplot, name(otmmean1)
margins obin, atmeans predict(outcome(5))
marginsplot, name(oummean1)

graph combine oemmean1 osmmean1 oedmmean1 otmmean1 oummean1, ycommon

graph save "obinnssec.gph", replace


mlogit econ201 i.obin i.sex i.tenure ib(8).nssec, b(3)

margins tenure, atmeans predict(outcome(1))
marginsplot, name(temmean1)
margins tenure, atmeans predict(outcome(2))
marginsplot, name(tsmmean1)
margins tenure, atmeans predict(outcome(3))
marginsplot, name(tedmmean1)
margins tenure, atmeans predict(outcome(4))
marginsplot, name(ttmmean1)
margins tenure, atmeans predict(outcome(5))
marginsplot, name(tummean1)

graph combine temmean1 tsmmean1 tedmmean1 ttmmean1 tummean1, ycommon

graph save "tenurenssec.gph", replace


quietly mlogit econ201 i.obin i.sex i.tenure ib(8).nssec, b(3)

margins, dydx(*) post

est store nssecccamarg

etable, append



quietly mlogit econ201 i.obin i.sex i.tenure ib(8).nssec, b(3)

vce

* moving on to sensitivity analysis with camsis and rgsc *

quietly mlogit econ201 i.rgsc, b(3)

fitstat
estat ic

quietly mlogit econ201 i.obin i.sex i.tenure i.rgsc, b(3) 

fitstat
estat ic

mlogit econ201 i.obin i.sex i.tenure ib(6).rgsc, b(3)

est store rgsccca

etable, append

fitstat

*camsis*

quietly mlogit econ201 camsis, b(3)

fitstat
estat ic

quietly mlogit econ201 i.obin i.sex i.tenure camsis, b(3) 

fitstat
estat ic

mlogit econ201 i.obin i.sex i.tenure camsisf, b(3)

est store camsiscca

etable, append

fitstat

*model tables*

est table nsseccca rgsccca camsiscca

collect style showbase all

collect label levels etable_depvar 1 "NS-SEC Model" ///
										2 "RGSC Model" ///
										3 "CAMSIS Model", modify

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
		export("regressionchapterone.docx", replace)  

save ncds4_cca, replace



* Missing Data *

use "/Users/ScottOatley/Documents/NCDS Sweep 23/stata/stata9/ncds4_recoded"


drop if missing(n4118)

misstable summarize econ201 obin sex tenure nssec 

misstable patterns econ201 obin sex tenure nssec


quietly mlogit econ201 i.obin i.sex i.tenure i.nssec reading maths

gen cc= e(sample)

foreach var in econ201 obin sex tenure nssec {
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

mi register imputed econ201 obin sex tenure nssec reading maths maw5 aconnn512 genability11 toilet itoilet cooking water dconnn2492
tab _mi_miss

mi impute chained ///
///
(logit, augment) obin sex tenure maw5 aconnn512 genability11 toilet itoilet cooking water dconnn2492 ///
///
(mlogit, augment) econ201 nssec ///
///
, rseed(12346) dots force add(50) burnin(20) savetrace(MI_test_trace, replace)
