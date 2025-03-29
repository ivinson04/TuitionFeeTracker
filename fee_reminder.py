from datetime import datetime, timedelta
from flask import flash
from flask_login import current_user
from sqlalchemy import extract
from models import Payment, Student, db
import calendar


def calculate_next_due_date(payment_date):
    """Calculate the next payment due date (1 month after last payment)"""
    # Get year and month from the payment date
    year = payment_date.year
    month = payment_date.month
    day = payment_date.day

    # Calculate the next month (handling year transition)
    if month == 12:
        next_month = 1
        next_year = year + 1
    else:
        next_month = month + 1
        next_year = year

    # Handle cases like Jan 31 -> Feb 28/29
    last_day_of_next_month = calendar.monthrange(next_year, next_month)[1]
    next_day = min(day, last_day_of_next_month)

    return datetime(next_year, next_month, next_day)


def check_pending_fees():
    """Check if the current user has pending fees and flash appropriate messages"""
    if not current_user.is_authenticated or current_user.is_admin:
        return

    # Get the student object
    student = Student.query.filter_by(id=current_user.id).first()
    if not student:
        return

    # Get the most recent approved payment
    latest_payment = Payment.query.filter_by(
        student_id=student.id,
        status="Approved"
    ).order_by(Payment.date.desc()).first()

    if not latest_payment:
        flash("You don't have any payment history yet. Please make your first payment.", "warning")
        return

    # Calculate next payment due date
    next_due_date = calculate_next_due_date(latest_payment.date)
    today = datetime.now()

    # Check if there's a pending payment request for the current month
    current_month = today.month
    current_year = today.year
    has_pending_request = Payment.query.filter(
        Payment.student_id == student.id,
        Payment.status.in_(["Pending", "Approved"]),
        extract('month', Payment.date) == current_month,
        extract('year', Payment.date) == current_year
    ).first() is not None

    # Calculate days until payment is due
    days_until_due = (next_due_date - today).days

    # If payment is due in 2 days or less and no pending request
    if days_until_due <= 2 and days_until_due >= 0 and not has_pending_request:
        if days_until_due == 0:
            flash(
                f"Your monthly fee payment is due today ({next_due_date.strftime('%d %B')}). Please make a payment request.",
                "danger")
        else:
            flash(
                f"Your monthly fee payment is due in {days_until_due} days ({next_due_date.strftime('%d %B')}). Please make a payment request.",
                "warning")

    # If payment is overdue and no pending request
    elif days_until_due < 0 and not has_pending_request:
        days_overdue = abs(days_until_due)
        flash(f"Your monthly fee payment is {days_overdue} days overdue. Please make a payment request immediately.",
              "danger")