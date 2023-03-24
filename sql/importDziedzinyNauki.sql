DELIMITER //

CREATE OR REPLACE PROCEDURE importDziedzinyNauki(in name varchar(100), in UR varchar(100))

BEGIN

    INSERT INTO dziedzinynauki VALUES (null, name, UR);
    
END//

DELIMITER ;