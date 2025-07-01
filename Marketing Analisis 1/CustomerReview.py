import pandas as pd
import pyodbc
import nltk
from nltk.sentiment.vader import SentimentIntensityAnalyzer


nltk.download('vader_lexicon')

#define the function to fetch data from a sql database using a sql query
def fetch_data_from_sql():
    conn_str=(
        "Driver={SQL Server};" #Speficy the driver for sql server
        "Server=TOBIAS\SQLEXPRESS;"#Specify your SQL instance
        "Database=PortfolioProject_MarketingAnalytics;"#Specify the database name
        "Trusted_Conexion=yes;" #Use windows authentication for the connection

    )
    #establish the connection to the database
    conn=pyodbc.connect(conn_str)
    #Define the sql query to fetch customers reviews data
    query="Select ReviewID,CustomerID,ProductID,ReviewDate,Rating,ReviewText FROM dbo.customer_reviews"

    #Execute the query and fetch the data into a dataframe
    df=pd.read_sql(query,conn)

    #close the connection to free the resources
    conn.close()

    #return the fetched data as a Dataframe
    return df
#Fetch the customer reviews data from sql database
customer_reviews_df=fetch_data_from_sql()

sia=SentimentIntensityAnalyzer()

#define a funtion to calculate the sentiment scores using Vader
def calculate_sentiment(review):
    sentiment=sia.polarity_scores(review)
    return sentiment['compound']

def categorize_sentiment(score,rating):
    #use both the text sentiment score and the numerical rating to determinate sentiment category
    if score >0.05:
        if rating>=4:
            return 'Positive'
        elif rating==3:
            return 'Mixed Positive'
        else:
            return 'Mixed Negative'
    elif score < -0.05:
        if rating<=2:
            return 'Negative'
        elif rating ==3:
            return 'Mixed Negative'
        else:
            return 'Mixed Positive' 
    else:
        if rating >=4:
            return 'Positive'
        elif rating <=2:
            return 'Negative'
        else:
            return 'Neutral'
        

#Define a function to bucket sentiment scores into text ranges
def sentiment_bucket(score):
    if score >= 0.5:
        return '0.5 to 1.0'
    elif 0.0<score <0.5:
        return '0.0 to 0.49'
    elif -0.5< score <0.0:
        return '-0.49 to 0.0'
    else:
        return'-1.0 to -0.5'

# Define a sentiment anylisis to calculate snetiment scores for each review
customer_reviews_df['SentimentScore'] =customer_reviews_df['ReviewText'].apply(calculate_sentiment)

#Apply sentiment categorization using both text and rating
customer_reviews_df['SentimentCategory']=customer_reviews_df.apply(
    lambda row:categorize_sentiment(row['SentimentScore'],row['Rating']),axis=1
)

#Apply sentiment bucketing to categorize scores into defined ranges
customer_reviews_df['SentimentBucket']=customer_reviews_df['SentimentScore'].apply(sentiment_bucket)

print(customer_reviews_df.head())

customer_reviews_df.to_csv('Fact_Customer_Rewviews_with_sentiment.csv',index=False)
        


        



