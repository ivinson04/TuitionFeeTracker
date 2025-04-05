import os
import mammoth
from flask import Flask, render_template, request, redirect, url_for, flash, send_from_directory, jsonify, abort
from PyPDF2 import PdfReader
from werkzeug.utils import secure_filename
import io
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime, timedelta

# Import models and db from models.py
from models import db, User, Student, Payment, Announcement, Subject, Chapter, VideoLecture, Test, TestAssignment, TestResponse, init_app

# Import the fee reminder function
from fee_reminder import check_pending_fees

# Ensure instance folder exists
if not os.path.exists('instance'):
    os.makedirs('instance')

app = Flask(__name__)
app.config['SECRET_KEY'] = 'supersecretkey'
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://tuition_db_1_user:LpWjs9RUC6lvJOlyyevfONCYzakv4prP@dpg-cvobvvh5pdvs739r90q0-a.oregon-postgres.render.com/tuition_db_1'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False  # Add this for performance

# Initialize database with app
init_app(app)

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'

# Define allowed extensions
ALLOWED_EXTENSIONS = {
    'test': {'pdf', 'docx'},
    'video': {'mp4', 'webm', 'ogg'},
    'response': {'pdf', 'docx', 'txt', 'jpg', 'jpeg', 'png'}
}

def allowed_file(filename, file_type='test'):
    if not filename or '.' not in filename:
        return False
    extension = filename.rsplit('.', 1)[1].lower()
    return extension in ALLOWED_EXTENSIONS.get(file_type, set())

# File upload configurations
UPLOAD_FOLDER = 'uploads'
TEST_RESPONSE_FOLDER = 'static/test_responses'
VIDEO_FOLDER = 'static/videos'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['TEST_RESPONSE_FOLDER'] = TEST_RESPONSE_FOLDER
app.config['VIDEO_FOLDER'] = VIDEO_FOLDER
app.config['MAX_TEST_CONTENT_LENGTH'] = 10 * 1024 * 1024  # 10MB for tests
app.config['MAX_CONTENT_LENGTH'] = 500 * 1024 * 1024  # 500MB for videos

for folder in [UPLOAD_FOLDER, TEST_RESPONSE_FOLDER, VIDEO_FOLDER]:
    if not os.path.exists(folder):
        os.makedirs(folder)
os.makedirs(os.path.join(UPLOAD_FOLDER, 'tests'), exist_ok=True)
os.makedirs(os.path.join(UPLOAD_FOLDER, 'responses'), exist_ok=True)


@app.context_processor
def utility_processor():
    def now():
        return datetime.now()

    return dict(now=now)

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

@app.before_request
def before_request():
    if request.endpoint == 'student_dashboard':
        check_pending_fees()

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
        admin_passcode = request.form.get('admin_passcode', '')
        allowed_admin_passcodes = {"9@11$", "1@99$"}
        if role == 'admin' and admin_passcode not in allowed_admin_passcodes:
            flash('Invalid admin registration password! Contact the system owner.', 'danger')
            return redirect(url_for('register'))#nice one
        if role == 'student':
            student = Student.query.filter_by(name=username).first()
            if not student:
                flash('Student name not found in the system. Please contact your administrator.', 'danger')
                return redirect(url_for('register'))
        hashed_password = generate_password_hash(password, method='pbkdf2:sha256')
        new_user = User(username=username, password=hashed_password, role=role)
        db.session.add(new_user)
        db.session.commit()
        if role == 'student':
            student = Student.query.filter_by(name=username).first()
            if student:
                student.user_id = new_user.id
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
    new_announcement = Announcement(title=title, content=content, admin_id=current_user.id)
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
    tests = Test.query.filter_by(admin_id=current_user.id).order_by(Test.date_created.desc()).all()
    return render_template('admin_dashboard.html', students=students, payments=payments, announcements=announcements, tests=tests)


