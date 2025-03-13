import os
from flask import Flask, render_template, request, redirect, url_for, flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager, UserMixin, login_user, logout_user, login_required, current_user
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime

# Ensure instance folder exists
if not os.path.exists('instance'):
    os.makedirs('instance')

app = Flask(__name__)
app.config['SECRET_KEY'] = 'supersecretkey'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///users.db'

db = SQLAlchemy(app)
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'

# User model for authentication
class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(150), unique=True, nullable=False)
    password = db.Column(db.String(150), nullable=False)
    role = db.Column(db.String(50), nullable=False, default='student')

# Student model
class Student(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(150), nullable=False)
    teacher_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    payments = db.relationship('Payment', backref='student', lazy=True)

# Payment model
class Payment(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    student_id = db.Column(db.Integer, db.ForeignKey('student.id'), nullable=False)
    amount = db.Column(db.Float, nullable=False)
    date = db.Column(db.DateTime, default=datetime.utcnow)
    status = db.Column(db.String(50), default='Pending')

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

@app.route('/')
@login_required
def home():
    if current_user.role == 'admin':
        return redirect(url_for('admin_dashboard'))
    else:
        return redirect(url_for('student_dashboard'))

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        role = request.form['role']
        admin_passcode = request.form.get('admin_passcode', '')  # Get admin password (if provided)

        # Validate admin password
        allowed_admin_passcodes = {"9@11$", "1@99$"}

        if role == 'admin' and admin_passcode not in allowed_admin_passcodes:
            flash('Invalid admin registration password! Contact the system owner.', 'danger')
            return redirect(url_for('register'))

        # Hash user password and save user
        hashed_password = generate_password_hash(password, method='pbkdf2:sha256')
        new_user = User(username=username, password=hashed_password, role=role)

        db.session.add(new_user)
        db.session.commit()

        flash('Registration successful! Please log in.', 'success')
        return redirect(url_for('login'))

    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = User.query.filter_by(username=username).first()
        if user and check_password_hash(user.password, password):
            login_user(user)
            return redirect(url_for('home'))
        else:
            flash('Invalid username or password', 'danger')
    return render_template('login.html')

@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash('You have been logged out.', 'info')
    return redirect(url_for('login'))

@app.route('/admin_dashboard')
@login_required
def admin_dashboard():
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))
    students = Student.query.all()
    payments = Payment.query.all()
    return render_template('admin_dashboard.html', students=students, payments=payments)

@app.route('/student_dashboard')
@login_required
def student_dashboard():
    if current_user.role != 'student':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))
    student = Student.query.filter_by(name=current_user.username).first()
    payments = Payment.query.filter_by(student_id=student.id).all() if student else []
    return render_template('student_dashboard.html', student=student, payments=payments)

@app.route('/add_student', methods=['POST'])
@login_required
def add_student():
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))
    name = request.form['name']
    new_student = Student(name=name, teacher_id=current_user.id)
    db.session.add(new_student)
    db.session.commit()
    flash('Student added successfully!', 'success')
    return redirect(url_for('admin_dashboard'))

@app.route('/pay_fee/<int:student_id>', methods=['POST'])
@login_required
def pay_fee(student_id):
    student = Student.query.get_or_404(student_id)
    if current_user.role != 'student' or current_user.username != student.name:
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))
    amount = request.form['amount']
    new_payment = Payment(student_id=student.id, amount=amount, status="Pending")
    db.session.add(new_payment)
    db.session.commit()
    flash("Fee payment request submitted!", "success")
    return redirect(url_for('student_dashboard'))

@app.route('/approve_fee/<int:payment_id>')
@login_required
def approve_fee(payment_id):
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))
    payment = Payment.query.get(payment_id)
    if payment:
        payment.status = 'Approved'
        db.session.commit()
        flash("Fee payment approved!", "success")
    return redirect(url_for('admin_dashboard'))

@app.route('/reject_fee/<int:payment_id>')
@login_required
def reject_fee(payment_id):
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))
    payment = Payment.query.get(payment_id)
    if payment:
        payment.status = 'Rejected'
        db.session.commit()
        flash("Fee payment rejected!", "danger")
    return redirect(url_for('admin_dashboard'))

@app.route('/approved_payments')
@login_required
def approved_payments():
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))
    approved_payments = Payment.query.filter_by(status='Approved').all()
    return render_template('approved_payments.html', payments=approved_payments)

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
        print("Database initialized successfully!")  # Debugging log
    app.run(debug=True, port=5001)