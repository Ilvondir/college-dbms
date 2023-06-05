DELIMITER //

CREATE OR REPLACE PROCEDURE inserting(IN name varchar(30),
                                      IN surname varchar(30),
                                      IN albumNumber int(6),
                                      IN way varchar(50),
                                      IN mean decimal(3,2),
                                      IN work varchar(100),
                                      IN mark decimal(2,1),
                                      IN hobby varchar(100))
BEGIN

    DECLARE StudentID INTEGER;
    DECLARE IDkierunku INTEGER;
    DECLARE counterKierunki INTEGER;

    SET counterKierunki = (SELECT COUNT(*) FROM kierunki WHERE Nazwa=way);

    IF counterKierunki=0 THEN
        INSERT INTO kierunki VALUES (null, way);
    END IF;
    
    SET StudentID = (SELECT MAX(IDStudenta) FROM studenci);
    SET StudentID = StudentID+1;

    SET IDkierunku = (SELECT ID from kierunki where Nazwa=way);

    SET FOREIGN_KEY_CHECKS=0;

    INSERT INTO studenci VALUES (null, name, surname, albumNumber, IDkierunku, mean);
    INSERT INTO projekty VALUES (StudentID, work, mark);
    INSERT INTO zainteresowania VALUES (StudentID, hobby);

    SET FOREIGN_KEY_CHECKS=1;

END//

DELIMITER ;