clear all
set more off
local owndir = "" 
global dirin = "`owndir'/Data"
global dirfigures = "`owndir'/Figures"
global dirtables = "`owndir'/Tables"
cd "$dirin"

use "$dirin/crystal.dta", clear  
gen measurement_error = (sum_in_btc >total_sent | total_tx_fee_btc>total_sent)  
drop if measurement_error==1 /* Measurement error -  transactions .09% - does not affect our results */ 
drop contr_entity entity_country id
rename sum_in_btc btc
rename sum_in_usd usd
rename total_tx_fee_btc fee_btc
rename total_tx_fee_usd fee_usd
gen transactions=1
replace direction="_withdrawal" if direction=="withdrawal"
replace direction="_deposit" if direction=="deposit"
replace direction="_internal" if direction=="internal_transfer" 

gcollapse (sum) transactions btc usd fee_btc fee_usd total_sent (mean) mean_fee_usd=fee_usd mean_fee_btc=fee_btc, by(direction all_dates) fast 

reshape wide transactions btc usd fee_btc fee_usd total_sent mean_fee_usd mean_fee_btc, i(all_dates) j(direction) string  

foreach var in transactions_deposit btc_deposit usd_deposit fee_btc_deposit fee_usd_deposit total_sent_deposit transactions_internal btc_internal usd_internal fee_btc_internal fee_usd_internal total_sent_internal transactions_withdrawal btc_withdrawal usd_withdrawal fee_btc_withdrawal fee_usd_withdrawal total_sent_withdrawal {
	replace `var' = 0 if `var'==.
}

tsset all_dates
replace usd_deposit = usd_deposit/1000 /* Report graphs in thousands of dollars */
replace usd_internal = usd_internal/1000 
replace usd_withdrawal = usd_withdrawal/1000 

gen usd_deposit_cum = sum(usd_deposit)
gen usd_withdrawal_cum = sum(usd_withdrawal)
gen usd_net = usd_deposit_cum - usd_withdrawal_cum

tssmooth ma usd_deposit_ma= usd_deposit,window(3 1 3) 
tssmooth ma usd_withdrawal_ma = usd_withdrawal,window(3 1 3) 
tssmooth ma usd_net_ma = usd_net,window(3 1 3) 

gen usd_total = usd_deposit + usd_internal + usd_withdrawal
gen pct_fee_deposit = (fee_btc_deposit)/(btc_deposit ) 
gen pct_fee_withdrawal = (fee_btc_withdrawal)/(btc_withdrawal ) 
 
tssmooth ma pct_fee_deposit_ma = pct_fee_deposit,window(3 1 3) 
tssmooth ma pct_fee_withdrawal_ma = pct_fee_withdrawal,window(3 1 3) 
tssmooth ma usd_total_ma = usd_total,window(3 1 3) 

gen avg_usd_deposit = usd_deposit/transactions_deposit
gen avg_usd_internal = usd_internal/transactions_internal
gen avg_usd_withdrawal = usd_withdrawal/transactions_withdrawal

tssmooth ma avg_usd_deposit_ma = avg_usd_deposit,window(3 1 3) 
tssmooth ma avg_usd_internal_ma = avg_usd_internal,window(3 1 3) 
tssmooth ma avg_usd_withdrawal_ma = avg_usd_withdrawal,window(3 1 3) 

#delimit
twoway 
(line usd_total_ma all_dates, lwidth(thick) lcolor(cranberry))  
, ytitle("USD (Thousands)", height(5)) 
 xtitle(" ")  title(" ") ylabel(0[500]3000)
 tlabel(05sep2021  05dec2021  05mar2022 05jun2022 05sep2022, format(%d)) 
graphregion(color(white)) plotregion(fcolor(white)) 
graphregion(margin(l+0 r+5));
#delimit cr
graph export "$dirfigures/Figure3a.eps", replace

#delimit
twoway 
(line usd_withdrawal_ma all_dates, lwidth(thick) lcolor(cranberry))  
(line usd_deposit_ma all_dates, lwidth(thick) lcolor(ebblue))  
, ytitle("USD (Thousands)", height(5)) 
 xtitle(" ")  title(" ") ylabel(0[200]600)
 tlabel(05sep2021  05dec2021  05mar2022 05jun2022 05sep2022, format(%d)) 
legend(order(1 "Withdrawals" 2 "Deposits") region(lwidth(none)) rows(1) size(medlarge))  
xline(22529, lwidth(vthin) lcolor(black) lpattern(dash))
xline(22530, lwidth(thin) lcolor(black) lpattern(dash))
xline(22543, lwidth(thin) lcolor(black) lpattern(dash))
xline(22580, lwidth(thin) lcolor(black) lpattern(dash))
xline(22610, lwidth(thin) lcolor(black) lpattern(dash))
xline(22618, lwidth(thin) lcolor(black) lpattern(dash))
xline(22636, lwidth(thin) lcolor(black) lpattern(dash))
xline(22666, lwidth(thin) lcolor(black) lpattern(dash))
xline(22774, lwidth(thin) lcolor(black) lpattern(dash))
xline(22827, lwidth(thin) lcolor(black) lpattern(dash))
graphregion(color(white)) plotregion(fcolor(white)) 
graphregion(margin(l+0 r+5));
#delimit cr
graph export "$dirfigures/Figure3b.eps", replace

