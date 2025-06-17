CREATE TABLE Books (
	id INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	author VARCHAR(255) NOT NULL,
	publisher VARCHAR(255) NOT NULL,
	isbn VARCHAR(255) NOT NULL,
	publication_year YEAR NOT NULL,
	genre VARCHAR(255) NOT NULL,
	available TINYINT(1) NOT NULL DEFAULT 1,
	price DECIMAL(10,2) NOT NULL
);

INSERT INTO Books (title, author, publisher, isbn, publication_year, genre, available, price)
VALUES ('Wonder 5', 'R.J. Palacio', 'Penguin', '0375869026', 2012, 'fiction', 1, 7.35);

INSERT INTO Books (title, author, publisher, isbn, publication_year, genre, available, price)
VALUES ('Driving Forwards 5', 'Sophie L Morgan', 'Little, Brown Book Group', '9780751582222', 2023, 'non fiction', 20, 5.00);

SHOW CREATE TABLE Books;

SELECT * FROM Books;

CREATE TABLE Members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    register_date DATE NOT NULL
);

SELECT * FROM Members;

INSERT INTO Members (first_name, last_name, address, phone, email, register_date)
VALUES
    ('Lauren', "O'Brien", '1 Road', '001122334455', "lauren.o'brien@kainos.com", '2025-06-16'),
    ('Dane', 'Westley', '2 Road', '667788991010', 'dane.westley@kainos.com', '2025-06-16');

CREATE TABLE Loans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    loan_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(id),
    FOREIGN KEY (book_id) REFERENCES Books(id)
);

SELECT * FROM Loans;

INSERT INTO Books (title, author, publisher, isbn, publication_year, genre, available, price)
VALUES ('Hitting Against the Spin', 'Ben Jones', 'Little, Brown Book Group', '9781472131263', 2022, 'sport', 50, 12.99);

INSERT INTO Loans (member_id, book_id, loan_date)
VALUES
    (1, 1, '2025-06-16'),
    (1, 3, '2025-06-16'),
    (2, 2, '2025-06-16'),
    (2, 3, '2025-06-16');

USE Library_Test_RebeccaC;

SELECT a.first_name, a.last_name, GROUP_CONCAT(b.title) as Books FROM Members a
JOIN Loans l ON a.id = l.member_id
JOIN Books b ON l.book_id = b.id
GROUP BY a.id;

SELECT a.first_name, a.last_name, GROUP_CONCAT(b.title) as Books FROM Members a
JOIN Loans l ON a.id = l.member_id
JOIN Books b ON l.book_id = b.id
WHERE l.return_date is NULL
GROUP BY a.id;

SELECT b.publisher, COUNT(*) as total_loans FROM Loans l
JOIN Books b ON l.book_id = b.id
WHERE year(l.loan_date) = year(curdate())
GROUP BY b.publisher
ORDER BY total_loans DESC
LIMIT 1;

UPDATE Books
SET price = price*0.8
WHERE year(curdate()) - publication_year > 5;

UPDATE Members
SET first_name = UPPER(first_name);

UPDATE Members
SET first_name = CONCAT(UPPER(LEFT(first_name, 1)), LOWER(SUBSTRING(first_name, 2)));

DELETE FROM Loans
WHERE datediff(return_date, loan_date) > 30;

CREATE INDEX idx_genre_author_publisher ON Books (genre, author, publisher);

CREATE UNIQUE INDEX idx_email_unique ON Members (email);

