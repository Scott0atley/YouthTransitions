* How to use Stata in the UKDS SecureLab
* As there is no internet connection in SecureLab, we keep the ADOs in a folder 
* on the References drive, and Stata needs to know about where to look for these
sysdir set PLUS "R:\ADO_Files"
sysdir
* This way we replace the default path to the PLUS directory with the SecureLab 
* specific ADO_Files folder
*Alternatively the path can be added as
*adopath ++ "R:\ADO_Files"



********************************************************************************
* Transition from School-to-Work BHPS+UKHLS 
********************************************************************************


clear all
macro drop _all
set more off

********************************************************************************
* DIRECTORIES/FOLDER PATHS 
********************************************************************************

* TOP LEVEL FILE PATH
cd"REDACTED"

* DIRECTORY IN WHICH UKHLS AND BHPS FILES ARE KEPT
global fld "REDACTED"

* FOLDER DO FILES ARE KEPT 
global do_fld "REDACTED"

* BHPS FOLDER
global bhpsdata "REDACTED"

* UKHLS FOLDER
global ukhlsdata "REDACTED"

* NPD Folder 
global npddata "REDACTED"

* WORKING DATA FOLDER
global workingdata "REDACTED"

* OUTPUT FOLDER 

global out_fld "${workingdata}\output"

********************************************************************************
* REGRESSION SET UP
********************************************************************************
* Place covariates into globals
* Model Builder macros 
glo mb1null econ 
glo mb1edu econ i.obin 
glo mb1sex econ i.female
glo mb1ten econ i.tenure 
glo mb1nssec econ ib(3).nssec
glo mb2rgsc econ ib(2).rgsc 
glo mb1synth econ ib(1).s_cohort

* Model Builder additive macros 
glo mb1a econ i.obin i.female 
glo mb1b econ i.obin i.female i.tenure 
glo mb1c econ i.obin i.female i.tenure ib(1).s_cohort
glo mb1d econ i.obin i.female i.tenure ib(1).s_cohort ib(3).nssec
glo mb1e econ i.obin i.female i.tenure ib(3).nssec ib(1).s_cohort 
glo mb2f econ i.obin i.female i.tenure ib(1).s_cohort ib(2).rgsc 

* Model QV Statistics 
glo qvn econ i.obin i.female i.tenure i.s_cohort i.qvnssec
glo qvr econ i.obin i.female i.tenure i.s_cohort i.qvrgsc

* KHB Builder Macros
glo khb1 econ obin || female, summary
glo khb2 econ obin female || tenure, summary
glo khb3 econ obin female tenure || ib(1).s_cohort, summary 
glo khb3 econ obin female tenure ib(1).s_cohort || ib(3).nssec, summary 
glo khb5 econ obin female tenure ib(1).s_cohort || ib(2).rgsc, summary 

* Full Model Macro 

glo full econ i.obinc i.obinc2 i.obinc3 i.sexc i.sexc2 i.sexc3 i.tenurec i.tenurec2 i.tenurec3 ib(0).nssecsynth1 ib(0).nssecsynth2 ib(0).nssecsynth3 i.s_cohort




********************************************************************************
* RUN DO FILES
********************************************************************************
* Set Up Files

cls global start time "$S_TIME"
di in red "Program Started: $start_time"

*1. BHPS 1-18 single file
	qui do "${do_fld}\1 BHPS data set-up"
	
*2. UKHLS 1-11 single file
	qui do "${do_fld}\2 UKHLS data set-up"
	
*3. Append BHPS + UKHLS 
	qui do "${do_fld}\3 master merge set-up"
	
*3b. Graph Set Up
	qui do "${do_fld}\3b graphsetup"
	
*4. Descriptive Statistics
	qui do "${do_fld}\4 descstats"
	
*5. Model Building
	qui do "${do_fld}\5 modbuild"
	
*6. Base Model
	qui do "${do_fld}\6 basemod"
	
*7. Imputation
	qui do "${do_fld}\7 imputation"
di in red "Program Completed: $S_TIME"