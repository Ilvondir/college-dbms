DELIMITER //

CREATE OR REPLACE PROCEDURE inserting(IN name varchar(30),
                                      IN surname varchar(30),
                                      IN albumNumber int(6),
                                      IN way varchar(50),
                                      IN mean decimal(3,2),
                                      IN work varchar(100),
                                      IN mark decimal(2,1))
BEGIN
    
    DECLARE StudentID INTEGER;
    
    SET StudentID = (SELECT MAX(IDStudenta) FROM studenci);
    SET StudentID = StudentID+1;

    INSERT INTO studenci VALUES (null, name, surname, albumNumber, way, mean);
    INSERT INTO projekty VALUES (StudentID, work, mark);

END//

DELIMITER ;