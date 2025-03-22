import os
from flask import Flask, render_template, request, redirect, url_for, flash, send_from_directory
from flask_sqlalchemy import SQLAlchemy
from werkzeug.utils import secure_filename
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
    payments = db.relationship('Payment', backref='student', lazy=True, cascade='all, delete-orphan')


# Payment model
class Payment(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    student_id = db.Column(db.Integer, db.ForeignKey('student.id'), nullable=False)
    amount = db.Column(db.Float, nullable=False)
    date = db.Column(db.DateTime, default=datetime.utcnow)
    status = db.Column(db.String(50), default='Pending')


# Announcement model
class Announcement(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(150), nullable=False)
    content = db.Column(db.Text, nullable=False)
    date_posted = db.Column(db.DateTime, default=datetime.utcnow)
    admin_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)


# New Subject model (for video playlists)
class Subject(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text, nullable=True)
    date_created = db.Column(db.DateTime, default=datetime.utcnow)
    admin_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    chapters = db.relationship('Chapter', backref='subject', lazy=True, cascade='all, delete-orphan')


# New Chapter model (for organizing videos within subjects)
class Chapter(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text, nullable=True)
    subject_id = db.Column(db.Integer, db.ForeignKey('subject.id'), nullable=False)
    date_created = db.Column(db.DateTime, default=datetime.utcnow)
    videos = db.relationship('VideoLecture', backref='chapter', lazy=True, cascade='all, delete-orphan')


# Updated VideoLecture model with subject and chapter relationships
class VideoLecture(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200), nullable=False)
    description = db.Column(db.Text, nullable=True)
    filename = db.Column(db.String(255), nullable=False)
    date_added = db.Column(db.DateTime, default=datetime.utcnow)
    admin_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    chapter_id = db.Column(db.Integer, db.ForeignKey('chapter.id'), nullable=True)


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

        # For student role, check if the student name exists in the Student table
        if role == 'student':
            student = Student.query.filter_by(name=username).first()
            if not student:
                flash('Student name not found in the system. Please contact your administrator.', 'danger')
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


@app.route('/add_announcement', methods=['POST'])
@login_required
def add_announcement():
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))

    title = request.form['title']
    content = request.form['content']

    new_announcement = Announcement(
        title=title,
        content=content,
        admin_id=current_user.id
    )

    db.session.add(new_announcement)
    db.session.commit()
    flash('Announcement posted successfully!', 'success')
    return redirect(url_for('admin_dashboard'))


@app.route('/delete_announcement/<int:announcement_id>')
@login_required
def delete_announcement(announcement_id):
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))

    announcement = Announcement.query.get_or_404(announcement_id)
    db.session.delete(announcement)
    db.session.commit()
    flash('Announcement deleted successfully!', 'success')
    return redirect(url_for('admin_dashboard'))


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
    announcements = Announcement.query.order_by(Announcement.date_posted.desc()).all()
    return render_template('admin_dashboard.html', students=students, payments=payments, announcements=announcements)


@app.route('/student_dashboard')
@login_required
def student_dashboard():
    if current_user.role != 'student':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))
    student = Student.query.filter_by(name=current_user.username).first()
    payments = Payment.query.filter_by(student_id=student.id).all() if student else []
    # Get recent announcements for students to see
    announcements = Announcement.query.order_by(Announcement.date_posted.desc()).all()
    return render_template('student_dashboard.html', student=student, payments=payments, announcements=announcements)


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


@app.route('/delete_student/<int:student_id>')
@login_required
def delete_student(student_id):
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))

    student = Student.query.get_or_404(student_id)

    # First, try to delete any associated user account
    user = User.query.filter_by(username=student.name, role='student').first()
    if user:
        db.session.delete(user)

    # Then delete the student (payments will be automatically deleted due to cascade)
    db.session.delete(student)
    db.session.commit()

    flash(f'Student "{student.name}" deleted successfully!', 'success')
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


# Add these configurations to app.py
UPLOAD_FOLDER = 'static/videos'
ALLOWED_EXTENSIONS = {'mp4', 'webm', 'ogg'}
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['MAX_CONTENT_LENGTH'] = 500 * 1024 * 1024  # Limit uploads to 500MB

# Ensure the upload directory exists
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)


def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


# Updated route for video lectures page
@app.route('/video_lectures')
@login_required
def video_lectures():
    subjects = Subject.query.order_by(Subject.name).all()
    # For uncategorized videos, find videos with no chapter_id
    uncategorized_videos = VideoLecture.query.filter_by(chapter_id=None).order_by(VideoLecture.date_added.desc()).all()
    return render_template('video_lectures.html', subjects=subjects, uncategorized_videos=uncategorized_videos)


