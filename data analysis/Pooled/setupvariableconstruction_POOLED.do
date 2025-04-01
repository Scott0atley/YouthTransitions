
/*====================================================================
                        1: Setup variable construction
====================================================================*/

replace econbin=0 if econ==0 & econbin==.
replace econbin=1 if econ==1 & econbin==.

replace econ201 = 1 if econm==1 & econ201==.
replace econ201 = 2 if econm==2 & econ201==.
replace econ201 = 3 if econm==3 & econ201==.
replace econ201 = 4 if econm==4 & econ201==.

replace sex=0 if female==1 & sex==.
replace sex=1 if female==0 & sex==.

drop obinc* sexc* tenurec* nssecsynth*
lab drop obinc obinc2 obinc3 sexc sexc2 sexc3 tenurec tenurec2 tenurec3 nssecsynth1 nssecsynth2 nssecsynth3

gen obinc=.
replace obinc=0 if (obin==0 & cohort==0)
replace obinc=0 if (cohort==1)
replace obinc=0 if (cohort==2)
replace obinc=0 if (cohort==3)
replace obinc=0 if (cohort==4)
replace obinc=1 if (obin==1 & cohort==0)

gen obinc2=.
replace obinc2=0 if (obin==0 & cohort==1)
replace obinc2=0 if (cohort==0)
replace obinc2=0 if (cohort==2)
replace obinc2=0 if (cohort==3)
replace obinc2=0 if (cohort==4)
replace obinc2=1 if (obin==1 & cohort==1)

gen obinc3=.
replace obinc3=0 if (obin==0 & cohort==2)
replace obinc3=0 if (cohort==0)
replace obinc3=0 if (cohort==1)
replace obinc3=0 if (cohort==3)
replace obinc3=0 if (cohort==4)
replace obinc3=1 if (obin==1 & cohort==2)

gen obinc4=.
replace obinc4=0 if (obin==0 & cohort==3)
replace obinc4=0 if (cohort==0)
replace obinc4=0 if (cohort==1)
replace obinc4=0 if (cohort==2)
replace obinc4=0 if (cohort==4)
replace obinc4=1 if (obin==1 & cohort==3)

gen obinc5=.
replace obinc5=0 if (obin==0 & cohort==4)
replace obinc5=0 if (cohort==0)
replace obinc5=0 if (cohort==1)
replace obinc5=0 if (cohort==2)
replace obinc5=0 if (cohort==3)
replace obinc5=1 if (obin==1 & cohort==4)

gen sexc=.
replace sexc=0 if (sex==0 & cohort==0)
replace sexc=0 if (cohort==1)
replace sexc=0 if (cohort==2)
replace sexc=0 if (cohort==3)
replace sexc=0 if (cohort==4)
replace sexc=1 if (sex==1 & cohort==0)

gen sexc2=.
replace sexc2=0 if (sex==0 & cohort==1)
replace sexc2=0 if (cohort==0)
replace sexc2=0 if (cohort==2)
replace sexc2=0 if (cohort==3)
replace sexc2=0 if (cohort==4)
replace sexc2=1 if (sex==1 & cohort==1)

gen sexc3=.
replace sexc3=0 if (sex==0 & cohort==2)
replace sexc3=0 if (cohort==0)
replace sexc3=0 if (cohort==1)
replace sexc3=0 if (cohort==3)
replace sexc3=0 if (cohort==4)
replace sexc3=1 if (sex==1 & cohort==2)

gen sexc4=.
replace sexc4=0 if (sex==0 & cohort==3)
replace sexc4=0 if (cohort==0)
replace sexc4=0 if (cohort==1)
replace sexc4=0 if (cohort==2)
replace sexc4=0 if (cohort==4)
replace sexc4=1 if (sex==1 & cohort==3)

gen sexc5=.
replace sexc5=0 if (sex==0 & cohort==4)
replace sexc5=0 if (cohort==0)
replace sexc5=0 if (cohort==1)
replace sexc5=0 if (cohort==2)
replace sexc5=0 if (cohort==3)
replace sexc5=1 if (sex==1 & cohort==4)

gen tenurec=.
replace tenurec=0 if (tenure==0 & cohort==0)
replace tenurec=0 if (cohort==1)
replace tenurec=0 if (cohort==2)
replace tenurec=0 if (cohort==3)
replace tenurec=0 if (cohort==4)
replace tenurec=1 if (tenure==1 & cohort==0)

gen tenurec2=.
replace tenurec2=0 if (tenure==0 & cohort==1)
replace tenurec2=0 if (cohort==0)
replace tenurec2=0 if (cohort==2)
replace tenurec2=0 if (cohort==3)
replace tenurec2=0 if (cohort==4)
replace tenurec2=1 if (tenure==1 & cohort==1)

