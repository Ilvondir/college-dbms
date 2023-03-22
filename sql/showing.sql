DELIMITER //

CREATE OR REPLACE PROCEDURE showing(IN id int)
BEGIN

    SELECT Imie, Nazwisko, NrAlbumu, KierunekStudiow, SredniaOcen, NazwaProjektu, Ocena, przedmioty.Nazwa
    FROM studenci
    INNER JOIN projekty
    ON studenci.IDStudenta=projekty.IDStudenta
    INNER JOIN transfer
    ON studenci.IDStudenta=transfer.IDStudenta
    INNER JOIN przedmioty
    ON transfer.IDPrzedmiotu=przedmioty.IDPrzedmiotu
    WHERE studenci.IDStudenta=id;
    
END//

DELIMITER ;