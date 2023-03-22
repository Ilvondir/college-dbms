DELIMITER //

CREATE OR REPLACE PROCEDURE updating(IN id int,
                                     IN name varchar(30),
                                     IN surname varchar(30),
                                     IN albumNumber int(6),
                                     IN way varchar(50),
                                     IN mean decimal(3,2),
                                     IN work varchar(100),
                                     IN mark decimal(2,1))
BEGIN

    UPDATE studenci
    SET Imie=name, Nazwisko=surname, NrAlbumu=albumNumber, KierunekStudiow=way, SredniaOcen=mean
    WHERE IDStudenta=id;

    UPDATE projekty
    SET NazwaProjektu=work, Ocena=mark
    WHERE IDStudenta=id;

    DELETE FROM transfer WHERE IDStudenta=id;

END//

DELIMITER ;