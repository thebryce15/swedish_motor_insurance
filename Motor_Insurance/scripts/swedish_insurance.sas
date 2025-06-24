/************************************************************************
*  Swedish Motor Insurance – fresh zone-level KPI build
*  Source  : /home/u64256136/SwedishMotorInsurance.csv
*  Output  : /home/u64256136/zone_kpis.csv
************************************************************************/

/*----- 0 ▸ House-keeping ---------------------------------------------*/
options mprint symbolgen;                /* log detail for debugging   */
proc datasets library=work kill nolist;  /* start with a clean WORK lib */
quit;

/*----- 1 ▸ Import the raw CSV ----------------------------------------*/
filename src "/home/u64256136/SwedishMotorInsurance.csv";

proc import datafile=src
            out=work.motor_raw
            dbms=csv
            replace;
   guessingrows=max;          /* scans whole file for accurate types   */
   getnames=yes;
run;

/*----- 2 ▸ Inspect column types (shows in log) -----------------------*/
proc contents data=work.motor_raw short; run;

/*----- 3 ▸ Force key fields to numeric ------------------------------*
   The Swedish file *should* already be numeric, but this block
   converts any that accidentally came in as character.               */
data work.motor;
   set work.motor_raw;

   /* list every numeric-should-be variable once */
   array nums insured claims payment zone kilometres bonus make;

   /* convert in place if the current variable type is character */
   do _i = 1 to dim(nums);
      if vtype(nums[_i]) = 'C' then nums[_i] = input(strip(nums[_i]), best32.);
   end;

   drop _i;
run;

/*----- 4 ▸ Confirm we now have all seven zones -----------------------*/
proc freq data=work.motor nlevels;
   tables zone / nocum;
run;

/*----- REPLACEMENT for step 5 ------------------------------------------------*/
proc sql;
   create table work.zone_kpis as
   select zone                                             label="Zone"
        , sum(insured)    as exposure     label="Exposure"
        , sum(claims)     as claims       label="Claim Count"
        , sum(payment)    as total_loss   label="Total Loss"  format=dollar16.

        /* use CALCULATED to reference aliases defined above */
        , calculated claims   / calculated exposure          as claim_frequency
                                                           format=8.3   label="Freq/Policy"

        , case when calculated claims = 0
               then .
               else calculated total_loss / calculated claims
          end                            as claim_severity   format=dollar16.2 label="Avg Severity"

        , calculated total_loss / calculated exposure        as pure_premium
                                                           format=dollar16.2 label="Pure Premium"
   from work.motor
   where not missing(zone)
   group by zone
   order by zone;
quit;


/*----- 6 ▸ Portfolio pure premium & multipliers ----------------------*/
proc sql noprint;
   select sum(total_loss) / sum(exposure)
          into :portfolio_pp
          from work.zone_kpis;
quit;

data work.zone_kpis;
   set work.zone_kpis;
   premium_multiplier = pure_premium / &portfolio_pp;  /* >1 surcharge */
   format premium_multiplier 8.3;
run;

/*----- 7 ▸ Quick sanity print ----------------------------------------*/
title "Zone-level KPIs (expect 7 rows)";
proc print data=work.zone_kpis noobs; run;
title;

proc sql;
   select sum(premium_multiplier*exposure)/sum(exposure) as exp_wtd_multiplier
          label="Exp-weighted Avg Multiplier" format=8.3
   from work.zone_kpis;
quit;

/*----- 8 ▸ Export CSV for Tableau -----------------------------------*/
filename out "/home/u64256136/zone_kpis.csv";

proc export data=work.zone_kpis
            outfile=out
            dbms=csv
            replace;
run;

title;  /* clear any leftover titles */
