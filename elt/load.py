import psycopg2
from psycopg2.extras import execute_values
from elt.utils import logger

def load_customer_changes(conn, changed_df):
    try:
        cursor = conn.cursor()
        now = changed_df['valid_from'].iloc[0]

        for _, row in changed_df.iterrows():
            # Expire old version
            cursor.execute("""
                UPDATE dwh.dim_customer
                SET is_current = FALSE, valid_to = %s
                WHERE customer_id = %s AND is_current = TRUE
            """, (now, row['customer_id']))

        # Insert new versions
        execute_values(cursor, """
            INSERT INTO dwh.dim_customer (
                customer_id, customer_unique_id, zip_code_prefix, city, state, valid_from, valid_to, is_current
            ) VALUES %s
        """, changed_df.values.tolist())

        conn.commit()
        logger.info(f"{len(changed_df)} customer records updated (SCD2).")
    except Exception as e:
        logger.error(f"Error loading customers: {e}")
        conn.rollback()
