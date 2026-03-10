clear all
set more off
local owndir = ""
global dirin = "`owndir'/Data"
global dirfigures = "`owndir'/Figures"
global dirtables = "`owndir'/Tables"



** FIGURE A1
clear all
cd "$dirin"
* SOURCE: Google Trends 
import delimited "GoogleTrends_Bitcoin.csv", delimiter(comma) varnames(2) clear 
rename bitcoinelsalvador searches
replace searches = subinstr(searches, "<", "",.) 
split week, p("-")
rename week1 year
rename week2 month
rename week3 day
drop week 
destring *, replace 
gen all_dates=mdy(month, day, year)
format %d all_dates
drop if all_dates>=22738
drop if all_dates<22283
*June 2: law
*September 5: Chivo
#delimit
twoway 
(line searches all_dates, lwidth(thick) lcolor(ebblue))  
, ytitle("Google Searches - Bitcoin", height(5)) 
 xtitle(" ") ylabel(0[25]100) title(" ") xline(22528, lwidth(thick)   lcolor(cranberry) lpattern(dash))
 xline(22437, lwidth(thick)   lcolor(black) lpattern(dash))
legend(off) graphregion(color(white)) plotregion(fcolor(white)) 
graphregion(margin(l+0 r+5));
#delimit cr
graph export "$dirfigures/FigureA1a.eps", replace


import delimited "GoogleTrends_Chivo.csv", delimiter(comma) varnames(2) clear 
rename chivowalletelsalvador searches
replace searches = subinstr(searches, "<", "",.) 
split week, p("-")
rename week1 year
rename week2 month
rename week3 day
drop week 
destring *, replace 
gen all_dates=mdy(month, day, year)
format %d all_dates
drop if all_dates>=22738
drop if all_dates<22283
#delimit
twoway 
(line searches all_dates, lwidth(thick) lcolor(ebblue))  
, ytitle("Google Searches - Chivo", height(5)) 
 xtitle(" ") ylabel(0[25]100) title(" ") xline(22528, lwidth(thick)   lcolor(cranberry) lpattern(dash))
 xline(22437, lwidth(thick)   lcolor(black) lpattern(dash))
legend(off) graphregion(color(white)) plotregion(fcolor(white)) 
graphregion(margin(l+0 r+5));
#delimit cr
graph export "$dirfigures/FigureA1b.eps", replace



** FIGURE A2
clear all
cd "$dirin"
* SOURCE: Banco Central de Reserva de El Salvador - File Remesas_oficiales.xls 
set obs 1
generate str var1 = "September" in 1
set obs 2
replace var1 = "October" in 2
set obs 3
replace var1 = "November" in 3
set obs 4
replace var1 = "December" in 4
set obs 5
replace var1 = "January" in 5
set obs 6
replace var1 = "February" in 6
set obs 7
replace var1 = "March" in 7
set obs 8
replace var1 = "April" in 8
set obs 9
replace var1 = "May" in 9
set obs 10
replace var1 = "June" in 10
set obs 11
replace var1 = "July" in 11
set obs 12
replace var1 = "Ago" in 12
set obs 13
replace var1 = "Sep" in 13

generate var2 = 595.63 in 1
replace var2 = 657.11 in 2
replace var2 = 625.17 in 3
replace var2 = 750.09 in 4
replace var2 = 552.74 in 5
replace var2 = 572.64 in 6
replace var2 = 676.88 in 7
replace var2 = 641.83 in 8
replace var2 = 701.78 in 9
replace var2 = 632.8 in 10
replace var2 = 636.99 in 11
replace var2 = 649.96 in 12
replace var2 = 623.69 in 13

generate var3 = 2.64 in 1
replace var3 = 29.68 in 2
replace var3 = 12.27 in 3
replace var3 = 12.37 in 4
replace var3 = 10.06 in 5
replace var3 = 9.39 in 6
replace var3 = 9.83 in 7
replace var3 = 10.14 in 8
replace var3 = 12.56 in 9
replace var3 = 11.52 in 10
replace var3 = 10.37 in 11
replace var3 = 10.92 in 12
replace var3 = 10.78 in 13