#delimit
twoway 
(line avg_usd_withdrawal all_dates, lwidth(thick) lcolor(cranberry))  
(line avg_usd_internal all_dates, lwidth(thick) lcolor(purple))  
(line avg_usd_deposit all_dates,    lwidth(thick) lcolor(ebblue))  
, ytitle("Average Size USD (Thousands)", height(5))   
 xtitle(" ")  title(" ") 
  tlabel(05sep2021  05dec2021  05mar2022 05jun2022 05sep2022, format(%d)) 
legend(order(1 "Withdrawals" 2 "Internal" 3 "Deposits" ) region(lwidth(none)) rows(1) size(medlarge)) 
graphregion(color(white)) plotregion(fcolor(white)) 
graphregion(margin(l+0 r+5));
#delimit cr
graph export "$dirfigures/FigureA24.eps", replace
 
#delimit
twoway 
(line usd_net_ma all_dates, lwidth(thick) lcolor(cranberry))  
, ytitle("Deposits - Withdrawals USD (thousands)", height(5)) 
 xtitle(" ")  title("") 
  tlabel(05sep2021  05dec2021  05mar2022 05jun2022 05sep2022, format(%d)) 
legend(order(1 "Withdrawals" 2 "Internal" 3 "Deposits" ) region(lwidth(none)) rows(1) size(medlarge)) 
graphregion(color(white)) plotregion(fcolor(white)) 
graphregion(margin(l+0 r+5));
#delimit cr
graph export "$dirfigures/FigureA25.eps", replace

#delimit
twoway 
(line pct_fee_withdrawal_ma all_dates, lwidth(thick) lcolor(cranberry))  
(line pct_fee_deposit_ma all_dates,    lwidth(thick) lcolor(ebblue))  
, ytitle("Fee (% Amount Transacted)", height(5))   
 xtitle(" ")  title(" ") 
  tlabel(05sep2021  05dec2021  05mar2022 05jun2022 05sep2022, format(%d)) 
legend(order(1 "Withdrawals" 2  "Deposits" ) region(lwidth(none)) rows(1) size(medlarge)) 
graphregion(color(white)) plotregion(fcolor(white)) 
graphregion(margin(l+0 r+5));
#delimit cr
graph export "$dirfigures/FigureA26.eps", replace


** Figure E1 
*Source: yahoofinance
cd "$dirin"
import delimited "BTC-USD_yahoofinance_2023.csv", clear 
split date, p("-")
drop date 
destring date*, replace 
gen all_dates=mdy(date2, date3, date1)
format all_dates %td 
drop date*  
gen week = wofd(all_dates)
format week %tw
collapse (sum) open close  volume,by(week)
save "Volumes_2021_2023.dta", replace 
 
use "crystal.dta", clear 
gen transactions=1
drop if direction=="internal_transfer"
gen week = wofd(all_dates)
format week %tw 
collapse (sum) transactions sum_in_btc sum_in_usd total_tx_fee_btc total_tx_fee_usd total_sent, by(week) fast 
merge 1:1 week using "Volumes_2021_2023.dta", keep(match) nogenerate 
replace volume=volume/1000000000  
replace sum_in_usd = sum_in_usd/1000000000

tsset week 
gen dlog_volume = ln(volume) - ln(l.volume)
gen dlog_price = ln(close) - ln(l.close)

#delimit
twoway (scatter dlog_volume l.dlog_price  , msize(vlarge) msymbol(Oh) mcolor(ebblue))  
  (lfit  dlog_volume  l.dlog_price ,  lcolor(cranberry) lwidth(thick))  
, xtitle("% Change Price Week Before") title(" ") 
		ytitle("% Change Volume Market Market (USD)")  
		legend(off) graphregion(color(white)) plotregion(fcolor(white));
		#delimit cr	
graph export "$dirfigures/FigureE1a.eps", replace


