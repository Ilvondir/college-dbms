-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 05 Cze 2023, 17:50
-- Wersja serwera: 10.4.25-MariaDB
-- Wersja PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE college;
USE college;

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleting` (IN `id` INT)   BEGIN

    DECLARE maxID INTEGER;
    DECLARE STquery TEXT;

    SELECT MAX(IDStudenta) INTO maxID from studenci;

    DELETE FROM projekty WHERE IDStudenta=id;
    DELETE FROM zainteresowania WHERE IDStudenta=id;
    DELETE FROM studenci WHERE IDStudenta=id;

    SET FOREIGN_KEY_CHECKS=0;

    UPDATE zainteresowania SET IDStudenta=IDStudenta-1 WHERE IDStudenta>id;
    UPDATE projekty SET IDStudenta=IDStudenta-1 WHERE IDStudenta>id;
    UPDATE studenci SET IDStudenta=IDStudenta-1 WHERE IDStudenta>id;

    SET FOREIGN_KEY_CHECKS=1;

    SET STquery = CONCAT("ALTER TABLE studenci AUTO_INCREMENT=", maxID);
    PREPARE st FROM STquery;
    EXECUTE st;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getKierunki` ()   BEGIN

    SELECT * FROM kierunki;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUzytkownicy` ()   BEGIN

    SELECT login, password FROM uzytkownicy;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `importKierunki` (IN `name` VARCHAR(50))   BEGIN

    SET FOREIGN_KEY_CHECKS=0;
    INSERT INTO kierunki VALUES (null, name);
    SET FOREIGN_KEY_CHECKS=1;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `importProjekty` (IN `name` VARCHAR(100), IN `mark` DECIMAL(2,1))   BEGIN

    DECLARE idToInsert INTEGER;
    SET idToInsert = (SELECT MAX(IDStudenta) FROM projekty);
    SET idToInsert = idToInsert+1;

    SET FOREIGN_KEY_CHECKS=0;
    INSERT INTO projekty VALUES (idToInsert, name, mark);
    SET FOREIGN_KEY_CHECKS=1;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `importStudenci` (IN `name` VARCHAR(50), IN `surname` VARCHAR(50), IN `album` INT(6), IN `way` INT, IN `mean` DECIMAL(3,2))   BEGIN

    SET FOREIGN_KEY_CHECKS=0;
    INSERT INTO studenci VALUES (null, name, surname, album, way, mean);
    SET FOREIGN_KEY_CHECKS=0;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `importZainteresowania` (IN `name` VARCHAR(50))   BEGIN

    DECLARE idToInsert INTEGER;
    SET idToInsert = (SELECT MAX(IDStudenta) FROM zainteresowania);
    SET idToInsert = idToInsert+1;

    SET FOREIGN_KEY_CHECKS=0;
    INSERT INTO zainteresowania VALUES (idToInsert, name);
    SET FOREIGN_KEY_CHECKS=1;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inserting` (IN `name` VARCHAR(30), IN `surname` VARCHAR(30), IN `albumNumber` INT(6), IN `way` VARCHAR(50), IN `mean` DECIMAL(3,2), IN `work` VARCHAR(100), IN `mark` DECIMAL(2,1), IN `hobby` VARCHAR(100))   BEGIN

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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registering` (IN `login` VARCHAR(255), IN `password` VARCHAR(255))   BEGIN

    INSERT INTO uzytkownicy VALUES (null, login, SHA2(password, 256));

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `searching` (IN `cond` VARCHAR(30), IN `phrase` VARCHAR(100), IN `minMean` DECIMAL(3,2), IN `maxMean` DECIMAL(3,2))   BEGIN

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
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showing` (IN `id` INT)   BEGIN

    SELECT Imie, Nazwisko, NrAlbumu, kierunki.Nazwa as Kierunek, SredniaOcen, NazwaProjektu, Ocena, zainteresowania.Nazwa
    FROM studenci
    INNER JOIN projekty
    ON studenci.IDStudenta=projekty.IDStudenta
    INNER JOIN zainteresowania
    ON studenci.IDStudenta=zainteresowania.IDStudenta
    INNER JOIN kierunki
    ON studenci.KierunekStudiow=kierunki.ID
    WHERE studenci.IDStudenta=id;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showToExport` (IN `tab` VARCHAR(20))   BEGIN

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
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updating` (IN `idSt` INT, IN `name` VARCHAR(30), IN `surname` VARCHAR(30), IN `albumNumber` INT(6), IN `way` VARCHAR(50), IN `mean` DECIMAL(3,2), IN `work` VARCHAR(100), IN `mark` DECIMAL(2,1), IN `hobby` VARCHAR(100))   BEGIN

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

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `kierunki`
--

