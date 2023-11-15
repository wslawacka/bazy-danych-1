CREATE DATABASE firma;

CREATE SCHEMA firma.ksiegowosc;

CREATE TABLE ksiegowosc.pracownicy(
  id_pracownika INT PRIMARY KEY,
  imie VARCHAR(20) NOT NULL,
  nazwisko VARCHAR(30) NOT NULL,
  adres VARCHAR(50) NOT NULL,
  telefon INT
  );

CREATE TABLE ksiegowosc.godziny(
  id_godziny INT PRIMARY KEY,
  data DATE NOT NULL,
  liczba_godzin INT NOT NULL,
  id_pracownika INT,
   FOREIGN KEY(id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika)
  );

CREATE TABLE ksiegowosc.pensje(
  id_pensji INT PRIMARY KEY,
  stanowisko VARCHAR(50) NOT NULL,
  kwota DECIMAL(10, 2)
);

CREATE TABLE ksiegowosc.premie(
  id_premii INT PRIMARY KEY,
  rodzaj VARCHAR(50) NOT NULL,
  kwota DECIMAL(10, 2)
  );

CREATE TABLE ksiegowosc.wynagrodzenie(
  id_wynagrodzenia INT PRIMARY KEY,
  data DATE NOT NULL,
  id_pracownika INT,
  id_premii INT,
  id_pensji INT,
   FOREIGN KEY(id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika),
   FOREIGN KEY(id_pensji) REFERENCES ksiegowosc.pensje(id_pensji), 
   FOREIGN KEY(id_premii) REFERENCES ksiegowosc.premie(id_premii)
);

COMMENT ON TABLE ksiegowosc.pracownicy IS 'Ta tabela zawiera dane o pracownikach.';
COMMENT ON TABLE ksiegowosc.godziny IS 'Ta tabela zawiera dane dotyczace godzin.';
COMMENT ON TABLE ksiegowosc.pensje IS 'Ta tabela zawiera dane o pensjach.';
COMMENT ON TABLE ksiegowosc.premie IS 'Ta tabela zawiera dane o premiach.';
COMMENT ON TABLE ksiegowosc.wynagrodzenie IS 'Ta tabela zawiera dane o wynagrodzeniach.';



INSERT INTO ksiegowosc.pracownicy(id_pracownika, imie, nazwisko, adres, telefon)
VALUES 
(1, 'Jan', 'Kowalski', 'ul. Prosta 1, Warszawa', 123456789),
(2, 'Anna', 'Nowak', 'ul. Kwiatowa 2, Kraków', 987654321),
(3, 'Piotr', 'Dąbrowski', 'ul. Słoneczna 3, Gdańsk', 111222333),
(4, 'Maria', 'Wójcik', 'ul. Brzozowa 4, Poznań', 444555666),
(5, 'Andrzej', 'Kaczmarek', 'ul. Polna 5, Wrocław', 777888999),
(6, 'Magdalena', 'Grabowska', 'ul. Jagodowa 6, Łódź', 222333444),
(7, 'Tomasz', 'Zawisza', 'ul. Radosna 7, Szczecin', 555666777),
(8, 'Katarzyna', 'Piotrowska', 'ul. Słowackiego 8, Lublin', 999888777),
(9, 'Michał', 'Lis', 'ul. Mickiewicza 9, Białystok', 555444333),
(10, 'Ewa', 'Nowacka', 'ul. Leśna 10, Katowice', 111999888);

INSERT INTO ksiegowosc.godziny(id_godziny, data, liczba_godzin, id_pracownika)
VALUES
(1, '2023-10-15', 7, 4),
(2, '2023-12-05', 6, 10),
(3, '2023-11-21', 8, 5),
(4, '2023-09-03', 7, 1),
(5, '2023-08-27', 7, 9),
(6, '2023-07-11', 6, 7),
(7, '2023-04-18', 8, 3),
(8, '2023-06-30', 7, 2),
(9, '2023-03-09', 8, 6),
(10, '2023-01-14', 7, 8);

INSERT INTO ksiegowosc.premie(id_premii, rodzaj, kwota)
VALUES
(101, 'Bonus za wyniki', 500.00),
(102, 'Premia świąteczna', 300.50),
(103, 'Nagroda za staż pracy', 250.75),
(104, 'Premia za wydajność', 400.25),
(105, 'Bonus jubileuszowy', 600.80),
(106, 'Nagroda za najlepszy projekt', 450.60),
(107, 'Premia za pracę nadgodzinową', 350.75),
(108, 'Nagroda za projekt graficzny', 200.90),
(109, 'Premia za dobre wyniki rekrutacji', 350.70),
(110, 'Nagroda za najlepszy serwis', 400.45);

