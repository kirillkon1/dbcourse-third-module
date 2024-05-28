CREATE DATABASE IF NOT EXISTS db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE db;

-- Создание таблицы Individuals
CREATE TABLE IF NOT EXISTS Individuals (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(32) NOT NULL,
    last_name VARCHAR(32) NOT NULL,
    middle_name VARCHAR(32),
    passport VARCHAR(10) NOT NULL,
    inn VARCHAR(12) NOT NULL,
    snils VARCHAR(11) NOT NULL,
    driver_license VARCHAR(30) NOT NULL,
    additional_documents VARCHAR(255),
    notes VARCHAR(255)
);

-- Вставка данных в таблицу Individuals
INSERT INTO Individuals (first_name, last_name, middle_name, passport, inn, snils, driver_license, additional_documents, notes) VALUES
('Иван', 'Иванов', 'Иванович', '1234567890', '123456789012', '12345678901', 'AB1234567', 'Документ 1', 'Заметка об Иване'),
('Кирилл', 'Кондрашов', 'Юрьевич', '0987654321', '210987654321', '10987654321', 'XY9876543', 'Документ 2', 'Заметка о Кирилле'),
('Алексей', 'Сидоров', 'Алексеевич', '1122334455', '332211445566', '11223344556', 'CD1122334', 'Документ 3', 'Заметка об Алексее'),
('Ольга', 'Кузнецова', 'Сергеевна', '5566778899', '556677889900', '55667788901', 'EF5566778', 'Документ 4', 'Заметка об Ольге'),
('Дмитрий', 'Морозов', 'Викторович', '6677889900', '667788990011', '66778899001', 'GH6677889', 'Документ 5', 'Заметка о Дмитрии');

-- Создание таблицы Borrowers
CREATE TABLE IF NOT EXISTS Borrowers (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    INN VARCHAR(12) NOT NULL,
    is_individual BOOLEAN NOT NULL,
    address TEXT NOT NULL,
    sum INT NOT NULL,
    conditions TEXT NOT NULL,
    notes TEXT,
    contracts TEXT
);

-- Вставка данных в таблицу Borrowers
INSERT INTO Borrowers (INN, is_individual, address, sum, conditions, notes, contracts) VALUES
('123456789012', TRUE, '123 Main St', 10000, 'Good conditions', 'No notes', 'Contract text 1'),
('210987654321', FALSE, '456 Elm St', 20000, 'Better conditions', 'Some notes', 'Contract text 2');

-- Создание таблицы Loans
CREATE TABLE IF NOT EXISTS Loans (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    individual_id INT NOT NULL,
    amount INT NOT NULL,
    interest_rate FLOAT NOT NULL,
    term TIMESTAMP NOT NULL,
    conditions VARCHAR(255) NOT NULL,
    notes VARCHAR(255),
    FOREIGN KEY (individual_id) REFERENCES Individuals(Id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Вставка данных в таблицу Loans
INSERT INTO Loans (individual_id, amount, interest_rate, term, conditions, notes) VALUES
(1, 5000, 5.5, '2023-05-01 00:00:00', 'Standard conditions', 'Loan notes 1'),
(2, 10000, 4.2, '2023-06-01 00:00:00', 'Special conditions', 'Loan notes 2');

-- Создание таблицы OrganizationLoans
CREATE TABLE IF NOT EXISTS OrganizationLoans (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    organization_id INT NOT NULL,
    individual_id INT NOT NULL,
    amount INT NOT NULL,
    term TIMESTAMP NOT NULL,
    interest_rate FLOAT NOT NULL,
    conditions VARCHAR(255) NOT NULL,
    notes VARCHAR(255),
    borrower_id INT NOT NULL,
    FOREIGN KEY (individual_id) REFERENCES Individuals(Id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (borrower_id) REFERENCES Borrowers(Id)
);

-- Вставка данных в таблицу OrganizationLoans
INSERT INTO OrganizationLoans (organization_id, individual_id, amount, term, interest_rate, conditions, notes, borrower_id) VALUES
(1, 1, 15000, '2023-07-01 00:00:00', 3.5, 'Business conditions', 'Organization loan notes 1', 1),
(2, 2, 25000, '2023-08-01 00:00:00', 3.8, 'Corporate conditions', 'Organization loan notes 2', 2);

COMMIT;
