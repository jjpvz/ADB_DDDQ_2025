-- Maak tijdelijke database voor opgeschoonde data
--DROP DATABASE Top2000_cleaned
CREATE DATABASE Top2000_cleaned
GO



-- Maak tabel aan voor alle artiesten
--DROP TABLE Top2000_cleaned.dbo.Artist
CREATE TABLE Top2000_cleaned.dbo.Artist (
	artist_name NVARCHAR(255) PRIMARY KEY
)
GO

-- Haal alle unieke artiesten op uit Top2000
INSERT INTO Top2000_cleaned.dbo.Artist (artist_name)
SELECT DISTINCT TRIM(value) as Artiest
FROM Top2000.dbo.Song
CROSS APPLY string_split(REPLACE(Artiest, 'ft.', '#'), '#')
GO



-- Maak tabel voor alle songs aan
--DROP TABLE Top2000_cleaned.dbo.Song
CREATE TABLE Top2000_cleaned.dbo.Song (
	titel NVARCHAR(255) NOT NULL,
	artist NVARCHAR(255) NOT NULL,
	release_year INT,
	duration time(0),
	old_componist NVARCHAR(255),

	PRIMARY KEY (titel, artist),
	FOREIGN KEY (artist) REFERENCES Top2000_cleaned.dbo.Artist(artist_name)
)
GO

-- Kopieer alle song met hoofdartiest en zonder componisten naar Song
INSERT INTO Top2000_cleaned.dbo.Song (titel, release_year, duration, old_componist, artist)
SELECT titel as titel, Jaar as release_year, Speelduur as duration, Componist as old_componist,
	CASE
		WHEN CHARINDEX('ft.', Artiest) > 0
			THEN TRIM(LEFT(Artiest, CHARINDEX('ft.', Artiest) - 1))
		ELSE TRIM(Artiest)
	END AS artist
FROM Top2000.dbo.Song
GO



-- Maak tabel aan voor alle featured artiesten
--DROP TABLE Top2000_cleaned.dbo.SongFeaturedArtist
CREATE TABLE Top2000_cleaned.dbo.SongFeaturedArtist (
	song_titel NVARCHAR(255) NOT NULL,
	artist NVARCHAR(255) NOT NULL,
	featured_artist NVARCHAR(255) NOT NULL,
	PRIMARY KEY (song_titel, artist)
)
GO

-- ALTER TABLE Top2000_cleaned.dbo.SongFeaturedArtist DROP CONSTRAINT FK_SongFeaturedArtist_Song 
ALTER TABLE Top2000_cleaned.dbo.SongFeaturedArtist 
ADD CONSTRAINT FK_SongFeaturedArtist_Song 
FOREIGN KEY (song_titel, artist) 
REFERENCES Top2000_cleaned.dbo.Song(titel, artist) 
ON UPDATE CASCADE
GO


-- Zet alle featured artiesten over
-- SELECT * FROM Top2000_cleaned.dbo.SongFeaturedArtist
-- TRUNCATE TABLE Top2000_cleaned.dbo.SongFeaturedArtist
INSERT INTO Top2000_cleaned.dbo.SongFeaturedArtist (song_titel, artist, featured_artist)
SELECT *
FROM (
	SELECT titel as titel, 
		CASE
			WHEN CHARINDEX('ft.', Artiest) > 0
				THEN TRIM(LEFT(Artiest, CHARINDEX('ft.', Artiest) - 1))
			ELSE TRIM(Artiest)
		END AS artist,
		CASE
			WHEN CHARINDEX('ft.', Artiest) > 0
				THEN TRIM(SUBSTRING(Artiest, CHARINDEX('ft.', Artiest) + LEN('ft.'), LEN(Artiest)))
			ELSE NULL
		END AS featured_artist
	FROM Top2000.dbo.Song
) sub
WHERE featured_artist IS NOT NULL
GO



-- Maak tabel aan voor alle componisten
--DROP TABLE Top2000_cleaned.dbo.Componist
CREATE TABLE Top2000_cleaned.dbo.Componist (
	componist_name NVARCHAR(255) PRIMARY KEY
)
GO

-- Haal alle unieke componisten op uit Top2000
INSERT INTO Top2000_cleaned.dbo.Componist (componist_name)
SELECT DISTINCT TRIM(value) as componist_name
FROM Top2000_cleaned.dbo.Song
CROSS APPLY string_split(old_componist, ',')
GO


--- Link Componisten aan songs
--DROP TABLE Top2000_cleaned.dbo.SongComponist
CREATE TABLE Top2000_cleaned.dbo.SongComponist (
	titel NVARCHAR(255) NOT NULL,
	artist NVARCHAR(255) NOT NULL,
	componist_name NVARCHAR(255) NOT NULL,

	PRIMARY KEY (titel, artist, componist_name)
)
GO

-- ALTER TABLE Top2000_cleaned.dbo.SongComponist DROP CONSTRAINT FK_SongComponist_Song 
ALTER TABLE Top2000_cleaned.dbo.SongComponist
ADD CONSTRAINT FK_SongComponist_Song 
FOREIGN KEY (titel, artist) 
REFERENCES Top2000_cleaned.dbo.Song(titel, artist) 
ON UPDATE CASCADE
GO

-- ALTER TABLE Top2000_cleaned.dbo.SongComponist DROP CONSTRAINT FK_SongComponist_Componist 
ALTER TABLE Top2000_cleaned.dbo.SongComponist
ADD CONSTRAINT FK_SongComponist_Componist 
FOREIGN KEY (componist_name) 
REFERENCES Top2000_cleaned.dbo.Componist(componist_name)
ON UPDATE CASCADE
GO

