-- Amanda Overbye
-- Part 1

CREATE TRIGGER egg_filler
AFTER INSERT ON Bird_eggs
FOR EACH ROW
WHEN NEW.Egg_num IS NULL
BEGIN
    UPDATE Bird_eggs
    SET Egg_num = (
        SELECT IFNULL(MAX(Egg_num), 0) + 1
        FROM Bird_eggs
        WHERE Nest_ID = NEW.Nest_ID
    )
    WHERE rowid = last_insert_rowid();
END;

-- Part 2

CREATE TRIGGER egg_filler
AFTER INSERT ON Bird_eggs
FOR EACH ROW
BEGIN
    UPDATE Bird_eggs
    SET
        Egg_num = (
            SELECT IFNULL(MAX(Egg_num), 0) + 1
            FROM Bird_eggs
            WHERE Nest_ID = NEW.Nest_ID
        ),
        Book_page = (
            SELECT Book_page 
            FROM Bird_nests 
            WHERE Nest_ID = NEW.Nest_ID
        ),
        Year = (
            SELECT Year 
            FROM Bird_nests 
            WHERE Nest_ID = NEW.Nest_ID
        ),
        Site = (
            SELECT Site 
            FROM Bird_nests 
            WHERE Nest_ID = NEW.Nest_ID
        )
    WHERE rowid = last_insert_rowid();
END;