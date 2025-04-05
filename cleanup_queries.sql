-- Maak tijdelijke database voor opgeschoonde data
--DROP DATABASE Top2000_cleaned
CREATE DATABASE Top2000_cleaned
GO



-- Tabel voor alle duo's en bands
--DROP TABLE Top2000_cleaned.dbo.ampersand_artists
CREATE TABLE Top2000_cleaned.dbo.ampersand_artists (
	artist_name NVARCHAR(255) PRIMARY KEY
)
GO

-- Importeer bands en duo's
INSERT INTO Top2000_cleaned.dbo.ampersand_artists ([artist_name]) VALUES
	('Alice & Battiato'),
	('Anna & Kate McGarrigle'),
	('Arne Jansen & Les Cigales'),
	('Art Sullivan & Kiki'),
	('Ashford & Simpson'),
	('Barry & Eileen'),
	('Bill & Buster'),
	('Bill Haley & His Comets'),
	('Blood, Sweat & Tears'),
	('Bob & Earl'),
	('Bob Marley & The Wailers'),
	('Bob Seger & The Silver Bullet Band'),
	('Bolland & Bolland'),
	('Booker T. & the M.G.''s'),
	('Brighouse & Rastrick Brass Band'),
	('Bruce Hornsby & The Range'),
	('Captain & Tennille'),
	('Carlos Santana & Willie Nelson'),
	('Chaka Khan & Rufus'),
	('Charles & Eddie'),
	('Charly Lownoise & Mental Theo'),
	('Chas & Dave'),
	('Crosby, Stills & Nash'),
	('Crosby, Stills, Nash & Young'),
	('Danny & the Juniors'),
	('Hall & Oates'),
	('Dave Dee, Dozy, Beaky, Mick & Tich'),
	('Delaney, Bonnie & Friends'),
	('Derek & the Dominos'),
	('Desmond Dekker & The Aces'),
	('Diana Ross & The Supremes'),
	('Earth & Fire'),
	('Earth, Wind & Fire'),
	('Earth, Wind & Fire ft. The Emotions'),
	('Echo & the Bunnymen'),
	('Emerson, Lake & Palmer'),
	('Esther & Abi Ofarim'),
	('Fluitsma & Van Tijn'),
	('Freddie & the Dreamers'),
	('Freek de Jonge & Stips'),
	('Gary Puckett & the Union Gap'),
	('Gerry & the Pacemakers'),
	('Gladys Knight & the Pips'),
	('Gloria Estefan & Miami Sound Machine'),
	('Godley & Creme'),
	('Greenfield & Cook'),
	('Guus Meeuwis & Vagant'),
	('Hank the Knife & the Jets'),
	('Harold Melvin & the Blue Notes'),
	('Henny Vrienten & Herman Brood'),
	('Herb Alpert & The Tijuana Brass'),
	('Herman Brood & His Wild Romance'),
	('Ian Dury & Blockheads'),
	('Ike & Tina Turner'),
	('James & Bobby Purify'),
	('Joan Jett & The Blackhearts'),
	('John Fred & his Playboy Band'),
	('Johnny & Orquestra Rodrigues'),
	('Johnny Mathis & Deniece Williams'),
	('Jon & Vangelis'),
	('Jonathan Richman & The Modern Lovers'),
	('Julie Driscoll & The Brian Auger Trinity'),
	('Katrina & the Waves'),
	('KC & the Sunshine Band'),
	('Kenny Rogers & First Edition'),
	('King Curtis & Kingpins'),
	('Kool & The Gang'),
	('Koot & Bie'),
	('Linda, Roos & Jessica'),
	('Little Steven & Disciples of Soul'),
	('Mac & Katie Kissoon'),
	('Mark & Clark Band'),
	('Marvin, Welch & Farrar'),
	('Mary J. Blige & U2'),
	('Mcguinn, Clark & Hillman'),
	('Mel & Kim'),
	('Michael Nesmith & First National Band'),
	('Milk & Honey'),
	('Moments & Whatnauts'),
	('Mouth & MacNeal'),
	('Mumford & Sons'),
	('Nick & Simon'),
	('Nick Cave & The Bad Seeds'),
	('Nick & Thomas'),
	('Pacific Gas & Electric'),
	('Paul McCartney & Wings'),
	('Peaches & Herb'),
	('Peter & Gordon'),
	('Peter Koelewijn & Zijn Rockets'),
	('Prince & The Revolution'),
	('Roberto Jacketti & the Scooters'),
	('Roger Glover & Guests'),
	('Sam & Dave'),
	('Sam the Sham & the Pharaohs'),
	('Sheila & Black Devotion'),
	('Shirley & Company'),
	('Simon & Garfunkel'),
	('Smokey Robinson & the Miracles'),
	('Sonny & Cher'),
	('Steve Harley & Cockney Rebel'),
	('Steve Rowland & The Family Dogg'),
	('Sutherland Brothers & Quiver'),
	('Suzan & Freek'),
	('The Animals & Eric Burdon'),
	('The Rob Hoeke Rhythm & Blues Group'),
	('Tom Petty & The Heartbreakers'),
	('Tommy Dorsey & Sentimentalists'),
	('Tozzi & Raf'),
	('Veldhuis & Kemper'),
	('Womack & Womack'),
	('Yarbrough & Peoples'),
	('Zager & Evans'),
	('ZZ & De Maskers')
