DELIMITER //

CREATE OR REPLACE PROCEDURE importProjekty(IN id int, IN name varchar(100), IN mark decimal(2,1))

BEGIN

    SET FOREIGN_KEY_CHECKS=0;
    INSERT INTO projekty VALUES (id, name, mark);
    SET FOREIGN_KEY_CHECKS=1;
    
END//

DELIMITER ;