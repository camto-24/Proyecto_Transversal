clear all
set more off
local owndir = ""
global dirin = "`owndir'/Data"
global dirout = "`owndir'/Figures"
cd "$dirin"

* SOURCE: original data set obtained from Cid Gallup
import spss using "Base BitcoinES -ene-22.sav", clear

rename SbjNum id
rename departamento dpt
rename Sexo sex
rename edad age
rename P2 educ_det
rename p3 marriage_status
rename p4 date_birth
rename p6 members_home
rename p7 income
rename p8 income_lastyear
rename _v1 p9_1
rename _v2 p9_2
rename _v3 p9_3
rename _v4 p9_4
rename _v5 p10_1
rename _v6 p10_2
rename _v7 p10_3
rename _v8 p10_4
rename _v9 p10_5
rename _v10 p10_6
rename _v11 p10_7
rename _v12 p13_1
rename _v13 p13_2
rename _v14 p13_3
rename _v15 p13_4
rename _v16 p13_5
rename _v17 p13_6
rename _v18 p13_7
rename _v19 p13_8
rename _v20 p13_9
rename p15 p15_1
rename _v21 p15_2
rename p17 p17_1
rename _v22 p17_2
rename _v23 p20_1
rename _v24 p20_2
rename _v25 p20_3
rename _v26 p20_4
rename _v27 p23_1
rename _v28 p23_2
rename _v29 p23_3
rename _v30 p26_1
rename _v31 p26_2
rename _v32 p26_3
rename _v33 p26_4
rename _v34 p26_5
rename _v35 p27_1
rename _v36 p27_2
rename _v37 p27_3
rename _v38 p27_4
rename _v39 p27_5
rename _v40 p27_6
rename _v41 p27_7
rename _v42 p27_8
rename _v43 p27_9
rename _v44 p30_1
rename _v45 p30_2
rename _v46 p30_3
rename _v47 p30_4
rename _v48 p30_5
rename _v49 p30_6
rename _v50 p34_1
rename _v51 p34_2
rename _v52 p34_3
rename _v53 p34_4
rename _v54 p34_5
rename _v55 p34_6
rename _v56 p34_7
rename _v57 p34_8
rename _v58 p34_9
rename _v59 p34_10
rename _v60 p34_11
rename _v61 p34_12
rename _v62 p41_1
rename _v63 p41_2
rename _v64 p42_1
rename _v65 p42_2
rename _v66 p43_1
rename _v67 p43_2
rename _v68 p44_1
rename _v69 p44_2
rename _v70 p45_1
rename _v71 p45_2
rename _v72 p45_3
rename _v73 p45_4
rename _v74 p45_5
rename _v75 p45_6
rename _v76 p46_1
rename _v77 p46_2
rename _v78 p46_3
rename _v79 p46_4
rename _v80 p47_1
rename _v81 p47_2
rename _v82 p48_1
rename _v83 p48_2
rename _v84 p48_3
rename _v85 p48_4
rename _v86 p49 
rename _v87 p51_1
rename _v88 p51_2
rename _v89 p51_3
rename _v90 p51_4
rename _v91 p64_1
rename _v92 p64_2
rename _v93 p64_3
rename _v94 p64_4
rename _v95 p64_5
rename _v96 p65_1
rename _v97 p65_2
rename _v98 p65_3
rename _v99 p65_4
rename p66 p66_1
rename _v100 p66_2
rename _v101 p66_3
rename _v102 p66_4
rename _v103 p68_1
rename _v104 p68_2
rename _v105 p69_1
rename _v106 p69_2
rename _v107 p70_1
rename _v108 p70_2
rename _v109 p71_1
rename _v110 p71_2
rename _v111 p72_1
rename _v112 p72_2
rename _v113 p73_1
rename _v114 p73_2
rename _v115 p74_1
rename _v116 p74_2

save "Survey.dta", replace

 
use "Survey.dta", clear
replace income = . if income ==99999999
replace income_lastyear = . if income_lastyear ==99999999
gen lnincome=ln(income)
label variable lnincome "Log Income"

replace sex=0 if sex==1
replace sex=1 if sex==2
label define sex_d 0 "Male" 1 "Female", modify
lab val sex sex_d
label variable sex "Female"

gen single = (marriage_status==1)
label define single_d 0 "Other" 1 "Single", modify
lab val single single_d
label variable single "Single"

gen elementary = (educ==1)
gen middleschool = (educ==2)
gen highschool = (educ==3)
label variable elementary "Elementary School"
label variable middleschool "Middle School"
label variable highschool "High School+"

gen age_18_24 = (age==1)
gen age_25_34 = (age==2)
gen age_35_44 = (age==3)
gen age_45_54 = (age==4)
gen age_55plus = (age==5)

label variable age_18_24 "Age 18-24"
label variable age_25_34 "Age 25-34"
label variable age_35_44 "Age 35-44"
label variable age_45_54 "Age 45-54"
label variable age_55plus "Age 55+"


gen phone_w_internet = (p9_1==2 | p9_2==2)  
label variable phone_w_internet "Phone with Internet"

gen internet =  (p9_1==1 | p9_1==2 | p9_2==2)
label variable internet "Internet"

drop p9_* 
gen n=1

gen unbanked = (p10_1==7)
gen card = (p10_1==2 | p10_2==2 | p10_3==2 | p10_4==2 | p10_5==2 | p10_6==2 | p10_1==3 | p10_2==3 | p10_3==3 | p10_4==3 | p10_5==3 | p10_6==3)  
gen account = (p10_1==1 | p10_2==1 | p10_3==1 | p10_4==1 | p10_5==1 | p10_6==1) 
gen bank_phone =(p10_1==5 | p10_2==5 | p10_3==5 | p10_4==5 | p10_5==5 | p10_6==5 | p10_1==6 | p10_2==6 | p10_3==6 | p10_4==6 | p10_5==6 | p10_6==6)
 
label variable unbanked "Unbanked"
label variable card "Own a Card"
label variable account "Bank Account"
label variable bank_phone "Mobile Banking"

*11. ¿Puede decirme que porcentaje de sus gastos pagaba con dinero en efectivo?
rename p11 share_cash_exp
gen auto = (p21>0)

*12. ¿Conoce Chivo Wallet?
replace p12 = 0 if p12==2
label define p12_d 0 "No" 1 "Yes", modify
lab val p12 p12_d
label variable p12 "Know Chivo"

save "Survey_cleaned_long.dta", replace

use "Survey_cleaned_long.dta", clear 
gen age2 = .
replace age2 = 1 if age_18_24==1 
replace age2 = 2 if age_25_34==1 
replace age2 = 3 if age_35_44==1 
replace age2 = 4 if age_45_54==1 
replace age2 = 5 if age_55plus==1 
label define age3 1 "18-24" 2 "25=34" 3 "35-44" 4 "45-54" 5 "55+" 
label values age2 age3

gen education2 = . 
replace education2 = 1 if elementary==1
replace education2 = 2 if middleschool==1
replace education2 = 3 if highschool==1
label define education3 1 "Elementary School" 2 "Middle School" 3 "High School"    
label values education2 education3


eststo clear 
eststo sex: estpost tabulate sex, nototal  
eststo age: estpost tabulate age2, nototal  
eststo education: estpost tabulate education2, nototal  
eststo dpt2: estpost tabulate dpt, nototal  
 
esttab sex age education dpt2 using "$dirtables/TableB2.tex", collabels(none) cells("b(pattern(1 1 1 1)) pct(pattern(1 1 1 1)fmt(1))") coeflab(sex "Male" sex "Female") nodepvars nomtitle noobs label replace
* Population demographics available in file Demographics.xlsx


use "Survey_cleaned_long.dta", clear 
preserve 
collapse (sum) n, by(bank_phone card unbanked account)
egen total = sum(n)
gen account1=account*n/1800 /* 1800 sample size */ 
gen unbanked2=unbanked*n/1800
gen bank_phone3=bank_phone*n/1800
gen card4=card*n/1800
collapse (sum) bank_phone3 card4 unbanked2 account1
gen i=1
reshape long bank_phone card unbanked account, i(i) j(code)
label define code_d 1 "Bank Account" 2 "Unbanked" 3 "Mobile Banking" 4 "Debit or Credit", modify
lab val code code_d
replace i = account if account!=.
replace i = card if card!=.
replace i = unbanked if unbanked!=.
replace i = bank_phone if bank_phone!=.
graph hbar i, over(code, sort(1) descending)   bar(1, color(midblue))  ///
ytitle("Share of Population") title("")   ///
 graphregion(color(white)) plotregion(fcolor(white))  
graph export "$dirfigures/FigureA7b.eps", replace
restore 

#delimit
twoway 
(hist share_cash_exp, bin(10) fraction fcolor(orange) lcolor(black) )
, title(" ") 
ytitle("Share of Population",size(large) height(7))
xtitle("Share of Expenditures Paid in Cash",size(large) height(7))  
legend(label(2 "Monthly Payment") label(1 "Maximum Amount") ring(0) position(2) bmargin(large) size(large) col(1) region(lwidth(none)))
graphregion(color(white)) plotregion(fcolor(white));
#delimit cr
graph export "$dirfigures/FigureA7a.eps", replace

areg p12 unbanked, absorb(dpt)  cluster(dpt)
outreg2 using "$dirtables/TableB3.tex", ///
keep(unbanked) replace tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)  ///
addtext(Department, Y)  
	
areg p12 phone_w_internet, absorb(dpt)  cluster(dpt)
outreg2 using "$dirtables/TableB3.tex", ///
keep(phone_w_internet) append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Department, Y)  

areg p12 middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single, absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/TableB3.tex", ///
keep(unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)  /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)  ///
addtext(Department, Y)  

areg p12 unbanked phone_w_internet  middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single, absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/TableB3.tex", ///
keep(unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)  ///
addtext(Department, Y)  

preserve 
collapse (sum) n, by(p12)
graph pie n, over(p12) title("") ///
nocl pie(1, explode color(ebblue)) pie(2, explode color(cranberry)) pie(3, explode color(erose)) ///
line(lwidth(thick)) legend(row(3)) plabel(1 perc, size(large)) /// 
plabel(2 perc, size(large))  plabel(3 perc, size(large)) ///
graphregion(color(white)) bgcolor(white) legend(order(1 "No" 2 "Yes") region(lwidth(none)) rows(1) size(medlarge))  
graph export "$dirfigures/FigureA8a.eps", replace
restore 
save "Survey_cleaned_long.dta", replace 


use "Survey_cleaned_long.dta", clear 
gen p34_entry = (p34_2==1 | p34_3==1 | p34_4==1 | p34_5==1 | p34_6==1 | p34_7==1 | p34_8==1 | p34_9==1 | p34_10==1 | p34_11==1 | p34_12==1)
recode p34_entry 1=0 0=1