INSERT INTO Top2000_cleaned.dbo.SongComponist (titel, artist, componist_name)
SELECT titel, artist, TRIM(s.value) as componist_name
FROM Top2000_cleaned.dbo.Song
CROSS APPLY string_split(old_componist, ',') s
GO

ALTER TABLE Top2000_cleaned.dbo.Song
DROP COLUMN old_componist
GO



-- Genre per song tabel
--DROP TABLE Top2000_cleaned.dbo.SongGenre
CREATE TABLE Top2000_cleaned.dbo.SongGenre (
	titel NVARCHAR(255) NOT NULL,
	artist NVARCHAR(255) NOT NULL,
	genre NVARCHAR(255) NOT NULL,

	PRIMARY KEY (titel, artist, genre)
)
GO

INSERT INTO Top2000_cleaned.dbo.SongGenre (titel, genre, artist)
SELECT S.titel, SG.genre,
	CASE
		WHEN CHARINDEX('ft.', S.Artiest) > 0
			THEN TRIM(LEFT(S.Artiest, CHARINDEX('ft.', S.Artiest) - 1))
		ELSE TRIM(S.Artiest)
	END AS artist
FROM Top2000.dbo.Song as S
INNER JOIN Top2000.dbo.SongGenre as SG ON SG.titel = S.titel AND SG.artiest = S.Artiest
GO

-- Genre namen opschonen
SELECT DISTINCT genre
FROM Top2000_cleaned.dbo.SongGenre
GO

UPDATE Top2000_cleaned.dbo.SongGenre
SET genre = 'alternatieve rock'
WHERE genre = 'allternatieve rock' OR genre = 'alternative rock'
GO

UPDATE Top2000_cleaned.dbo.SongGenre
SET genre = 'elektronische muziek'
WHERE genre = 'elketronische muziek'
GO

UPDATE Top2000_cleaned.dbo.SongGenre
SET genre = 'Keltische rock'
WHERE genre = 'Celtic rock'
GO

UPDATE Top2000_cleaned.dbo.SongGenre
SET genre = 'psychedelische rock'
WHERE genre = 'psychedelic rock'
GO

UPDATE Top2000_cleaned.dbo.SongGenre
SET genre = 'rock-''n-roll'
WHERE genre = 'rock-''n -roll'
GO

UPDATE Top2000_cleaned.dbo.SongGenre
SET genre = 'trash metal'
WHERE genre = 'trashmetal'
GO



-- tabel met alle genres
-- DROP TABLE Top2000_cleaned.dbo.Genre
CREATE TABLE Top2000_cleaned.dbo.Genre (
	genre_name NVARCHAR(255) PRIMARY KEY
)
GO

INSERT INTO Top2000_cleaned.dbo.Genre (genre_name)
SELECT DISTINCT genre
FROM Top2000_cleaned.dbo.SongGenre
GO

-- Zet foreign key op Top2000_cleaned.dbo.SongGenre
-- ALTER TABLE Top2000_cleaned.dbo.SongGenre DROP CONSTRAINT FK_SongGenre_Genre
ALTER TABLE Top2000_cleaned.dbo.SongGenre
ADD CONSTRAINT FK_SongGenre_Genre
FOREIGN KEY (genre)
REFERENCES Top2000_cleaned.dbo.Genre (genre_name)
ON UPDATE CASCADE
GO

-- ALTER TABLE Top2000_cleaned.dbo.SongGenre DROP CONSTRAINT FK_SongGenre_Song
ALTER TABLE Top2000_cleaned.dbo.SongGenre
ADD CONSTRAINT FK_SongGenre_Song
FOREIGN KEY (titel, artist)
REFERENCES Top2000_cleaned.dbo.Song (titel, artist)
ON UPDATE CASCADE
GO



-- Top2000Lijsten
--DROP TABLE Top2000_cleaned.dbo.Top2000Lijst
CREATE TABLE Top2000_cleaned.dbo.Top2000Lijst (
	edition_year INT NOT NULL,
	position INT NOT NULL,
	titel NVARCHAR(255) NOT NULL,
	artist NVARCHAR(255) NOT NULL,

	PRIMARY KEY (edition_year, position)
)
GO

-- ALTER TABLE Top2000_cleaned.dbo.Top2000Lijst DROP CONSTRAINT FK_Top2000Lijst_Song 
ALTER TABLE Top2000_cleaned.dbo.Top2000Lijst
ADD CONSTRAINT FK_Top2000Lijst_Song 
FOREIGN KEY (titel, artist) 
REFERENCES Top2000_cleaned.dbo.Song (titel, artist)
ON UPDATE CASCADE
GO

INSERT INTO Top2000_cleaned.dbo.Top2000Lijst (edition_year, position, titel, artist)
SELECT editiejaar as edition_year, positie as position, L.Titel as titel,
	CASE
		WHEN CHARINDEX('ft.', L.Artiest) > 0
			THEN TRIM(LEFT(L.Artiest, CHARINDEX('ft.', L.Artiest) - 1))
		ELSE TRIM(L.Artiest)
	END AS artist
FROM Top2000.dbo.Top2000Lijst as L
INNER JOIN Top2000.dbo.Song as S ON L.Artiest = S.Artiest and L.Titel = S.titel
GO

--SELECT editiejaar as edition_year, positie as position, L.Titel as titel, L.Artiest
--FROM Top2000.dbo.Top2000Lijst as L
--FULL JOIN Top2000.dbo.Song as S ON L.Artiest = S.Artiest and L.Titel = S.titel
--WHERE S.Artiest IS NULL


-- Wat doen we met songs die niet in Song staan maar wel in Top2000
-- Wat doen we met songs die niet in Song staan maar wel in SongGenre