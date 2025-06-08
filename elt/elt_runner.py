from elt.extract import extract_customers
from elt.transform import detect_customer_changes
from elt.load import load_customer_changes
import psycopg2

conn = psycopg2.connect(
    host="dwh", user="postgres", password="postgres", dbname="postgres"
)

source_df = extract_customers()
current_df = pd.read_sql("SELECT * FROM dwh.dim_customer WHERE is_current = TRUE", conn)
changes_df = detect_customer_changes(source_df, current_df)

if not changes_df.empty:
    load_customer_changes(conn, changes_df)
else:
    print("No changes detected.")