gen know_chivo1 = (p12==1)
gen trydownload_chivo2 = (p14==1 | p14==2)
gen notroubles_entering3 = trydownload_chivo*p34_entry
gen keepusing_chivo_afterbono4 = (p36==1)
gen received_remittances5 = (p50==1 | p50==2)
gen paidtaxes_remittances6 = (p54==1)

collapse (sum) know_chivo trydownload_chivo notroubles_entering keepusing_chivo_afterbono received_remittances paidtaxes_remittances
replace know_chivo=know_chivo/1800
replace trydownload_chivo=trydownload_chivo/1800
replace notroubles_entering=notroubles_entering/1800
replace keepusing_chivo_afterbono=keepusing_chivo_afterbono/1800
replace received_remittances=received_remittances/1800
replace paidtaxes_remittances=paidtaxes_remittances/1800
gen i=1
reshape long know_chivo trydownload_chivo notroubles_entering keepusing_chivo_afterbono received_remittances paidtaxes_remittances, i(i) j(code)

replace i = know_chivo if know_chivo!=.
replace i = trydownload_chivo if trydownload_chivo!=.
replace i = notroubles_entering if notroubles_entering!=.
replace i = keepusing_chivo_afterbono if keepusing_chivo_afterbono!=.
replace i = received_remittances if received_remittances!=.
replace i = paidtaxes_remittances if paidtaxes_remittances!=.
keep i code 

*Remittances via Chivo in bitcoin
set obs 8
replace i = .0588889 * 3/11  in 7 /* From Figure A17: 3% received remmittances in Bitcoin, 8% in Dollars, 89% did not received remmittances in Chivo. Conditional on receiving remmittances in Chivo, 3/11 received in bitcoin. */
replace code = 7 in 7

*Use Chivo after $30 in bitcoin
replace i = .20611112 *  45/100  in 8 /* From Table 2: Only people in the 55th percentile of active users have deposited bitcoin in the app, 72th percentile received transfers in btc, 62th percentile transferred in btc, thus assuming 45/100 is an upper bound */ 
replace code = 8 in 8

label define code_d 1 "Know about Chivo" 2 "Try to use Chivo" 3 "Able to use Chivo" 4 "Use Chivo after $30" 5 "Remittances via Chivo" 6 "Pay taxes with Chivo" 7 "Remittances via Chivo in bitcoin" 8 "Use Chivo after $30 in bitcoin", modify
lab values code code_d

graph hbar  i, over(code, sort(1) descending  )   bar(1, color(midblue))  ///
ytitle("Share of Population") title("")   ///
 graphregion(color(white)) plotregion(fcolor(white) )     
graph export "$dirfigures/Figure2a.eps", replace
 
 

use "Survey_cleaned_long.dta", clear 
gen p34_entry = (p34_2==1 | p34_3==1 | p34_4==1 | p34_5==1 | p34_6==1 | p34_7==1 | p34_8==1 | p34_9==1 | p34_10==1 | p34_11==1 | p34_12==1)
recode p34_entry 1=0 0=1

gen know_chivo1 = (p12==1)
gen trydownload_chivo2 = (p14==1 | p14==2)
gen notroubles_entering3 = trydownload_chivo*p34_entry
gen keepusing_chivo_afterbono4 = (p36==1)
gen received_remittances5 = (p50==1 | p50==2)
gen paidtaxes_remittances6 = (p54==1)
gen p = 1
collapse (sum) know_chivo trydownload_chivo notroubles_entering keepusing_chivo_afterbono received_remittances paidtaxes_remittances p ,by(unbanked)

replace know_chivo=know_chivo/p
replace trydownload_chivo=trydownload_chivo/p
replace notroubles_entering=notroubles_entering/p
replace keepusing_chivo_afterbono=keepusing_chivo_afterbono/p
replace received_remittances=received_remittances/p
replace paidtaxes_remittances=paidtaxes_remittances/p

gen i=1
reshape long know_chivo trydownload_chivo notroubles_entering keepusing_chivo_afterbono received_remittances paidtaxes_remittances, i(unbanked i) j(code)

replace i = know_chivo if know_chivo!=.
replace i = trydownload_chivo if trydownload_chivo!=.
replace i = notroubles_entering if notroubles_entering!=.
replace i = keepusing_chivo_afterbono if keepusing_chivo_afterbono!=.
replace i = received_remittances if received_remittances!=.
replace i = paidtaxes_remittances if paidtaxes_remittances!=.
label define code_d 1 "Know about Chivo" 2 "Try to use Chivo" 3 "Able to use Chivo" 4 "Continue to use Chivo after $30" 5 "Remittances through Chivo" 6 "Pay taxes with Chivo", modify
lab val code code_d

keep unbanked i code 
reshape wide i, i(code) j(unbanked) 

graph hbar i0 i1, over(code, sort(1) descending)   bar(1, color(ebblue)) bar(2, color(cranberry)) ///
ytitle("Share of Population") title("")  legend(order(1 "Share Banked" 2 "Share Unbanked")  region(lwidth(none) ) ) ///
 graphregion(color(white)) plotregion(fcolor(white))  
graph export "$dirfigures/FigureA20.eps", replace
 
 
 
use  "Survey_cleaned_long.dta", clear
keep if  p12==1 /* people that know about Chivo */ 

*13. Si conoce Chivo Wallet, ¿cómo se enteró de la existencia de la aplicación?
gen p13_news = (p13_1 == 1 | p13_2 == 1 | p13_3 == 1 | p13_4 == 1 | p13_5 == 1 | p13_6 == 1 | p13_7 == 1 | p13_8 == 1 | p13_9 == 1)
gen p13_socialmedia = (p13_1 == 2 | p13_2 == 2 | p13_3 == 2 | p13_4 == 2 | p13_5 == 2 | p13_6 == 2 | p13_7 == 2 | p13_8 == 2 | p13_9 == 2)
gen p13_tv_radio = (p13_1 == 3 | p13_2 == 3 | p13_3 == 3 | p13_4 == 3 | p13_5 == 3 | p13_6 == 3 | p13_7 == 3 | p13_8 == 3 | p13_9 == 3 | p13_1 == 4 | p13_2 == 4 | p13_3 == 4 | p13_4 == 4 | p13_5 == 4 | p13_6 == 4 | p13_7 == 4 | p13_8 == 4 | p13_9== 4)
gen p13_other = (p13_1 == 5 | p13_2 == 5 | p13_3 == 5 | p13_4 == 5 | p13_5 == 5 | p13_6 == 5 | p13_7 == 5 | p13_8 == 5 | p13_9 == 5 | p13_1 == 9 | p13_2 == 9 | p13_3 == 9 | p13_4 == 9 | p13_5 == 9 | p13_6 == 9 | p13_7 == 9 | p13_8 == 9 | p13_9== 9)
gen p13_friend = (p13_1 == 6 | p13_2 == 6 | p13_3 == 6 | p13_4 == 6 | p13_5 == 6 | p13_6 == 6 | p13_7 == 6 | p13_8 == 6 | p13_9 == 6 | p13_1 == 7 | p13_2 == 7 | p13_3 == 7 | p13_4 == 7 | p13_5 == 7 | p13_6 == 7 | p13_7 == 7 | p13_8 == 7 | p13_9== 7)
gen p13_work = (p13_1 == 8 | p13_2 == 8 | p13_3 == 8 | p13_4 == 8 | p13_5 == 8 | p13_6 == 8 | p13_7 == 8 | p13_8 == 8 | p13_9 == 8)
drop p13_1-p13_9

preserve
collapse (sum) n, by(p13_*)
egen total = sum(n)
gen news1 = p13_news*n/1800
gen socialmedia2 = p13_socialmedia*n/1800
gen tv_radio3 = p13_tv_radio*n/1800
gen other4 = p13_other*n/1800
gen friend5 = p13_friend*n/1800
gen work6 = p13_work*n/1800
collapse (sum) news1 socialmedia2 tv_radio3 other4 friend5 work6
gen i=1
reshape long news socialmedia tv_radio other friend work, i(i) j(code)
label define code_d 1 "News" 2 "Social media" 3 "TV and radio" 4 "Other" 5 "Friend and family" 6 "Co-workers", modify
lab val code code_d
replace i=news if news!=.
replace i=socialmedia if socialmedia!=.
replace i=tv_radio if tv_radio!=.
replace i=other if other!=.
replace i=friend if friend!=.
replace i=work if work!=.
graph hbar i, over(code, sort(1) descending)   bar(1, color(midblue))  ///
ytitle("Share of people know about Chivo") title("")   ///
 graphregion(color(white)) plotregion(fcolor(white))  
graph export "$dirfigures/FigureA8b.eps", replace
restore 

*14. ¿Ya intento bajar Chivo Wallet?
preserve 
collapse (sum) n, by(p14)
graph pie n, over(p14) title("") ///
nocl pie(1, explode color(ebblue)) pie(2, explode color(cranberry)) pie(3, explode color(lavender)) ///
line(lwidth(thick)) legend(row(3)) plabel(1 perc, size(large)) /// 
plabel(2 perc, size(large))  plabel(3 perc, size(large)) ///
graphregion(color(white)) bgcolor(white) legend(order(1 "Yes" 2 "Yes with family/friend help" 3 "No") region(lwidth(none)) rows(1) size(medlarge))  
graph export "$dirfigures/FigureA11a.eps", replace
restore 

gen p14_yes = (p14==1 | p14==2)
label variable p14_yes "Download Chivo"

gen p14_help = (p14==2)
label variable p14_help "Download Chivo w/ Help"

areg p14_yes unbanked, absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/Table1.tex", ///
keep(unbanked) replace tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)   ///
addtext(Department, Y)  

areg p14_yes phone_w_internet, absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/Table1.tex", ///
keep(phone_w_internet) append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)  ///
addtext(Department, Y)  

areg p14_yes middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single, absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/Table1.tex", ///
keep(unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)  /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)  ///
addtext(Department, Y)  

areg p14_yes unbanked phone_w_internet  middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single, absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/Table1.tex", ///
keep(unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)  ///
addtext(Department, Y)  

areg p14_help unbanked if p14_yes==1, absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/TableB4.tex", ///
keep(unbanked) replace tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)  ///
addtext(Department, Y)  

areg p14_help phone_w_internet if p14_yes==1, absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/TableB4.tex", ///
keep(phone_w_internet) append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Department, Y)  

areg p14_help middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single if p14_yes==1, absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/TableB4.tex", ///
keep(unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)  /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Department, Y)  

