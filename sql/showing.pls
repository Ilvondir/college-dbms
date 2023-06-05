DELIMITER //

CREATE OR REPLACE PROCEDURE showing(IN id int)
BEGIN

    SELECT Imie, Nazwisko, NrAlbumu, kierunki.Nazwa as Kierunek, SredniaOcen, NazwaProjektu, Ocena, zainteresowania.Nazwa
    FROM studenci
    INNER JOIN projekty
    ON studenci.IDStudenta=projekty.IDStudenta
    INNER JOIN zainteresowania
    ON studenci.IDStudenta=zainteresowania.IDStudenta
    INNER JOIN kierunki
    ON studenci.KierunekStudiow=kierunki.ID
    WHERE studenci.IDStudenta=id;
    
END//

DELIMITER ;