generate var4 = 2021 in 1
replace var4 = 2021 in 2
replace var4 = 2021 in 3
replace var4 = 2021 in 4
replace var4 = 2022 in 5
replace var4 = 2022 in 6
replace var4 = 2022 in 7
replace var4 = 2022 in 8
replace var4 = 2022 in 9
replace var4 = 2022 in 10
replace var4 = 2022 in 11
replace var4 = 2022 in 12
replace var4 = 2022 in 13

generate var6 = 9 in 1
replace var6 = 10 in 2
replace var6 = 11 in 3
replace var6 = 12 in 4
replace var6 = 1 in 5
replace var6 = 2 in 6
replace var6 = 3 in 7
replace var6 = 4 in 8
replace var6 = 5 in 9
replace var6 = 6 in 10
replace var6 = 7 in 11
replace var6 = 8 in 12
replace var6 = 9 in 13

rename var2 total
rename var3 bitcoin
rename var1 monthw
rename var4 year
rename var6 month2
gen share = bitcoin/total

gen all_dates=ym(year,month2)
format %tm all_dates

#delimit
twoway 
(line share all_dates, lwidth(thick) lcolor(cranberry))  
, ytitle("Share of Remmittances in Bitcoin (Official)", height(5)) 
 xtitle(" ") ylabel(0[.02].06) title(" ")
 tlabel(2021m9 2021m11 2022m1 2022m3 2022m5 2022m7 2022m9, format(%tm))   ///
legend(off) graphregion(color(white)) plotregion(fcolor(white)) 
graphregion(margin(l+0 r+5));
#delimit cr
graph export "$dirfigures/FigureA2.eps", replace


** FIGURE A3
clear all
cd "$dirin"
*SOURCE: https://finance.yahoo.com/quote/BTC-USD/history/
import delimited "BTC-USD_yahoofinance.csv", delimiter(comma) varnames(1) clear 
replace open=open/1000 /* normalization */ 
replace volume=volume/1000000000 /* normalization */ 
split date, p("-")
rename date1 year
rename date2 month
rename date3 day
drop date 
destring *, replace 
gen all_dates=mdy(month, day, year)
format %d all_dates

#delimit
twoway 
(line open all_dates if all_dates>=22371, lwidth(thick) lcolor(ebblue))  
, ytitle("Currency in USD (thousands)", height(5)) 
 xtitle(" ") ylabel(20[10]70) title(" ") 
 xline(22528, lwidth(thick)   lcolor(cranberry) lpattern(dash))
 xline(22433, lwidth(thick)   lcolor(black) lpattern(dash))
legend(off) graphregion(color(white)) plotregion(fcolor(white)) 
graphregion(margin(l+0 r+5));
#delimit cr
graph export "$dirfigures/FigureA3a.eps", replace


#delimit
twoway 
(line volume all_dates if all_dates>=22371, lwidth(thick) lcolor(ebblue))  
, ytitle("Volume (billions)", height(5)) 
 xtitle(" ") ylabel(0[50]100) title(" ") 
 xline(22528, lwidth(thick)   lcolor(cranberry) lpattern(dash))
 xline(22433, lwidth(thick)   lcolor(black) lpattern(dash))
legend(off) graphregion(color(white)) plotregion(fcolor(white)) 
graphregion(margin(l+0 r+5));
#delimit cr
graph export "$dirfigures/FigureA3b.eps", replace


** FIGURE A6
clear all
cd "$dirin/shape_files"
shp2dta using slv_admbnda_adm2_gadm_20210204, database("slv_admbnda_adm2_gadm_20210204_db") coordinates("slv_admbnda_adm2_gadm_20210204_cor") genid(id) replace

*Source: https://chivowallet.com.