areg p14_help unbanked phone_w_internet  middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single if p14_yes==1, absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/TableB4.tex", ///
keep(unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Department, Y)  

capture drop long_distance
gen long_distance=(p57>2) /* median distance */ 
replace long_distance=. if p57==.
label variable long_distance "$>$ median distance to ATM"


*15. Amigos y familiares
*16 Amigos y familiares que hayan intentado descargar Chivo
gen share_friends_chivo = p16/p15_1
replace share_friends_chivo = 1 if share_friends_chivo>1 & share_friends_chivo!=.
 
reg p14_yes share_friends_chivo  
reg p14_yes share_friends_chivo if p13_friend==0
reg p14_yes share_friends_chivo i.educ i.age i.sex i.single  if p13_friend==0
label variable share_friends_chivo "Share Friends Chivo"

areg p14_yes share_friends_chivo  middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single long_distance if p13_friend==0, absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/TableC1.tex", ///
keep(share_friends_chivo unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)  /// 
replace tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(share_friends_chivo unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Department, Y)  

areg p14_yes share_friends_chivo unbanked phone_w_internet  middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single   if p13_friend==0, absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/TableC1.tex", ///
keep(share_friends_chivo unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single  ) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(share_friends_chivo unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single  ) ///
addtext(Department, Y)  

reg p14_yes share_friends_chivo if p13_friend==0, vce(robust)
outreg2 using "$dirtables/TableC2.tex", ///
keep(share_friends_chivo)  /// 
replace tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(share_friends_chivo) ///
addtext(Department, N)  

reg p14_yes share_friends_chivo if p13_friend==0, vce(robust)
outreg2 using "$dirtables/TableC2.tex", ///
keep(share_friends_chivo) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(share_friends_chivo) ///
addtext(Department, N)  


*17. ¿Cuántos de sus amigos y familiares han descargado Chivo Wallet y lo utilizan regularmente como método de pago?
gen share_friends_chivo_reg = p17_1/p15_1
replace share_friends_chivo_reg = 1 if share_friends_chivo_reg>1 & share_friends_chivo_reg!=.
replace p36=0 if p36==2

label variable share_friends_chivo_reg "Share Friends Chivo (Reg.)"

areg p36 share_friends_chivo_reg  middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single   if p13_friend==0 & p14_yes==1 & p36!=., absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/TableC1.tex", ///
keep(share_friends_chivo_reg unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single  )  /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(share_friends_chivo share_friends_chivo_reg unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single  ) ///
addtext(Department, Y)  

areg p36 share_friends_chivo_reg unbanked phone_w_internet  middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single   if p13_friend==0 & p14_yes==1 & p36!=., absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/TableC1.tex", ///
keep(share_friends_chivo_reg unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single  ) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(share_friends_chivo share_friends_chivo_reg unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single  ) ///
addtext(Department, Y)  

reg p36 share_friends_chivo_reg if p13_friend==0 & p14_yes==1 & p36!=., vce(robust)
outreg2 using "$dirtables/TableC2.tex", ///
keep(share_friends_chivo_reg)  /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(share_friends_chivo share_friends_chivo_reg) ///
addtext(Department, N)  

reg p36 share_friends_chivo_reg if p13_friend==0 & p14_yes==1 & p36!=. , vce(robust)
outreg2 using "$dirtables/TableC2.tex", ///
keep(share_friends_chivo_reg unbanked) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(share_friends_chivo share_friends_chivo_reg) ///
addtext(Department, N)  



tab dpt, g(dpt_)
logit p14_yes unbanked phone_w_internet  middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single long_distance dpt_*, cluster(dpt)
margins, dydx(*) post
outreg2 using "$dirtables/TableC3.tex", ///
keep(share_friends_chivo share_friends_chivo_reg unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)  /// 
replace tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(share_friends_chivo unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Department, Y)  

logit p14_yes share_friends_chivo unbanked phone_w_internet  middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single dpt_*  if p13_friend==0,  cluster(dpt)
margins, dydx(*) post
outreg2 using "$dirtables/TableC3.tex", ///
keep(share_friends_chivo share_friends_chivo_reg  unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single  ) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(share_friends_chivo unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single  ) ///
addtext(Department, Y)  

logit p36  unbanked phone_w_internet  middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single dpt_* if  p14_yes==1 & p36!=., cluster(dpt)
margins, dydx(*) post
outreg2 using "$dirtables/TableC3.tex", ///
keep(share_friends_chivo share_friends_chivo_reg  unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)  /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(share_friends_chivo unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Department, Y)  

logit p36 share_friends_chivo_reg unbanked phone_w_internet  middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single dpt_*  if p13_friend==0 & p14_yes==1 & p36!=., cluster(dpt)
margins, dydx(*) post
outreg2 using "$dirtables/TableC3.tex", ///
keep(share_friends_chivo share_friends_chivo_reg  unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single  ) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(share_friends_chivo share_friends_chivo_reg unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single  ) ///
addtext(Department, Y)  


replace p36=2 if p36==0
*18. ¿A cuántos de sus amigos y familiares les han suplantado su identidad en Chivo Wallet?
gen p18_identitytheft = (p18>0 & p18!=.)
*19. ¿Está de acuerdo con el uso generalizado de Chivo Wallet?

preserve 
collapse (sum) n, by(p19)
graph pie n, over(p19) title("") ///
nocl pie(1, explode color(ebblue)) pie(2, explode color(cranberry)) pie(3, explode color(lavender)) ///
line(lwidth(thick)) legend(row(3)) plabel(1 perc, size(large)) /// 
plabel(2 perc, size(large))  plabel(3 perc, size(large)) ///
graphregion(color(white)) bgcolor(white) legend(order(1 "Yes" 2 "No") region(lwidth(none)) rows(1) size(medlarge))  
graph export "$dirfigures/FigureA16a.eps", replace
restore 

replace p19=0 if p19==2

areg p19 p14_yes, absorb(dpt)  cluster(dpt)
outreg2 using "$dirtables/TableB5.tex", ///
keep(p14_yes) /// 
replace tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(p14_yes p14_help unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Department, Y)  

areg p19 p14_yes unbanked phone_w_internet, absorb(dpt)  cluster(dpt)
outreg2 using "$dirtables/TableB5.tex", ///
keep(p14_yes unbanked phone_w_internet) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(p14_yes p14_help unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Department, Y)  

