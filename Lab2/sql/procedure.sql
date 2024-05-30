# --- ПРОЦЕДУРА ДЛЯ ВЫВОДА ДВУХ ТАБЛИЦ ---
DELIMITER //

CREATE PROCEDURE join_two_tables(IN table1 VARCHAR(255), IN table2 VARCHAR(255))
BEGIN
    SET @query = CONCAT('SELECT * FROM ', table1, ' t1 JOIN ', table2, ' t2 ON t1.id = t2.id');
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;