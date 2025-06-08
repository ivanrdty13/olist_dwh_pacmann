import pandas as pd

def extract_customers():
    return pd.read_csv("data/olist_customers_dataset.csv")

def extract_sellers():
    return pd.read_csv("data/olist_sellers_dataset.csv")
