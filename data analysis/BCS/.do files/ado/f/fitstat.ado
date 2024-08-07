*! version 1.6.4 2/22/01 add warning messages

capture program drop fitstat
program define fitstat, rclass
    version 6.0

    if ( /*
    */   "`e(cmd)'"!="regress"  /*

    */ & "`e(cmd)'"!="logit"    /*
    */ & "`e(cmd)'"!="probit"   /*
    */ & "`e(cmd)'"!="logistic" /*
    */ & "`e(cmd)'"!="cloglog"  /*

    */ & "`e(cmd)'"!="ologit"   /*
    */ & "`e(cmd)'"!="oprobit"  /*
    */ & "`e(cmd)'"!="gologit"  /*

    */ & "`e(cmd)'"!="mlogit"   /*
    */ & "`e(cmd)'"!="clogit"   /*

    */ & "`e(cmd)'"!="tobit"    /*
    */ & "`e(cmd)'"!="cnreg"    /*
    */ & "`e(cmd)'"!="intreg"   /*

    */ & "`e(cmd)'"!="poisson"  /*
    */ & "`e(cmd)'"!="nbreg"    /*
    */ & "`e(cmd)'"!="zip"      /*
    */ & "`e(cmd)'"!="zinb"     /*

    */  ) { di in r "-fitstat- does not work with the last model estimated."
        exit
    }

    tempname n_obs n_obs2 n_parm llF llR df x2 r2 b v_ystar v v_y v_x v_e
    tempname factor r2mcf r2mcfa r2mz r2ml r2cu r2 r2ef r2adj aic aicn bicx
    tempname bicp isbin isord isvare isystar islgt ispbt ssr dev lrx2 lrx2p
    tempname depv2 maxtmp uniqgrp n_obs2 depvgrp ifin v_error bicdif fllR
    tempname bnocon phat yphat ydev predpr predcat wrong hiprob fbicp fn_obs
    tempname totcor totone maxrow cntr2 cntr2a chkobs d d2 prevval prevdf
    tempname results

    mat `b' = get(_b)
    local cmd  `e(cmd)'
    local depv `e(depvar)'

    syntax [if] [in] [, Saving(string) Using(string) SAVE Diff FORCE Bic]

    if "`save'" != "" { local saving 0 }
    if "`dif'" != "" { local using 0 }

*-> get information from last model estimated

    local wtis ""
    local iswgt "no"
    if "`e(wtype)'"!="" {
        local iswgt "yes"
        local wtis "[`e(wtype)'`e(wexp)']"
    }

    mat `v_e' = J(1,1,1)
    sca `n_obs' = e(N)
    sca `llF' = e(ll)
    sca `llR' = e(ll_0)
    sca `df' = e(df_m)
    if "`cmd'"~="regress" & "`cmd'"~="tobit" & "`cmd'"~="cnreg" {
        sca `x2' = e(chi2)
    }
    if "`cmd'"=="tobit" | "`cmd'"=="cnreg" {
        sca `x2' = e(F)
    }
    if "`cmd'"=="regress" {
        sca `ssr' = e(rss)
        sca `r2' = e(r2)
        sca `r2adj' = e(r2_a)
        mat `v_e'[1,1] = (e(rmse)*e(rmse)*e(df_r)/e(N))
    }
    if "`cmd'"=="clogit" {
        if "`e(wtype)'"=="iweight" |"`e(wtype)'"=="pweight" /*
          */ | "`e(wtype)'"=="aweight" {
            di in r "cannot use fitstat after clogit with `e(wtype)'"
            exit
        }
        qui egen `uniqgrp' = rank(_n) if e(sample)==1, by(`e(group)')
        qui replace `uniqgrp' = . if `uniqgrp' ~= 1
        qui sum `uniqgrp' `wtis', meanonly
        sca `n_obs' = r(sum_w)
    }

*-> classify type of model

    * binary?
    local isbin "no"
    if "`cmd'"=="probit" | "`cmd'"=="logit" | "`cmd'"=="logistic" /*
    */ | "`cmd'"=="cloglog" {
        local isbin "yes"
    }
    * ordinal?
    local isord "no"
    if "`cmd'"=="oprobit" | "`cmd'"=="ologit" {
        local isord "yes"
    }
    * var(e) assumed?
    local isvare "no"
    if "`cmd'"=="probit" | "`cmd'"=="logit" | "`cmd'"=="logistic" /*
    */ | "`cmd'"=="oprobit" | "`cmd'"=="ologit" {
        local isvare "yes"
    }
    * is there a ystar?
    local isystar "`isvare'"
    if "`cmd'"=="tobit" | "`cmd'"=="intreg" | "`cmd'"=="cnreg" {
        local isystar "yes"
    }
    * logit model?
    local islgt "no"
    if "`cmd'"=="logit" | "`cmd'"=="ologit" | "`cmd'"=="logistic" {
        local islgt "yes"
    }
    * probit model?
    local ispbt "no"
    if "`cmd'"=="probit" | "`cmd'"=="oprobit" {
        local ispbt "yes"
    }
    * zip/zinb?
        local iszi "no"
        if "`cmd'"=="zip" | "`cmd'"=="zinb" {
            local iszi "yes"
    }

