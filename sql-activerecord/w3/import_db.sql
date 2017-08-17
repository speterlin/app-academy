DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_follow;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
  );

CREATE TABLE question_follow (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body VARCHAR(255) NOT NULL,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (author_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('frank', 'thomas'),
  ('bob', 'smith'),
  ('joe', 'smoe');

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('integers', 'what are integers', (SELECT id FROM users WHERE fname = 'frank' AND lname = 'thomas')),
  ('floats', 'what are floats', (SELECT id FROM users WHERE fname = 'frank' AND lname = 'thomas')),
  ('fixnum', 'what are fixnums', (SELECT id FROM users WHERE fname = 'bob' AND lname = 'smith'));

INSERT INTO
  replies(body, question_id, parent_id, author_id)
VALUES
  ('they are whole numbers', 1, NULL, (SELECT id FROM users WHERE fname = 'frank' AND lname = 'thomas')),
  ('they are not floats', 1, 1, (SELECT id FROM users WHERE fname = 'frank' AND lname = 'thomas'));

INSERT INTO
  question_follow(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'bob' AND lname = 'smith'),1),
  ((SELECT id FROM users WHERE fname = 'frank' AND lname = 'thomas'),1),
  ((SELECT id FROM users WHERE fname = 'frank' AND lname = 'thomas'),2);

INSERT INTO
  question_likes(question_id, user_id)
VALUES
  (1, 1),
  (1, 2),
  (3,1),
  (3,2),
  (3,3);