CREATE TABLE `kierunki` (
  `ID` int(11) NOT NULL,
  `Nazwa` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `kierunki`
--

INSERT INTO `kierunki` (`ID`, `Nazwa`) VALUES
(1, 'Informatyka'),
(2, 'Matematyka'),
(3, 'Ekonomia'),
(4, 'Architektura'),
(5, 'Agroleśnictwo'),
(6, 'Fizyka'),
(7, 'Polonistyka');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `projekty`
--

CREATE TABLE `projekty` (
  `IDStudenta` int(2) NOT NULL,
  `NazwaProjektu` varchar(45) DEFAULT NULL,
  `Ocena` decimal(2,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `projekty`
--

INSERT INTO `projekty` (`IDStudenta`, `NazwaProjektu`, `Ocena`) VALUES
(1, 'Metody wizualizacji danych ekonomicznych', '5.0'),
(2, 'Zastosowania rownan funkcyjnych w fizyce', '4.5'),
(3, 'Zastosowania rownan funkcyjnych w gastronomii', '4.0'),
(4, 'Rownania finansowe', '5.0'),
(5, 'Quasiliniowosci', '3.5'),
(6, 'Rownania Jensena', '3.5'),
(7, 'Badania ekonometryczne', '4.0'),
(8, 'Przebudowa PIT', '3.5'),
(9, 'Prawo podatkowe', '2.0'),
(10, 'Analiza ekonometryczna', '3.0'),
(11, 'Grafy powiazań budowlanych', '4.5'),
(12, 'Relacje gospodarcze Australii', '3.0'),
(13, 'Relacje gospodarcze Azji', '5.0'),
(14, 'Relacje gospodarcze Ameryki Polnocnej', '3.0'),
(15, 'Relacje gospodarcze Ameryki Poludniowej', '2.0'),
(16, 'Gospodarka zbrojeniowa', '4.5'),
(17, 'Całkowanie numeryczne', '3.0'),
(18, 'Zastosowanie programowania obiektowego', '3.0'),
(19, 'Dynamiczna wizualizacja danych finansowych', '4.0'),
(20, 'Implementacje kwadratur numerycznych', '5.0'),
(21, 'Ujęcie sieci neuronowych w medycynie', '5.0'),
(22, 'OpenGL i jego praktyczne implementacje', '5.0'),
(23, 'Szeregi zbieżne i niezbieżne', '3.0'),
(24, 'Programowanie w Asembly', '2.0'),
(25, 'Programowanie sterowników niskopoziomowych', '4.0'),
(26, 'Programowanie dynamiczne', '4.0'),
(27, 'Szacowanie zniszczeń gospodarczych', '2.5'),
(28, 'Dzieła pozytywizmu', '3.0'),
(29, 'Środowisko i właściwości sosen', '5.0'),
(30, 'Badanie całek zespolonych', '4.5'),
(31, 'Analiza dofinansowań Unii Europejskiej', '5.0'),
(32, 'Analiza tekstów epoki wojennej', '3.0'),
(33, 'Pomiary ciepła wrzenia substancji', '4.0'),
(34, 'Pasożyty w lasach liściastych', '3.5'),
(35, 'Ekosystem lasów równikowych', '5.0'),
(36, 'Systemy Arduino', '4.0'),
(37, 'Literatura epoki starożytnej', '4.5'),
(38, 'Programowanie w Objective-C', '3.0'),
(39, 'Znaczenie agroturystyki w leśnictwie', '2.0'),
(40, 'Zastosowanie rachunku prawdopodobieństwa', '5.0'),
(41, 'Programowanie obiektowe w C++', '3.0'),
(42, 'Stosowana analiza matematyczna', '4.5'),
(43, 'Bazy danych w biznesie', '3.5'),
(44, 'Projektowanie wnętrz', '4.0'),
(45, 'Agroekologia', '5.0'),
(46, 'Fizyka molekularna', '3.5'),
(47, 'Język francuski', '4.5'),
(48, 'Systemy informatyczne w zarządzaniu', '4.0'),
(49, 'Zarządzanie projektami informatycznymi', '4.0'),
(50, 'Teoria grafów w architekturze', '4.5'),
(51, 'Estymatory złożone', '4.0'),
(52, 'Aplikacje Laravela', '5.0'),
(53, 'Zachowania roślin tundry', '4.0');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `studenci`
--

CREATE TABLE `studenci` (
  `IDStudenta` int(2) NOT NULL,
  `Imie` varchar(30) DEFAULT NULL,
  `Nazwisko` varchar(30) DEFAULT NULL,
  `NrAlbumu` int(6) DEFAULT NULL,
  `KierunekStudiow` int(11) NOT NULL,
  `SredniaOcen` decimal(3,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `studenci`
--

INSERT INTO `studenci` (`IDStudenta`, `Imie`, `Nazwisko`, `NrAlbumu`, `KierunekStudiow`, `SredniaOcen`) VALUES
(1, 'Andrzej', 'Pies', 112425, 3, '4.98'),
(2, 'Tomasz', 'Nowak', 122137, 2, '4.90'),
(3, 'Dariusz', 'Myszka', 111133, 2, '2.67'),
(4, 'Karolina', 'Kowalska', 124138, 2, '3.07'),
(5, 'Kamil', 'Nawalski', 122139, 2, '2.90'),
(6, 'Zofia', 'Czarna', 111141, 2, '3.08'),
(7, 'Adrian', 'Stanicki', 115546, 3, '3.91'),
(8, 'Krzysztof', 'Rysz', 111148, 3, '3.92'),
(9, 'Krzysztof', 'Ziembicka', 111149, 3, '4.12'),
(10, 'Malwina', 'Chylda', 122151, 3, '2.68'),
(11, 'Oliwia', 'Szczur', 122152, 2, '4.14'),
(12, 'Gerwazy', 'Olejko', 121154, 3, '2.99'),
(13, 'Tomasz', 'Orkiestra', 111155, 3, '4.15'),
(14, 'Marek', 'Kaproń', 129156, 3, '2.92'),
(15, 'Mariusz', 'Flis', 111158, 3, '4.17'),
(16, 'Michalina', 'Myszak', 111159, 3, '4.17'),
(17, 'Edmund', 'Nawalski', 123411, 2, '3.11'),
(18, 'Adrian', 'Dukla', 124071, 1, '3.22'),
(19, 'Julia', 'Staszowska', 133211, 3, '4.22'),
(20, 'Konrad', 'Gustawiński', 134112, 2, '4.55'),
(21, 'Michał', 'Komsa', 123633, 1, '4.87'),
(22, 'Ewa', 'Krzat', 123455, 1, '3.91'),
(23, 'Edyta', 'Marzec', 132555, 2, '3.01'),
(24, 'Tytus', 'Fredro', 120885, 1, '2.66'),
(25, 'Damian', 'Król', 112355, 1, '3.42'),
(26, 'Edyta', 'Komar', 133422, 1, '3.44'),
(27, 'Konstancja', 'Rusinek', 144412, 3, '2.76'),
(28, 'Adrian', 'Zelot', 132789, 7, '4.55'),
(29, 'Konrad', 'Adamowicz', 122909, 5, '3.89'),
(30, 'Anna', 'Żygała', 129088, 2, '4.33'),
(31, 'Wiktoria', 'Bełżycka', 132216, 3, '3.49'),
(32, 'Katarzyna', 'Komsa', 123228, 7, '3.55'),
(33, 'Adam', 'Kowalski', 133266, 6, '4.44'),
(34, 'Jan', 'Rzęsa', 132541, 5, '3.10'),
(35, 'Rafał', 'Staszowski', 134511, 5, '4.98'),
(36, 'Franciszek', 'Chojnicki', 144288, 1, '4.22'),
(37, 'Michał', 'Orzeł', 195443, 7, '4.51'),
(38, 'Ewa', 'Małek', 123431, 1, '3.99'),
(39, 'Renata', 'Rowlison', 144577, 5, '3.77'),
(40, 'Piotr', 'Homa', 121256, 2, '5.00'),
(41, 'Katarzyna', 'Stolarska', 111222, 1, '3.75'),
(42, 'Marek', 'Kowalczyk', 123456, 2, '4.60'),
(43, 'Tomasz', 'Kaminski', 134567, 1, '3.90'),
(44, 'Marta', 'Nowicka', 145678, 4, '3.22'),
(45, 'Piotr', 'Wojciechowski', 156789, 5, '2.80'),
(46, 'Karolina', 'Lis', 167890, 6, '3.45'),
(47, 'Rafał', 'Marciniak', 178901, 7, '3.15'),
(48, 'Weronika', 'Zawadzka', 189012, 1, '4.25'),
(49, 'Bartosz', 'Wójcik', 190123, 1, '4.00'),
(50, 'Aleksandra', 'Krajewska', 201234, 2, '3.50'),
(51, 'Adam', 'Lato', 123871, 2, '4.00'),
(52, 'Andrzej', 'Dukla', 111366, 1, '4.88'),
(53, 'Kamil', 'Kupiec', 114366, 5, '3.55');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownicy`
--

CREATE TABLE `uzytkownicy` (
  `ID` int(11) NOT NULL,
  `login` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `uzytkownicy`
--

INSERT INTO `uzytkownicy` (`ID`, `login`, `password`) VALUES
(1, 'Administrator', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918'),
(2, 'Michał', '009cdb9edc49299a91853cc79b994f1c23be934e83db5598eb690bbf82fe81b7'),
(3, 'Ilvondir', '9b09990a04b9351370f6c65292b7a2e81d90d058afafdd572e16f0ca03afc157'),
(4, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zainteresowania`
--

CREATE TABLE `zainteresowania` (
  `IDStudenta` int(11) NOT NULL,
  `Nazwa` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `zainteresowania`
--

INSERT INTO `zainteresowania` (`IDStudenta`, `Nazwa`) VALUES
(1, 'Mikroekonomia'),
(2, 'Analiza zespolona'),
(3, 'Statystyka opisowa'),
(4, 'Analiza finansowa'),
(5, 'Rownania funkcyjne'),
(6, 'Analiza funkcjonalna'),
(7, 'Analiza ekonomiczna'),
(8, 'Stosunki gospodarcze'),
(9, 'Marketing'),
(10, 'Makroekonomia'),
(11, 'Matematyka dyskretna'),
(12, 'Stosunki europejskie'),
(13, 'Stosunki gospodarcze'),
(14, 'Marketing'),
(15, 'Polityka spoleczna'),
(16, 'Teoria przedsiebiorstwa'),
(17, 'Metody numeryczne'),
(18, 'Programowanie obiektowe'),
(19, 'Brak'),
(20, 'Metody numeryczne'),
(21, 'Grafika i komunikacja człowieka z komputerem'),
(22, 'Grafika i komunikacja człowieka z komputerem'),
(23, 'Analiza matematyczna'),
(24, 'Architektura systemów komputerowych'),
(25, 'Architektura systemów komputerowych'),
(26, 'Programowanie procesów współbieżnych'),
(27, 'Mikroekonomia'),
(28, 'Literatura pozytywizmu'),
(29, 'Flora leśna'),
(30, 'Analiza zespolona'),
(31, 'Finanse publiczne'),
(32, 'Literatura międzywojenna'),
(33, 'Metrologia'),
(34, 'Leśnictwo'),
(35, 'Turystyka leśna'),
(36, 'Programowanie obiektowe'),
(37, 'Analiza polonistyczna'),
(38, 'Programowanie obiektowe'),
(39, 'Agroturystyka'),
(40, 'Rachunek prawdopodobieństwa'),
(41, 'Programowanie obiektowe'),
(42, 'Analiza matematyczna'),
(43, 'Bazy danych'),
(44, 'Rysunek techniczny'),
(45, 'Ekologia'),
(46, 'Fizyka molekularna'),
(47, 'Literatura francuska'),
(48, 'Problemy społeczne informatyki'),
(49, 'Problemy społeczne informatyki'),
(50, 'Teoria grafów'),
(51, 'Obliczenia statystyczne'),
(52, 'Programowanie obiektowe'),
(53, 'Uprawy kontrolowane');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `kierunki`
--
ALTER TABLE `kierunki`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `projekty`
--
ALTER TABLE `projekty`
  ADD KEY `IDStudenta` (`IDStudenta`);

--
-- Indeksy dla tabeli `studenci`
--
ALTER TABLE `studenci`
  ADD PRIMARY KEY (`IDStudenta`),
  ADD KEY `KierunekStudiow` (`KierunekStudiow`);

--
-- Indeksy dla tabeli `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `zainteresowania`
--
ALTER TABLE `zainteresowania`
  ADD KEY `IDStudenta` (`IDStudenta`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `kierunki`
--
ALTER TABLE `kierunki`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT dla tabeli `studenci`
--
ALTER TABLE `studenci`
  MODIFY `IDStudenta` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT dla tabeli `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `projekty`
--
ALTER TABLE `projekty`
  ADD CONSTRAINT `projekty_ibfk_1` FOREIGN KEY (`IDStudenta`) REFERENCES `studenci` (`IDStudenta`);

--
-- Ograniczenia dla tabeli `studenci`
--
ALTER TABLE `studenci`
  ADD CONSTRAINT `studenci_ibfk_1` FOREIGN KEY (`KierunekStudiow`) REFERENCES `kierunki` (`ID`);

--
-- Ograniczenia dla tabeli `zainteresowania`
--
ALTER TABLE `zainteresowania`
  ADD CONSTRAINT `zainteresowania_ibfk_1` FOREIGN KEY (`IDStudenta`) REFERENCES `studenci` (`IDStudenta`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