*-> compute numbers of variables and parameters

    sca  `n_parm' = colsof(`b')
    local n_cat   = e(k_cat)
    if "`n_cat'" == "." { local n_cat = 2 }
    local n_rhs   = `n_parm' - `n_cat' + 1
    if "`cmd'"=="mlogit" { local n_rhs = (`n_parm'/(`n_cat'-1)) - 1 }
    if "`cmd'"=="tobit"   | "`cmd'"=="intreg"  /*  for var(e)
    */ | "`cmd'"=="nbreg" | "`cmd'"=="cnreg"   /*  for alpha
    */ | "`cmd'"=="zip"                        /*  for 2nd intercept
    */ { local n_rhs = `n_rhs' - 1 }
    if "`cmd'"=="zinb" { local n_rhs = `n_rhs' - 2 } /* 2nd int & alpha */

    local varlist : colnames(`b')
    parse "`varlist'", parse (" ")

    * 2/11/00
    * to deal with rhsnam gt 80 characters, can't use string functions
    local rhsnam ""
    if "`isord'"=="yes" {
        local i 1
        while "``i''"!= "" {
            local j = substr("``i''",1,4)
            if "`j'"!="_cut" { local rhsnam "`rhsnam' ``i''" }
            local i = `i' + 1
        }
    }
    if "`isbin'"=="yes"     | "`cmd'"=="mlogit" | "`cmd'"=="regress" /*
    */ | "`cmd'"=="tobit"   | "`cmd'"=="intreg" | "`cmd'"=="cnreg"   /*
    */ | "`cmd'"=="poisson" | "`cmd'"=="nbreg" {
        local i 1
        while "``i''"!= "" {
            if "``i''"!="_cons" { local rhsnam "`rhsnam' ``i''" }
            local i = `i' + 1
        }
    }

*-> compute ll0 for zip and zinb (ll0 is for model with two intercepts)

    if "`iszi'"=="yes" {
        tempname res zill0
        tempvar insamp
        sca `df' = `n_parm' - 2
        gen `insamp' = e(sample)
        local inftyp "`e(inflate)'"
        if "`inftyp'" == "logit" {
            local inftyp ""
        }
        local doit "`e(cmd)' `e(depvar)' if `insamp' `wtis',inf(_cons) `inftyp'"
        estimates hold `res'
        quietly `doit'
        sca `llR' = e(ll) /* sic: not ll_0 */
        estimates unhold `res'
        sca `x2' = -2*(`llR'-`llF')
    } /* iszi model */

    if "`bic'" == "" {
        di _newline in g "Measures of Fit for " in y "`cmd'" in g " of " /*
        */ in y "`depv'" _newline
    }

    if "`isbin'" == "yes" | "`isord'" == "yes" | "`cmd'" == "mlogit" {

        * sum does not allow pweights or iweights
        if "`e(wtype)'"=="pweight" | "`e(wtype)'"=="iweight" {
            sca `cntr2a' = .
            sca `cntr2' = .
            if "`isbin'" == "yes" {sca `r2ef' = .}
            if "`isbin'"=="yes" {
                di _n in blu /*
                */ "(Efron's R2, Count R2, and Adj Count R2 not calculated if " /*
                */ in whi "`e(wtype)'" in blu " used)"
            }
            else {
                di _n in blu /*
                */ "(Count R2 and Adj Count R2 not calculated if " /*
                */ in whi "`e(wtype)'" in blu " used)"
            }
        }
        * can compute measures if aweight, fweight or no weight
        else quietly {
            egen `depvgrp' = group(`depv') if e(sample)==1
            sca `maxrow' = 0
            gen `hiprob' = 0 if e(sample)==1
            gen `predcat' = 0 if e(sample)==1
            local counter = 1

            * BRM - Efron R2 and Count R2s
            if "`isbin'" == "yes" {
                * Efron R2
                * convert 0/!0 to 0/1 for binary outcomes
                gen `depv2' = (`depv'!=0) if e(sample)==1
                predict `phat' if e(sample)==1
                sum `depv2' `wtis' if e(sample)==1
                local mn = r(mean)
                gen `yphat' = (`depv2' - `phat')^2 if e(sample)==1
                gen `ydev' = (`depv2' - `mn')^2 if e(sample)==1
                sum `yphat' `wtis' if e(sample)==1
                local num = r(mean)
                sum `ydev' `wtis' if e(sample)==1
                local den = r(mean)
                scalar `r2ef' = 1 - (`num'/`den')
                * Count R2 and Adjusted Count R2
                replace `predcat' = round(`phat', 1) if e(sample)==1
                gen `wrong' = (`predcat'~=`depv2') if e(sample)==1
                sum `depv2' `wtis' if `depv2' == 1 & e(sample)==1
                sca `totone' = r(N)
                if `totone' > (`n_obs'-`totone') {sca `maxrow' = `totone'}
                else {sca `maxrow' = `n_obs' - `totone'}
            }

            * ORM - Count R2s
            if "`isord'" == "yes" {
                while `counter' <= `n_cat' {
                    * ctnam is argument for ologitp/oprobitp
                    tempvar ct`counter'
                    local ctnam "`ctnam' `ct`counter''"
                    * find frequency of the modal category (for adj count R2)
                    sum `depvgrp' if (`depvgrp'==`counter') & (e(sample)==1) `wtis'
                    if r(N) > `maxrow' { sca `maxrow' = r(N) }
                    local counter = `counter' + 1
                }
                predict `ctnam' if e(sample) == 1
                local counter = 1
                while `counter' <= `n_cat' {
                    replace `predcat' = `counter' /*
                    */ if (`ct`counter''>`hiprob') & (e(sample)==1)
                    replace `hiprob' = `ct`counter'' /*
                    */ if (`ct`counter''>`hiprob') & (e(sample)==1)
                    local counter = `counter' + 1
                }
                gen `wrong' = (`predcat'~=`depvgrp') if e(sample)==1
            }

            * MNLM - Count R2s
            if "`cmd'" == "mlogit" {
                while `counter' <= `n_cat' {
                    tempvar ct`counter'
                    sum `depv' `wtis' /*
                    */ if (`depvgrp'==`counter') & (e(sample)==1), meanonly
                    local outcm = r(mean)
                    predict `ct`counter'', outcome(`outcm')
                    sum `depv' if (`depv'==`outcm') & (e(sample)==1) `wtis'
                    if r(N) > `maxrow' { sca `maxrow' = r(N) }
                    replace `predcat' = `outcm' /*
                    */ if (`ct`counter''>`hiprob') & (e(sample)==1)
                    replace `hiprob' = `ct`counter'' /*
                    */ if (`ct`counter''>`hiprob') & (e(sample)==1)
                    local counter = `counter' + 1
                }
                gen `wrong' = (`predcat'~=`depv') if e(sample)==1
            }
            * compute count R2s
            sum `wrong' if `wrong' == 0  & e(sample) == 1 `wtis'
            sca `totcor' = r(N)
            sca `cntr2' = `totcor'/`n_obs'
            sca `cntr2a' = (`totcor'-`maxrow')/(`n_obs'-`maxrow')
        }

    } /* is binary, ordinal or nominal */

    * CLOGIT - Count R2s
    if "`cmd'"=="clogit" {
        quietly {
            tempname cntr2 clphat clhi clpick clpred clwrong clright /*
            */ posval motest1 motest2 mptest1
            * generate predicted outcomes for each group
            predict `clphat' if e(sample) == 1
            egen `clhi' = max(`clphat') if e(sample) == 1, by(`e(group)')
            gen `clpred' = 1 if `clhi'==`clphat' & e(sample)==1
            replace `clpred' = 0 if `clhi'!=`clphat' & e(sample)==1
            * check if multiple predicted 1's per group
            egen `mptest1' = sum(`clpred') if e(sample), by(`e(group)')
            * weight of multiple predicted 1's per group split among each 1
            replace `clpred' = `clpred'/`mptest1' if `clpred'==1 & e(sample)==1
            * calculate count R2
            sum `clpred' `wtis' if `clpred'>0 & `clpred'~=. & `depv'==0 & e(sample)==1
            sca `clwrong' = r(sum)
            sum `clpred' `wtis' if `clpred'>0 & `clpred'~=. & `depv'!=0 & e(sample)==1
            sca `clright' = r(sum)
            sca `cntr2' = `clright' / (`clwrong'+`clright')
            * warn user if multiple outcomes per group
            gen `posval'=1 if `depv'!=0 & `depv'~=. & e(sample)==1
            egen `motest1' = sum(`posval') if `posval'==1, by(`e(group)')
            sum `motest1'
            sca `motest2' = r(max)
            if `motest2' > 1 {
                noi di in blu "(Multiple outcomes per group for clogit: Count R2 may not be valid)"
            }
        } /* quietly */
    } /* clogit */

*-> compute Var(y*) using cov_x

    if "`isystar'"=="yes" {
        sca `factor' = 1/(`n_obs'-1)
        quietly mat accum `v_x' = `depv' `rhsnam' `wtis' if e(sample), /*
        */ deviations noconstant
        sca `v_y' = `factor' * `v_x'[1,1] /* sum y/(n-1) */
        mat `v_x' = `factor' * `v_x'[2...,2...]  /* cov matrix of rhs vars */
        if "`e(cmd)'"=="intreg" { mat `v_x' = `v_x'[2...,2...] }
        mat `bnocon' = `b'[1,1..`n_rhs'] /* trim off _con */
        mat `v' = `bnocon' * `v_x' * `bnocon''
        if "`ispbt'"=="yes"     { mat `v_e'[1,1] = 1 }
        if "`islgt'"=="yes"     { mat `v_e'[1,1] = (_pi*_pi)/3 }
        if "`e(cmd)'"=="intreg" { mat `v_e'[1,1] = e(sigma)*e(sigma) }
        if "`e(cmd)'"=="tobit"  | "`e(cmd)'"=="cnreg" {
            mat `v_e'[1,1] = `b'[1,"_se"]*`b'[1,"_se"]
        }
        mat `v' = `v' + `v_e'
        sca `v_ystar' = `v'[1,1]
    }

*-> information measures

    sca `aicn' = ((-2*`llF') + (2*`n_parm'))
    sca `aic' = `aicn'/`n_obs'
    sca `dev' = -2*`llF'
    local devdf = `n_obs'-`n_parm'
    sca `lrx2' = 2*(`llF'-`llR')
    local lrx2df = e(df_m)
    if "`iszi'"=="yes" {
        local lrx2df = `df'
    }
    sca `lrx2p' = chiprob(`lrx2df',`lrx2')
    sca `bicx' = `dev' - (`devdf'*ln(`n_obs'))
    sca `bicp' = -`lrx2' + (e(df_m)*ln(`n_obs'))

    capture return scalar dev_df   = `devdf'
    capture return scalar lrx2_df  = `lrx2df'

    if "`iszi'"=="yes" {
        * df = # rhs in both equations
        sca `bicp' = -`lrx2' + (`df'*ln(e(N)))
    }

    * these equal usual R2 in regress
    if "`cmd'"~="regress" {
        sca `r2mcf' = 1 - (`llF'/`llR')
        sca `r2mcfa' = 1 - ((`llF'-`n_parm')/`llR')
        sca `n_obs2' = 2/`n_obs'
        sca `r2ml' = 1 - exp(2*(`llR'-`llF')/`n_obs')
*       sca `r2ml' = 1 - ((exp(`llR'-`llF')) ^`n_obs2')
        sca `r2cu' = (`r2ml')/(1-exp(2*`llR'/`n_obs'))
*       sca `r2cu' = (`r2ml')/(1-(exp(`llR'))^`n_obs2')
    }

    if "`isystar'"=="yes" {
        sca `r2mz' = (`v_ystar' - `v_e'[1,1])/`v_ystar'
        sca `v_error' = `v_e'[1,1]
    }

*-> output

    * define output macros with format where @ is parse character:
    * output_text@tempname_of_scalar@abbrev_for_r()@df?
    *                               @width@column(?MeansEither)
    local stat2  "Log-Lik Intercept Only@llR@ll_0@no@11@1"
    local stat3  "Log-Lik Full Model@llF@ll@no@11@2"
    local stat4  "D@dev@dev@yes@11@1"
    local stat6  "LR@lrx2@lrx2@yes@11@2"
    local stat8  "Prob > LR@lrx2p@lrx2_p@no@9@2"
    local stat9  "McFadden's R2@r2mcf@r2_mf@no@9@1"
    local stat10 "McFadden's Adj R2@r2mcfa@r2_mfadj@no@9@2"
    local stat11 "Maximum Likelihood R2@r2ml@r2_ml@no@9@1"
    local stat12 "Cragg & Uhler's R2@r2cu@r2_cu@no@9@2"
    local stat13 "McKelvey and Zavoina's R2@r2mz@r2_mz@no@9@?"
    local stat14 "Efron's R2@r2ef@r2_ef@no@9@?"
    local stat15 "Variance of y*@v_ystar@v_ystar@no@11@1"
    local stat16 "Variance of error@v_error@v_error@no@11@2"
    local stat17 "Count R2@cntr2@r2_ct@no@9@1"
    local stat18 "Adj Count R2@cntr2a@r2_ctadj@no@9@2"
    local stat19 "R2@r2@r2@no@9@1"
    local stat20 "Adjusted R2@r2adj@r2_adj@no@9@2"
    local stat21 "AIC@aic@aic@no@11@1"
    local stat22 "AIC*n@aicn@aic_n@no@11@2"
    local stat23 "BIC@bicx@bic@no@11@1"
    local stat24 "BIC'@bicp@bic_p@no@11@2"

*-> check models for using and saving

    if "`saving'" != "" {
        if (length("`saving'")>4) {
            di in red "saving() name must be < 5 characters long"
            exit 198
        }
    }
    if "`using'"!= "" {
        if (length("`using'")>4) {
            di in red "using() name must be < 5 characters long"
            exit 198
        }
        qui capture mat list fs_`using'
        if _rc == 111 {
            di in red "Incorrect using() option: no indices saved as `using'"
            exit 111
        }
        * if the using option has been set, prepare comparison macros
        sca `fn_obs'  = fs_`using'[1,1]
        if `fn_obs' == -9999 { sca `fn_obs' = . }

        * estimate command saved as row name
        local fcmd : rownames(fs_`using')
        local fcmd : word 1 of `fcmd'

        * test if current and using are same type of model
        local same "no"
        if ("`fcmd'"=="logit"&"`e(cmd)'"=="logistic") | /*
        */ ("`fcmd'"=="logistic"&"`e(cmd)'"=="logit") { local same "yes" }
        if ("`fcmd'"!="`e(cmd)'" & "`same'"=="no") & "`force'"=="" {
            di in r "Current model estimated by " in y "`e(cmd)'" /*
            */ in r ", but saved model estimated by " in y "`fcmd'" in r "."
            di in r "To make the comparisons anyway, use the " /*
            */ in y "force" in r " option."
            exit
        }

        if ("`fcmd'"!="`e(cmd)'" & "`same'"=="no") {
            di in y "Warning: Current model estimated by " /*
            */ "`e(cmd)', but saved model estimated by `fcmd'"
            di
        }
        if `n_obs' != `fn_obs'  & "`force'"=="force" {
            di in y "Warning: N's do not match."
            di
        }

        di in g _col(28) %9s "Current" _col(45) "    Saved" /*
        */ _col(61) "Difference"
        di in g "Model:" _col(28) %9s in y "`e(cmd)'" /*
        */ %9s _col(45) in y "`fcmd'"
        di in g "N:" _col(28) %9.0f in y `n_obs' /*
        */ %9.0f _col(45) in y `fn_obs' /*
        */ %9.0f _col(62) in y (`n_obs' - `fn_obs')

        * test if N's match
        if `n_obs' != `fn_obs' & "`force'"=="" {
            di _newline in r "N's do not match. To make the comparisons, use the " /*
            */ in y "force" in r " option."
            exit
        }

        * test of ll0 match
        sca `fllR' = fs_`using'[1,2]
        if `fllR'==-9999 { sca `fllR' = . }

        if abs(`llR'-`fllR') > .0001 & (`llR'-`fllR') ~= . & "`force'"=="" {
            di _newline in r /*
                */ "Log-likelihoods for intercept model differ for current and saved models."
            di in r "To make the comparisons, use the " in y "force" in r " option."
            exit
        }
    } /* if "`using'"!="" */

    capture return scalar n_parm = `n_parm'
    capture return scalar n_rhs  = `n_rhs'
    capture return scalar N      = `n_obs'

*-> loop to print measures

    local colnow = 1
    * line endings for print loop
    local lnend1 "_col(42) _c"
    local lnend2 ""
    local nstats = 24 /* number of stats reported in output matrix */
    mat `results' = J(1, `nstats'+2, -9999)
    mat `results'[1,1] = `n_obs'

    mat `results'[1,`nstats'+1] = `n_parm'
    mat `results'[1,`nstats'+2] = `n_rhs'

    local cnames "N" /* start bulding column names for output matrix */
    local count = 2
    while `count' <= `nstats' {
        tokenize "`stat`count''", parse(@)
        local outtxt "`1'"
        local scalnm "`3'"
        local abnm "`5'"
        local df "`7'"
        local outwid "`9'"
        local outcol "`11'"
        local cnames "`cnames' `abnm'"
        * see if scalar exists, if not, no output
        capture return scalar `abnm' = ``scalnm''
        if _rc != 0 {
            mat `results'[1, `count'] = -9999
            if "`df'"=="yes" { mat `results'[1,`count'+1] = -9999 }
        }
        if _rc == 0 {
            * column settings (adjusted for fmt width inside loop)
            local c1 = 28 - (`outwid'-9) /* keeps things lined up for dif fmt widths */
            if "`using'"=="" {
                local c2 = 42 - (`outwid'-9) /* middle if using off */
                local c3 = 65 - (`outwid'-9) /* third column if using off */
            }
            else {
                local c2 = 45 - (`outwid'-9) /* second column if using on */
                local c3 = 62 - (`outwid'-9) /* third column if using on */
            }
            if ~("`bic'"!="" & `count' < 21) {
                if "`using'"=="" {
                    if "`outcol'"=="?" { local outcol "`colnow'" }
                    if "`outcol'"!="`colnow'"{ di `lnend`colnow'' }
                    if "`df'"=="yes" {
                        di in g "`outtxt'(" ``scalnm'df' "):" /*
                        */ _col(`c1') in y %`outwid'.3f ``scalnm'' `lnend`outcol''
                    }
                    else { /* no df */
                        di in g "`outtxt':" /*
                            */ _col(`c1') in y %`outwid'.3f ``scalnm'' `lnend`outcol''
                    }
                    local colnow = (3-`outcol')
                }  /* if not using option */
                else { /* if using option on */
                    sca `prevval' = fs_`using'[1,`count']
                    if `prevval' == -9999 { sca `prevval' = . }
                    local outwid3 = `outwid' - 2
                    local c3 = 62 - (`outwid3'-9)
                    if "`df'"== "yes" {
                        sca `prevdf' = fs_`using'[1,(`count'+ 1)]
                        if `prevdf' == -9999 { sca `prevdf' = . }
                        di in g "`outtxt':" /*
                        */ in y _col(`c1') %`outwid'.3f ``scalnm'' in g "(" ``scalnm'df' ")" /*
                        */ in y _col(`c2') %`outwid'.3f `prevval' in g "(" `prevdf' ")" /*
                        */ in y _col(`c3') %`outwid3'.3f (``scalnm''-`prevval') in g "(" ``scalnm'df'-`prevdf' ")"
                    }
                    else { /* no df */
                        di in g "`outtxt':" /*
                        */ in y _col(`c1') %`outwid'.3f ``scalnm'' /*
                        */ in y _col(`c2') %`outwid'.3f `prevval' /*
                        */ in y _col(`c3') %`outwid3'.3f (``scalnm''-`prevval')
                    }
                } /* if using is on */

            } /* if ~("`bic'"!="" & `count' < 21) */
                * add to results matrix
                if ``scalnm'' == . { sca ``scalnm'' = -9999 }
                mat `results'[1, `count'] = ``scalnm''
                if "`df'"=="yes" { mat `results'[1,`count'+1] = ``scalnm'df' }
        } /* if _rc == 0 */

        local count = `count' + 1
        if "`df'"=="yes" {
            local count = `count' + 1
            local cnames "`cnames' `abnm'_df"
        }
    } /* while `count' <= `countto' */

    if "`using'" == "" & "`colnow'" == "2" { di } /* cr if cursor in midline */

    *-> BIC comparisons
    if "`using'" != "" {
        if abs(`llR'-`fllR') < .0001 {  /* check that LL0s are the same */
            sca `fbicp' = fs_`using'[1, 24]
            if `fbicp' == -9999 { sca `fbicp' = . }
            sca `bicdif' = abs(`bicp'-`fbicp')
            if `bicdif'~=. {
                local sup "very strong"
                if `bicdif'<= .0000000001 { local sup "no" }
                else if `bicdif' <=2      { local sup "weak" }
                else if `bicdif' <=6      { local sup "positive" }
                else if `bicdif' <=10     { local sup "strong" }
                local modpref "current"
                if `bicp' > `fbicp'      { local modpref "saved" }
                if `bicdif'< .0000000001 & `bicdif'>-.0000000001 /*
                */ { local modpref "either" }
                di _newline in g  "Difference of " %8.3f in y `bicdif' in g /*
                */ " in BIC' provides " in y "`sup'" /*
                */ in g " support for " in y "`modpref'" in g " model."
            }
        } /* if `llR' == `fllR' */
    } /* if "`using'" != "" */

    local cnames "`cnames' n_parm n_rhs"
    mat rownames `results' = `e(cmd)'
    mat colnames `results' = `cnames'
    if "`saving'" != "" {
        capture mat drop fs_`saving'
        mat fs_`saving' = `results'
        di _newline in blu "(Indices saved in matrix fs_`saving')"
    }

    quietly `cmd'
end
