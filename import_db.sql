PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies; 
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);


CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    users_id INTEGER NOT NULL,

    FOREIGN KEY (users_id) REFERENCES users(id)
);


CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL,
    questions_id INTEGER,

    FOREIGN KEY (users_id) REFERENCES users(id),
    FOREIGN KEY (questions_id) REFERENCES questions(id)
);


CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    parent_id INTEGER,
    users_id INTEGER NOT NULL,
    questions_id INTEGER NOT NULL,

    FOREIGN KEY (users_id) REFERENCES users(id),
    FOREIGN KEY (parent_id) REFERENCES replies(id)
    -- FOREIGN KEY (questions_id) REFERENCES questions(id)
);


CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL,
    questions_id INTEGER NOT NULL,

    FOREIGN KEY (questions_id) REFERENCES questions(id)
);


INSERT INTO
    users (fname, lname)

VALUES
    ('Jay', 'Reddy'),
    ('Derek', 'Li'),
    ('Taylor', 'Name'),
    ('Bob', 'Bobby');

INSERT INTO
    questions (title, body, users_id)

VALUES 
    ('Environment Setup', 'How do I setup my environment?', (SELECT id FROM users WHERE fname = 'Jay')),
    ('Creating Classes in Ruby', 'How do I create a class?', (SELECT id FROM users WHERE fname = 'Derek')),
    ('NULL Subject', 'What is NULL?', (SELECT id FROM users WHERE fname = 'Jay'));

INSERT INTO
    question_follows (users_id, questions_id)

VALUES 
    ((SELECT users.id FROM users WHERE users.fname = 'Jay'), (SELECT questions.id FROM questions WHERE questions.title LIKE 'Environment%')),
    ((SELECT users.id FROM users WHERE users.fname = 'Jay'), (SELECT questions.id FROM questions WHERE questions.title LIKE 'Creat%')),
    ((SELECT users.id FROM users WHERE users.fname = 'Taylor'), (SELECT questions.id FROM questions WHERE questions.title LIKE 'Environment%')),
    ((SELECT users.id FROM users WHERE users.fname = 'Derek'), (SELECT questions.id FROM questions WHERE questions.title LIKE 'Environment%')),
    ((SELECT users.id FROM users WHERE users.fname = 'Derek'), (SELECT questions.id FROM questions WHERE questions.title LIKE 'Creat%')),
    ((SELECT users.id FROM users WHERE users.fname = 'Jay'), (SELECT questions.id FROM questions WHERE questions.title LIKE '%NULL%')),
    ((SELECT users.id FROM users WHERE users.fname = 'Derek'), (SELECT questions.id FROM questions WHERE questions.title LIKE '%NULL%')),
    ((SELECT users.id FROM users WHERE users.fname = 'Taylor'), (SELECT questions.id FROM questions WHERE questions.title LIKE '%NULL%')),
    ((SELECT users.id FROM users WHERE users.fname = 'Bob'), (SELECT questions.id FROM questions WHERE questions.title LIKE '%NULL%'));

INSERT INTO
    replies (body, parent_id, users_id, questions_id)

VALUES  
    ("Download ubuntu", NULL,
    (SELECT users.id FROM users WHERE users.fname = 'Jay'), (SELECT questions.id FROM questions WHERE questions.title LIKE 'Environment%')),
    ("class Class at the top", 1,
    (SELECT users.id FROM users WHERE users.fname = 'Jay'), (SELECT questions.id FROM questions WHERE questions.title LIKE 'Environment%')),
    ("Nice", 2,
    (SELECT users.id FROM users WHERE users.fname = 'Jay'), (SELECT questions.id FROM questions WHERE questions.title LIKE 'Environment%'));
    

INSERT INTO
    question_likes (users_id, questions_id)

VALUES 
    ((SELECT users.id FROM users WHERE users.fname = 'Jay'), (SELECT questions.id FROM questions WHERE questions.title LIKE 'Environment%')),
    ((SELECT users.id FROM users WHERE users.fname = 'Derek'), (SELECT questions.id FROM questions WHERE questions.title LIKE 'Creating%'));

