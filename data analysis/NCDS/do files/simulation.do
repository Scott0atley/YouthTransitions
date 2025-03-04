

/*====================================================================
                        1: Missing Data Simulations
====================================================================*/
clear
simulate beta1 se1 beta2 se2 beta3 se3 error1, reps(1000) seed(1234): regress1 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6 _sim_7

rename _sim_1 beta1 
rename _sim_2 se1 
rename _sim_3 beta2 
rename _sim_4 se2 
rename _sim_5 beta3 
rename _sim_6 se3 
rename _sim_7 error1 


cd "$dta_fld"

save godmodel, replace

simulate beta1 se1 beta2 se2 beta3 se3, reps(1000) seed(1234): sem1 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6


rename _sim_1 beta1 
rename _sim_2 se1 
rename _sim_3 beta2 
rename _sim_4 se2 
rename _sim_5 beta3 
rename _sim_6 se3 

save semgodmodel, replace

simulate beta1 se1 beta2 se2 beta3 se3 error1, reps(1000) seed(1234): missingmcar 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6 _sim_7

rename _sim_1 beta1 
rename _sim_2 se1 
rename _sim_3 beta2 
rename _sim_4 se2 
rename _sim_5 beta3 
rename _sim_6 se3 
rename _sim_7 error1 


save missingmcar, replace

simulate beta1 se1 beta2 se2 beta3 se3 error1, reps(1000) seed(1234): missingmar 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6 _sim_7

rename _sim_1 beta1 
rename _sim_2 se1 
rename _sim_3 beta2 
rename _sim_4 se2 
rename _sim_5 beta3 
rename _sim_6 se3 
rename _sim_7 error1 

save missingmar, replace

simulate beta1 se1 beta2 se2 beta3 se3 error1, reps(1000) seed(1234): missingmean 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6 _sim_7

rename _sim_1 beta1 
rename _sim_2 se1 
rename _sim_3 beta2 
rename _sim_4 se2 
rename _sim_5 beta3 
rename _sim_6 se3 
rename _sim_7 error1 

save missingmean, replace


simulate beta1 se1 beta2 se2 beta3 se3, reps(1000) seed(1234): semmlmv 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6

rename _sim_1 beta1 
rename _sim_2 se1 
rename _sim_3 beta2 
rename _sim_4 se2 
rename _sim_5 beta3 
rename _sim_6 se3 

save semmlmv, replace

simulate beta1 se1 beta2 se2 beta3 se3, reps(1000) seed(1234): minoaux1 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6 

rename _sim_1 beta1 
rename _sim_2 se1 
rename _sim_3 beta2 
rename _sim_4 se2 
rename _sim_5 beta3 
rename _sim_6 se3 

save minoaux1, replace

simulate beta1i se1i beta2i se2i beta3i se3i, reps(1000) seed(1234): miaux1 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6

rename _sim_1 beta1 
rename _sim_2 se1 
rename _sim_3 beta2 
rename _sim_4 se2 
rename _sim_5 beta3 
rename _sim_6 se3 

save miaux1, replace

simulate beta1j se1j beta2j se2j beta3j se3j, reps(1000) seed(1234): miaux100 

ci mean _sim_1 _sim_2 _sim_3 _sim_4 _sim_5 _sim_6

rename _sim_1 beta1 
rename _sim_2 se1 
rename _sim_3 beta2 
rename _sim_4 se2 
rename _sim_5 beta3 
rename _sim_6 se3 

save miaux100, replace

