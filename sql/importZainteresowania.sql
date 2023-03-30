DELIMITER //

CREATE OR REPLACE PROCEDURE importZainteresowania(IN id varchar(50), IN name varchar(50))
BEGIN

    SET FOREIGN_KEY_CHECKS=0;
    INSERT INTO zainteresowania VALUES (id, name);
    SET FOREIGN_KEY_CHECKS=1;
    
END//

DELIMITER ;