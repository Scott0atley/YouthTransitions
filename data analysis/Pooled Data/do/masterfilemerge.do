/*
           __...--~~~~~-._   _.-~~~~~--...__
         //               `V'               \\
        //                 |                 \\
       //__...--~~~~~~-._  |  _.-~~~~~~--...__\\
      //__.....----~~~~._\ | /_.~~~~----.....__\\
     ====================\\|//====================
                         `---`
                      PhD Thesis
*/

/*====================================================================
Youth in Transition: Longitudinal Comparisons of Youth Transitions in the UK using Cohort and Synthetic Cohort Data
PhD Thesis

Scott Oatley 
----------------------------------------------------------------------
Part:				1
Cohort: 			Merge
Do File:			00_master.do 
Task: 				Set globals
----------------------------------------------------------------------
Creation Date:		12 July 2024
Do-file version:	01

User commands:		
====================================================================*/

/* 
Process Order: 

masterfilencds.do 			set globals 
Create Programs.do			create programs for analysis 
Setup.do					set up sample and covariates
descstats.do				generate descriptive statistics
basemodel.do 				generate base model and figures 
Imputation.do 				generate multiple imputation

*/

/*====================================================================
                        0: Program set up
====================================================================*/
qui{
clear all
macro drop _all
set more off

/*
1. Change the following parameters.
*/
* Top-level directory which original and constructed data files will be located under
cd "G:\Stata data and do\NCDS"
* Directory in which UKHLS and BHPS files are kept.
global fld "G:\Stata data and do\Merge"
global fld_ncds "G:\Stata data and do\NCDS"
global fld_bcs "G:\Stata data and do\BCS"
* Folder altered data will be saved in.
global dta_fld "G:\Stata data and do\do files\Merge\data"
global dta_ncds_fld "G:\Stata data and do\do files\NCDS\data"
global dta_bcs_fld "G:\Stata data and do\do files\BCS\data"
* Folder do files are kept in.
global do_fld "G:\Stata data and do\do files\Merge\do"
* Set Personal ado folder
sysdir set PLUS "${do_fld}\ado\"
* Folder for outputs
global out_fld "G:\Stata data and do\do files\Merge\outputs"

* Decide whether to run full code (set equal to YES, if so)
global run_full				"YES"


/*====================================================================
                        1: Regression Set Up
====================================================================*/
	* Put Covariates into globals
	*Model Builder additive macros
	glo merge1 econbin i.obin#i.cohort i.sex#i.cohort i.tenure#i.cohort ib(3).nssec#i.cohort i.cohort
	glo merge2 econbin i.obinc i.obinc2 i.sexc i.sexc2 i.tenurec i.tenurec2 ib(0).nssecncds ib(0).nssecbcs i.cohort
	glo mergencds econbin i.obin i.sex i.tenure ib(3).nssec if cohort ==0
	glo mergebcs econbin i.obin i.sex i.tenure ib(3).nssec if cohort ==1

}

/*====================================================================
                        3: Run Do Files
====================================================================*/

if "$run_full"=="YES"{
	cls
	global start_time "$S_TIME"
	di in red "Program Started: $start_time"
	
	*i. Prepare basis data.
	qui do "${do_fld}/Setup.do"	

	
	di in red "Program Started: $start_time"
	di in red "Program Completed: $S_TIME"
	}
	
/*====================================================================
                        4: Run Analysis Do Files
====================================================================*/
if "$run_full"=="YES"{
	cls
	global start_time_time "$S_Time"
	di in red "Program Started: $start_time"
	
*i. Run Descriptive Statistics 
	qui do "${do_fld}/descstats.do"		
*ii. Run Basic Model
	qui do "${do_fld}/basemodel.do"	
*iii. Run Multiple Imputation 
	qui do "${do_fld}/Imputation.do"	

	di in red "Program Started: $start_time"
	di in red "Program Completed: $S_TIME"
}

if "$run_full"=="YES"{
	cls
	global start_time_time "$S_Time"
	di in red "Program Started: $start_time"
	
*i. Run Descriptive Statistics 
	qui do "${do_fld}/descstatsmlogit.do"		
*ii. Run Multiple Imputation 
	qui do "${do_fld}/Imputationmlogit.do"	

	di in red "Program Started: $start_time"
	di in red "Program Completed: $S_TIME"
}

/*====================================================================
								End
====================================================================*/