cd "$dirin"
use "object_id.dta", clear
merge 1:1 id using "$dirin/shape_files/slv_admbnda_adm2_gadm_20210204_db.dta"
replace atm=0 if atm==.
replace pop = pop/1000
replace  atm_per100k=0 if atm_per100k==.
gen atm_perarea = atm/Shape_Area
  
spmap atm using "$dirin/shape_files/slv_admbnda_adm2_gadm_20210204_cor.dta" if atm!=. , ///
id(id) fcolor(Blues) title("") legstyle(2) ///
  plotregion(icolor(white)) graphregion(icolor(white)) ///
   clmethod(custom) clbreaks (0 1 2 5 10 30)  ///
legend(label(2 "No ATM") label(3 "1 to 2") label(4 "2 to 5" )  label(5 "5 to 10" ) /// 
label(6 "10 to 30" ) pos(7) row(5) size(Large) region(lcolor(white)))
graph export "$dirfigures/FigureA6.eps", replace 
 
erase "$dirin/shape_files/slv_admbnda_adm2_gadm_20210204_db.dta"
erase "$dirin/shape_files/slv_admbnda_adm2_gadm_20210204_cor.dta"

** FIGURE A9 
clear all
cd "$dirin"
* SOURCE: World Bank Open Data
clear all 
import delimited "Cell.csv", delimiter(comma) varnames(4) encoding(UTF-8) clear 
keep if countrycode=="SLV"
drop  countrycode indicatorname indicatorcode

forvalues i = 1960/2019 { 
	local n = `i'-1955
rename v`n' Cell`i' 
}

reshape long Cell, i(countryname) j(year)
capture drop v*

#delimit
twoway 
(line Cell year if year>=1996, lwidth(thick) lcolor(ebblue))  
, ytitle("Mobile Cellular Subscriptions (per 100 people)", height(5)) 
 xtitle(" ") ylabel(0[40]160) title(" ") 
legend(off) graphregion(color(white)) plotregion(fcolor(white)) 
graphregion(margin(l+0 r+5));
#delimit cr
graph export "$dirfigures/FigureA9a.eps", replace



import delimited "Branches.csv", varnames(4) encoding(UTF-8) clear 
keep if countrycode=="SLV"
drop  countrycode indicatorname indicatorcode

forvalues i = 1960/2020 { 
	local n = `i'-1955
rename v`n' Branches`i' 
}

reshape long Branches, i(countryname) j(year)
capture drop v*

#delimit
twoway 
(line Branches year if year>=2009, lwidth(thick) lcolor(ebblue))  
, ytitle("Bank Branches (per 100,000 adults)", height(5)) 
 xtitle(" ") ylabel(0[5]20) title(" ") 
legend(off) graphregion(color(white)) plotregion(fcolor(white)) 
graphregion(margin(l+0 r+5));
#delimit cr
graph export "$dirfigures/FigureA9d.eps", replace


import delimited "ATM.csv", varnames(4) encoding(UTF-8) clear 
keep if countrycode=="SLV"
drop  countrycode indicatorname indicatorcode

forvalues i = 1960/2020 { 
	local n = `i'-1955
rename v`n' ATM`i' 
}

reshape long ATM, i(countryname) j(year)
capture drop v*

#delimit
twoway 
(line ATM year if year>=2004, lwidth(thick) lcolor(ebblue))  
, ytitle("ATMs (per 100,000 adults)", height(5)) 
 xtitle(" ") ylabel(0[10]40) title(" ") 
legend(off) graphregion(color(white)) plotregion(fcolor(white)) 
graphregion(margin(l+0 r+5));
#delimit cr
graph export "$dirfigures/FigureA9c.eps", replace


import delimited "Remittances.csv", delimiter(comma) varnames(1) encoding(UTF-8) clear 
keep if worlddevelopmentindicators=="SLV"
drop worlddevelopmentindicators v3 v4

forvalues i = 1960/2019 { 
	local n = `i'-1955
rename v`n' remittances_gdp`i' 
}

