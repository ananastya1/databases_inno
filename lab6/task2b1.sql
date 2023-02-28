SELECT s.school_name, b.publisher, COUNT(l.book_id) AS num_books_loaned
FROM schools s
JOIN teachers t ON s.school_id = t.school_id
JOIN courses c ON t.teacher_id = c.course_id
JOIN classrooms cl ON c.course_id = cl.room_id
JOIN grades g ON cl.school_id = g.grade_id
JOIN loans l ON g.grade_id = l.grade_id
JOIN books b ON l.book_id = b.book_id
GROUP BY s.school_name, b.publisher;