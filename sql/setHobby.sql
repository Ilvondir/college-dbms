DELIMITER //

CREATE OR REPLACE PROCEDURE setHobby(IN hobby varchar(100), IN id int(6))
BEGIN

    DECLARE HobbyID INTEGER;
    
    SET HobbyID = (SELECT IDPrzedmiotu FROM przedmioty WHERE Nazwa=hobby);

    INSERT INTO transfer VALUES (id, HobbyID);

END//

DELIMITER ;