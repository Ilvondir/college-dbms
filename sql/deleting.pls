DELIMITER //

CREATE OR REPLACE PROCEDURE deleting(IN id int)
BEGIN

    DECLARE maxID INTEGER;
    DECLARE STquery TEXT;

    SELECT MAX(IDStudenta) INTO maxID from studenci;

    DELETE FROM projekty WHERE IDStudenta=id;
    DELETE FROM zainteresowania WHERE IDStudenta=id;
    DELETE FROM studenci WHERE IDStudenta=id;

    SET FOREIGN_KEY_CHECKS=0;

    UPDATE zainteresowania SET IDStudenta=IDStudenta-1 WHERE IDStudenta>id;
    UPDATE projekty SET IDStudenta=IDStudenta-1 WHERE IDStudenta>id;
    UPDATE studenci SET IDStudenta=IDStudenta-1 WHERE IDStudenta>id;

    SET FOREIGN_KEY_CHECKS=1;

    SET STquery = CONCAT("ALTER TABLE studenci AUTO_INCREMENT=", maxID);
    PREPARE st FROM STquery;
    EXECUTE st;

END//

DELIMITER ;