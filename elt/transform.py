import pandas as pd
from datetime import datetime

def detect_customer_changes(source_df, current_df):
    merged = source_df.merge(current_df, on='customer_id', how='left', suffixes=('', '_curr'))
    changed = merged[
        (merged['city'] != merged['city_curr']) |
        (merged['state'] != merged['state_curr'])
    ].copy()
    
    changed["valid_from"] = datetime.utcnow()
    changed["valid_to"] = pd.Timestamp("9999-12-31")
    changed["is_current"] = True

    return changed[["customer_id", "customer_unique_id", "zip_code_prefix", "city", "state", "valid_from", "valid_to", "is_current"]]