@app.route('/create_test', methods=['POST'])
@login_required
def create_test():
    if current_user.role != 'admin':
        flash('Access denied: Admin privileges required', 'danger')
        return redirect(url_for('student_dashboard'))

    test_title = request.form.get('test_title')
    test_description = request.form.get('test_description')
    test_type = request.form.get('test_type')
    is_timed = (test_type == 'timed')
    time_limit = int(request.form.get('time_limit', 60)) if is_timed else None
    test_content = request.form.get('test_content', '')

    new_test = Test(
        title=test_title,
        description=test_description,
        is_timed=is_timed,
        time_limit=time_limit,
        content=test_content,
        date_created=datetime.now(),
        admin_id=current_user.id
    )

    db.session.add(new_test)
    db.session.commit()

    all_students = request.form.get('all_students') == 'all'
    selected_students = request.form.getlist('selected_students')

    if all_students:
        students = Student.query.all()
    else:
        students = Student.query.filter(Student.id.in_(selected_students)).all()

    for student in students:
        assignment = TestAssignment(
            test_id=new_test.id,
            student_id=student.id,
            status='Pending',
            date_assigned=datetime.now()
        )
        db.session.add(assignment)

    db.session.commit()
    flash(f'Test "{test_title}" has been created and assigned to {len(students)} students.', 'success')
    return redirect(url_for('admin_dashboard'))

@app.route('/view_test/<int:test_id>')
@login_required
def view_test(test_id):
    if current_user.role != 'admin':
        flash('Access denied: Admin privileges required', 'danger')
        return redirect(url_for('student_dashboard'))
    test = Test.query.get_or_404(test_id)
    student_data = []
    assignments = TestAssignment.query.filter_by(test_id=test.id).all()
    for assignment in assignments:
        student = Student.query.get(assignment.student_id)
        responses = TestResponse.query.filter_by(assignment_id=assignment.id).all()
        student_data.append({'student': student, 'assignment': assignment, 'responses': responses})
    return render_template('view_test.html', test=test, student_data=student_data)

@app.route('/delete_test/<int:test_id>')
@login_required
def delete_test(test_id):
    if current_user.role != 'admin':
        flash('Access denied: Admin privileges required', 'danger')
        return redirect(url_for('student_dashboard'))
    test = Test.query.get_or_404(test_id)
    if test.file_path:
        file_path = os.path.join(UPLOAD_FOLDER, test.file_path)
        if os.path.exists(file_path):
            os.remove(file_path)
    assignments = TestAssignment.query.filter_by(test_id=test.id).all()
    for assignment in assignments:
        responses = TestResponse.query.filter_by(assignment_id=assignment.id).all()
        for response in responses:
            if response.file_path:
                response_file_path = os.path.join(UPLOAD_FOLDER, response.file_path)
                if os.path.exists(response_file_path):
                    os.remove(response_file_path)
            db.session.delete(response)
        db.session.delete(assignment)
    db.session.delete(test)
    db.session.commit()
    flash(f'Test "{test.title}" has been deleted.', 'success')
    return redirect(url_for('admin_dashboard'))

@app.route('/student_tests')
@login_required
def student_tests():
    if current_user.role != 'student':
        flash('Unauthorized access: Admin users should use the admin dashboard', 'danger')
        return redirect(url_for('admin_dashboard'))
    student = Student.query.filter_by(user_id=current_user.id).first()
    if not student:
        student = Student.query.filter_by(name=current_user.username).first()
        if student:
            student.user_id = current_user.id
            db.session.commit()
            flash('Your student profile has been linked to your account.', 'info')
        else:
            flash('Student profile not found. Please contact your administrator.', 'danger')
            return redirect(url_for('student_dashboard'))
    now = datetime.now()
    pending_assignments = TestAssignment.query.filter_by(student_id=student.id, status='Pending').join(Test).all()
    in_progress_assignments = TestAssignment.query.filter_by(student_id=student.id, status='In Progress').join(Test).all()
    completed_assignments = TestAssignment.query.filter_by(student_id=student.id, status='Completed').join(Test).all()
    return render_template('student_tests.html', pending_assignments=pending_assignments, in_progress_assignments=in_progress_assignments, completed_assignments=completed_assignments, now=now)