areg p19 p14_yes unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single, absorb(dpt)   cluster(dpt)
outreg2 using "$dirtables/TableB5.tex", ///
keep(p14_yes p14_help unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(p14_yes p14_help unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Department, Y)  

areg p19 p14_help if p14_yes ==1, absorb(dpt)  cluster(dpt)
outreg2 using "$dirtables/TableB5.tex", ///
keep(p14_help) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(p14_yes p14_help unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Department, Y)  

areg p19 p14_help unbanked phone_w_internet if p14_yes ==1, absorb(dpt)  cluster(dpt)
outreg2 using "$dirtables/TableB5.tex", ///
keep(p14_help unbanked phone_w_internet) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(p14_yes p14_help unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Department, Y)  

areg p19 p14_help unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single if p14_yes ==1, absorb(dpt)  cluster(dpt)
outreg2 using "$dirtables/TableB5.tex", ///
keep(p14_help unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(p14_yes p14_help p14_help unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Department, Y)  

*20 enumere del 1 al 3 (siendo la 1 la más importante) las principales razones por las que está en desacuerdo con el uso de Chivo Wallet
replace p19=0 if p19==2
gen p20_politics = (p20_1==1)
gen p20_notrust = (p20_2==1)
gen p20_nobtc = (p20_3==1)
gen p20_volatility = (p20_4==1)

preserve
keep if p19==0
drop p20_1-p20_4
collapse (sum) n, by(p20_*)
egen total=sum(n)
gen politics1 = p20_politics*n/total
gen notrust2 = p20_notrust*n/total
gen nobtc3 = p20_nobtc*n/total
gen volatility4 = p20_volatility*n/total

collapse (sum) politics1 notrust2 nobtc3 volatility4  
gen i=1
reshape long politics notrust nobtc volatility, i(i) j(code)
label define code_d 1 "Political ideology" 2 "Do not trust system" 3 "Do not understand Bitcoin" 4 "Volatility Bitcoin", modify
lab val code code_d
replace i=politics if politics!=.
replace i=notrust if notrust!=.
replace i=nobtc if nobtc!=.
replace i=volatility if volatility!=.
drop politics notrust nobtc volatility
graph hbar i, over(code, sort(1) descending)   bar(1, color(midblue))  ///
ytitle("Share of People Not in Favor") title("")   ///
 graphregion(color(white)) plotregion(fcolor(white))  
graph export "$dirfigures/FigureA16b.eps", replace
restore 

*21. ¿Cuántos autos tiene?
*22. Si tenía auto antes de que se lanzara Chivo Wallet, ¿cuánto gastaba en gasolina en dólares en un mes promedio?
replace p22 = . if p22==999 /* No sabe */

*23. ¿qué fracción o porcentaje pagaba en....(nota: la suma de las 3 opciones debe dar 100%)
rename p23_1 p23_pctcash
rename p23_2 p23_pctcard
rename p23_3 p23_pctother

*24. ¿Esta enterado de que hay descuentos en gasolina si paga con Chivo Wallet?
replace p24=0 if p24==2

*25. Si tiene auto, desde de que se implementaron los descuentos en gasolina con Chivo Wallet, ¿cuánto gasta en gasolina en dólares en un mes promedio? (indique NS/NR si no tenia auto y pase a la pregunta 27)
replace p25=. if p25==999
gen p25_Xgas = (p25>0 & p25!=.)

*26. Del monto que gasta en gasolina desde de que se implementaron los descuentos en gasolina con Chivo Wallet, ¿qué fracción o porcentaje paga en...? (nota: la suma de las 5 opciones debe dar 100%)
gen p26_chivo = 0 if p25_Xgas==1
replace p26_chivo = 1 if p26_3>0 & p26_3!=. 
replace p26_chivo = 1 if p26_4>0 & p26_4!=. 
gen p26_sharechivo = p26_3 + p26_4 

* estimating the differences in shares between treatment and control group
reg p26_sharechivo p24 if p26_chivo==1 
su p26_sharechivo if p26_chivo==1 & p24==0 , d /* 36.25 */ 

gen share = p26_sharechivo/100
gen share_other = 1-share
gen lnp_ratio = 1 if p25_Xgas==1

gen multiplier =1 if p26_chivo==1 & p25_Xgas==1
replace multiplier = 1/1.08 if p26_chivo==1 & p24==1 & p25_Xgas==1 /* discount 8% per gallon */
capture drop constant*
gen constant1=.3625 if p25_Xgas==1 /* .3625 from su p26_sharechivo if p26_chivo==1 & p24==0 */ 
gen constant2=.3625*(1-.3625) if p25_Xgas==1
gen lnmultiplier=ln(multiplier) if p25_Xgas==1
gen lnmultiplier2=lnmultiplier*lnmultiplier if p25_Xgas==1
capture drop term*
gen term1=constant1 if p25_Xgas==1
gen term2=constant2*lnmultiplier if p25_Xgas==1

label variable term2 "Log Price"

reg share term2 if p25_Xgas==1 & p26_chivo==1, vce(robust)
outreg2 using "$dirtables/TableC4.tex", ///
keep(term2) /// 
replace tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(term2 unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)

reg share term2 unbanked phone_w_internet if p25_Xgas==1 & p26_chivo==1, vce(robust)
outreg2 using "$dirtables/TableC4.tex", ///
keep(term2 unbanked phone_w_internet) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(term2 unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)

reg share term2 age_25_34 age_35_44 age_45_54 age_55plus sex single  if p25_Xgas==1 & p26_chivo==1, vce(robust)
outreg2 using "$dirtables/TableC4.tex", ///
keep(term2 age_25_34 age_35_44 age_45_54 age_55plus sex single) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(term2 unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)

reg share term2 unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single if p25_Xgas==1 & p26_chivo==1, vce(robust)
outreg2 using "$dirtables/TableC4.tex", ///
keep(term2 unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(term2 unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single)


*27. Si no ha descargado Chivo Wallet, ¿podría enumerar del 1 al 3 las razones principales por las que no lo descargó (siendo la 1 la más importante y 3 la menos importante)? 
gen p27_tech = (p27_1==1) /* La tecnología es muy complicada de usar */
gen p27_errors = (p27_2==1) /* La aplicación tuvo fallas técnicas  */
gen p27_nointernet = (p27_3==1) /*  No tengo celular con internet */
gen p27_noATM = (p27_4==1) /* Vivo muy lejos de algún cajero Chivo Wallet  */
gen p27_notrust = (p27_5==1)  /* Desconfío del sistema  */
gen p27_notrustBTC = (p27_6==1) /* Desconfío de Bitcoin  */
gen p27_cash = (p27_7==1) /* Prefiero utilizar efectivo  */
gen p27_card = (p27_8==1 | p27_9==1) /*  Prefiero utilizar tarjeta de crédito, Prefiero utilizar tarjeta de débito */

preserve
keep if p14_yes==0
drop p27_1-p27_9
collapse (sum) n, by(p27_*)
egen total=sum(n)
gen tech1 = p27_tech*n/total
gen errors2 = p27_errors*n/total
gen nointernet3 = p27_nointernet*n/total
gen noATM4 = p27_noATM*n/total
gen notrust5 = p27_notrust*n/total
gen notrustBTC6 = p27_notrustBTC*n/total
gen cash7 = p27_cash*n/total
gen card8 = p27_card*n/total
collapse (sum) tech1 errors2 nointernet3 noATM4 notrust5 notrustBTC6 cash7 card8
gen i=1
reshape long tech errors nointernet noATM notrust notrustBTC cash card, i(i) j(code)
label define code_d 1 "Technology complicated" 2 "Errors in app" 3 "No phone with internet" 4 "Chivo ATM is far" 5 "Do not trust system" 6 "Do not trust Bitcoin" 7 "Prefer cash" 8 "Prefer card"  , modify
lab val code code_d
replace i=tech if tech!=.
replace i=errors if errors!=.
replace i=nointernet if nointernet!=.
replace i=noATM if noATM!=.
replace i=notrust if notrust!=.
replace i=notrustBTC if notrustBTC!=.
replace i=cash if cash!=.
replace i=card if card!=.
drop tech errors nointernet noATM notrust notrustBTC cash card 
graph hbar i, over(code, sort(1) descending)   bar(1, color(midblue))  ///
ytitle("Share of people without Chivo") title("")   ///
 graphregion(color(white)) plotregion(fcolor(white))  
graph export "$dirfigures/FigureA13a.eps", replace
restore 

*28. Si no ha descargado Chivo Wallet ¿que tan grande tendría que ser el bono en dólares para convencerle de bajar Chivo Wallet?
replace p28 = . if p28<30 & p14_yes==0 /* Measurement error: people that have not dowloaded the app reporting they would do it for less than the $30 bonus */

preserve 
keep p29 n
drop if p29==.
capture drop month
gen all_dates=dofc(p29)
gen month=month(all_dates)
gen year=year(all_dates)
drop all_dates
gen all_dates = ym(year, month)
format %tm all_dates
collapse (sum) n, by(all_dates)
egen total = sum(n)
gen share = n/total

#delimit
twoway 
(line share all_dates, lwidth(thick) lcolor(cranberry))  
, ytitle("Share of Adopters", height(5)) 
 xtitle(" ") ylabel(0[.1].4) title(" ") xline(22528, lwidth(thick)   lcolor(cranberry) lpattern(dash))
legend(off) graphregion(color(white)) plotregion(fcolor(white)) 
graphregion(margin(l+0 r+5));
#delimit cr
graph export "$dirfigures/Figure1a.eps", replace
restore

*31. Si ya descargó Chivo Wallet, ¿cuál es el monto mínimo del bono que lo hubiera convencido de bajar Chivo Wallet?
egen p28_p31 = rowtotal(p28 p31)
replace p28_p31=. if p28==. & p31==. 

preserve
keep p28_p31 p28 p31 p14_yes  unbanked phone_w_internet  middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single dpt age educ
gen weight = 3 if p14_yes==0 /* reweight distribution adjusting for measurement error */ 
replace weight = 1 if p14_yes==1 
label variable p28_p31 "Adoption Cost"
estpost summarize p28_p31 [w=weight], d 
esttab using "$dirtables/TableB7.tex",  fragment  cells("mean(fmt(3)) sd(fmt(3)) p10(fmt(3)) p25(fmt(3)) p50(fmt(3)) p75(fmt(3)) p90(fmt(3))") noobs label replace
restore 
 

*30. Si ya intentó descargar Chivo Wallet, ¿podría enumerar del 1 al 3 las razones principales por las que lo descargó 
gen p30_withdraw30 = (p30_1==1) /* Retirar en efectivo los $30 (mediante algún intermediario o conocido) */
gen p30_use30friends = (p30_2==1) /* Utilizar los $30 en Bitcoin a través de Chivo Wallet - familiares o amigos */
gen p30_use30commerce = (p30_3==1) /*  Utilizar los $30 en Bitcoin a través de Chivo Wallet - comercios */
gen p30_remittances = (p30_4==1) /* Remesas  */
gen p30_covid = (p30_5==1) /* COVID-19  */
gen p30_other = (p30_6==1) /* Otros  */
gen p30_use30 = (p30_1==1 | p30_2==1 | p30_3==1)

preserve
keep if p14_yes==1
drop p30_1-p30_6
collapse (sum) n, by(p30_use30 p30_remittances p30_covid p30_other)
egen total=sum(n)
gen use301 = p30_use30*n/total
gen remittances4 = p30_remittances*n/total
gen covid5 = p30_covid*n/total
gen other6 = p30_other*n/total
collapse (sum) use301 remittances covid other
gen i=1
reshape long use30 remittances covid other, i(i) j(code)
label define code_d 1 "Use $30 bonus" 4 "Remittances" 5 "Contactless - COVID-19" 6 "Other", modify
lab val code code_d
replace i=use30 if use30!=.
replace i=remittances if remittances!=.
replace i=covid if covid!=.
replace i=other if other!=.
drop use30 remittances covid other 
graph hbar i, over(code, sort(1) descending)   bar(1, color(midblue))  ///
ytitle("Share of people with Chivo") title("")   ///
 graphregion(color(white)) plotregion(fcolor(white))  
graph export "$dirfigures/FigureA11b.eps", replace
restore 
 

*34. Si ya intentó descargar Chivo Wallet, ¿tuvo algún problema usando la aplicación?

preserve 
collapse (sum) n, by(p34_1)
drop if p34_1==.
graph pie n, over(p34_1) title("") ///
nocl pie(1, explode color(ebblue)) pie(2, explode color(cranberry)) pie(3, explode color(lavender)) ///
line(lwidth(thick)) legend(row(3)) plabel(1 perc, size(large)) /// 
plabel(2 perc, size(large))  plabel(3 perc, size(large)) ///
graphregion(color(white)) bgcolor(white) legend(order(1 "Yes" 2 "No") region(lwidth(none)) rows(1) size(medlarge))  
graph export "$dirfigures/FigureA14a.eps", replace
restore 

gen p34_entry = (p34_2==1 | p34_3==1 | p34_4==1 | p34_5==1 | p34_6==1 | p34_7==1 | p34_8==1 | p34_9==1 | p34_10==1 | p34_11==1 | p34_12==1)
gen p34_identitytheft = (p34_2==2 | p34_3==2 | p34_4==2 | p34_5==2 | p34_6==2 | p34_7==2 | p34_8==2 | p34_9==2 | p34_10==2 | p34_11==2 | p34_12==2)
gen p34_nonauthorized_transfers = (p34_2==3 | p34_3==3 | p34_4==3 | p34_5==3 | p34_6==3 | p34_7==3 | p34_8==3 | p34_9==3 | p34_10==3 | p34_11==3 | p34_12==3)
gen p34_transfers = (p34_2==4 | p34_3==4 | p34_4==4 | p34_5==4 | p34_6==4 | p34_7==4 | p34_8==4 | p34_9==4 | p34_10==4 | p34_11==4 | p34_12==4 | p34_2==5 | p34_3==5 | p34_4==5 | p34_5==5 | p34_6==5 | p34_7==5 | p34_8==5 | p34_9==5 | p34_10==5 | p34_11==5 | p34_12==5)
gen p34_withdrawing = (p34_2==6 | p34_3==6 | p34_4==6 | p34_5==6 | p34_6==6 | p34_7==6 | p34_8==6 | p34_9==6 | p34_10==6 | p34_11==6 | p34_12==6)
gen p34_depositing = (p34_2==7 | p34_3==7 | p34_4==7 | p34_5==7 | p34_6==7 | p34_7==7 | p34_8==7 | p34_9==7 | p34_10==7 | p34_11==7 | p34_12==7)
gen p34_bono = (p34_2==8 | p34_3==8 | p34_4==8 | p34_5==8 | p34_6==8 | p34_7==8 | p34_8==8 | p34_9==8 | p34_10==8 | p34_11==8 | p34_12==8)
gen p34_lostmoney = (p34_2==9 | p34_3==9 | p34_4==9 | p34_5==9 | p34_6==9 | p34_7==9 | p34_8==9 | p34_9==9 | p34_10==9 | p34_11==9 | p34_12==9)
gen p34_othertechnical = (p34_2==10 | p34_3==10 | p34_4==10 | p34_5==10 | p34_6==10 | p34_7==10 | p34_8==10 | p34_9==10 | p34_10==10 | p34_11==10 | p34_12==10)
 
label variable p34_1 "Problems using app."
label variable p34_entry "Unable to access"
label variable p34_identitytheft "Identity theft"
label variable p34_nonauthorized_transfers "Unauthorized transactions" 
label variable p34_transfers  "Issues receiving/sending"
label variable p34_withdrawing "Issues withdrawing"
label variable p34_depositing "Issues depositing"
label variable p34_lostmoney  "Lost money"
label variable p34_othertechnical "Other technical"
 
replace p36=0 if p36==2

areg p36 p34_1 if p14_yes==1 & p36!=., absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/TableB6.tex", ///
keep(p34_1 long_distance unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) /// 
replace tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(p34_1 long_distance unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Demographic Controls, Y, Department Fixed Effects, Y)  

areg p36 long_distance  if p14_yes==1 & p36!=., absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/TableB6.tex", ///
keep(p34_1 p34_entry  long_distance unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(p34_1 long_distance unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Demographic Controls, Y, Department Fixed Effects, Y)  

areg p36 p34_1 long_distance unbanked phone_w_internet if p14_yes==1 & p36!=., absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/TableB6.tex", ///
keep(p34_1 long_distance unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(p34_1 long_distance unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Demographic Controls, Y, Department Fixed Effects, Y)  
 
areg p36 p34_1 long_distance unbanked phone_w_internet  middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single   if p14_yes==1 & p36!=., absorb(dpt) cluster(dpt)
outreg2 using "$dirtables/TableB6.tex", ///
keep(p34_1 long_distance unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
label nonotes sortvar(p34_1 long_distance unbanked phone_w_internet unbanked phone_w_internet middleschool highschool age_25_34 age_35_44 age_45_54 age_55plus sex single) ///
addtext(Demographic Controls, Y, Department Fixed Effects, Y)  
 
preserve
keep if p14_yes==1
drop p34_1-p34_12
collapse (sum) n, by(p34_*)
egen total=sum(n)
gen entry1 = p34_entry*n/total
gen identitytheft2 = p34_identitytheft*n/total
gen nonauthorized_transfers3 = p34_nonauthorized_transfers*n/total
gen transfers4 = p34_transfers*n/total
gen withdrawing5 = p34_withdrawing*n/total
gen depositing6 = p34_depositing*n/total
gen bono7 = p34_bono*n/total
gen lostmoney8 = p34_lostmoney*n/total
gen othertechnical9 = p34_othertechnical*n/total

collapse (sum) entry1 identitytheft2 nonauthorized_transfers3 transfers4 withdrawing5 depositing6 bono7 lostmoney8 othertechnical9
gen i=1
reshape long entry identitytheft nonauthorized_transfers transfers withdrawing depositing bono lostmoney othertechnical, i(i) j(code)
label define code_d 1 "Unable to access" 2 "Identity theft" 3 "Unauthorized transactions" 4 "Issues receiving/sending" 5 "Issues withdrawing" 6 "Issues depositing" 7 "Did not get $30 bonus" 8 "Lost money" 9 "Other technical", modify
lab val code code_d
replace i=entry if entry!=.
replace i=identitytheft if identitytheft!=.
replace i=nonauthorized_transfers if nonauthorized_transfers!=.
replace i=transfers if transfers!=.
replace i=withdrawing if withdrawing!=.
replace i=depositing if depositing!=.
replace i=bono if bono!=.
replace i=lostmoney if lostmoney!=.
replace i=othertechnical if othertechnical!=.

drop entry identitytheft nonauthorized_transfers transfers withdrawing depositing bono lostmoney othertechnical 
graph hbar i, over(code, sort(1) descending)   bar(1, color(midblue))  ///
ytitle("Share of people with Chivo") title("")   ///
 graphregion(color(white)) plotregion(fcolor(white))  
graph export "$dirfigures/FigureA14b.eps", replace
restore 


* 35. ¿Cuál fue el uso principal del bono de $30?
preserve
keep if p14_yes==1
collapse (sum) n, by(p35)
drop if p35==.
rename p35 code
rename n i
collapse (sum) i, by(code)
gen code2 = . 
replace code2=1 if code==1 | code==2 
replace code2=2 if code==5 | code==6
replace code2=3 if code==3 | code==4 | code==7 | code==8 | code==9
collapse (sum) i, by(code2)
egen total=sum(i)
replace i = i/total
label define code_d 1 "Have not used it" 2 "Use it in Bitcoin" 3 "Other uses", modify
lab val code2 code_d
graph hbar i, over(code, sort(1) descending)   bar(1, color(midblue))  ///
ytitle("Share of population") title("")   ///
 graphregion(color(white)) plotregion(fcolor(white))  
graph export "$dirfigures/FigureA11c.eps", replace
restore

* 36. ¿ha seguido usando Chivo Wallet después de usar su bono de $30?
preserve 
collapse (sum) n, by(p36)
drop if p36==.
graph pie n, over(p36) title("") ///
nocl pie(1, explode color(ebblue)) pie(2, explode color(cranberry)) pie(3, explode color(lavender)) ///
line(lwidth(thick)) legend(row(3)) plabel(1 perc, size(large)) /// 
plabel(2 perc, size(large))  plabel(3 perc, size(large)) ///
graphregion(color(white)) bgcolor(white) legend(order(1 "Yes" 2 "No") region(lwidth(none)) rows(1) size(medlarge))  
graph export "$dirfigures/FigureA11d.eps", replace
restore 
replace p36 = 0 if p36==2

* 37. ¿Cuántos retiros de efectivo realiza al mes usando cajeros Chivo?  
preserve 
collapse (sum) n, by(p37)
drop if p37==.
gen p37_withdrawal = (p37>0)
collapse (sum) n, by(p37_withdrawal)
replace p37=2 if p37==0
graph pie n, over(p37_withdrawal) title("") ///
nocl pie(1, explode color(ebblue)) pie(2, explode color(cranberry)) pie(3, explode color(lavender)) ///
line(lwidth(thick)) legend(row(3)) plabel(1 perc, size(large)) /// 
plabel(2 perc, size(large))  plabel(3 perc, size(large)) ///
graphregion(color(white)) bgcolor(white) legend(order(1 "At least 1 withdrawal" 2 "No") region(lwidth(none)) rows(1) size(medlarge))  
graph export "$dirfigures/FigureA11e.eps", replace
restore 
save  "Survey_cleaned_Table2.dta", replace 


use  "Survey_cleaned_Table2.dta", clear 
*37. ¿Cuántos retiros de efectivo realiza al mes usando cajeros Chivo?  
su p37 if p14_yes==1 & p36==1, d
gen p37_nooutliers = p37 if p14_yes==1 & p36==1 & p37<`r(p99)'

*38. ¿Cuál es el monto promedio de sus retiros en efectivo usando cajeros Chivo? 
su p38 if p14_yes==1 & p36==1 & p38>0, d /* conditional on withdrawing */
gen p38_nooutliers = p38 if p14_yes==1 & p36==1 & p38<`r(p99)' & p38>0  /* conditional on withdrawing, removes outliers */

*41. ¿aproximadamente cuántos pagos o transferencias realiza al mes usando Chivo Wallet?
su p41_1 if p14_yes==1 & p36==1, d
gen p41_1_nooutliers = p41_1 if p14_yes==1 & p36==1 & p41_1<`r(p99)' /* removes outliers */

su p41_2 if p14_yes==1 & p36==1, d
gen p41_2_nooutliers = p41_2 if p14_yes==1 & p36==1 & p41_2<`r(p99)' /* removes outliers */

*42. ¿cuál es el monto promedio de sus pagos o transferencias?
su p42_1 if p14_yes==1 & p36==1 & p42_1>0, d  
gen p42_1_nooutliers = p42_1 if p14_yes==1 & p36==1 & p42_1<`r(p99)' & p42_1>0 /* conditional on transferring, removes outliers */

su p42_2 if p14_yes==1 & p36==1 & p42_2>0, d  
gen p42_2_nooutliers = p42_2 if p14_yes==1 & p36==1 & p42_2<`r(p99)'  & p42_2>0 /* conditional on transferring, removes outliers */

*43. ¿aproximadamente cuántos pagos o transferencias recibe al mes usando Chivo Wallet?
su p43_1 if p14_yes==1 & p36==1, d
gen p43_1_nooutliers = p43_1 if p14_yes==1 & p36==1 & p43_1<`r(p99)' /* removes outliers */

su p43_2 if p14_yes==1 & p36==1, d
gen p43_2_nooutliers = p43_2 if p14_yes==1 & p36==1 & p43_2<`r(p99)' /* removes outliers */

*44.  ¿cuál es el monto promedio de los pagos o transferencias que recibe?
su p44_1 if p14_yes==1 & p36==1 & p44_1>0, d  
gen p44_1_nooutliers = p44_1 if p14_yes==1 & p36==1 & p44_1<`r(p99)' & p44_1>0 /* conditional on receiving, removes outliers */

su p44_2 if p14_yes==1 & p36==1 & p44_2>0, d  
gen p44_2_nooutliers = p44_2 if p14_yes==1 & p36==1 & p44_2<`r(p99)' & p44_2>0 /* conditional on receiving, removes outliers */

*47. ¿Cuántas veces ha cargado dinero a su Chivo Wallet desde que la descargó?
su p47_1 if p14_yes==1 & p36==1, d
gen p47_1_nooutliers = p47_1 if p14_yes==1 & p36==1 & p47_1<`r(p99)' /* removes outliers */

su p47_2 if p14_yes==1 & p36==1, d
gen p47_2_nooutliers = p47_2 if p14_yes==1 & p36==1 & p47_2<`r(p99)' /* removes outliers */

gen deposits_btc = p47_1_nooutliers
gen deposits_usd = p47_2_nooutliers 

gen all_dates=dofc(p29)
gen month=month(all_dates)
replace month=13 if month==1 
replace month=14 if month==2 
gen monthssincedownload = 14-month  /* survey started february - keeps people that have been there at least a month */ 

gen deposits_btc_permonth = deposits_btc/ monthssincedownload
gen deposits_usd_permonth = deposits_usd/ monthssincedownload

label variable p37_nooutliers "ATM withdrawals"
label variable p38_nooutliers "Avg. amount ATM withdrawals (in dollars)"
label variable p41_1_nooutliers "Payments/transfers sent in bitcoin"
label variable p41_2_nooutliers "Payments/transfers sent in dollars"
label variable p42_1_nooutliers "Avg. amount payments/transfers sent in bitcoin (in dollars)"
label variable p42_2_nooutliers "Avg. amount payments/transfers sent in dollars (in dollars)"
label variable p43_1_nooutliers "Payments/transfers received in bitcoin"
label variable p43_2_nooutliers "Payments/transfers received in dollars"
label variable p44_1_nooutliers "Avg. amount payments/transfers received in bitcoin (in dollars)"
label variable p44_2_nooutliers "Avg. amount payments/transfers received in dollars (in dollars)"
label variable deposits_btc_permonth "Deposits in bitcoin"
label variable deposits_usd_permonth "Deposits in dollars"


estpost summarize p37_nooutliers p38_nooutliers p41_1_nooutliers p41_2_nooutliers p42_1_nooutliers p42_2_nooutliers p43_1_nooutliers p43_2_nooutliers p44_1_nooutliers p44_2_nooutliers deposits_btc_permonth deposits_usd_permonth, d 
esttab using "$dirtables/Table2.tex",  fragment  cells("mean(fmt(3)) sd(fmt(3)) p10(fmt(3)) p25(fmt(3)) p50(fmt(1)) p75(fmt(1)) p90(fmt(1))") noobs label replace


*46. ¿Ha cargado dinero a su Chivo Wallet?
gen p46_no = (p46_1==4 | p46_2==4 | p46_3==4 | p46_4==4)
gen p46_ATM = (p46_1==1 | p46_2==1 | p46_3==1 | p46_4==1)
gen p46_webcard = (p46_1==2 | p46_2==2 | p46_3==2 | p46_4==2 | p46_1==3 | p46_2==3 | p46_3==3 | p46_4==3)

preserve 
drop p46_1-p46_4
keep if p14_yes==1
collapse (sum) n, by(p46_*)
egen total=sum(n)
gen no1 = p46_no*n/total
gen ATM2 = p46_ATM*n/total
gen webcard3 = p46_webcard*n/total
collapse (sum) no1 ATM2 webcard3 
gen i=1
reshape long no ATM webcard, i(i) j(code)
label define code_d 1 "No" 2 "Chivo ATM" 3 "Online using card", modify
lab val code code_d
replace i=no if no!=.
replace i=ATM if ATM!=.
replace i=webcard if webcard!=.
drop no ATM webcard
graph hbar i, over(code, sort(1) descending)   bar(1, color(midblue))  ///
ytitle("Share of people with Chivo") title("")   ///
 graphregion(color(white)) plotregion(fcolor(white))  
graph export "$dirfigures/FigureA11f.eps", replace
restore 
 

*48. Si ya descargó Chivo Wallet, marque todas las opciones que apliquen:
gen p48_btc_before = (p48_1==1 | p48_2==1 | p48_3==1 | p48_4==1) /* use btc before */
gen p48_btc_now = (p48_1==2 | p48_2==2 | p48_3==2 | p48_4==2 | p48_1==3 | p48_2==3 | p48_3==3 | p48_4==3) /* use btc inside chivo or outside*/
gen p48_no_btc = (p48_1==4 | p48_2==4 | p48_3==4 | p48_4==4) /* not before or now */ 

*49 ¿Por qué no usa Bitcoin para pagos o transferencias?
preserve 
collapse (sum) n, by(p49)
drop if p49==.
egen total=sum(n)
rename p49 code
gen  i = n/total
label define code_d  1 "Do not understand it" 2 "Do not trust it" 3 "High fees" 4 "Volatility of Bitcoin" 5 "Not accepted in businesses" 6 "Other", modify
lab val code code_d
graph hbar i, over(code, sort(1) descending)   bar(1, color(midblue))  ///
ytitle("Share of People That Do Not Use It Anymore") title("")   ///
 graphregion(color(white)) plotregion(fcolor(white))  
graph export "$dirfigures/FigureA13b.eps", replace
restore 


*50 ¿Ha recibido dinero del exterior (remesas) a través de Chivo Wallet?
preserve 
collapse (sum) n, by(p50)
drop if p50==.
egen total=sum(n)
replace n=n/total
replace n=round(n,0.01)

graph pie n, over(p50) title("") ///
nocl pie(1, explode color(ebblue)) pie(3, explode color(cranberry)) pie(2, explode color(lavender)) ///
line(lwidth(thick)) legend(row(3)) plabel(1 perc, size(large)) /// 
plabel(2 perc, size(large))  plabel(3 perc, size(large)) ///
graphregion(color(white)) bgcolor(white) legend(order(1 "Yes in Bitcoin" 2 "Yes in dollars" 3 "No") region(lwidth(none)) rows(1) size(medlarge))  
graph export "$dirfigures/FigureA17b.eps", replace
restore 


*52 sin considerar el bono de $30, su uso de efectivo ha
preserve
keep n p52 p14_yes
keep if p14_yes==1 
collapse (sum) n, by(p52)
egen total=sum(n)
replace n=n/total
replace n=round(n,0.1)
graph pie n, over(p52) title("") ///
nocl pie(1, explode color(ebblue)) pie(3, explode color(cranberry)) pie(2, explode color(lavender)) ///
line(lwidth(thick)) legend(row(3)) plabel(1 perc, size(large)) /// 
plabel(2 perc, size(large))  plabel(3 perc, size(large)) ///
graphregion(color(white)) bgcolor(white) legend(order(1 "Increased" 2 "Decreased" 3 "Same") region(lwidth(none)) rows(1) size(medlarge))  
graph export "$dirfigures/FigureA21a.eps", replace
restore 


*53 sin considerar el bono de $30, su uso de tarjetas de débito o crédito ha
preserve
keep n p53 p14_yes
keep if p14_yes==1 
collapse (sum) n, by(p53)
egen total=sum(n)
replace n=n/total
replace n=round(n,0.01)
graph pie n, over(p53) title("") ///
nocl pie(1, explode color(ebblue)) pie(3, explode color(cranberry)) pie(2, explode color(lavender)) ///
line(lwidth(thick)) legend(row(3)) plabel(1 perc, size(large)) /// 
plabel(2 perc, size(large))  plabel(3 perc, size(large)) ///
graphregion(color(white)) bgcolor(white) legend(order(1 "Increased" 2 "Decreased" 3 "Same") region(lwidth(none)) rows(1) size(medlarge))  
graph export "$dirfigures/FigureA21b.eps", replace
restore 

*54 ¿has utilizado la aplicación para pagar tus impuestos?
preserve
keep n p54 p14_yes
keep if p14_yes==1 
collapse (sum) n, by(p54)
egen total=sum(n)
replace n=n/total
replace n=round(n,0.01)
graph pie n, over(p54) title("") ///
nocl pie(1, explode color(ebblue)) pie(2, explode color(cranberry)) ///
line(lwidth(thick)) legend(row(3)) plabel(1 perc, size(large)) /// 
plabel(2 perc, size(large))  plabel(3 perc, size(large)) ///
graphregion(color(white)) bgcolor(white) legend(order(1 "Yes" 2 "No") region(lwidth(none)) rows(1) size(medlarge))  
graph export "$dirfigures/FigureA17a.eps", replace
restore 

*56 ¿has encontrado negocios que han subido los precios (o cobrado alguna comisión) por los bienes/servicios pagados en Bitcoin?
preserve
keep n p56 p14_yes
keep if p14_yes==1 
collapse (sum) n, by(p56)
egen total=sum(n)
replace n=n/total
replace n=round(n,0.01)
graph pie n, over(p56) title("") ///
nocl pie(1, explode color(ebblue)) pie(2, explode color(cranberry)) ///
line(lwidth(thick)) legend(row(3)) plabel(1 perc, size(large)) /// 
plabel(2 perc, size(large))  plabel(3 perc, size(large)) ///
graphregion(color(white)) bgcolor(white) legend(order(1 "Yes" 2 "No") region(lwidth(none)) rows(1) size(medlarge))  
graph export "$dirfigures/FigureA22a.eps", replace
restore 

*57 A cuantos kilometros de su casa queda el cajero Chivo mas cercano?
capture drop p57_logs 
gen p57_logs = asinh(p57)
xtile distance_pct = p57,  nq(5) /* Mean 10 km, Median 2km */ 
capture drop p57_w
winsor2 p57, cut(0 95)

#delimit
twoway 
(hist p57_w if p14_yes==1, bin(13) fraction fcolor(orange) lcolor(black) )
, title(" ") 
ytitle("Share of population",size(large) height(7))
xtitle("Distance to Chivo ATM (Km.)",size(large) height(7))  
legend(off)
graphregion(color(white)) plotregion(fcolor(white));
#delimit cr 
graph export "$dirfigures/FigureA12.eps", replace


*58 ¿cuál sería la comisión máxima que estaría dispuesto a pagar por un retiro de 100 dólares? 
*59 ¿cuál sería la comisión máxima que estaría dispuesto a pagar por cada transacción de este tipo?
label variable p58 "Max fee to withdraw 100 USD"
label variable p59 "Max fee to convert BTC to USD"

estpost summarize p58 p59, d 
esttab using "$dirtables/TableB8.tex",  fragment  cells("mean(fmt(3)) sd(fmt(3)) p10(fmt(3)) p25(fmt(3)) p50(fmt(3)) p75(fmt(3)) p90(fmt(3))") noobs label replace
  
save "Survey_cleaned_short.dta", replace 

use "Survey_cleaned_short.dta", clear 
gen p60_dontwork = (p60==4) 
keep if  p60_dontwork==0 /* keep those who work */ 

*61. Es usted: Dueño,  Empleado ventas, Empleado de una empresa en otra posición, Otros
gen p61_owner_or_insales = (p61 ==1 | p61 ==2)

*62. Indique el número de empleados que tiene la empresa donde trabaja
replace p62=. if p62==9999999
gen lnsize =ln(p62)
xtile size_pct = p62,  nq(5)
tab size_pct, g(size_pct_)
label variable size_pct_1 "1st Quantile"
label variable size_pct_2 "2nd Quantile"
label variable size_pct_3 "3rd Quantile"
label variable size_pct_4 "4th Quantile"
label variable size_pct_5 "5th Quantile"

*63. ¿En qué sector está su empresa?
rename p63 sector
 
 
*64. En la empresa donde trabaja, ¿qué métodos de pago aceptan?
gen p64_cash = (p64_1==3 | p64_2==3 | p64_3==3 | p64_4==3)  
gen p64_card = (p64_1==2 | p64_2==2 | p64_3==2 | p64_4==2)
gen p64_btc = (p64_1==1 | p64_2==1 | p64_3==1 | p64_4==1 | p64_1==4 | p64_2==4 | p64_3==4 | p64_4==4)
replace p64_cash=. if p64_1==5
replace p64_card=. if p64_1==5
replace p64_btc=. if p64_1==5

reg p64_btc size_pct_2 size_pct_3 size_pct_4 size_pct_5, cluster(sector)
outreg2 using "$dirtables/TableB9.tex", ///
keep(size_pct_2 size_pct_3 size_pct_4 size_pct_5) /// 
replace tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
addtext(Owner/Working in Sales, N, Sector, N) ///
label nonotes sortvar(size_pct_2 size_pct_3 size_pct_4 size_pct_5)

reghdfe p64_btc size_pct_2 size_pct_3 size_pct_4 size_pct_5, absorb(sector) cluster(sector)
outreg2 using "$dirtables/TableB9.tex", ///
keep(size_pct_2 size_pct_3 size_pct_4 size_pct_5) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
addtext(Owner/Working in Sales, N, Sector, Y) ///
label nonotes sortvar(size_pct_2 size_pct_3 size_pct_4 size_pct_5)

reg p64_btc size_pct_2 size_pct_3 size_pct_4 size_pct_5 if p61_owner_or_insales==1, cluster(sector)
outreg2 using "$dirtables/TableB9.tex", ///
keep(size_pct_2 size_pct_3 size_pct_4 size_pct_5) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
addtext(Owner/Working in Sales, Y, Sector, N) ///
label nonotes sortvar(size_pct_2 size_pct_3 size_pct_4 size_pct_5)

reghdfe p64_btc size_pct_2 size_pct_3 size_pct_4 size_pct_5 if p61_owner_or_insales==1, absorb(sector)  cluster(sector) 
outreg2 using "$dirtables/TableB9.tex", ///
keep(size_pct_2 size_pct_3 size_pct_4 size_pct_5) /// 
append tex nocons bdec(4) tdec(4)  ctitle(" ")  ///
addtext(Owner/Working in Sales, Y, Sector, Y) ///
label nonotes sortvar(size_pct_2 size_pct_3 size_pct_4 size_pct_5)

preserve 
drop p64_1-p64_5
collapse (sum) n, by(p64*)
drop if p64_cash==.
egen total = sum(n)
gen cash1 = p64_cash*n/total
gen card2 = p64_card*n/total
gen btc3 = p64_btc*n/total
collapse (sum) cash1 card2 btc3  
gen i=1
reshape long cash card btc, i(i) j(code)
label define code_d 1 "Cash" 2 "Card" 3 "Bitcoin", modify
lab val code code_d
replace i=cash if cash!=.
replace i=card if card!=.
replace i=btc if btc!=.
graph hbar i, over(code, sort(1) descending)   bar(1, color(midblue))  ///
ytitle("Share of people working") title("")   ///
 graphregion(color(white)) plotregion(fcolor(white))  
graph export "$dirfigures/FigureA23a.eps", replace
restore 

*65. En la empresa donde trabaja, ¿qué porcentaje de ventas se realizaron en Bitcoin, otra aplicación, efectivo, tarjeta
preserve 
replace p65_1 = . if p65_1 == 999
replace p65_2 = . if p65_2 == 999
replace p65_3 = . if p65_3 == 999
replace p65_4 = . if p65_4 == 999
drop if p65_1==. & p65_2==. & p65_3==. & p65_4==.  
gen p64_btc_nozero = p64_btc * (p65_1!=.)
replace p65_1=0 if p64_btc==1

#delimit
twoway 
(histogram p65_1, bin(13) fraction fcolor(orange) lcolor(black) )
, title(" ") 
ytitle("Share of Businesses",size(large) height(7))
xtitle("Share of Sales",size(large) height(7))  
legend(off)
graphregion(color(white)) plotregion(fcolor(white));
#delimit cr 
graph export "$dirfigures/FigureA22b.eps", replace
restore 

*66. de las ventas en Bitcoin ¿cuánto conservan en Bitcoin, y cuánto pasan a dólares o efectivo? Dejamos todo en Bitcoin, Pasamos todo a dólares, efectivo, Dejamos % en Bitcoin,% en dólares en Chivo Wallet, y saco % en efectivo  
tab p66_1 if p66_1!=4 
preserve 
collapse (sum) n, by(p66_1)
drop if p66_1==4
egen total = sum(n)
replace n = n/total 
label define code_d 1 "Keep in Bitcoin" 2 "Convert to Dollars" 3 "Convert to Dollars Then Cash", modify
lab val p66_1 code_d
replace n = round(n,.01)
graph pie n, over(p66_1) title("") ///
nocl pie(1, explode color(ebblue)) pie(2, explode color(cranberry)) pie(3, explode color(lavender)) ///
line(lwidth(thick)) legend(row(3)) plabel(1 perc, size(large)) /// 
plabel(2 perc, size(large))  plabel(3 perc, size(large)) ///
graphregion(color(white)) bgcolor(white) legend(order(1 "Bitcoin" 2 "Dollars" 3 "Dollars Then Cash") region(lwidth(none)) rows(1) size(medlarge))  
graph export "$dirfigures/FigureA23c.eps", replace
restore 

*67. ¿aceptan Bitcoin como método de pago en su negocio?  Sí, desde septiembre 2021, Sí, pero no inmediatamente, Aún no  
gen p67_btc = (p67==1 | p67==2)
gen p67_btc_always = (p67==1)
gen p67_btc_later = (p67==2)
gen p67_btc_no = (p67==3 | p67==4)

preserve 
collapse (sum) n, by(p67_btc_always p67_btc_later p67_btc_no)
egen total = sum(n)
gen btc_no1 = p67_btc_no*n/total
gen btc_always2 = p67_btc_always*n/total
gen btc_later3 = p67_btc_later*n/total
collapse (sum) btc_no1 btc_always2 btc_later3  
gen i=1
reshape long btc_no btc_always btc_later, i(i) j(code)
label define code_d 1 "No Bitcoin" 2 "Bitcoin from the start" 3 "Bitcoin later", modify
lab val code code_d
replace i=btc_no if btc_no!=.
replace i=btc_always if btc_always!=.
replace i=btc_later if btc_later!=.
replace i = round(i,.01)
graph pie i, over(code) title("") ///
nocl pie(1, explode color(ebblue)) pie(2, explode color(cranberry)) pie(3, explode color(lavender)) ///
line(lwidth(thick)) legend(row(3)) plabel(1 perc, size(large)) /// 
plabel(2 perc, size(large))  plabel(3 perc, size(large)) ///
graphregion(color(white)) bgcolor(white) legend(order(1 "No Bitcoin" 2 "Bitcoin from the start" 3 "Bitcoin later") region(lwidth(none)) rows(1) size(medlarge))  
graph export "$dirfigures/FigureA23b.eps", replace
restore 

*68. ¿En qué porcentaje han cambiado sus precios en respuesta a la adopción de Bitcoin? Subí mis precios %, Baje mis precios %, Mis precios no cambiaron
replace p68_2=0 if p68_1==3
replace p68_2=-p68_2 if p68_1==2

preserve 
collapse (sum) n, by(p68_1)
drop if p68_1==4
drop if p68_1==.
egen total = sum(n)
replace n = n/total 
label define code_d 1 "Increased" 2 "Decreased" 3 "Same", modify
lab val p68_1 code_d
replace n = round(n,.01)
graph pie n, over(p68_1) title("") ///
nocl pie(1, explode color(ebblue)) pie(2, explode color(lavender)) pie(3, explode color(cranberry)) ///
line(lwidth(thick)) legend(row(3)) plabel(1 perc, size(large)) /// 
plabel(2 perc, size(large))  plabel(3 perc, size(large)) ///
graphregion(color(white)) bgcolor(white) legend(order(1 "Increased" 2 "Decreased" 3 "Same") region(lwidth(none)) rows(1) size(medlarge))  
graph export "$dirfigures/FigureA23d.eps", replace
restore 

*69.  Sus ventas totales han subido en %,  han bajado en %, se han mantenido igual
replace p69_1=0 if p69_1==3
replace p69_2=-p69_2 if p69_1==2

*70. Sus ventas pagadas con efectivo han subido en %, han bajado en %, se han mantenido igual
replace p70_1=0 if p70_1==3
replace p70_2=-p70_2 if p70_1==2

*71.  Sus ventas pagadas con tarjeta de crédito o débito han subido en %, han bajado en %, se han mantenido igual
replace p71_1=0 if p71_1==3
replace p71_2=-p71_2 if p71_1==2

** does not accept bitcoin yet
*72. Las ventas totales han subido en %, han bajado en % han mantenido igual
replace p72_1=0 if p72_1==3
replace p72_2=-p72_2 if p72_1==2

*73.  Las ventas pagadas con efectivo han subido en %, han bajado en %, se han mantenido igual
replace p73_1=0 if p73_1==3
replace p73_2=-p73_2 if p73_1==2

*74.   Las ventas pagadas con tarjeta de crédito o débito han subido en%, han bajado en %, mantenido igual
replace p74_1=0 if p74_1==3
replace p74_2=-p74_2 if p74_1==2

clear
set obs 4
gen i=.
gen code=.
*Firms accepting bitcoin
replace i = 21.75  in 1 /* tab p64_btc -  21.75  */
replace code = 1 in 1
*Firms with sales in bitcoin
replace i = 11.42 in 2 /* tab p64_btc_nozero - 11.42  */
replace code = 2 in 2
*Total sales in bitcoin
replace i = 4.948718 in 3 /* su p65_1, d - 4.948718 */ 
replace code = 3 in 3
*Total sales kept in bitcoin
replace i = (.04948718 * .1206897)*100  in 4 /* tab p66_1 if p66_1!=4 - .1206897 */ 
replace code = 4 in 4

label define code_d 1 "Firms accepting bitcoin" 2 "Firms with sales in bitcoin" 3 "Total sales in bitcoin" 4 "Total sales kept in bitcoin", modify
lab values code code_d

graph hbar  i, over(code, sort(1) descending  )   bar(1, color(midblue))  ///
ytitle("Percent") title("")  graphregion(color(white)) plotregion(fcolor(white) )    
graph export "$dirfigures/Figure2b.eps", replace
 
use "Survey_cleaned_long.dta", clear

gen p14_yes = (p14==1 | p14==2)
label variable p14_yes "Download Chivo"
replace p28 = . if p28<30 & p14_yes==0 
egen p28_p31 = rowtotal(p28 p31)
replace p28_p31=. if p28==. & p31==. 
gen weight = 3 if p14_yes==0
replace weight = 1 if p14_yes==1 

gen p34_entry = (p34_2==1 | p34_3==1 | p34_4==1 | p34_5==1 | p34_6==1 | p34_7==1 | p34_8==1 | p34_9==1 | p34_10==1 | p34_11==1 | p34_12==1)
 
gen know_chivo1 = (p12==1)
gen trydownload_chivo2 = (p14==1 | p14==2)
gen notroubles_entering3 = trydownload_chivo*p34_entry
gen keepusing_chivo_afterbono4 = (p36==1)
gen received_remittances5 = (p50==1 | p50==2)
gen paidtaxes_remittances6 = (p54==1)

gcollapse (sum) know_chivo trydownload_chivo notroubles_entering3 keepusing_chivo_afterbono4 received_remittances5 paidtaxes_remittances6 n (mean) income_lastyear income phone_w_internet unbanked, by(dpt)
  
replace know_chivo=know_chivo/n
replace trydownload_chivo=trydownload_chivo/n
replace notroubles_entering=notroubles_entering/n
replace keepusing_chivo_afterbono=keepusing_chivo_afterbono/n
replace received_remittances=received_remittances/n
replace paidtaxes_remittances=paidtaxes_remittances/n


*CAF Income 418 USD in 2020
*CAF Unbanked 100-13.7 = 86.3
*Panama Income 12172 
*Panama Unbanked 53.5
gen  income_lastyear_int=int(income_lastyear)

* El Salvador  .68 
su  know_chivo [w=n]
reg  know_chivo income_lastyear_int [w=n]
*di  .3280285  + 418 *.0001013 = .3703719
*di  .3280285  + 12172 *.0001013 = 1.5610521

		#delimit
		twoway 
		(scatter know_chivo income_lastyear_int [w=n], msymbol(Oh) mcolor(ebblue))
		(scatter know_chivo income_lastyear_int [w=n], msymbol(i) mlabel(dpt) mlabcolor(navy) )
		(lfit know_chivo income_lastyear_int [w=n], lcolor(cranberry) lwidth(thick))
		, ytitle("Know about Chivo (share of pop.)", height(5)) title(" ") 
		xtitle("Average Income ") xlabel(2000[1000]5000) ylabel(.4[.1].8)
		legend(off) graphregion(color(white)) plotregion(fcolor(white));
		#delimit cr	
		graph export "$dirfigures/Figure18a.eps", replace
		
		
		#delimit
		twoway 
		(scatter trydownload_chivo income_lastyear_int [w=n], msymbol(Oh) mcolor(ebblue))
		(scatter trydownload_chivo income_lastyear_int [w=n], msymbol(i) mlabel(dpt) mlabcolor(navy) )
		(lfit trydownload_chivo income_lastyear_int [w=n], lcolor(cranberry) lwidth(thick))
		, ytitle("Try downloading Chivo (share of pop.)", height(5)) title(" ") 
		xtitle("Average income ") xlabel(2000[1000]5000) ylabel(.3[.1].7)
		legend(off) graphregion(color(white)) plotregion(fcolor(white));
		#delimit cr	
		graph export "$dirfigures/Figure18b.eps", replace

* ESA   .2061111
su  keepusing_chivo_afterbono [w=n]
reg  keepusing_chivo_afterbono income_lastyear_int [w=n]
*di  .0616314   + 418 *.0000416  = .0790202
*di  .0616314   + 12172 *.0000416  = .5679866
		
		#delimit
		twoway 
		(scatter keepusing_chivo_afterbono income_lastyear_int [w=n], msymbol(Oh) mcolor(ebblue))
		(scatter keepusing_chivo_afterbono income_lastyear_int [w=n], msymbol(i) mlabel(dpt) mlabcolor(navy) )
		(lfit keepusing_chivo_afterbono income_lastyear_int  [w=n], lcolor(cranberry) lwidth(thick))
		, ytitle("Keep using Chivo after bonus (share of pop.)", height(5)) title(" ") 
		xtitle("Average income ") xlabel(2000[1000]5000) ylabel(0.1[.1].3)
		legend(off) graphregion(color(white)) plotregion(fcolor(white));
		#delimit cr	
		graph export "$dirfigures/Figure18c.eps", replace
		
* ESA .0588889
su  received_remittances [w=n]
reg  received_remittances income_lastyear_int [w=n]
*di   -.0378191  + 418 *.0000278    = -.0261987
*di    -.0378191  + 12172 *.0000278   = .3005625
		
		#delimit
		twoway 
		(scatter received_remittances income_lastyear_int [w=n], msymbol(Oh) mcolor(ebblue))
		(scatter received_remittances income_lastyear_int [w=n], msymbol(i) mlabel(dpt) mlabcolor(navy) )
		(lfit received_remittances income_lastyear_int  [w=n], lcolor(cranberry) lwidth(thick))
		, ytitle("Received remittances via Chivo (share of pop.)", height(5)) title(" ") 
		xtitle("Average income ") xlabel(2000[1000]5000) ylabel(0[.02].1)
		legend(off) graphregion(color(white)) plotregion(fcolor(white));
		#delimit cr		
		graph export "$dirfigures/Figure18d.eps", replace


**CAF Unbanked  86.3
*Panama Unbanked 53.5
reg  know_chivo unbanked [w=n]
*di  1.745752 -1.489405*.86 = .4648637
*di  1.745752 -1.489405 *.53 = .95636735

		#delimit
		twoway 
		(scatter know_chivo unbanked [w=n], msymbol(Oh) mcolor(ebblue))
		(scatter know_chivo unbanked [w=n], msymbol(i) mlabel(dpt) mlabcolor(navy) )
		(lfit know_chivo unbanked  [w=n], lcolor(cranberry) lwidth(thick))
		, ytitle("Know about Chivo (share of pop.)", height(5)) title(" ") 
		xtitle("Unbanked") xlabel(.6[.1].9) 
		ylabel(.4[.1].8)
		legend(off) graphregion(color(white)) plotregion(fcolor(white));
		#delimit cr	
		graph export "$dirfigures/Figure19a.eps", replace		
		
		
 	set obs 16
	gen dpt_add=.
	replace dpt_add = 15 in 15 /* CAF */ 
	replace dpt_add = 16 in 16 /* Panama */ 

	label define dpt_d 15 "CAF" 16 "Panama",  replace 
	lab val dpt_add dpt_d

	replace n = 1 in 15
	replace n = 1 in 16
	replace unbanked = .86 in 15	
	replace unbanked = .53 in 16
	
	replace trydownload_chivo = 1.366213    -1.161633  *.86 in 15	
	replace trydownload_chivo =  1.366213    -1.161633  *.53 in 16
 	
		 #delimit
		twoway 
		(scatter trydownload_chivo unbanked [w=n] if dpt!=., msymbol(Oh) mcolor(ebblue))
		(scatter trydownload_chivo unbanked [w=n] if dpt!=., msymbol(i) mlabel(dpt) mlabcolor(navy) )
		(lfit trydownload_chivo unbanked  [w=n], lcolor(cranberry) lwidth(thick))
		(scatter trydownload_chivo unbanked  if dpt_add!=., mcolor(black) msize(large) mlabel(dpt_add) mlabcolor(black) mlabsize(p10))
		, ytitle("Try downloading Chivo (share of pop.)", height(5)) title(" ") 
		xtitle("Unbanked") xlabel(.5[.1].9) 
		ylabel(.3[.1].8)
		legend(off) graphregion(color(white)) plotregion(fcolor(white));
		#delimit cr	
		graph export "$dirfigures/Figure1b.eps", replace
		
		
		#delimit
		twoway 
		(scatter trydownload_chivo unbanked [w=n] if dpt!=., msymbol(Oh) mcolor(ebblue))
		(scatter trydownload_chivo unbanked [w=n] if dpt!=., msymbol(i) mlabel(dpt) mlabcolor(navy) )
		(lfit trydownload_chivo unbanked  [w=n] if dpt!=., lcolor(cranberry) lwidth(thick))
		, ytitle("Try downloading Chivo (share of pop.)", height(5)) title(" ") 
		xtitle("Unbanked") xlabel(.6[.1].9) 
		ylabel(.3[.1].7)
		legend(off) graphregion(color(white)) plotregion(fcolor(white));
		#delimit cr	
		graph export "$dirfigures/FigureA19b.eps", replace


*ESA .2061111 
su  keepusing_chivo_afterbono [w=n]
reg  keepusing_chivo_afterbono unbanked [w=n]
*di  .5299006   -.4525008 *.86 = .14074991
*di  .5299006   -.4525008  *.53 = .29007518
	
	replace keepusing_chivo_afterbono = .5299006   -.4525008  *.86 in 15	
	replace keepusing_chivo_afterbono = .5299006   -.4525008  *.53 in 16
		
		#delimit
		twoway 
		(scatter keepusing_chivo_afterbono unbanked [w=n] if dpt!=., msymbol(Oh) mcolor(ebblue))
		(scatter keepusing_chivo_afterbono unbanked [w=n] if dpt!=., msymbol(i) mlabel(dpt) mlabcolor(navy) )
		(lfit keepusing_chivo_afterbono unbanked  [w=n] if dpt!=., lcolor(cranberry) lwidth(thick))
		, ytitle("Keep using Chivo after bonus (share of pop.)", height(5)) title(" ") 
		xtitle("Unbanked") xlabel(.6[.1].9) 
		ylabel(0.1[.1].3)
		legend(off) graphregion(color(white)) plotregion(fcolor(white));
		#delimit cr	
		graph export "$dirfigures/FigureA19c.eps", replace

*ESA .0588889 
su  received_remittances [w=n]
reg  received_remittances unbanked [w=n]
*di .2394285    -.2523069 *.86 = .02244457
*di .2394285   -.2523069*.53 = .10570584
		
		#delimit
		twoway 
		(scatter received_remittances unbanked [w=n] if dpt!=., msymbol(Oh) mcolor(ebblue))
		(scatter received_remittances unbanked [w=n] if dpt!=., msymbol(i) mlabel(dpt) mlabcolor(navy) )
		(lfit received_remittances unbanked  [w=n] if dpt!=., lcolor(cranberry) lwidth(thick))
		, ytitle("Received remittances via Chivo (share of pop.)", height(5)) title(" ") 
		xtitle("Unbanked") xlabel(.6[.1].9) 
		ylabel(0[.02].1)
		legend(off) graphregion(color(white)) plotregion(fcolor(white));
		#delimit cr		
		graph export "$dirfigures/FigureA19d.eps", replace
		
	

erase "$dirin/Survey.dta"
erase "$dirin/Survey_cleaned_long.dta"
erase "$dirin/Survey_cleaned_Table2.dta"
erase "$dirin/Survey_cleaned_short.dta"
	
	
