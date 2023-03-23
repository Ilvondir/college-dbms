DELIMITER //

CREATE OR REPLACE PROCEDURE showToExport(IN tab varchar(20))
BEGIN

    IF tab="studenci" THEN
        SELECT * FROM studenci;
    END IF;

    IF tab="projekty" THEN
        SELECT * FROM projekty;
    END IF;

    IF tab="transfer" THEN
        SELECT * FROM transfer;
    END IF;

    IF tab="przedmioty" THEN
        SELECT * FROM przedmioty;
    END IF;

    IF tab="dziedzinynauki" THEN
        SELECT * FROM dziedzinynauki;
    END IF;

    IF tab="wykladowcy" THEN
        SELECT * FROM wykladowcy;
    END IF;
    
END//

DELIMITER ;