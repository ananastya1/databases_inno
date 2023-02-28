SELECT s.school_name, b.book_name, t.teacher_name, MAX(l.loan_date) AS loan_date
FROM schools s
JOIN teachers t ON s.school_id = t.school_id
JOIN loans l ON t.teacher_id = l.teacher_id
JOIN books b ON l.book_id = b.book_id
JOIN (
  SELECT s.school_id, MAX(l.loan_date) AS max_loan_date
  FROM schools s
  JOIN teachers t ON s.school_id = t.school_id
  JOIN loans l ON t.teacher_id = l.teacher_id
  GROUP BY s.school_id
) AS subquery
ON s.school_id = subquery.school_id AND l.loan_date = subquery.max_loan_date
GROUP BY s.school_name, b.book_name, t.teacher_name;