*Source : https://data.bitcoinity.org/
cd "$dirin"
import delimited "$dirin/Bitcoin_trading_volume_bitcoinity.csv", encoding(ISO-8859-9) clear 
*volume BTC 
split time, p(" ")
split time1, p("-")
destring time11 time12 time13, replace 
gen all_dates=mdy(time12, time13, time11)
format all_dates %td 
drop time*
gen week = wofd(all_dates)
format week %tw
collapse (sum) bitbay bitfinex bitso bitstamp coinbase exmo gemini korbit kraken others, by(week)
egen OTHERS = rowtotal(bitstamp others exmo korbit) 
drop others bitstamp exmo korbit
rename OTHERS others 
rename bitbay bitbay1
rename bitfinex bitfinex2
rename bitso bitso3
rename coinbase coinbase4
rename gemini gemini5
rename kraken kraken6
rename others others7
reshape long bitbay bitfinex bitso coinbase gemini kraken others, i(week) j(exchange) string 
replace exchange = "bitbay" if exchange=="1" 
replace exchange = "bitfinex" if exchange=="2" 
replace exchange = "bitso" if exchange=="3" 
replace exchange = "coinbase" if exchange=="4" 
replace exchange = "gemini" if exchange=="5" 
replace exchange = "kraken" if exchange=="6" 
replace exchange = "others" if exchange=="7" 
gen volume = .
replace volume = bitbay if exchange=="bitbay"
replace volume = bitfinex if exchange=="bitfinex"
replace volume = bitso if exchange=="bitso"
replace volume = coinbase if exchange=="coinbase"
replace volume = gemini if exchange=="gemini"
replace volume = kraken if exchange=="kraken"
replace volume = others if exchange=="others"
drop bitbay bitfinex bitso coinbase gemini kraken others
save "$dirin/Volumes_2021_2023_exchange.dta", replace 

 
import delimited "$dirin/BTC-USD_yahoofinance_2023.csv", clear 
split date, p("-")
drop date 
destring date*, replace 
gen all_dates=mdy(date2, date3, date1)
format all_dates %td 
drop date*  
gen week = wofd(all_dates)
format week %tw
collapse (sum) open close  volume,by(week)
save "$dirin/Volumes_2021_2023.dta", replace 


use "$dirin/crystal.dta", clear 
gen transactions=1
drop if direction=="internal_transfer"
gen week = wofd(all_dates)
format week %tw 
replace contr_entity="bitbay" if contr_entity=="Zonda (prev. BitBay)"
replace contr_entity="bitfinex" if contr_entity=="Bitfinex"
replace contr_entity="bitso" if contr_entity=="Bitso"
replace contr_entity="coinbase" if contr_entity=="Coinbase"
replace contr_entity="gemini" if contr_entity=="Gemini"
replace contr_entity="kraken" if contr_entity=="Kraken"
rename contr_entity exchange 
collapse (sum) transactions sum_in_btc sum_in_usd total_tx_fee_btc total_tx_fee_usd total_sent, by(week exchange) fast 
merge 1:1 week exchange using "$dirin/Volumes_2021_2023_exchange.dta", keep(match) nogenerate 
merge m:1 week using "$dirin/Volumes_2021_2023.dta", keep(match) nogenerate 

keep if exchange=="coinbase"
 
tsset week 
gen dlog_volume = ln(volume) - ln(l.volume)
gen dlog_sum_in_btc = ln(sum_in_btc) - ln(l.sum_in_btc)
gen dlog_price = ln(close) - ln(l.close)


#delimit
twoway (scatter dlog_sum_in_btc l.dlog_price  , msize(vlarge) msymbol(Oh) mcolor(ebblue))  
  (lfit dlog_sum_in_btc l.dlog_price  ,  lcolor(cranberry) lwidth(thick))  
, ytitle("% Change Volume Chivo (Coinbase)", height(5)) title(" ") 
		xtitle("% Change Volume Bitcoin Market (Coinbase)")  
		legend(off) graphregion(color(white)) plotregion(fcolor(white));
		#delimit cr	
graph export "$dirfigures/FigureE1b.pdf", replace

#delimit
twoway (scatter dlog_volume l.dlog_price if  dlog_volume<.95, msize(vlarge) msymbol(Oh) mcolor(ebblue))  
  (lfit dlog_volume l.dlog_price  if  dlog_volume<.95,  lcolor(cranberry) lwidth(thick))  
, xtitle("% Change Price Week Before") title(" ") 
		ytitle("% Change Volume Coinbase (USD)")  
		legend(off) graphregion(color(white)) plotregion(fcolor(white));
		#delimit cr	
 graph export "$dirfigures/FigureE1c.eps", replace
		
#delimit
twoway (scatter dlog_sum_in_btc dlog_volume , msize(vlarge) msymbol(Oh) mcolor(ebblue))  
  (lfit dlog_sum_in_btc dlog_volume ,  lcolor(cranberry) lwidth(thick))  
, ytitle("% Change Volume Chivo (Coinbase)", height(5)) title(" ") 
		xtitle("% Change Volume Bitcoin Market (Coinbase)")  
		legend(off) graphregion(color(white)) plotregion(fcolor(white));
		#delimit cr	
graph export "$dirfigures/FigureE1d.eps", replace
	
erase "Volumes_2021_2023_exchange.dta"
erase "Volumes_2021_2023.dta"

