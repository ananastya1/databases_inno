CREATE TABLE schools (
  school_id SERIAL PRIMARY KEY,
  school_name VARCHAR(50)
);

CREATE TABLE teachers (
  teacher_id SERIAL PRIMARY KEY,
  teacher_name VARCHAR(30),
  school_id INT REFERENCES schools(school_id)
);

CREATE TABLE courses (
  course_id SERIAL PRIMARY KEY,
  course_name VARCHAR(40)
);

CREATE TABLE classrooms (
  room_id SERIAL PRIMARY KEY,
  room_name VARCHAR(10),
  school_id INT REFERENCES schools(school_id)
);

CREATE TABLE grades (
  grade_id SERIAL PRIMARY KEY,
  grade_name VARCHAR(15)
);

CREATE TABLE books (
  book_id SERIAL PRIMARY KEY,
  book_name VARCHAR(100),
  publisher VARCHAR(50)
);

CREATE TABLE loans (
  loan_id SERIAL PRIMARY KEY,
  book_id INT REFERENCES books(book_id),
  teacher_id INT REFERENCES teachers(teacher_id),
  course_id INT REFERENCES courses(course_id),
  room_id INT REFERENCES classrooms(room_id),
  grade_id INT REFERENCES grades(grade_id),
  loan_date DATE
);

-- insert schools
INSERT INTO schools (school_name) VALUES
  ('Horizon Education Institute'),
  ('Bright Institution');

-- insert teachers
INSERT INTO teachers (teacher_name, school_id) VALUES
  ('Chad Russell', 1),
  ('E.F.Codd', 1),
  ('Jones Smith', 1),
  ('Adam Baker', 2);

-- insert courses
INSERT INTO courses (course_name) VALUES
  ('Logical Thinking'),
  ('Writing'),
  ('Numerical thinking'),
  ('Spatial, Temporal and Causal Thinking'),
  ('English');

-- insert classrooms
INSERT INTO classrooms (room_name, school_id) VALUES
  ('1.A01', 1),
  ('1.B01', 1),
  ('2.B01', 2);

-- insert grades
INSERT INTO grades (grade_name) VALUES
  ('1st grade'),
  ('2nd grade');

-- insert books
INSERT INTO books (book_name, publisher) VALUES
  ('Learning and teaching in early childhood education', 'BOA Editions'),
  ('Preschool, N56', 'Taylor & Francis Publishing'),
  ('Early Childhood Education N9', 'Prentice Hall'),
  ('Know how to educate: guide for Parents and Teachers', 'McGraw Hill');

-- insert loans
INSERT INTO loans (book_id, teacher_id, course_id, room_id, grade_id, loan_date) VALUES
  (1, 1, 1, 1, 1, '2010-09-09'),
  (2, 1, 2, 1, 1, '2010-05-05'),
  (1, 1, 3, 1, 1, '2010-05-05'),
  (3, 2, 4, 2, 1, '2010-05-06'),
  (1, 2, 3, 2, 1, '2010-05-06'),
  (1, 3, 2, 1, 2, '2010-09-09'),
  (4, 3, 5, 1, 2, '2010-05-05'),
  (1, 4, 1, 3, 1, '2010-12-18'),
  (3, 4, 3, 3, 1, '2010-05-06');
