DELIMITER //

CREATE OR REPLACE PROCEDURE importZainteresowania(IN name varchar(50))
BEGIN

    DECLARE idToInsert INTEGER;
    SET idToInsert = (SELECT MAX(IDStudenta) FROM zainteresowania);
    SET idToInsert = idToInsert+1;

    SET FOREIGN_KEY_CHECKS=0;
    INSERT INTO zainteresowania VALUES (idToInsert, name);
    SET FOREIGN_KEY_CHECKS=1;
    
END//

DELIMITER ;