GO

-- Maak tabel aan voor alle artiesten
--DROP TABLE Top2000_cleaned.dbo.Artist
--TRUNCATE TABLE Top2000_cleaned.dbo.Artist
CREATE TABLE Top2000_cleaned.dbo.Artist (
	artist_name NVARCHAR(255) PRIMARY KEY
)
GO

-- [SQSQL1] Haal alle artiesten op die geen duo zijn of band. Maar wel samenwerkings verband hebben
INSERT INTO Top2000_cleaned.dbo.Artist (artist_name)
	SELECT DISTINCT TRIM(CHAR(160) FROM TRIM(value))  as Artiest
	FROM Top2000.dbo.Song as S
	CROSS APPLY string_split(REPLACE(REPLACE(S.Artiest, '&', '#'), 'ft.', '#'), '#')
	LEFT JOIN Top2000_cleaned.dbo.ampersand_artists as A ON S.Artiest = A.artist_name
	WHERE A.artist_name is NULL
GO

-- [SQSQL2] Haal bands/vaste duo's op.
INSERT INTO Top2000_cleaned.dbo.Artist (artist_name)
SELECT DISTINCT S.Artiest
FROM Top2000.dbo.Song as S
INNER JOIN Top2000_cleaned.dbo.ampersand_artists as A ON S.Artiest = A.artist_name
GO



-- Maak tabel voor alle songs aan
--DROP TABLE Top2000_cleaned.dbo.Song
--TRUNCATE TABLE Top2000_cleaned.dbo.Song
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

ALTER TABLE Top2000_cleaned.dbo.Song
ADD CONSTRAINT FK_Song_Artist
FOREIGN KEY (artist) REFERENCES Top2000_cleaned.dbo.Artist(artist_name)
ON UPDATE CASCADE
GO

-- [SQSQL3] Kopieer alle songs met dat geen band of duo is naar Song en haal de hoofd artiest eruit.
INSERT INTO Top2000_cleaned.dbo.Song (titel, release_year, duration, old_componist, artist)
SELECT S.titel as titel, S.Jaar as release_year, S.Speelduur as duration, S.Componist as old_componist,
	TRIM(CHAR(160) FROM
		CASE
			WHEN CHARINDEX('ft.', Artiest) > 0
				THEN TRIM(LEFT(Artiest, CHARINDEX('ft.', Artiest) - 1))
			WHEN CHARINDEX('&', Artiest) > 0
				THEN TRIM(LEFT(Artiest, CHARINDEX('&', Artiest) - 1))
			ELSE TRIM(Artiest)
		END
	) AS artist
FROM Top2000.dbo.Song as S
LEFT JOIN Top2000_cleaned.dbo.ampersand_artists as A ON S.Artiest = A.artist_name
WHERE A.artist_name is NULL
GO

-- [SQSQL4] Kopieer alle songs van vaste duo's of bands
INSERT INTO Top2000_cleaned.dbo.Song (titel, release_year, duration, old_componist, artist)
SELECT S.titel as titel, S.Jaar as release_year, S.Speelduur as duration, S.Componist as old_componist, S.Artiest as artist
FROM Top2000.dbo.Song as S
INNER JOIN Top2000_cleaned.dbo.ampersand_artists as A ON S.Artiest = A.artist_name
GO



-- Maak tabel aan voor alle featured artiesten
--DROP TABLE Top2000_cleaned.dbo.SongFeaturedArtist
CREATE TABLE Top2000_cleaned.dbo.SongFeaturedArtist (
	song_titel NVARCHAR(255) NOT NULL,
	artist NVARCHAR(255) NOT NULL,
	featured_artist NVARCHAR(255) NOT NULL,
	PRIMARY KEY (song_titel, artist, featured_artist)
)
GO

