DELIMITER //

CREATE OR REPLACE PROCEDURE updating(IN idSt int,
                                     IN name varchar(30),
                                     IN surname varchar(30),
                                     IN albumNumber int(6),
                                     IN way varchar(50),
                                     IN mean decimal(3,2),
                                     IN work varchar(100),
                                     IN mark decimal(2,1),
                                     IN hobby varchar(100))
BEGIN

    DECLARE IDkierunku INTEGER;

    SET IDkierunku = (SELECT ID from kierunki WHERE Nazwa=way);

    UPDATE studenci
    SET Imie=name, Nazwisko=surname, NrAlbumu=albumNumber, KierunekStudiow=IDkierunku, SredniaOcen=mean
    WHERE IDStudenta=idSt;

    UPDATE projekty
    SET NazwaProjektu=work, Ocena=mark
    WHERE IDStudenta=idSt;

    UPDATE zainteresowania
    SET Nazwa=hobby
    WHERE IDStudenta=idSt;

END//

DELIMITER ;