@app.route('/take_test/<int:assignment_id>')
@login_required
def take_test(assignment_id):
    if current_user.role != 'student':
        flash('Access denied: Admin users should use the admin dashboard', 'danger')
        return redirect(url_for('admin_dashboard'))

    student = Student.query.filter_by(user_id=current_user.id).first()
    if not student:
        student = Student.query.filter_by(name=current_user.username).first()
        if student:
            student.user_id = current_user.id
            db.session.commit()
            flash('Your student profile has been linked to your account.', 'info')
        else:
            flash('Student profile not found. Please contact your administrator.', 'danger')
            return redirect(url_for('student_dashboard'))

    assignment = TestAssignment.query.get_or_404(assignment_id)
    if assignment.student_id != student.id:
        flash('Access denied: This test is not assigned to you.', 'danger')
        return redirect(url_for('student_tests'))

    # Check if the test is already completed
    if assignment.status == 'Completed':
        flash('This test has already been completed.', 'info')
        return redirect(url_for('view_completed_test', assignment_id=assignment.id))

    test = Test.query.get(assignment.test_id)
    file_url = url_for('serve_test_file', filename=test.file_path) if test.file_path else None

    # If the test is in progress and timed, check if time expired
    if assignment.status == 'In Progress' and test.is_timed and assignment.start_time:
        end_time = assignment.start_time + timedelta(minutes=test.time_limit)
        if datetime.now() > end_time:
            # Time has expired, mark as completed
            assignment.status = 'Completed'
            assignment.end_time = end_time

            # Get most recent response
            latest_response = TestResponse.query.filter_by(assignment_id=assignment.id).order_by(
                TestResponse.timestamp.desc()).first()
            if latest_response:
                # Add a note to the response
                auto_response = TestResponse(
                    assignment_id=assignment.id,
                    content=latest_response.content + "\n\n[Note: This test expired while the student was away. The latest saved response has been automatically submitted.]",
                    timestamp=datetime.now()
                )
                db.session.add(auto_response)

            db.session.commit()
            flash(
                'Your test time has expired. The test has been automatically submitted with your last saved response.',
                'warning')
            return redirect(url_for('student_tests'))

    if assignment.status == 'Pending':
        assignment.status = 'In Progress'
        assignment.start_time = datetime.now()
        db.session.commit()

    time_remaining = None
    if test.is_timed and assignment.start_time:
        end_time = assignment.start_time + timedelta(minutes=test.time_limit)
        remaining = (end_time - datetime.now()).total_seconds()
        time_remaining = max(0, int(remaining))

    response = TestResponse.query.filter_by(assignment_id=assignment.id).order_by(TestResponse.id.desc()).first()
    return render_template('take_test.html', test=test, assignment=assignment, file_url=file_url,
                           test_content=test.content, time_remaining=time_remaining, response=response)

@app.route('/submit_test/<int:assignment_id>', methods=['POST'])
@login_required
def submit_test(assignment_id):
    if current_user.is_admin:
        return redirect(url_for('admin_dashboard'))

    student = Student.query.filter_by(user_id=current_user.id).first()
    if not student:
        flash('Student profile not found.', 'danger')
        return redirect(url_for('student_dashboard'))

    assignment = TestAssignment.query.get_or_404(assignment_id)
    if assignment.student_id != student.id:
        flash('Access denied: This test is not assigned to you.', 'danger')
        return redirect(url_for('student_tests'))

    # Check if test is already completed
    if assignment.status == 'Completed':
        flash('This test has already been submitted.', 'warning')
        return redirect(url_for('student_tests'))

    # Check if time has expired for timed tests
    test = Test.query.get(assignment.test_id)
    if test.is_timed and assignment.start_time:
        end_time = assignment.start_time + timedelta(minutes=test.time_limit)
        if datetime.now() > end_time and assignment.status != 'Completed':
            # Time has expired, mark as completed with current content
            assignment.status = 'Completed'
            assignment.end_time = end_time  # Set end time to when it should have ended

            # Add a final response notification
            response_content = request.form.get('response_content', '')
            response = TestResponse(
                assignment_id=assignment.id,
                content=response_content,
                timestamp=datetime.now()
            )
            response.content += "\n\n[Note: This test was submitted after the time limit expired. The submission time has been recorded as the expiration time.]"

            db.session.add(response)
            db.session.commit()

            flash('Your test time had expired. The test has been automatically submitted.', 'warning')
            return redirect(url_for('student_tests'))

    is_autosave = request.form.get('autosave') == 'true'
    response_content = request.form.get('response_content', '')

    response = TestResponse(
        assignment_id=assignment.id,
        content=response_content,
        timestamp=datetime.now()
    )

    db.session.add(response)

    if not is_autosave:
        assignment.status = 'Completed'
        assignment.end_time = datetime.now()
        flash('Your test has been submitted successfully!', 'success')

    db.session.commit()

    if is_autosave:
        return jsonify({'status': 'success', 'message': 'Response auto-saved'})

    return redirect(url_for('student_tests'))

