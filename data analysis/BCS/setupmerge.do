

cd "$fld"

use "bcs70_activity_histories_eul.dta", clear

rename BCSID bcsid 

egen year_month = group(JSTYR JSTMTH), label

keep if year_month ==9

sort bcsid year_month JDUR

by bcsid year_month (JDUR), sort: gen highest_jdur = (_n == 1)

by bcsid year_month: replace JDUR = . if highest_jdur == 0

keep if highest_jdur == 1

drop highest_jdur

reshape wide JACTIV, i(bcsid) j(year_month)

qui do "${do_fld}\activitylong.do"	

save bcsactivity, replace

use "bcs3_occupation_coding_mother.dta", clear

rename BCSID bcsid 

save bcsmother, replace

use "bcs3_occupation_coding_father.dta", clear

rename BCSID bcsid 

save bcsfather, replace

clear

use "bcs2000.dta", clear

gen crecords = bcsid

save bcs30, replace

clear

* List the dataset names
local datasets bcs21yearsample bcs96x bcs30 bcs7016x bcs7072a bcsmother bcsfather sn3723

* Display the datasets to check their names
di "Datasets to merge: `datasets'"

* Get the first dataset name
local first = word("`datasets'", 1)

* Load the first dataset
use "bcs21yearsample.dta", clear


* Loop through the remaining datasets and merge them
forvalues i = 2/8 {
    local next = word("`datasets'", `i')
    
    * Check if the next dataset file exists
    if !missing("`next'") {
        * Merge the datasets
        merge m:1 bcsid using "`next'.dta"
        
        * Check merge results (debugging)
        tab _merge
        
        * Drop the merge variable
        drop _merge
    }
}


* Save the merged dataset
cd "${dta_fld}"
save merged_data.dta, replace

* merge long format histories 

cd "$fld"

merge m:m bcsid using "bcsactivity"
drop _merge 

* Save the merged dataset
cd "${dta_fld}"
save merged_data.dta, replace