# New route for adding subjects
@app.route('/add_subject', methods=['POST'])
@login_required
def add_subject():
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))

    name = request.form['name']
    description = request.form.get('description', '')

    new_subject = Subject(
        name=name,
        description=description,
        admin_id=current_user.id
    )

    db.session.add(new_subject)
    db.session.commit()
    flash('Subject added successfully!', 'success')
    return redirect(url_for('video_lectures'))


# New route for deleting subjects
@app.route('/delete_subject/<int:subject_id>')
@login_required
def delete_subject(subject_id):
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))

    subject = Subject.query.get_or_404(subject_id)

    # Delete all videos in chapters
    for chapter in subject.chapters:
        for video in chapter.videos:
            try:
                os.remove(os.path.join(app.config['UPLOAD_FOLDER'], video.filename))
            except:
                flash(f'Warning: Could not delete the video file "{video.title}" from server', 'warning')

    db.session.delete(subject)
    db.session.commit()
    flash(f'Subject "{subject.name}" and all its content deleted successfully!', 'success')
    return redirect(url_for('video_lectures'))


# New route for adding chapters
@app.route('/add_chapter', methods=['POST'])
@login_required
def add_chapter():
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))

    subject_id = request.form['subject_id']
    name = request.form['name']
    description = request.form.get('description', '')

    new_chapter = Chapter(
        name=name,
        description=description,
        subject_id=subject_id
    )

    db.session.add(new_chapter)
    db.session.commit()
    flash('Chapter added successfully!', 'success')
    return redirect(url_for('video_lectures'))


# New route for deleting chapters
@app.route('/delete_chapter/<int:chapter_id>')
@login_required
def delete_chapter(chapter_id):
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))

    chapter = Chapter.query.get_or_404(chapter_id)

    # Delete all videos in chapter
    for video in chapter.videos:
        try:
            os.remove(os.path.join(app.config['UPLOAD_FOLDER'], video.filename))
        except:
            flash(f'Warning: Could not delete the video file "{video.title}" from server', 'warning')

    db.session.delete(chapter)
    db.session.commit()
    flash(f'Chapter "{chapter.name}" and all its videos deleted successfully!', 'success')
    return redirect(url_for('video_lectures'))


# Updated route for adding video lectures
@app.route('/add_video_lecture', methods=['POST'])
@login_required
def add_video_lecture():
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))

    title = request.form['title']
    description = request.form['description']
    chapter_id = request.form.get('chapter_id')

    # Handle empty chapter_id
    if chapter_id == "":
        chapter_id = None

    # Handle file upload
    if 'video_file' not in request.files:
        flash('No file part', 'danger')
        return redirect(url_for('video_lectures'))

    file = request.files['video_file']

    if file.filename == '':
        flash('No selected file', 'danger')
        return redirect(url_for('video_lectures'))

    if file and allowed_file(file.filename):
        # Create a unique filename to prevent overwriting
        filename = secure_filename(file.filename)
        unique_filename = f"{datetime.utcnow().strftime('%Y%m%d%H%M%S')}_{filename}"

        file.save(os.path.join(app.config['UPLOAD_FOLDER'], unique_filename))

        new_lecture = VideoLecture(
            title=title,
            description=description,
            filename=unique_filename,
            admin_id=current_user.id,
            chapter_id=chapter_id
        )

        db.session.add(new_lecture)
        db.session.commit()
        flash('Video lecture added successfully!', 'success')
    else:
        flash('Invalid file type. Only MP4, WebM, and OGG files are allowed.', 'danger')

    return redirect(url_for('video_lectures'))


@app.route('/delete_video_lecture/<int:lecture_id>')
@login_required
def delete_video_lecture(lecture_id):
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))

    lecture = VideoLecture.query.get_or_404(lecture_id)

    # Delete the file from the server
    try:
        os.remove(os.path.join(app.config['UPLOAD_FOLDER'], lecture.filename))
    except:
        flash('Warning: Could not delete the video file from server', 'warning')

    db.session.delete(lecture)
    db.session.commit()
    flash('Video lecture deleted successfully!', 'success')
    return redirect(url_for('video_lectures'))


@app.route('/video/<filename>')
@login_required
def serve_video(filename):
    """Serve video files only to authenticated users"""
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename)


if __name__ == '__main__':
    with app.app_context():
        db.create_all()
        print("Database initialized successfully!")  # Debugging log
    app.run(debug=True, port=5001)