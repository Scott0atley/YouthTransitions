

/*====================================================================
                        1: Missing Data Simulations
====================================================================*/
clear

simulate beta1 se1 beta2 se2 beta3 se3, reps(1000) seed(1234): regress1 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6 

rename _sim_1 beta1 
rename _sim_2 se1 
rename _sim_3 beta2 
rename _sim_4 se2 
rename _sim_5 beta3 
rename _sim_6 se3 

cd "$dta_fld"

save godmodel, replace

simulate beta1b se1b beta2b se2b beta3b se3b, reps(1000) seed(1234): sem1 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6


rename _sim_1 beta1b 
rename _sim_2 se1b 
rename _sim_3 beta2b 
rename _sim_4 se2b 
rename _sim_5 beta3b 
rename _sim_6 se3b 

save semgodmodel, replace

simulate beta1c se1c beta2c se2c beta3c se3c, reps(1000) seed(1234): missingregress1 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6 

rename _sim_1 beta1c 
rename _sim_2 se1c 
rename _sim_3 beta2c
rename _sim_4 se2c
rename _sim_5 beta3c
rename _sim_6 se3c

save missingmodel, replace

simulate beta1d se1d beta2d se2d beta3d se3d, reps(1000) seed(1234): missing01 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6

rename _sim_1 beta1d
rename _sim_2 se1d
rename _sim_3 beta2d
rename _sim_4 se2d
rename _sim_5 beta3d
rename _sim_6 se3d

save missing01, replace

simulate beta1e se1e beta2e se2e beta3e se3e, reps(1000) seed(1234): missing11 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6

rename _sim_1 beta1e
rename _sim_2 se1e
rename _sim_3 beta2e
rename _sim_4 se2e
rename _sim_5 beta3e
rename _sim_6 se3e

save missing11, replace

simulate beta1f se1f beta2f se2f beta3f se3f, reps(1000) seed(1234): missingsingle1 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6

rename _sim_1 beta1f
rename _sim_2 se1f
rename _sim_3 beta2f
rename _sim_4 se2f
rename _sim_5 beta3f
rename _sim_6 se3f

save missingsingle1, replace

simulate beta1g se1g beta2g se2g beta3g se3g, reps(1000) seed(1234): semmlmv 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6

rename _sim_1 beta1g
rename _sim_2 se1g
rename _sim_3 beta2g
rename _sim_4 se2g
rename _sim_5 beta3g
rename _sim_6 se3g

save semmlmv, replace

simulate beta1h se1h beta2h se2h beta3h se3h, reps(1000) seed(1234): minoaux1 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6

rename _sim_1 beta1h
rename _sim_2 se1h
rename _sim_3 beta2h
rename _sim_4 se2h
rename _sim_5 beta3h
rename _sim_6 se3h

save minoaux1, replace

simulate beta1i se1i beta2i se2i beta3i se3i, reps(1000) seed(1234): miaux1 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6

rename _sim_1 beta1i
rename _sim_2 se1i
rename _sim_3 beta2i
rename _sim_4 se2i
rename _sim_5 beta3i
rename _sim_6 se3i

save miaux1, replace

simulate beta1j se1j beta2j se2j beta3j se3j, reps(1000) seed(1234): miaux100 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6

rename _sim_1 beta1j
rename _sim_2 se1j
rename _sim_3 beta2j
rename _sim_4 se2j
rename _sim_5 beta3j
rename _sim_6 se3j

save miaux100, replace

