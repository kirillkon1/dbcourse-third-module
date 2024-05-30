CREATE DATABASE IF NOT EXISTS db;
USE db;

CREATE TABLE IF NOT EXISTS Objects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(255),
    accuracy FLOAT,
    quantity INT,
    time TIMESTAMP,
    date DATE,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS NaturalObjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(255),
    galaxy VARCHAR(255),
    accuracy FLOAT,
    light_flow FLOAT,
    associated_objects VARCHAR(255),
    notes TEXT
);

CREATE TABLE IF NOT EXISTS Sector (
    id INT AUTO_INCREMENT PRIMARY KEY,
    coordinates VARCHAR(255),
    light_intensity FLOAT,
    foreign_object INT,
    star_objects_count INT,
    unknown_object_count INT,
    defined_object_count INT,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS Positions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    earth_pos VARCHAR(255),
    sun_pos VARCHAR(255),
    moon_pos VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Connection (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sector_id INT NOT NULL,
    object_id INT NOT NULL,
    narural_id INT NOT NULL,
    position_id INT NOT NULL,
    FOREIGN KEY (sector_id) REFERENCES Sector(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (object_id) REFERENCES Objects(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (narural_id) REFERENCES NaturalObjects(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (position_id) REFERENCES Positions(id) ON DELETE CASCADE ON UPDATE CASCADE
);



-- Заполнение таблицы Objects
INSERT INTO Objects (type, accuracy, quantity, time, date, notes) VALUES
('Звезда', 99.5, 10, NOW(), '2024-05-30', 'Очень яркая звезда'),
('Планета', 95.0, 5, NOW(), '2024-05-29', 'Большая планета'),
('Комета', 80.5, 2, NOW(), '2024-05-28', 'Быстрая комета');

-- Заполнение таблицы NaturalObjects
INSERT INTO NaturalObjects (type, galaxy, accuracy, light_flow, associated_objects, notes) VALUES
('Звезда', 'Млечный Путь', 99.5, 1200.5, 'Планета, Комета', 'Яркая звезда в галактике Млечный Путь'),
('Планета', 'Андромеда', 90.0, 300.0, 'Комета', 'Планета в галактике Андромеда'),
('Комета', 'Млечный Путь', 75.0, 50.5, 'Звезда', 'Комета в галактике Млечный Путь');

-- Заполнение таблицы Sector
INSERT INTO Sector (coordinates, light_intensity, foreign_object, star_objects_count, unknown_object_count, defined_object_count, notes) VALUES
('15.6, -25.4', 500.0, 3, 10, 2, 8, 'Сектор с высокой светимостью'),
('10.1, 45.3', 200.0, 1, 5, 1, 4, 'Сектор с умеренной светимостью'),
('20.2, -10.8', 300.0, 0, 7, 0, 7, 'Сектор с низкой светимостью');

-- Заполнение таблицы Positions
INSERT INTO Positions (earth_pos, sun_pos, moon_pos) VALUES
('30.5, 45.2', '100.3, 200.6', '50.1, 75.3'),
('35.1, 50.4', '105.5, 205.8', '55.2, 80.6'),
('40.6, 55.7', '110.7, 210.9', '60.3, 85.9');

-- Заполнение таблицы Connection
INSERT INTO Connection (sector_id, object_id, narural_id, position_id) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3);


