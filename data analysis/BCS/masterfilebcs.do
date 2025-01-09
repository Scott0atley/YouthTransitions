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
Cohort: 			BCS
Do File:			00_master.do 
Task: 				Set globals
----------------------------------------------------------------------
Creation Date:		20 June 2024
Do-file version:	01

User commands:		
====================================================================*/

/* 
Process Order: 

masterfilencds.do 			set globals 
Create Programs.do			create programs for analysis 
Setup.do					set up sample and covariates
descstats.do				generate descriptive statistics
modbuild.do 				produce goodness-of-fit statistics 
basemodel.do 				generate base model and figures
Sensanalysis.do 			generate sensitivity analysis
Socanalysis.do 				generate SOC analysis
dummy.do 				run handling missing data simulation 
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
cd "G:\Stata data and do\BCS"
* Directory in which UKHLS and BHPS files are kept.
global fld "G:\Stata data and do\BCS"
* Folder altered data will be saved in.
global dta_fld "G:\Stata data and do\do files\BCS\data"
* Folder do files are kept in.
global do_fld "G:\Stata data and do\do files\BCS\do"
* Set Personal ado folder
sysdir set PLUS "${do_fld}\ado\"
* Folder for outputs
global out_fld "G:\Stata data and do\do files\BCS\outputs"


* NCDS Folder Prefix for Stata Files
global bcs_path			bcs
* Common stub which is affixed on end of original stata files (e.g. "_protect" where using Special Licence files; blank for End User Licence files)
global file_type					

* Decide whether to run full code (set equal to YES, if so)
global run_full				"YES"


/*====================================================================
                        1: Regression Set Up
====================================================================*/
	* Put Covariates into globals 
	* Model Builder macros
	glo mb1null econbin
	glo mb1edu econbin i.obin
	glo mb1sex econbin i.sex
	glo mb1ten econbin i.tenure
	glo mb1nssec econbin ib(3).nssec
	glo mb1nssec90 econbin ib(3).nssec90
	glo mb2rgsc econbin ib(2).rgsc
	glo mb2rgsc90 econbin ib(2).rgsc90
	glo mb3camsis econbin camsis
	glo mb3camsis90 econbin cam90
	*Model Builder additive macros
	glo mb1a econbin i.obin i.sex 
	glo mb1b econbin i.obin i.sex i.tenure
	glo mb1c econbin i.obin i.sex i.tenure ib(3).nssec
	glo mb1c90 econbin i.obin i.sex i.tenure ib(3).nssec90
	glo mb2c econbin i.obin i.sex i.tenure ib(2).rgsc 
	glo mb2c90 econbin i.obin i.sex i.tenure ib(2).rgsc90
	glo mb3c econbin i.obin i.sex i.tenure camsis
	glo mb3c90 econbin i.obin i.sex i.tenure cam90
	*Model QV Statistics Regressions
	glo qvn econbin i.obin i.sex i.tenure i.qvnssec
	glo qvn90 econbin i.obin i.sex i.tenure i.qvnssec90
	glo qvr econbin i.obin i.sex i.tenure i.qvrgsc
	glo qvr90 econbin i.obin i.sex i.tenure i.qvrgsc90
	* khb Builder macros
	glo khb1 econbin obin || sex, summary
	glo khb2 econbin obin sex || tenure, summary
	glo khb3 econbin obin sex tenure || i.nssec, summary
	glo khb4 econbin obin sex tenure || i.rgsc, summary
	glo khb5 econbin obin sex tenure || camsis, summary
	glo khb3b econbin obin sex tenure || i.nssec90, summary
	glo khb4b econbin obin sex tenure || i.rgsc90, summary
	glo khb5b econbin obin sex tenure || cam90, summary
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
*ii. Run Model Building Statistics
	qui do "${do_fld}/modbuild.do"	
*iii. Run Basic Model
	qui do "${do_fld}/basemodel.do"	
*iv. Run Sensitivity Analysis 
	qui do "${do_fld}/Sensanalysis.do"	
*v. Run SOC analysis
	qui do "${do_fld}/Socanalysis.do"	
*vi. Run Dummy Variable Adjustment 
	qui do "${do_fld}/dummy.do"
*vii. Run Multiple Imputation 
	qui do "${do_fld}/Imputation.do"	

	di in red "Program Started: $start_time"
	di in red "Program Completed: $S_TIME"
}

/*====================================================================
								End
====================================================================*/




