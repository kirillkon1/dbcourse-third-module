UPDATE Objects
SET quantity = 12,
    notes = 'Очень яркая звезда, количество обновлено'
WHERE id = 1;


CALL join_two_tables('Objects', 'NaturalObjects');