@app.route('/serve_test_file/<path:filename>')
@login_required
def serve_test_file(filename):
    return send_from_directory(UPLOAD_FOLDER, filename)

@app.route('/serve_response_file/<path:filename>')
@login_required
def serve_response_file(filename):
    if current_user.is_admin:
        return send_from_directory(UPLOAD_FOLDER, filename)
    student = Student.query.filter_by(user_id=current_user.id).first()
    if not student:
        abort(403)
    try:
        parts = filename.split('_')
        if len(parts) >= 3 and int(parts[1]) == student.id:
            return send_from_directory(UPLOAD_FOLDER, filename)
    except:
        pass
    abort(403)

@app.route('/grade_test/<int:assignment_id>', methods=['POST'])
@login_required
def grade_test(assignment_id):
    if current_user.role != 'admin':
        flash('Access denied: Admin privileges required', 'danger')
        return redirect(url_for('student_dashboard'))
    assignment = TestAssignment.query.get_or_404(assignment_id)
    score = request.form.get('score', type=float)
    assignment.score = score
    db.session.commit()
    test = Test.query.get(assignment.test_id)
    flash(f'Score saved for {assignment.student.name}.', 'success')
    return redirect(url_for('view_test', test_id=test.id))

@app.route('/view_completed_test/<int:assignment_id>')
@login_required
def view_completed_test(assignment_id):
    if current_user.is_admin:
        return redirect(url_for('admin_dashboard'))
    student = Student.query.filter_by(user_id=current_user.id).first()
    if not student:
        flash('Student profile not found.', 'danger')
        return redirect(url_for('student_dashboard'))
    assignment = TestAssignment.query.get_or_404(assignment_id)
    if assignment.student_id != student.id:
        flash('Access denied: This test is not assigned to you.', 'danger')
        return redirect(url_for('student_tests'))
    if assignment.status != 'Completed':
        flash('This test has not been completed yet.', 'warning')
        return redirect(url_for('student_tests'))
    test = Test.query.get(assignment.test_id)
    responses = TestResponse.query.filter_by(assignment_id=assignment.id).order_by(TestResponse.timestamp.desc()).all()
    return render_template('view_completed_test.html', test=test, assignment=assignment, responses=responses)

@app.route('/student_dashboard')
@login_required
def student_dashboard():
    if current_user.role != 'student':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))
    try:
        student = Student.query.filter_by(user_id=current_user.id).first()
        if not student:
            student = Student.query.filter_by(name=current_user.username).first()
            if student:
                student.user_id = current_user.id
                db.session.commit()
                flash('Your student profile has been linked to your account.', 'info')
            else:
                flash('Student profile not found. Please contact your administrator.', 'danger')
        payments = Payment.query.filter_by(student_id=student.id).all() if student else []
        announcements = Announcement.query.order_by(Announcement.date_posted.desc()).all()
        return render_template('student_dashboard.html', student=student, payments=payments, announcements=announcements)
    except Exception:
        return "Database temporarily unavailable. Try again soon!", 503

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
    user = User.query.filter_by(username=student.name, role='student').first()
    if user:
        db.session.delete(user)
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


@app.route('/add_subject', methods=['POST'])
@login_required
def add_subject():
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))
    name = request.form['name']
    description = request.form.get('description', '')
    new_subject = Subject(name=name, description=description, admin_id=current_user.id)
    db.session.add(new_subject)
    db.session.commit()
    flash('Subject added successfully!', 'success')
    return redirect(url_for('video_lectures'))

@app.route('/delete_subject/<int:subject_id>')
@login_required
def delete_subject(subject_id):
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))
    subject = Subject.query.get_or_404(subject_id)
    for chapter in subject.chapters:
        for video in chapter.videos:
            try:
                os.remove(os.path.join(app.config['VIDEO_FOLDER'], video.filename))
            except:
                flash(f'Warning: Could not delete the video file "{video.title}" from server', 'warning')
    db.session.delete(subject)
    db.session.commit()
    flash(f'Subject "{subject.name}" and all its content deleted successfully!', 'success')
    return redirect(url_for('video_lectures'))

