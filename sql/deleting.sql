DELIMITER //

CREATE OR REPLACE PROCEDURE deleting(IN id int)
BEGIN

    DELETE FROM projekty WHERE IDStudenta=id;
    DELETE FROM transfer WHERE IDStudenta=id;
    DELETE FROM studenci WHERE IDStudenta=id;

    SET FOREIGN_KEY_CHECKS=0;

    UPDATE transfer SET IDStudenta=IDStudenta-1 WHERE IDStudenta>id;
    UPDATE projekty SET IDStudenta=IDStudenta-1 WHERE IDStudenta>id;
    UPDATE studenci SET IDStudenta=IDStudenta-1 WHERE IDStudenta>id;

    SET FOREIGN_KEY_CHECKS=1;

    SET @maxID = (SELECT MAX(IDStudenta)+1 FROM studenci);
    SET @sql = CONCAT('ALTER TABLE studenci AUTO_INCREMENT=', @max_id);
    PREPARE st FROM @sql;
    EXECUTE st;

END//

DELIMITER ;