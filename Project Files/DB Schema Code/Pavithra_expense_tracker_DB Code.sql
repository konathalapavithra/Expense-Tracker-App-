 Drop database if it already exists
DROP DATABASE IF EXISTS expense_tracker
Create a new database
CREATE DATABASE expense_tracker;
-- Use the database
USE expense_tracker;
-- Create Users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100),
    password VARCHAR(255) NOT NULL
);

--  Create Categories table
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    type ENUM('income', 'expense') NOT NULL
);

-- Create Transactions table
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    category_id INT,
    amount DECIMAL(10,2) NOT NULL,
    transaction_date DATE,
    note VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Create Budgets table
CREATE TABLE budgets (
    budget_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    category_id INT,
    amount DECIMAL(10,2),
    month VARCHAR(15),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Create Reminders table
CREATE TABLE reminders (
    reminder_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    title VARCHAR(100),
    due_date DATE,
    status ENUM('pending', 'paid') DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

--  Insert sample data into users
INSERT INTO users (username, email, password) VALUES 
('pavitra', 'pavitra@email.com', 'pass123'),
('john', 'john@email.com', 'john456'),
('ram', 'ram@email.com', 'ram789'),
('sita', 'sita@email.com', 'sita123'),
('kiran', 'kiran@email.com', 'kiran987');

-- Insert sample data into categories
INSERT INTO categories (name, type) VALUES 
('Salary', 'income'),
('Freelance', 'income'),
('Groceries', 'expense'),
('Rent', 'expense'),
('Entertainment', 'expense');

-- Insert sample data into transactions
INSERT INTO transactions (user_id, category_id, amount, transaction_date, note) VALUES 
(1, 1, 50000, '2025-07-01', 'Monthly salary'),
(1, 3, 2500, '2025-07-02', 'Groceries shopping'),
(2, 4, 8000, '2025-07-03', 'Paid rent'),
(3, 2, 10000, '2025-07-04', 'Freelance project'),
(4, 5, 1200, '2025-07-05', 'Movie night');

--  Insert sample data into budgets
INSERT INTO budgets (user_id, category_id, amount, month) VALUES 
(1, 3, 3000, 'July'),
(1, 4, 8000, 'July'),
(2, 5, 2000, 'July'),
(3, 3, 2500, 'July'),
(4, 5, 1500, 'July');

-- Insert sample data into reminders
INSERT INTO reminders (user_id, title, due_date, status) VALUES 
(1, 'Pay electricity bill', '2025-07-10', 'pending'),
(2, 'Recharge mobile', '2025-07-11', 'paid'),
(3, 'Pay water bill', '2025-07-15', 'pending'),
(4, 'Pay Wi-Fi bill', '2025-07-18', 'pending'),
(5, 'Pay credit card', '2025-07-20', 'paid');
INSERT INTO transactions (user_id, category_id, amount, transaction_date, note)
VALUES (1, 3, 1800, '2025-07-06', 'Snacks and supplies');
-- Update July budget for user_id=1 and category_id=3 (Groceries) to ₹3500
UPDATE budgets
SET amount = 3500
WHERE user_id = 1 AND category_id = 3;
-- Delete reminder with reminder_id=5 (e.g., Pay credit card)
DELETE FROM reminders
WHERE reminder_id = 5;
-- Show total amount spent by each user (only 'expense' type categories)
SELECT 
    u.username,
    SUM(t.amount) AS total_expense
FROM transactions t
JOIN users u ON t.user_id = u.user_id
JOIN categories c ON t.category_id = c.category_id
WHERE c.type = 'expense'
GROUP BY u.username;
-- Get all reminders, sorted by the earliest due date
SELECT * FROM reminders
ORDER BY due_date ASC;
-- Show all budgets that are set for the month of July
SELECT * FROM budgets
WHERE month = 'July';
-- List all transactions where the amount is greater than ₹5000
SELECT * FROM transactions
WHERE amount > 5000;
-- Find users whose total spending is more than ₹8000
SELECT username FROM users
WHERE user_id IN (
    SELECT user_id FROM transactions
    GROUP BY user_id
    HAVING SUM(amount) > 8000
);
-- Get the category that has the highest total amount of transactions
SELECT name, total
FROM (
    SELECT c.name, SUM(t.amount) AS total
    FROM transactions t
    JOIN categories c ON t.category_id = c.category_id
    GROUP BY c.name
) AS totals
ORDER BY total DESC
LIMIT 1;



USE expense_tracker;
SELECT * FROM users;
SELECT * FROM categories;
SELECT * FROM transactions;
SELECT * FROM budgets;
SELECT * FROM reminders;
--  INSERT a new transaction record
INSERT INTO transactions (user_id, category_id, amount, transaction_date, note)
VALUES (1, 3, 1800, '2025-07-06', 'Snacks and supplies');

--  UPDATE budget for user_id=1 and category_id=3 (Groceries)
UPDATE budgets
SET amount = 3500
WHERE user_id = 1 AND category_id = 3;

--  DELETE a reminder with reminder_id = 5
DELETE FROM reminders
WHERE reminder_id = 5;
--  Show transactions with username and category name
SELECT 
    t.transaction_id,
    u.username,
    c.name AS category,
    t.amount,
    t.transaction_date,
    t.note
FROM transactions t
JOIN users u ON t.user_id = u.user_id
JOIN categories c ON t.category_id = c.category_id;
--  Show total expenses by each user
SELECT 
    u.username,
    SUM(t.amount) AS total_expense
FROM transactions t
JOIN users u ON t.user_id = u.user_id
JOIN categories c ON t.category_id = c.category_id
WHERE c.type = 'expense'
GROUP BY u.username;
-- List all reminders sorted by due date (ascending)
SELECT * FROM reminders
ORDER BY due_date ASC;

-- Show budgets set for July
SELECT * FROM budgets
WHERE month = 'July';
-- Show all transactions where amount is greater than ₹5000
SELECT * FROM transactions
WHERE amount > 5000;
--  Show users who spent more than ₹8000 in total
SELECT username FROM users
WHERE user_id IN (
    SELECT user_id FROM transactions
    GROUP BY user_id
    HAVING SUM(amount) > 8000
);
--  Show category with highest total spending
SELECT name, total
FROM (
    SELECT c.name, SUM(t.amount) AS total
    FROM transactions t
    JOIN categories c ON t.category_id = c.category_id
    GROUP BY c.name
) AS totals
ORDER BY total DESC
LIMIT 1;