reshape long remittances_gdp, i(datasource) j(year)
capture drop v*

#delimit
twoway 
(line remittances_gdp year if year>=1996, lwidth(thick) lcolor(ebblue))  
, ytitle("Personal Remittances (% GDP)", height(5)) 
 xtitle(" ") ylabel(10[5]25) title(" ") 
legend(off) graphregion(color(white)) plotregion(fcolor(white)) 
graphregion(margin(l+0 r+5));
#delimit cr
graph export "$dirfigures/FigureA9b.eps", replace




** FIGURE A10 and A15
clear all
cd "$dirin"
** SOURCE: Multipurpose Survey on Households (EHPM) - DIGESTYC
** DATA AVAILABLE AT: https://onec.bcr.gob.sv/encuesta-de-hogares-de-propositos-multiples-ehpm/
import spss using "EHPM 2020.sav", clear
save EHPM_2020.dta, replace

use EHPM_2020.dta, clear
rename edicion year
rename r101 person 
rename idboleta  id_hh  
rename fac00 pf
rename r106  age
rename r021a members
rename r027 internet_users
rename ingfa income
replace income=income*12
rename ingpe income_pcp
replace income_pcp=income_pcp*12
rename r3211a hh_phone
replace hh_phone=0 if hh_phone==2
rename r3211b num_hh_phones
rename r3212a hh_cell
replace hh_cell=0 if hh_cell==2
rename r3212b num_hh_cells
rename r3213a hh_internet
replace hh_internet=0 if hh_internet==2
rename r3213a1 hh_internet_mobile
replace hh_internet_mobile=0 if hh_internet_mobile==2
rename r3214a hh_cable 
replace hh_cable=0 if hh_cable==2
rename r32303a hh_tv
replace hh_tv=0 if hh_tv==2
rename r32303b num_hh_tv
rename r32309a hh_pc
replace hh_pc=0 if hh_pc==2
rename r32309b  num_hh_pc
rename r44815 gasoline
replace gasoline=0 if gasoline==2
rename r44825 exp_gasoline
rename r32312a hh_cars
replace hh_cars=0 if hh_cars==2
rename r32312b num_hh_cars
gen labor_mkt_activ = (actpr2012==10)
rename irefa income_remittance
replace income_remittance=income_remittance*12
gen hh_remittance = (income_remittance>0)
rename r01a hh_foreign 
rename r01b num_hh_foreign 
gen read = (r202a==1 | r202a==3)
rename r214 education
	
*r020 - Confiabilidad de la información
/*
Confiabilidad de la |
               información |      Freq.     Percent        Cum.
---------------------------+-----------------------------------
     Información confiable |     36,521       98.63       98.63
Informacion poco confiable |        293        0.79       99.42
  Información no confiable |        216        0.58      100.00
---------------------------+-----------------------------------
                     Total |     37,030      100.00
*/
gen trust = (r020==1)
keep if trust==1												
	
rename r103 relationship
gen hh = 1

keep year person id_hh income hh_phone hh_cell hh_internet hh_internet_mobile gasoline hh_cars num_hh_cells  num_hh_phones members internet_users exp_gasoline num_hh_cars hh pf income_pcp age labor_mkt_activ income_remittance hh_remittance hh_foreign num_hh_foreign read education hh_cable hh_tv num_hh_tv hh_pc num_hh_pc trust relationship
keep if age>=18  
gen persons = 1
save demographics.dta, replace 
 
use demographics.dta, clear 

gcollapse (mean) income_pcp income hh_phone hh_cell hh_internet hh_internet_mobile gasoline hh_cars num_hh_cells num_hh_phones members internet_users exp_gasoline num_hh_cars hh labor_mkt_activ income_remittance hh_remittance hh_foreign num_hh_foreign read hh_cable hh_tv num_hh_tv hh_pc num_hh_pc pf (sum) persons, by(id_hh year) fast
 
