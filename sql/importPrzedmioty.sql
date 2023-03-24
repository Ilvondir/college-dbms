DELIMITER //

CREATE OR REPLACE PROCEDURE importPrzedmioty(IN name varchar(100), IN domain int)
BEGIN

    INSERT INTO przedmioty VALUES (null, name, domain);
    
END//

DELIMITER ;