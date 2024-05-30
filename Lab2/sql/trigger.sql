DELIMITER //

CREATE PROCEDURE add_date_update_column()
BEGIN
    DECLARE column_exists INT DEFAULT 0;

    -- Проверка наличия столбца date_update
    SELECT COUNT(*)
    INTO column_exists
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME='Objects' AND COLUMN_NAME='date_update';

    -- Добавление столбца date_update, если он отсутствует
    IF column_exists = 0 THEN
        SET @alter_query = 'ALTER TABLE Objects ADD COLUMN date_update TIMESTAMP';
        PREPARE stmt FROM @alter_query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER before_update_objects_trigger
BEFORE UPDATE ON Objects
FOR EACH ROW
BEGIN
    -- Установка значения столбца date_update текущей датой и временем
    SET NEW.date_update = NOW();
END //

DELIMITER ;
