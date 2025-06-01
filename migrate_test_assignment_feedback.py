import psycopg2
from psycopg2 import sql

# Database connection parameters
DB_HOST = "dpg-d0r9t2be5dus73fo7dr0-a.oregon-postgres.render.com"
DB_NAME = "tuition_db_5"
DB_USER = "tuition_db_5_user"
DB_PASS = "eb7M2GmRlZrZolX0M5f8GHzqqtECWm4e"

def add_feedback_column():
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASS
        )
        cursor = conn.cursor()

        # Check if feedback column exists
        cursor.execute("""
            SELECT column_name 
            FROM information_schema.columns 
            WHERE table_name='test_assignment' AND column_name='feedback';
        """)
        column_exists = cursor.fetchone()

        if not column_exists:
            print("Adding feedback column to test_assignment table...")
            # Add feedback column
            cursor.execute("""
                ALTER TABLE test_assignment
                ADD COLUMN feedback TEXT;
            """)
            conn.commit()
            print("Migration completed successfully!")
        else:
            print("feedback column already exists in test_assignment table.")

        cursor.close()
        conn.close()

    except Exception as e:
        print(f"Error during migration: {e}")
        if 'conn' in locals():
            conn.rollback()
            conn.close()

if __name__ == "__main__":
    add_feedback_column()
