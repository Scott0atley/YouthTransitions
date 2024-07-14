


gen econ201=.
replace econ201 = 1 if (JACTIV9==1)
replace econ201 = 1 if (JACTIV9==2)
replace econ201 = 1 if (JACTIV9==3)
replace econ201 = 1 if (JACTIV9==4)
replace econ201 = 1 if (JACTIV9==5)
replace econ201 = 1 if (JACTIV9==6)
replace econ201 = 1 if (JACTIV9==7)
replace econ201 = 1 if (JACTIV9==10)

replace econ201 = 4 if (JACTIV9==11)
replace econ201 = 4 if (JACTIV9==15)
replace econ201 = 4 if (JACTIV9==16)
replace econ201 = 4 if (JACTIV9==17)
replace econ201 = 4 if (JACTIV9==18)
replace econ201 = 4 if (JACTIV9==19)
replace econ201 = 4 if (JACTIV9==20)
replace econ201 = 4 if (JACTIV9==21)
replace econ201 = 4 if (JACTIV9==22)


replace econ201 = 2 if (JACTIV9==12)
replace econ201 = 2 if (JACTIV9==13)

replace econ201 = 3 if (JACTIV9==14)

keep econ201 bcsid

drop if missing(econ201)