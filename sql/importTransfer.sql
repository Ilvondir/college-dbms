DELIMITER //

CREATE OR REPLACE PROCEDURE importTransfer(IN student int, IN hobby int)

BEGIN

    SET FOREIGN_KEY_CHECKS=0;
    INSERT INTO transfer VALUES (student, hobby);
    SET FOREIGN_KEY_CHECKS=1;

END//

DELIMITER ;