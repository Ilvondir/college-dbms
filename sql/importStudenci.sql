DELIMITER //

CREATE OR REPLACE PROCEDURE importStudenci(IN name varchar(50),
                                           IN surname varchar(50),
                                           IN album int(6),
                                           IN way varchar(100),
                                           IN mean decimal(3,2))
BEGIN

    INSERT INTO studenci VALUES (null, name, surname, album, way, mean);
    
END//

DELIMITER ;