gen tenurec3=.
replace tenurec3=0 if (tenure==0 & cohort==2)
replace tenurec3=0 if (cohort==0)
replace tenurec3=0 if (cohort==1)
replace tenurec3=0 if (cohort==3)
replace tenurec3=0 if (cohort==4)
replace tenurec3=1 if (tenure==1 & cohort==2)

gen tenurec4=.
replace tenurec4=0 if (tenure==0 & cohort==3)
replace tenurec4=0 if (cohort==0)
replace tenurec4=0 if (cohort==1)
replace tenurec4=0 if (cohort==2)
replace tenurec4=0 if (cohort==4)
replace tenurec4=1 if (tenure==1 & cohort==3)

gen tenurec5=.
replace tenurec5=0 if (tenure==0 & cohort==4)
replace tenurec5=0 if (cohort==0)
replace tenurec5=0 if (cohort==1)
replace tenurec5=0 if (cohort==2)
replace tenurec5=0 if (cohort==3)
replace tenurec5=1 if (tenure==1 & cohort==4)

gen nssecncds=.
replace nssecncds=0 if (cohort==1)
replace nssecncds=0 if (cohort==2)
replace nssecncds=0 if (cohort==3)
replace nssecncds=0 if (cohort==4)
replace nssecncds=0 if (cohort==0 & nssec==3)
replace nssecncds=1 if (cohort==0 & nssec==1)
replace nssecncds=2 if (cohort==0 & nssec==2)
replace nssecncds=3 if (cohort==0 & nssec==4)
replace nssecncds=4 if (cohort==0 & nssec==5)
replace nssecncds=5 if (cohort==0 & nssec==6)
replace nssecncds=6 if (cohort==0 & nssec==7)
replace nssecncds=7 if (cohort==0 & nssec==8)

gen nssecbcs=.
replace nssecbcs=0 if (cohort==0)
replace nssecbcs=0 if (cohort==2)
replace nssecbcs=0 if (cohort==3)
replace nssecbcs=0 if (cohort==4)
replace nssecbcs=0 if (cohort==1 & nssec==3)
replace nssecbcs=1 if (cohort==1 & nssec==1)
replace nssecbcs=2 if (cohort==1 & nssec==2)
replace nssecbcs=3 if (cohort==1 & nssec==4)
replace nssecbcs=4 if (cohort==1 & nssec==5)
replace nssecbcs=5 if (cohort==1 & nssec==6)
replace nssecbcs=6 if (cohort==1 & nssec==7)
replace nssecbcs=7 if (cohort==1 & nssec==8)

gen nssecsynth1=.
replace nssecsynth1=0 if (cohort==0)
replace nssecsynth1=0 if (cohort==1)
replace nssecsynth1=0 if (cohort==3)
replace nssecsynth1=0 if (cohort==4)
replace nssecsynth1=0 if (cohort==2 & nssec==3)
replace nssecsynth1=1 if (cohort==2 & nssec==1)
replace nssecsynth1=2 if (cohort==2 & nssec==2)
replace nssecsynth1=3 if (cohort==2 & nssec==4)
replace nssecsynth1=4 if (cohort==2 & nssec==5)
replace nssecsynth1=5 if (cohort==2 & nssec==6)
replace nssecsynth1=6 if (cohort==2 & nssec==7)
replace nssecsynth1=7 if (cohort==2 & nssec==8)

gen nssecsynth2=.
replace nssecsynth2=0 if (cohort==0)
replace nssecsynth2=0 if (cohort==1)
replace nssecsynth2=0 if (cohort==2)
replace nssecsynth2=0 if (cohort==4)
replace nssecsynth2=0 if (cohort==3 & nssec==3)
replace nssecsynth2=1 if (cohort==3 & nssec==1)
replace nssecsynth2=2 if (cohort==3 & nssec==2)
replace nssecsynth2=3 if (cohort==3 & nssec==4)
replace nssecsynth2=4 if (cohort==3 & nssec==5)
replace nssecsynth2=5 if (cohort==3 & nssec==6)
replace nssecsynth2=6 if (cohort==3 & nssec==7)
replace nssecsynth2=7 if (cohort==3 & nssec==8)

gen nssecsynth3=.
replace nssecsynth3=0 if (cohort==0)
replace nssecsynth3=0 if (cohort==1)
replace nssecsynth3=0 if (cohort==2)
replace nssecsynth3=0 if (cohort==3)
replace nssecsynth3=0 if (cohort==4 & nssec==3)
replace nssecsynth3=1 if (cohort==4 & nssec==1)
replace nssecsynth3=2 if (cohort==4 & nssec==2)
replace nssecsynth3=3 if (cohort==4 & nssec==4)
replace nssecsynth3=4 if (cohort==4 & nssec==5)
replace nssecsynth3=5 if (cohort==4 & nssec==6)
replace nssecsynth3=6 if (cohort==4 & nssec==7)
replace nssecsynth3=7 if (cohort==4 & nssec==8)
