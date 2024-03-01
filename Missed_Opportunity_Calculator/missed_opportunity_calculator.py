import yfinance as yf
import pandas as pd
from datetime import datetime, timedelta
import matplotlib.pyplot as plt

# Seting display options for pandas
pd.set_option('display.max_columns', None)  # Show all columns
pd.set_option('display.max_rows', None)     # Show all rows
pd.set_option('display.width', None)  # Set the width to fit all columns

# Welcome message
print("\nWelcome to the missed opportunity calculator. \nFind out how much an asset of your choosing would be worth today if you started investing regularly at a point in the past.")

# Gathering inputs
ticker = input("Please input ticker of your preffered asset (as shown on Yahoo finance, e.g. TSLA for Tesla/ AAPL for Apple/ ^GSPC for S&P500/ GC=F for Gold etc.): ")
frequency = input("Please input frequency of conributions (w for weekly/ m for monthly/ y for yearly): ")
start_date = input("Please input a starting date in YYYY-MM-DD format: ")
dca_amount_input = input("Please input the amount you wish you had been investing in dollars: ")

# Converting to date format and subtracting 10 days
start_date_obj = datetime.strptime(start_date, '%Y-%m-%d')
new_date_obj = start_date_obj - timedelta(days=10)

# Creating first Dataframe, default index is the date, so resetting it in order to be able to work with date as column
asset = yf.Ticker(ticker)
asset_history = asset.history(start=new_date_obj)
df = pd.DataFrame(asset_history)
df.reset_index(inplace=True)

# Re-formatting date back and finding last trading day before start date
df['Date'] = df['Date'].dt.strftime('%Y-%m-%d')
condition = df['Date'] < start_date
trading_day_before_start_date = df.loc[condition, 'Date'].iloc[-1]

# Re-creating Dataframewith predated date to be able to use lag later effectively.
# If starting date is used directly as start parameter in following line, lagged_week_filled will not differ from week for any Monday etc.
asset_history = asset.history(start=trading_day_before_start_date)
df = pd.DataFrame(asset_history)
df.reset_index(inplace=True)

# Calculating how much stock could be bought on each day at close
dca_amount = float(dca_amount_input)
df['Stock_bought'] = dca_amount / df['Close']

# Performing relevant date based transformations and calculations depending on chosen frequency
if frequency == 'w':
    # Creating a week column based on date column
    df['week'] = df['Date'].dt.isocalendar().week
    # Creating a lagged version of the week column
    df['lagged_week'] = df['week'].shift(1)
    # Filling in week value into the first line of lagged_week column which is by default NaN
    df['lagged_week_filled'] = df['lagged_week'].fillna(df['week'])
    # Checking whether day is first day of a new week
    df['same_week'] = (df['week'] == df['lagged_week_filled']).astype(int)
    # Filtering df for first day of every week
    week_start_slice = df[df['same_week'] == 0]
    # Creating a proper DF, so that I can reformat without errors
    week_start_df = week_start_slice.copy()
    # Reformatting for better visual clarity
    week_start_df['Date'] = week_start_df['Date'].dt.strftime('%Y-%m-%d')
    week_start_df['Closing_price'] = week_start_df['Close'].round(2)
    week_start_df['Stock_bought'] = week_start_df['Stock_bought'].round(2)
    chosen_df = week_start_df
    basis = 'weekly'
elif frequency == 'm':
    # Same process with month and year columns
    df['month'] = df['Date'].dt.month
    df['lagged_month'] = df['month'].shift(1)
    df['lagged_month_filled'] = df['lagged_month'].fillna(df['month'])
    df['same_month'] = (df['month'] == df['lagged_month_filled']).astype(int)
    month_start_slice = df[df['same_month'] == 0]
    month_start_df = month_start_slice.copy()
    month_start_df['Date'] = month_start_df['Date'].dt.strftime('%Y-%m-%d')
    month_start_df['Closing_price'] = month_start_df['Close'].round(2)
    month_start_df['Stock_bought'] = month_start_df['Stock_bought'].round(2)
    chosen_df = month_start_df
    basis = 'monthly'
