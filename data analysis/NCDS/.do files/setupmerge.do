

cd "$fld"

* List the dataset names
local datasets ncds2_occupation_coding_father ncds0123 ncds4 

* Display the datasets to check their names
di "Datasets to merge: `datasets'"

* Get the first dataset name
local first = word("`datasets'", 1)

* Load the first dataset
use "`first'.dta", clear

* Re-name NCDSID to ncdsid to merge properly
rename NCDSID ncdsid 

* Loop through the remaining datasets and merge them
forvalues i = 2/3 {
    local next = word("`datasets'", `i')
    
    * Check if the next dataset file exists
    if !missing("`next'") {
        * Merge the datasets
        merge 1:1 ncdsid using "`next'.dta"
        
        * Check merge results (debugging)
        tab _merge
        
        * Drop the merge variable
        drop _merge
    }
}

* Save the merged dataset
cd "${dta_fld}"
save merged_data.dta, replace