-- ALTER TABLE Top2000_cleaned.dbo.SongFeaturedArtist DROP CONSTRAINT FK_SongFeaturedArtist_Song 
ALTER TABLE Top2000_cleaned.dbo.SongFeaturedArtist 
ADD CONSTRAINT FK_SongFeaturedArtist_Song 
FOREIGN KEY (song_titel, artist) 
REFERENCES Top2000_cleaned.dbo.Song(titel, artist) 
ON UPDATE CASCADE
GO

-- [CQSQL5] Zet alle featured artiesten over
-- SELECT * FROM Top2000_cleaned.dbo.SongFeaturedArtist
-- TRUNCATE TABLE Top2000_cleaned.dbo.SongFeaturedArtist
INSERT INTO Top2000_cleaned.dbo.SongFeaturedArtist (song_titel, artist, featured_artist)
SELECT *
FROM (
	SELECT titel as titel, 
		TRIM(CHAR(160) FROM
			CASE
				WHEN CHARINDEX('ft.', Artiest) > 0
					THEN TRIM(LEFT(Artiest, CHARINDEX('ft.', Artiest) - 1))
				WHEN CHARINDEX('&', Artiest) > 0
					THEN TRIM(LEFT(Artiest, CHARINDEX('&', Artiest) - 1))
				ELSE TRIM(Artiest)
			END
		) AS artist,
		TRIM(CHAR(160) FROM 
			CASE
				WHEN CHARINDEX('ft.', Artiest) > 0
					THEN TRIM(SUBSTRING(Artiest, CHARINDEX('ft.', Artiest) + LEN('ft.'), LEN(Artiest)))
				WHEN CHARINDEX('&', Artiest) > 0
					THEN TRIM(SUBSTRING(Artiest, CHARINDEX('&', Artiest) + LEN('&'), LEN(Artiest))) 
				ELSE NULL
			END 
		) AS featured_artist
	FROM Top2000.dbo.Song as S
	LEFT JOIN Top2000_cleaned.dbo.ampersand_artists as A ON S.Artiest = A.artist_name
	WHERE A.artist_name is NULL
) sub
WHERE featured_artist IS NOT NULL
GO

INSERT INTO Top2000_cleaned.dbo.SongFeaturedArtist
SELECT FA.song_titel, FA.artist, TRIM(CHAR(160) FROM TRIM(value)) as featured_artist
FROM Top2000_cleaned.dbo.SongFeaturedArtist as FA
CROSS APPLY string_split(FA.featured_artist, '&')
LEFT JOIN Top2000_cleaned.dbo.Artist as MA ON MA.artist_name = FA.featured_artist
WHERE MA.artist_name IS NULL
GO

DELETE SFA
FROM Top2000_cleaned.dbo.SongFeaturedArtist as SFA
JOIN (
	SELECT FA.song_titel, FA.artist, FA.featured_artist
	FROM Top2000_cleaned.dbo.SongFeaturedArtist as FA
	LEFT JOIN Top2000_cleaned.dbo.Artist as MA ON MA.artist_name = FA.featured_artist
	WHERE MA.artist_name IS NULL
) sub
ON SFA.artist = sub.artist AND SFA.featured_artist = sub.featured_artist AND SFA.song_titel = sub.song_titel
GO



-- Maak tabel aan voor alle componisten
--DROP TABLE Top2000_cleaned.dbo.Componist
CREATE TABLE Top2000_cleaned.dbo.Componist (
	componist_name NVARCHAR(255) PRIMARY KEY
)
GO

-- [CQSQL6] Haal alle unieke componisten op uit Top2000
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

-- [CQSQL7] Componisten weer koppelen aan de song waar zij bij horen
INSERT INTO Top2000_cleaned.dbo.SongComponist (titel, artist, componist_name)
SELECT titel, artist, TRIM(s.value) as componist_name
FROM Top2000_cleaned.dbo.Song
CROSS APPLY string_split(old_componist, ',') s
GO

--ALTER TABLE Top2000_cleaned.dbo.Song
--DROP COLUMN old_componist
--GO



-- Genre per song tabel
--DROP TABLE Top2000_cleaned.dbo.SongGenre
CREATE TABLE Top2000_cleaned.dbo.SongGenre (
	titel NVARCHAR(255) NOT NULL,
	artist NVARCHAR(255) NOT NULL,
	genre NVARCHAR(255) NOT NULL,

	PRIMARY KEY (titel, artist, genre)
)
GO

