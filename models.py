import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from flask_login import UserMixin

# Database setup
db = SQLAlchemy()


# User model
class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(150), unique=True, nullable=False)
    password = db.Column(db.String(150), nullable=False)
    role = db.Column(db.String(50), nullable=False, default='student')
    is_admin = db.Column(db.Boolean, default=False)


# Student model
class Student(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(150), nullable=False)
    teacher_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    payments = db.relationship('Payment', backref='student', lazy=True, cascade='all, delete-orphan')
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))


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


# Subject model
class Subject(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text, nullable=True)
    date_created = db.Column(db.DateTime, default=datetime.utcnow)
    admin_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    chapters = db.relationship('Chapter', backref='subject', lazy=True, cascade='all, delete-orphan')


# Chapter model
class Chapter(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text, nullable=True)
    subject_id = db.Column(db.Integer, db.ForeignKey('subject.id'), nullable=False)
    date_created = db.Column(db.DateTime, default=datetime.utcnow)
    videos = db.relationship('VideoLecture', backref='chapter', lazy=True, cascade='all, delete-orphan')


# VideoLecture model
class VideoLecture(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200), nullable=False)
    description = db.Column(db.Text, nullable=True)
    filename = db.Column(db.String(255), nullable=True)
    youtube_url = db.Column(db.String(255), nullable=True)
    date_added = db.Column(db.DateTime, default=datetime.utcnow)
    admin_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    chapter_id = db.Column(db.Integer, db.ForeignKey('chapter.id'), nullable=True)


# Test model
class Test(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text)
    is_timed = db.Column(db.Boolean, default=False)
    time_limit = db.Column(db.Integer)
    content = db.Column(db.Text)
    file_path = db.Column(db.String(255))
    date_created = db.Column(db.DateTime, default=datetime.now)
    admin_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    assignments = db.relationship('TestAssignment', backref='test', lazy=True, cascade="all, delete-orphan")


# Test Assignment model
class TestAssignment(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    test_id = db.Column(db.Integer, db.ForeignKey('test.id'), nullable=False)
    student_id = db.Column(db.Integer, db.ForeignKey('student.id'), nullable=False)
    status = db.Column(db.String(20), default='Pending')
    date_assigned = db.Column(db.DateTime, default=datetime.now)
    start_time = db.Column(db.DateTime)
    end_time = db.Column(db.DateTime)
    score = db.Column(db.Float)
    due_date = db.Column(db.DateTime)
    responses = db.relationship('TestResponse', backref='assignment', lazy=True, cascade="all, delete-orphan")
    student = db.relationship('Student')


# Test Response model
class TestResponse(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    assignment_id = db.Column(db.Integer, db.ForeignKey('test_assignment.id'), nullable=False)
    content = db.Column(db.Text)
    file_path = db.Column(db.String(255))
    timestamp = db.Column(db.DateTime, default=datetime.now)


def init_app(app):
    db.init_app(app)

    with app.app_context():
        db.create_all()