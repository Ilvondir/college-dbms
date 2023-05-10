DELIMITER //

CREATE OR REPLACE PROCEDURE getUzytkownicy()
BEGIN

    SELECT login, password FROM uzytkownicy;

END//

DELIMITER ;