# Missed Opportunity Calculator

### What is Dollar Cost Averaging?

Dollar Cost Averaging (DCA) simulates effect of regular investments an asset without regard for price/market fluctuations or trying to time markets. DCA is a popular investment strategy that does not depend on your ability to time the markets and has been [mathematically](https://ofdollarsanddata.com/even-god-couldnt-beat-dollar-cost-averaging/) proven to yield better results over the long run than 'buying the dip' even if the the investor happens to be omniscient and able to perfectly time the market.


### What does missed opportunity calculator do?

Missed opportunity calculator lets you determine 4 parameters: **asset, frequency of investment, contribution and start date**. 

Using your parameters it will calculate:
- how much money you would have invested in an asset until present day
- how much such a portfolio would be worth based on the latest prize
- what your profit/loss would be on the investment.
  
A list of all dates when investments take place along with historical stock price, count of shares bought, running invested funds and running portfolio value is provided.

Here are some examples of what using the output of the calculator might look like:	

DCA-ing Apple terminal output
![Picture1](https://github.com/DmitrijSolanic/Portfolio/blob/main/Missed_Opportunity_Calculator/missed_opportunity_calculator_example1.jpg)

DCA-ing Alibaba terminal output
![Picture2](https://github.com/DmitrijSolanic/Portfolio/blob/main/Missed_Opportunity_Calculator/missed_opportunity_calculator_example2.JPG)

DCA-ing Tesla figure output
![Picture3](https://github.com/DmitrijSolanic/Portfolio/blob/main/Missed_Opportunity_Calculator/missed_opportunity_calculator_example3_viz.JPG)


### How to use the calculator?

1. **Assets** can be *stocks, cryptocurrencies or commodities* as long as they have a ticker on Yahoo finance, which I am using as a data source for asset closing price at each trading day. You can check out trending ticker on [Yahoo](https://finance.yahoo.com/trending-tickers/).
2. There are three **frequency** options to choose from: *weekly, monthly and yearly*. 
In case of weekly, Mondays are used, in case of monthly, 1st day of month is used, in case of yearly, January 1st is used. 
In cases when these are not trading days for a given asset, data from the closest following trading day is used. 
3. **Contribution** is how much money you are investing into the asset in dollars on a given frequency. 
4. **Date** of your first contribution is either start date if coincides with starting day of chosen frequency or the starting day of subsequent week/month/year.


### Disclaimer

Provided for informational/educational purposes only and should not be construed as investment advice . Past performance may not be not indicative of future results. Always consult your Investment Adviser before any decision. 

