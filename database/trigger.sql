.schema
.tables
SELECT * FROM Species;
.nullvalue -NULL-

INSERT INTO Species VALUES ('abcd', 'thing1', 'Study species');
SELECT * FROM Species;

CREATE TRIGGER Fix_up_species
AFTER INSERT ON Species 
FOR EACH ROW 
BEGIN
UPDATE Species
SET Scientific_name = NULL
WHERE CODE = new.Code AND Scientific_name = '';
END;


INSERT INTO Species
VALUES ('efgh', 'thing2', '', 'Study species');


    




