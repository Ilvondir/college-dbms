DELIMITER //

CREATE OR REPLACE PROCEDURE searching(IN cond varchar(30), IN phrase varchar(100))
BEGIN

	IF cond="Nazwisko" THEN
        SELECT studenci.IDStudenta, Imie, Nazwisko, NrAlbumu, KierunekStudiow, projekty.NazwaProjektu
        FROM studenci INNER JOIN projekty
        ON studenci.IDStudenta=projekty.IDStudenta
        WHERE studenci.Nazwisko LIKE CONCAT('%', phrase, '%');
    ELSE 
        IF cond="Imię" THEN
            SELECT studenci.IDStudenta, Imie, Nazwisko, NrAlbumu, KierunekStudiow, projekty.NazwaProjektu
            FROM studenci INNER JOIN projekty
            ON studenci.IDStudenta=projekty.IDStudenta
            WHERE studenci.Imie LIKE CONCAT('%', phrase, '%');
        ELSE 
            IF cond="Temat pracy magisterskiej" THEN
                SELECT studenci.IDStudenta, Imie, Nazwisko, NrAlbumu, KierunekStudiow, projekty.NazwaProjektu
                FROM studenci INNER JOIN projekty
                ON studenci.IDStudenta=projekty.IDStudenta
                WHERE projekty.NazwaProjektu LIKE CONCAT('%', phrase, '%');
            ELSE 
                IF cond="Numer albumu" THEN
                    SELECT studenci.IDStudenta, Imie, Nazwisko, NrAlbumu, KierunekStudiow, projekty.NazwaProjektu
                    FROM studenci INNER JOIN projekty
                    ON studenci.IDStudenta=projekty.IDStudenta
                    WHERE studenci.NrAlbumu LIKE CONCAT('%', phrase, '%');
                ELSE 
                    IF cond="Kierunek studiów" THEN
                        SELECT studenci.IDStudenta, Imie, Nazwisko, NrAlbumu, KierunekStudiow, projekty.NazwaProjektu
                        FROM studenci INNER JOIN projekty
                        ON studenci.IDStudenta=projekty.IDStudenta
                        WHERE studenci.KierunekStudiow LIKE CONCAT('%', phrase, '%');
                    END IF;
                END IF;
            END IF;
        END IF;
    END IF;
    
END//

DELIMITER ;