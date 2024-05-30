UPDATE Objects
SET quantity = 12,
    notes = 'Очень-очень яркая звезда'
WHERE id = 1;


CALL join_two_tables('Objects', 'NaturalObjects');
