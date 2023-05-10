DELIMITER //

CREATE OR REPLACE PROCEDURE getUzytkownicy(IN login varchar(255), IN password varchar(255))
BEGIN

    INSERT INTO uzytkownicy VALUES (null, login, SHA2(password, 256));

END//

DELIMITER ;