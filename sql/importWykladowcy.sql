DELIMITER //

CREATE OR REPLACE PROCEDURE importWykladowcy(IN name varchar(50),
                                             IN surname varchar(50),
                                             IN money decimal(7,2),
                                             IN date date,
                                             IN domain int)
BEGIN

    INSERT INTO wykladowcy VALUES (null, name, surname, money, date, domain);
    
END//

DELIMITER ;