-- [CQSQL8] Insert Alle genres voor losse artiesten en songs met featured artiesten
INSERT INTO Top2000_cleaned.dbo.SongGenre (titel, genre, artist)
SELECT S.titel, SG.genre,
	TRIM(CHAR(160) FROM
		CASE
			WHEN CHARINDEX('ft.', S.Artiest) > 0
				THEN TRIM(LEFT(S.Artiest, CHARINDEX('ft.', S.Artiest) - 1))
			WHEN CHARINDEX('&', S.Artiest) > 0
				THEN TRIM(LEFT(S.Artiest, CHARINDEX('&', S.Artiest) - 1))
			ELSE TRIM(S.Artiest)
		END
	) AS artist
FROM Top2000.dbo.Song as S
INNER JOIN Top2000.dbo.SongGenre as SG ON SG.titel = S.titel AND SG.artiest = S.Artiest
LEFT JOIN Top2000_cleaned.dbo.ampersand_artists as A ON S.Artiest = A.artist_name
WHERE A.artist_name is NULL
GO

-- [CQSQL9] Insert alle genres van bands en vaste duo's
INSERT INTO Top2000_cleaned.dbo.SongGenre (titel, genre, artist)
SELECT S.titel, SG.genre, S.Artiest as artist
FROM Top2000.dbo.Song as S
INNER JOIN Top2000.dbo.SongGenre as SG ON SG.titel = S.titel AND SG.artiest = S.Artiest
INNER JOIN Top2000_cleaned.dbo.ampersand_artists as A ON S.Artiest = A.artist_name
GO


-- Genre namen opschonen
SELECT DISTINCT genre
FROM Top2000_cleaned.dbo.SongGenre
GO

-- [CQSQL10]
UPDATE Top2000_cleaned.dbo.SongGenre
SET genre = 'alternatieve rock'
WHERE genre = 'allternatieve rock' OR genre = 'alternative rock'
GO

-- [CQSQL11]
UPDATE Top2000_cleaned.dbo.SongGenre
SET genre = 'elektronische muziek'
WHERE genre = 'elketronische muziek'
GO

-- [CQSQL12]
UPDATE Top2000_cleaned.dbo.SongGenre
SET genre = 'Keltische rock'
WHERE genre = 'Celtic rock'
GO

-- [CQSQL13]
UPDATE Top2000_cleaned.dbo.SongGenre
SET genre = 'psychedelische rock'
WHERE genre = 'psychedelic rock'
GO

-- [CQSQL14]
UPDATE Top2000_cleaned.dbo.SongGenre
SET genre = 'rock-''n-roll'
WHERE genre = 'rock-''n -roll'
GO

-- [CQSQL15]
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

-- [CQSQL16]
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

-- [CQSQL17]
INSERT INTO Top2000_cleaned.dbo.Top2000Lijst (edition_year, position, titel, artist)
SELECT editiejaar as edition_year, positie as position, L.Titel as titel,
	TRIM(CHAR(160) FROM
		CASE
			WHEN CHARINDEX('ft.', S.Artiest) > 0
				THEN TRIM(LEFT(S.Artiest, CHARINDEX('ft.', S.Artiest) - 1))
			WHEN CHARINDEX('&', S.Artiest) > 0
				THEN TRIM(LEFT(S.Artiest, CHARINDEX('&', S.Artiest) - 1))
			ELSE TRIM(S.Artiest)
		END
	) AS artist
FROM Top2000.dbo.Top2000Lijst as L
INNER JOIN Top2000.dbo.Song as S ON L.Artiest = S.Artiest and L.Titel = S.titel
LEFT JOIN Top2000_cleaned.dbo.ampersand_artists as A ON S.Artiest = A.artist_name
WHERE A.artist_name is NULL
GO

-- [CQSQL18]
INSERT INTO Top2000_cleaned.dbo.Top2000Lijst (edition_year, position, titel, artist)
SELECT editiejaar as edition_year, positie as position, L.Titel as titel, S.artiest
FROM Top2000.dbo.Top2000Lijst as L
INNER JOIN Top2000.dbo.Song as S ON L.Artiest = S.Artiest and L.Titel = S.titel
INNER JOIN Top2000_cleaned.dbo.ampersand_artists as A ON S.Artiest = A.artist_name
GO