gen share_remittance = income_remittance/income
gen share_remittance_cond = income_remittance/income if hh_remittance==1

xtile pct=income [aw=pf], nq(5)
gcollapse (mean) hh_* gasoline labor_mkt_activ share_remittance* read  [pw=pf], by(pct) fast
drop if pct==.

graph bar hh_cell, over(pct)  ///
bar(1, color(ebblue) lcolor(black)) ///
legend(label(1 "Share of households" )) ytitle("Share of households", height(5)) ///
title(" ") ///
graphregion(color(white)) bgcolor(white) 
graph export "$dirfigures/FigureA10a.eps", replace 

graph bar hh_internet, over(pct)  ///
bar(1, color(ebblue) lcolor(black)) ///
legend(label(1 "Share of households" )) ytitle("Share of households", height(5)) ///
title(" ") ///
graphregion(color(white)) bgcolor(white) 
graph export "$dirfigures/FigureA10c.eps", replace 

graph bar hh_phone, over(pct)  ///
bar(1, color(ebblue) lcolor(black)) ///
legend(label(1 "Share of households" )) ytitle("Share of households", height(5)) ///
title(" ") ///
graphregion(color(white)) bgcolor(white) 
graph export "$dirfigures/FigureA10d.eps", replace 

graph bar hh_cars, over(pct)  ///
bar(1, color(ebblue) lcolor(black)) ///
legend(label(1 "Share of households" )) ytitle("Share of households", height(5)) ///
title(" ") ///
graphregion(color(white)) bgcolor(white) 
graph export "$dirfigures/FigureA10e.eps", replace 

graph bar gasoline, over(pct)  ///
bar(1, color(ebblue) lcolor(black)) ///
legend(label(1 "Share of households" )) ytitle("Share of households", height(5)) ///
title(" ") ///
graphregion(color(white)) bgcolor(white) 
graph export "$dirfigures/FigureA10f.eps", replace 

graph bar hh_remittance, over(pct)  ///
bar(1, color(ebblue) lcolor(black)) ///
legend(label(1 "Share of households" )) ytitle("Share of households", height(5)) ///
title(" ") ///
graphregion(color(white)) bgcolor(white) 
graph export "$dirfigures/FigureA15a.eps", replace 

graph bar share_remittance_cond , over(pct)  ///
bar(1, color(ebblue) lcolor(black)) ///
legend(label(1 "Share of households" )) ytitle("Share of households", height(5)) ///
title(" ") ///
graphregion(color(white)) bgcolor(white) 
graph export "$dirfigures/FigureA15b.eps", replace 


use demographics.dta, clear 
su education, d
keep if relationship==1 
su education, d

gcollapse (mean) education pf income (sum) persons, by(id_hh year) fast
 
gen education_yrs=.
replace education_yrs = 0 if education==1 | education>=6  /* Parvularia, Especial, Ninguno */
replace education_yrs = 6 if education==2 /* Básica */
replace education_yrs = 10 if education==3 |  education==5 /* Media  o no universitario */
replace education_yrs = 15 if education==4 /* Universitario */
gen hh_education_superior =(education==4 | education==5) /* Superior */ 

xtile pct=income [aw=pf], nq(5)

gcollapse (mean) education_yrs  hh_education_superior [pw=pf], by(pct) fast
drop if pct==.

graph bar education_yrs, over(pct)  ///
bar(1, color(ebblue) lcolor(black)) ///
legend(label(1 "Share of households" )) ytitle("Share of households", height(5)) ///
title(" ") ///
graphregion(color(white)) bgcolor(white) 
graph export "$dirfigures/FigureA10b.eps", replace 

erase EHPM_2020.dta
erase demographics.dta 

** Table B1 
clear all
cd "$dirin"
import delimited "ESA_GFI_2017.csv", varnames(1) encoding(UTF-8) 
drop if v2==. 
export delimited using "$dirtables/TableB1.csv", replace
