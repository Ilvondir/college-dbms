DELIMITER //

CREATE OR REPLACE PROCEDURE setHobby(IN hobby varchar(100), IN album int(6))
BEGIN
    
    DECLARE StudentID INTEGER;
    DECLARE HobbyID INTEGER;
    
    SET StudentID = (SELECT IDStudenta FROM studenci WHERE NrAlbumu=album);
    SET HobbyID = (SELECT IDPrzedmiotu FROM przedmioty WHERE Nazwa=hobby);

    INSERT INTO transfer VALUES (StudentID, HobbyID);

END//

DELIMITER ;