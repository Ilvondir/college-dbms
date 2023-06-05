DELIMITER //

CREATE OR REPLACE PROCEDURE importProjekty(IN name varchar(100), IN mark decimal(2,1))

BEGIN

    DECLARE idToInsert INTEGER;
    SET idToInsert = (SELECT MAX(IDStudenta) FROM projekty);
    SET idToInsert = idToInsert+1;

    SET FOREIGN_KEY_CHECKS=0;
    INSERT INTO projekty VALUES (idToInsert, name, mark);
    SET FOREIGN_KEY_CHECKS=1;
    
END//

DELIMITER ;