INSERT INTO ksiegowosc.pensje(id_pensji, stanowisko, kwota)
VALUES
(1, 'Kierownik', 5500.75),
(2, 'Programista', 4200.50),
(3, 'Specjalista ds. marketingu', 3600.25),
(4, 'Analityk danych', 4800.80),
(5, 'Księgowy', 3900.60),
(6, 'Inżynier sprzedaży', 4100.75),
(7, 'Asystentka biura', 3200.40),
(8, 'Grafik komputerowy', 4300.90),
(9, 'Specjalista ds. HR', 3700.70),
(10, 'Technik serwisu', 4000.45);

INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika, id_pensji, 
id_premii)
VALUES
(1, '2023-01-05', 5, 1, 101),
(2, '2023-02-03', 2, 2, 105),
(3, '2023-03-01', 8, 4, 103),
(4, '2023-04-04', 1, 8, 102),
(5, '2023-05-02', 10, 3, 104),
(6, '2023-06-05', 6, 9, 106),
(7, '2023-07-03', 7, 10, 109),
(8, '2023-08-01', 3, 5, 107),
(9, '2023-09-04', 4, 7, 108),
(10, '2023-10-02', 9, 6, 110);

--a
SELECT id_pracownika, nazwisko
FROM ksiegowosc.pracownicy;

--b
SELECT wynagrodzenie.id_pracownika, (pensje.kwota+premie.kwota) AS placa
FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji
LEFT JOIN ksiegowosc.premie ON premie.id_premii=wynagrodzenie.id_premii
WHERE (pensje.kwota+premie.kwota)>1000;

--c
SELECT wynagrodzenie.id_pracownika, (premie.kwota+pensje.kwota) AS placa
FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.premie ON wynagrodzenie.id_premii=premie.id_premii
LEFT JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji=pensje.id_pensji
WHERE wynagrodzenie.id_premii IS NULL AND (premie.kwota+pensje.kwota)>2000;

--d
SELECT *
FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%';

--e
SELECT *
FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

--f
SELECT pracownicy.id_pracownika, imie, nazwisko, SUM(liczba_godzin) AS przepracowane_godziny
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.godziny ON pracownicy.id_pracownika=godziny.id_pracownika
GROUP BY pracownicy.id_pracownika
HAVING SUM(liczba_godzin)>160;

--g
SELECT imie, nazwisko, pensje.kwota
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika
JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji
WHERE pensje.kwota BETWEEN 1500 AND 3000;

--h
SELECT id_pracownika, imie, nazwisko, SUM(liczba_godzin) AS przepracowane_godziny
FROM ksiegowosc.pracownicy
WHERE przepracowane_godziny>160
GROUP BY id_pracownika;

--i
SELECT pracownicy.id_pracownika, imie, nazwisko, pensje.kwota
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika=wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji
ORDER BY pensje.kwota;


--j
SELECT pracownicy.id_pracownika, imie, nazwisko, pensje.kwota AS pensja, premie.kwota AS premia
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika=wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji
JOIN ksiegowosc.premie ON premie.id_premii=wynagrodzenie.id_premii
ORDER BY pensje.kwota, premie.kwota DESC;

--k
SELECT stanowisko, COUNT(wynagrodzenie.id_pracownika)AS liczba_pracownikow
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji=pensje.id_pensji
JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika
GROUP BY stanowisko;

--l
SELECT MIN(pensje.kwota+premie.kwota) AS min, 
  MAX(pensje.kwota+premie.kwota) AS max,
  AVG(pensje.kwota+premie.kwota) AS avg
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji=pensje.id_pensji
JOIN ksiegowosc.premie ON premie.id_premii=wynagrodzenie.id_premii
WHERE stanowisko='Kierownik';

--m
SELECT (SUM(pensje.kwota)+SUM(premie.kwota)) AS suma_wynagrodzen
FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.premie ON wynagrodzenie.id_premii=premie.id_premii
LEFT JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji=pensje.id_pensji;

--n
SELECT stanowisko, (SUM(pensje.kwota)+SUM(premie.kwota)) AS suma_wynagrodzen
FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.premie ON wynagrodzenie.id_premii=premie.id_premii
LEFT JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji=pensje.id_pensji
GROUP BY stanowisko;

--o
SELECT stanowisko, COUNT(premie.id_premii) AS liczba_premii
FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.premie ON wynagrodzenie.id_premii=premie.id_premii
LEFT JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji=pensje.id_pensji
GROUP BY stanowisko;

--p
DELETE
FROM ksiegowosc.pracownicy
WHERE id_pracownika IN (SELECT id_pracownika
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
WHERE pensje.kwota < 1200);
