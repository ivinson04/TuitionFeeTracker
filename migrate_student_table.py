from app import app, db
from models import Student
import sqlalchemy as sa

def migrate_student_table():
    with app.app_context():
        # Check if column already exists
        inspector = sa.inspect(db.engine)
        columns = [col['name'] for col in inspector.get_columns('student')]
        
        if 'class_level' not in columns:
            print("Adding class_level column to Student table...")
            op = sa.schema.DDL('ALTER TABLE student ADD COLUMN class_level VARCHAR(20)')
            db.session.execute(op)
            db.session.commit()
            print("Migration completed successfully!")
        else:
            print("class_level column already exists in Student table.")

if __name__ == "__main__":
    migrate_student_table()