else:
    df['year'] = df['Date'].dt.year
    df['lagged_year'] = df['year'].shift(1)
    df['lagged_year_filled'] = df['lagged_year'].fillna(df['year'])
    df['same_year'] = (df['year'] == df['lagged_year_filled']).astype(int)
    year_start_slice = df[df['same_year'] == 0]
    year_start_df = year_start_slice.copy()
    year_start_df['Date'] = year_start_df['Date'].dt.strftime('%Y-%m-%d')
    year_start_df['Closing_price'] = year_start_df['Close'].round(2)
    year_start_df['Stock_bought'] = year_start_df['Stock_bought'].round(2)
    chosen_df = year_start_df
    basis = 'yearly'

chosen_df.reset_index(inplace=True)
chosen_df = chosen_df[['Date','Closing_price','Stock_bought']]
chosen_df = chosen_df.copy()
# Adding clumns
chosen_df['running_stock_unit_total'] = chosen_df['Stock_bought'].cumsum()
chosen_df['running_portfolio_value'] = round(chosen_df['running_stock_unit_total']  * chosen_df['Closing_price'])
chosen_df['amount_invested'] = ((chosen_df.index + 1) * dca_amount).round()
chosen_df['running_pl'] = round((chosen_df['running_portfolio_value'] / chosen_df['amount_invested'])*100)

# Definitions prep for last_price_row and final message
latest_trading_date = df['Date'].iloc[-1]
latest_trading_date_reformatted = latest_trading_date.strftime('%Y-%m-%d')
invested_funds = chosen_df['amount_invested'].iloc[-1]
overall_portfolio = round(chosen_df['running_stock_unit_total'].iloc[-1] * df['Close'].iloc[-1])
overall_shares = chosen_df['running_stock_unit_total'].iloc[-1]

p_l =round(((overall_portfolio / invested_funds ) -1 )*100)
if p_l < 0:
    p_l_word = 'loss'
else: p_l_word = 'profit'
absolute_pl = abs(p_l)

# Adding last row with latest price and appending the new row to the DataFrame
latest_price_row = {'Date': latest_trading_date_reformatted ,
                    'Closing_price': round(df['Close'].iloc[-1],2) ,
                    'running_stock_unit_total': overall_shares ,
                    'running_portfolio_value': overall_portfolio ,
                    'amount_invested': invested_funds ,
                    'running_pl':  round((chosen_df['running_stock_unit_total'].iloc[-1] * df['Close'].iloc[-1] / chosen_df['amount_invested'].iloc[-1])*100) }
latest_price_row_df = pd.DataFrame([latest_price_row])
chosen_df = pd.concat([chosen_df, latest_price_row_df], ignore_index=True)
gains_losses = overall_portfolio - invested_funds

# Converting each string date to a date object without changing the format for correct reading by matplotlib
chosen_df['Date'] = chosen_df['Date'].apply(lambda x: datetime.strptime(x, '%Y-%m-%d').date())

# Final dataset
print("\n",chosen_df)

# Final personalized message
print("\nInvesting",dca_amount_input,"USD on a",basis,"basis in",ticker,"starting from",start_date,"till today means your total contribution would be",round(invested_funds),"USD."
      "\nThese funds would have generated a",p_l_word,"of",round(abs(gains_losses)),"USD (a",p_l_word,"of",absolute_pl,"%) with position currently valued at",overall_portfolio,"USD (",round(overall_shares, 2),"shares/coins ).")
if p_l < 0:
    print("\nCongratulations on not following that idea through.")
else:
    print("\nDon't be sad. Remember the saying 'The best time to start investing was 10 years ago, the next best time is now.'")

# Visualisation
chosen_df.plot(x = 'Date', y= ['amount_invested', 'running_portfolio_value'], style=['o-', 'o-'])
plt.legend(labels=['Amount Invested ($)', 'Portfolio Value ($)'], loc='upper left')
plt.title(ticker + ' portfolio - the story of what could have been if you DCA-ed')
fig = plt.gcf()
fig.set_size_inches(13, 6)
plt.grid(True)
plt.show()