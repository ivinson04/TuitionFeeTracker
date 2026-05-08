import psycopg2
from psycopg2 import sql

# IMPORTANT: Update these to match your CURRENT database credentials
# From your app.py: postgresql://tuition_db_7_user:S3KMiYAmGMr3sHrLw7hL6HLB0IWT0APo@dpg-d1thvger433s73doq6b0-a/tuition_db_7

DB_HOST = "dpg-d1thvger433s73doq6b0-a.oregon-postgres.render.com"  # Added .oregon-postgres.render.com
DB_NAME = "tuition_db_7"  # Changed from tuition_db_5
DB_USER = "tuition_db_7_user"  # Changed from tuition_db_5_user
DB_PASS = "S3KMiYAmGMr3sHrLw7hL6HLB0IWT0APo"  # Updated password

def add_feedback_column():
    try:
        print("Connecting to database...")
        conn = psycopg2.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASS,
            sslmode='require'  # Added SSL requirement for Render
        )
        cursor = conn.cursor()
        print("Connected successfully!")

        # Check if feedback column exists
        print("Checking if feedback column exists...")
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
            print("✓ Migration completed successfully! Feedback column added.")
        else:
            print("✓ Feedback column already exists in test_assignment table.")

        cursor.close()
        conn.close()
        print("Database connection closed.")

    except Exception as e:
        print(f"✗ Error during migration: {e}")
        if 'conn' in locals():
            conn.rollback()
            conn.close()

if __name__ == "__main__":
    add_feedback_column()