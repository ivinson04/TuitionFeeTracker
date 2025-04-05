CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    username VARCHAR(150) NOT NULL,
    password VARCHAR(150) NOT NULL,
    role VARCHAR(50) NOT NULL,
    is_admin BOOLEAN,
    UNIQUE (username)
);
INSERT INTO "user" VALUES (1, 'Vineet Admin', 'pbkdf2:sha256:1000000$9MCHmpCFWbmJNHV6$74e3da45a3fd4f37e19b41cabaed31ee96cc698941b63d1fc6e23ed61dc21743', 'admin', FALSE);
INSERT INTO "user" VALUES (2, 'abc', 'pbkdf2:sha256:1000000$h4MM52Ud9KAYh78I$2e70dc5142b0f31a4958ce5d5aa71238abdb063e1a7b87cca39406ff3cfdfda6', 'student', FALSE);

CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    teacher_id INTEGER NOT NULL,
    user_id INTEGER,
    FOREIGN KEY (teacher_id) REFERENCES "user" (id),
    FOREIGN KEY (user_id) REFERENCES "user" (id)
);
INSERT INTO student VALUES (1, 'abc', 1, 2);

CREATE TABLE announcement (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    content TEXT NOT NULL,
    date_posted TIMESTAMP,
    admin_id INTEGER NOT NULL,
    FOREIGN KEY (admin_id) REFERENCES "user" (id)
);

CREATE TABLE subject (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    date_created TIMESTAMP,
    admin_id INTEGER NOT NULL,
    FOREIGN KEY (admin_id) REFERENCES "user" (id)
);
INSERT INTO subject VALUES (1, 'Biology', '', '2025-04-05 07:47:30.864748', 1);

CREATE TABLE test (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    is_timed BOOLEAN,
    time_limit INTEGER,
    content TEXT,
    file_path VARCHAR(255),
    date_created TIMESTAMP,
    admin_id INTEGER NOT NULL,
    FOREIGN KEY (admin_id) REFERENCES "user" (id)
);
INSERT INTO test VALUES (1, 'Test 1', 'First Demo Test', TRUE, 1, 'Just reply with anything you see fit', NULL, '2025-04-05 13:17:21.097914', 1);

CREATE TABLE payment (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    amount FLOAT NOT NULL,
    date TIMESTAMP,
    status VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES student (id)
);

CREATE TABLE chapter (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    subject_id INTEGER NOT NULL,
    date_created TIMESTAMP,
    FOREIGN KEY (subject_id) REFERENCES subject (id)
);

CREATE TABLE test_assignment (
    id SERIAL PRIMARY KEY,
    test_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    status VARCHAR(20),
    date_assigned TIMESTAMP,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    score FLOAT,
    due_date TIMESTAMP,
    FOREIGN KEY (test_id) REFERENCES test (id),
    FOREIGN KEY (student_id) REFERENCES student (id)
);
INSERT INTO test_assignment VALUES (1, 1, 1, 'Completed', '2025-04-05 13:17:21.113987', '2025-04-05 13:18:03.658595', '2025-04-05 13:18:22.357017', 10.0, NULL);

CREATE TABLE video_lecture (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    filename VARCHAR(255),
    youtube_url VARCHAR(255),
    date_added TIMESTAMP,
    admin_id INTEGER NOT NULL,
    chapter_id INTEGER,
    FOREIGN KEY (admin_id) REFERENCES "user" (id),
    FOREIGN KEY (chapter_id) REFERENCES chapter (id)
);

CREATE TABLE test_response (
    id SERIAL PRIMARY KEY,
    assignment_id INTEGER NOT NULL,
    content TEXT,
    file_path VARCHAR(255),
    timestamp TIMESTAMP,
    FOREIGN KEY (assignment_id) REFERENCES test_assignment (id)
);
INSERT INTO test_response VALUES (1, 1, 'Yes i see the test just fine now try grading the test', NULL, '2025-04-05 13:18:22.356932');