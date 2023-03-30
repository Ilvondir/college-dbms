DELIMITER //

CREATE OR REPLACE PROCEDURE importStudenci(IN name varchar(50),
                                           IN surname varchar(50),
                                           IN album int(6),
                                           IN way int,
                                           IN mean decimal(3,2))
BEGIN

    SET FOREIGN_KEY_CHECKS=0;
    INSERT INTO studenci VALUES (null, name, surname, album, way, mean);
    SET FOREIGN_KEY_CHECKS=0;
    
END//

DELIMITER ;