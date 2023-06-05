DELIMITER //

CREATE OR REPLACE PROCEDURE showToExport(IN tab varchar(20))
BEGIN

    IF tab="studenci" THEN
        SELECT * FROM studenci;
    END IF;

    IF tab="projekty" THEN
        SELECT * FROM projekty;
    END IF;

    IF tab="zainteresowania" THEN
        SELECT * FROM zainteresowania;
    END IF;

    IF tab="kierunki" THEN
        SELECT * FROM kierunki;
    END IF;
    
END//

DELIMITER ;