@app.route('/add_chapter', methods=['POST'])
@login_required
def add_chapter():
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))
    subject_id = request.form['subject_id']
    name = request.form['name']
    description = request.form.get('description', '')
    new_chapter = Chapter(name=name, description=description, subject_id=subject_id)
    db.session.add(new_chapter)
    db.session.commit()
    flash('Chapter added successfully!', 'success')
    return redirect(url_for('video_lectures'))

@app.route('/delete_chapter/<int:chapter_id>')
@login_required
def delete_chapter(chapter_id):
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))
    chapter = Chapter.query.get_or_404(chapter_id)
    for video in chapter.videos:
        try:
            os.remove(os.path.join(app.config['VIDEO_FOLDER'], video.filename))
        except:
            flash(f'Warning: Could not delete the video file "{video.title}" from server', 'warning')
    db.session.delete(chapter)
    db.session.commit()
    flash(f'Chapter "{chapter.name}" and all its videos deleted successfully!', 'success')
    return redirect(url_for('video_lectures'))

@app.route('/video_lectures')
@login_required
def video_lectures():
    subjects = Subject.query.order_by(Subject.name).all()
    uncategorized_videos = VideoLecture.query.filter_by(chapter_id=None).order_by(VideoLecture.date_added.desc()).all()
    return render_template('video_lectures.html', subjects=subjects, uncategorized_videos=uncategorized_videos)


@app.route('/add_video_lecture', methods=['POST'])
@login_required
def add_video_lecture():
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))

    title = request.form['title']
    description = request.form['description']
    chapter_id = request.form.get('chapter_id')
    upload_type = request.form.get('upload_type')

    if chapter_id == "":
        chapter_id = None

    if upload_type == 'file':
        if 'video_file' not in request.files:
            flash('No file part', 'danger')
            return redirect(url_for('video_lectures'))
        file = request.files['video_file']
        if file.filename == '':
            flash('No selected file', 'danger')
            return redirect(url_for('video_lectures'))
        if file and allowed_file(file.filename, 'video'):
            filename = secure_filename(file.filename)
            unique_filename = f"{datetime.utcnow().strftime('%Y%m%d%H%M%S')}_{filename}"
            file.save(os.path.join(app.config['VIDEO_FOLDER'], unique_filename))
            new_lecture = VideoLecture(
                title=title,
                description=description,
                filename=unique_filename,
                youtube_url=None,
                admin_id=current_user.id,
                chapter_id=chapter_id
            )
        else:
            flash('Invalid file type. Only MP4, WebM, and OGG files are allowed.', 'danger')
            return redirect(url_for('video_lectures'))
    elif upload_type == 'youtube':
        youtube_url = request.form.get('youtube_url')
        if not youtube_url or not ('youtube.com' in youtube_url or 'youtu.be' in youtube_url):
            flash('Invalid YouTube URL', 'danger')
            return redirect(url_for('video_lectures'))
        new_lecture = VideoLecture(
            title=title,
            description=description,
            filename=None,
            youtube_url=youtube_url,
            admin_id=current_user.id,
            chapter_id=chapter_id
        )
    else:
        flash('Invalid upload type', 'danger')
        return redirect(url_for('video_lectures'))

    db.session.add(new_lecture)
    db.session.commit()
    flash('Video lecture added successfully!', 'success')
    return redirect(url_for('video_lectures'))

@app.route('/delete_video_lecture/<int:lecture_id>')
@login_required
def delete_video_lecture(lecture_id):
    if current_user.role != 'admin':
        flash('Unauthorized access', 'danger')
        return redirect(url_for('home'))
    lecture = VideoLecture.query.get_or_404(lecture_id)
    if lecture.filename:  # Delete local file if it exists
        try:
            os.remove(os.path.join(app.config['VIDEO_FOLDER'], lecture.filename))
        except:
            flash('Warning: Could not delete the video file from server', 'warning')
    db.session.delete(lecture)
    db.session.commit()
    flash('Video lecture deleted successfully!', 'success')
    return redirect(url_for('video_lectures'))

@app.route('/video/<filename>')
@login_required
def serve_video(filename):
    return send_from_directory(app.config['VIDEO_FOLDER'], filename)



if __name__ == '__main__':
    with app.app_context():
        db.create_all()
        print("Database initialized successfully!")
    app.run(debug=True, port=5001)