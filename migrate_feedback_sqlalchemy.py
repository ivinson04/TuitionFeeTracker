from app import app, db
from sqlalchemy import text, inspect

def add_feedback_column():
    with app.app_context():
        try:
            print("Checking database schema...")
            
            # Check if column exists
            inspector = inspect(db.engine)
            columns = [col['name'] for col in inspector.get_columns('test_assignment')]
            
            if 'feedback' not in columns:
                print("Adding feedback column to test_assignment table...")
                
                # Add the column
                with db.engine.connect() as conn:
                    conn.execute(text('ALTER TABLE test_assignment ADD COLUMN feedback TEXT'))
                    conn.commit()
                
                print("✓ Migration completed successfully! Feedback column added.")
            else:
                print("✓ Feedback column already exists in test_assignment table.")
                
        except Exception as e:
            print(f"✗ Error during migration: {e}")
            db.session.rollback()

if __name__ == "__main__":
    add_feedback_column()