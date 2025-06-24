
/******************************************************
 * Swedish Motor Insurance Case Study
 ******************************************************/

ods pdf file="/home/u64256136/EPG1V2/data/swedish_motor_insurance_report.pdf" style=journal;

/* Step 0: Import the dataset */
proc import datafile="/home/u64256136/EPG1V2/data/SwedishMotorInsurance.csv"
    out=swedish_insurance
    dbms=csv
    replace;
    getnames=yes;
run;

/* Step 1: Understand Data Structure */
proc contents data=swedish_insurance;
    title "Dataset Structure";
run;

proc print data=swedish_insurance(obs=10);
    title "Sample of Swedish Motor Insurance Data";
run;

/***********************************************************
 * Question 1: What factors influence average claim cost?
 ***********************************************************/

/* Compute average cost per policy (loss cost) by Zone */
proc sql;
    create table avg_cost_by_zone as
    select Zone,
           sum(Payment) as Total_Payment,
           sum(Insured) as Total_Insured,
           calculated Total_Payment / calculated Total_Insured as Avg_Cost_Per_Policy
    from swedish_insurance
    group by Zone;
quit;

proc sgplot data=avg_cost_by_zone;
    vbar Zone / response=Avg_Cost_Per_Policy datalabel;
    yaxis label="Average Cost per Policy";
    title "Chart 1: Average Cost per Policy by Zone (Q1)";
run;

/* Explore relationship between exposure and claims */
proc sgplot data=swedish_insurance;
    scatter x=Insured y=Claims;
    reg x=Insured y=Claims;
    title "Chart 2: Exposure vs. Total Claims (Q1)";
run;

/***********************************************************
 * Question 2: How frequent are claims by region?
 ***********************************************************/

/* Calculate claim frequency and severity by zone */
proc sql;
    create table zone_risk_summary as
    select Zone,
           sum(Insured) as Total_Insured,
           sum(Claims) as Total_Claims,
           sum(Payment) as Total_Payment,
           calculated Total_Claims / calculated Total_Insured as Claim_Frequency,
           case when calculated Total_Claims > 0 
                then calculated Total_Payment / calculated Total_Claims 
                else . end as Claim_Severity,
           calculated Total_Payment / calculated Total_Insured as Loss_Cost
    from swedish_insurance
    group by Zone;
quit;

proc sgplot data=zone_risk_summary;
    vbar Zone / response=Claim_Frequency datalabel;
    yaxis label="Claim Frequency";
    title "Chart 3: Claim Frequency by Zone (Q2)";
run;

/* Correlation between frequency and severity */
proc corr data=zone_risk_summary;
    var Claim_Frequency Claim_Severity;
    title "Correlation: Frequency vs. Severity (Q2)";
run;

proc sgplot data=zone_risk_summary;
    scatter x=Claim_Frequency y=Claim_Severity / datalabel=Zone;
    title "Chart 4: Frequency vs. Severity Scatterplot (Q2)";
run;

/***********************************************************
 * Question 3: Can we model total claim amount?
 ***********************************************************/

/* Linear regression model for total payment */
proc reg data=swedish_insurance plots=all;
    model Payment = Kilometres Zone Bonus Make Insured;
    title "Regression Model: Predicting Payment (Q3)";
run;
quit;

/***********************************************************
 * Question 4: Compare severity vs. frequency by zone
 ***********************************************************/

/* Classify zones based on risk profile */
data zone_classification;
    set zone_risk_summary;
    length Risk_Type $20;
    if Claim_Frequency > 0.1 and Claim_Severity > 5000 then Risk_Type = "Both";
    else if Claim_Frequency > 0.1 then Risk_Type = "High Frequency";
    else if Claim_Severity > 5000 then Risk_Type = "High Severity";
    else Risk_Type = "Low Risk";
run;

proc print data=zone_classification;
    title "Zone Classification by Risk Type (Q4)";
run;

proc sgplot data=zone_classification;
    scatter x=Claim_Frequency y=Claim_Severity / group=Risk_Type datalabel=Zone;
    title "Chart 5: Zone Risk Matrix (Q4)";
run;

/***********************************************************
 * Question 5: Pricing Strategy Implications
 ***********************************************************/

/* Summary of cost by zone to assess pricing tiers */
proc sgplot data=zone_risk_summary;
    vbar Zone / response=Loss_Cost datalabel;
    title "Chart 6: Loss Cost by Zone for Pricing Strategy (Q5)";
run;

ods pdf close;
