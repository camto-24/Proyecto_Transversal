clear all
set more off

* movernos al proyecto * poner dirección 
cd "C:\Users\smelo\OneDrive - Universidad de los Andes\Escritorio\MECA 2026-1\proyecto transversal" 

global data "data/raw"
global figures "output/figures"

*================================================
* FIGURE A24
*================================================


use "$data/crystal.dta", clear

gen measurement_error = (sum_in_btc > total_sent | total_tx_fee_btc > total_sent)
drop if measurement_error==1

drop contr_entity entity_country id

rename sum_in_btc btc
rename sum_in_usd usd
rename total_tx_fee_btc fee_btc
rename total_tx_fee_usd fee_usd

gen transactions=1

replace direction="_withdrawal" if direction=="withdrawal"
replace direction="_deposit" if direction=="deposit"
replace direction="_internal" if direction=="internal_transfer"

gcollapse (sum) transactions btc usd fee_btc fee_usd total_sent ///
(mean) mean_fee_usd=fee_usd mean_fee_btc=fee_btc, by(direction all_dates) fast

reshape wide transactions btc usd fee_btc fee_usd total_sent ///
mean_fee_usd mean_fee_btc, i(all_dates) j(direction) string

foreach var in transactions_deposit btc_deposit usd_deposit ///
transactions_internal btc_internal usd_internal ///
transactions_withdrawal btc_withdrawal usd_withdrawal {

    replace `var' = 0 if `var'==.
}

tsset all_dates

replace usd_deposit = usd_deposit/1000
replace usd_internal = usd_internal/1000
replace usd_withdrawal = usd_withdrawal/1000

gen avg_usd_deposit = usd_deposit/transactions_deposit
gen avg_usd_internal = usd_internal/transactions_internal
gen avg_usd_withdrawal = usd_withdrawal/transactions_withdrawal


#delimit ;
twoway
(line avg_usd_withdrawal all_dates, lwidth(thick) lcolor(cranberry))
(line avg_usd_internal all_dates, lwidth(thick) lcolor(purple))
(line avg_usd_deposit all_dates, lwidth(thick) lcolor(ebblue)),
title("Chivo's Blockchain Transaction Size by Type")
ytitle("Average Size USD (Thousands)", height(5))
xtitle(" ")
tlabel(05sep2021 05dec2021 05mar2022 05jun2022 05sep2022, format(%d))
legend(order(1 "Withdrawals" 2 "Internal" 3 "Deposits")
region(lwidth(none)) rows(1) size(medlarge) position(6))
graphregion(color(white))
plotregion(fcolor(white))
graphregion(margin(l+0 r+5));
#delimit cr

graph export "$figures/FigureS24_replication.png", replace


*================================================
* FIGURE E1b
*================================================

import delimited "$data/BTC-USD_yahoofinance_2023.csv", clear

split date, p("-")
drop date
destring date*, replace

gen all_dates = mdy(date2,date3,date1)
format all_dates %td
drop date*

gen week = wofd(all_dates)
format week %tw

collapse (sum) open close volume, by(week)

save "Volumes_2021_2023.dta", replace


use "$data/crystal.dta", clear

gen transactions=1
drop if direction=="internal_transfer"

gen week = wofd(all_dates)
format week %tw

collapse (sum) transactions sum_in_btc sum_in_usd ///
total_tx_fee_btc total_tx_fee_usd total_sent, by(week) fast

merge 1:1 week using "Volumes_2021_2023.dta", keep(match) nogenerate

tsset week

gen dlog_sum_in_btc = ln(sum_in_btc) - ln(l.sum_in_btc)
gen dlog_price = ln(close) - ln(l.close)


#delimit ;
twoway
(scatter dlog_sum_in_btc l.dlog_price, msize(vlarge) msymbol(Oh) mcolor(ebblue))
(lfit dlog_sum_in_btc l.dlog_price, lcolor(cranberry) lwidth(thick)),
title("Bitcoin Price Changes and Chivo Transaction Volume")
ytitle("% Change Volume Chivo (Coinbase)", height(5))
xtitle("% Change Volume Bitcoin Market (Coinbase)")
yscale(range(-4 4))
ylabel(-4(2)4)
xscale(range(-0.3 .2))
xlabel(-0.3(0.1).2)
legend(off)
graphregion(color(white))
plotregion(fcolor(white));
#delimit cr

graph export "$figures/FigureE1b_replication.png", replace
