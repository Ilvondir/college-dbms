DELIMITER //

CREATE OR REPLACE PROCEDURE searching(IN cond varchar(30),
                                      IN phrase varchar(100),
                                      IN minMean decimal(3,2),
                                      IN maxMean decimal(3,2))
BEGIN

	IF cond="Nazwisko" THEN
        SELECT DISTINCT studenci.IDStudenta, Imie, Nazwisko, NrAlbumu, kierunki.Nazwa as Kierunek, SredniaOcen, projekty.NazwaProjektu 
        FROM studenci
        INNER JOIN projekty
        ON studenci.IDStudenta=projekty.IDStudenta
        INNER JOIN kierunki
        ON studenci.KierunekStudiow=kierunki.ID
        WHERE studenci.Nazwisko LIKE CONCAT('%', phrase, '%')
        ORDER BY studenci.IDStudenta asc;
    ELSE 
        IF cond="Imię" THEN
            SELECT DISTINCT studenci.IDStudenta, Imie, Nazwisko, NrAlbumu, kierunki.Nazwa as Kierunek, SredniaOcen, projekty.NazwaProjektu
            FROM studenci
            INNER JOIN projekty
            ON studenci.IDStudenta=projekty.IDStudenta
            INNER JOIN kierunki
            ON studenci.KierunekStudiow=kierunki.ID
            WHERE studenci.Imie LIKE CONCAT('%', phrase, '%')
            ORDER BY studenci.IDStudenta asc;
        ELSE 
            IF cond="Temat pracy magisterskiej" THEN
                SELECT DISTINCT studenci.IDStudenta, Imie, Nazwisko, NrAlbumu, kierunki.Nazwa as Kierunek, SredniaOcen, projekty.NazwaProjektu
                FROM studenci
                INNER JOIN projekty
                ON studenci.IDStudenta=projekty.IDStudenta
                INNER JOIN kierunki
                ON studenci.KierunekStudiow=kierunki.ID
                WHERE projekty.NazwaProjektu LIKE CONCAT('%', phrase, '%')
                ORDER BY studenci.IDStudenta asc;
            ELSE 
                IF cond="Numer albumu" THEN
                    SELECT DISTINCT studenci.IDStudenta, Imie, Nazwisko, NrAlbumu, kierunki.Nazwa as Kierunek, SredniaOcen, projekty.NazwaProjektu
                    FROM studenci
                    INNER JOIN projekty
                    ON studenci.IDStudenta=projekty.IDStudenta
                    INNER JOIN kierunki
                    ON studenci.KierunekStudiow=kierunki.ID
                    WHERE studenci.NrAlbumu LIKE CONCAT('%', phrase, '%')
                    ORDER BY studenci.IDStudenta asc;
                ELSE 
                    IF cond="Kierunek studiów" THEN
                        SELECT DISTINCT studenci.IDStudenta, Imie, Nazwisko, NrAlbumu, kierunki.Nazwa as Kierunek, SredniaOcen, projekty.NazwaProjektu
                        FROM studenci
                        INNER JOIN projekty
                        ON studenci.IDStudenta=projekty.IDStudenta
                        INNER JOIN kierunki
                        ON studenci.KierunekStudiow=kierunki.ID
                        WHERE kierunki.Nazwa LIKE CONCAT('%', phrase, '%')
                        ORDER BY studenci.IDStudenta asc;
                    ELSE 
                        IF cond="Średnia ocen" THEN
                            SELECT DISTINCT studenci.IDStudenta, Imie, Nazwisko, NrAlbumu, kierunki.Nazwa as Kierunek, SredniaOcen, projekty.NazwaProjektu
                            FROM studenci
                            INNER JOIN projekty
                            ON studenci.IDStudenta=projekty.IDStudenta
                            INNER JOIN kierunki
                            ON studenci.KierunekStudiow=kierunki.ID
                            WHERE studenci.SredniaOcen BETWEEN minMean AND maxMean
                            ORDER BY studenci.IDStudenta asc;
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;
    END IF;
    
END//

DELIMITER ;