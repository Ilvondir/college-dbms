DELIMITER //

CREATE OR REPLACE PROCEDURE importKierunki(IN name varchar(50))
BEGIN

    SET FOREIGN_KEY_CHECKS=0;
    INSERT INTO kierunki VALUES (null, name);
    SET FOREIGN_KEY_CHECKS=1;
    
END//

DELIMITER ;