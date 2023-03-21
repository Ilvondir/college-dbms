DELIMITER //

CREATE OR REPLACE PROCEDURE showing(IN album int(6))
BEGIN

    SELECT Imie, Nazwisko, NrAlbumu, NazwaProjektu, Ocena, przedmioty.Nazwa
    FROM studenci
    INNER JOIN projekty
    ON studenci.IDStudenta=projekty.IDStudenta
    INNER JOIN transfer
    ON studenci.IDStudenta=transfer.IDStudenta
    INNER JOIN przedmioty
    ON transfer.IDPrzedmiotu=przedmioty.IDPrzedmiotu
    WHERE studenci.NrAlbumu=album;
    
END//

DELIMITER ;