-- [DKSQ01] Geen uniforme schrijfwijze
SELECT DISTINCT genre
FROM [Top2000].[dbo].[SongGenre]

-- [DKSQ02] Check on Top2000Lijst's (logische) referentie naar Song
SELECT Artiest, Titel
FROM Top2000Lijst as list
WHERE NOT EXISTS (
	SELECT *
	FROM Song as song
	WHERE list.Artiest = song.Artiest
	AND list.Titel = song.titel
)

-- [DKSQ03] Check on SongGenre's (logische) referentie naar Song
SELECT artiest, titel
FROM SongGenre as genre
WHERE NOT EXISTS (
	SELECT *
	FROM Song as song
	WHERE genre.Artiest = song.Artiest
	AND genre.Titel = song.titel
)

-- [DKSQ04] Check on value for every given property for songs in the Top2000 list in 2019.
SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Top2000Lijst WHERE editiejaar = '2019')) as completeness_percentage
FROM (
		SELECT song.Artiest, 
			song.titel, 
			song.Jaar,
			song.Speelduur,
			song.Componist,
			list.editiejaar,
			COUNT(genre.genre) AS number_of_genres
		FROM Top2000Lijst AS list
		INNER JOIN Song AS song
		ON list.Artiest = song.Artiest 
		AND list.Titel = song.titel
		LEFT JOIN SongGenre as genre
		ON genre.artiest = song.Artiest 
		AND genre.titel = song.titel
		WHERE list.editiejaar = '2019'
		GROUP BY song.Artiest, 
			song.titel, 
			song.Jaar,
			song.Speelduur,
			song.Componist,
			list.editiejaar,
			genre.artiest,
			genre.titel
		HAVING COUNT(genre.genre) >= 1
		AND song.Componist IS NOT NULL
		AND song.Speelduur IS NOT NULL
) as Dataset

-- [DKSQ05] 100% of the songs in the Top2000 list in 2019 has a value for duration
SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Top2000Lijst WHERE editiejaar = '2019')) as completeness_percentage
FROM (
		SELECT song.Artiest, 
			song.titel, 
			song.Jaar,
			song.Speelduur,
			song.Componist,
			list.editiejaar,
			COUNT(genre.genre) AS number_of_genres
		FROM Top2000Lijst AS list
		INNER JOIN Song AS song
		ON list.Artiest = song.Artiest 
		AND list.Titel = song.titel
		LEFT JOIN SongGenre as genre
		ON genre.artiest = song.Artiest 
		AND genre.titel = song.titel
		WHERE list.editiejaar = '2019'
		GROUP BY song.Artiest, 
			song.titel, 
			song.Jaar,
			song.Speelduur,
			song.Componist,
			list.editiejaar,
			genre.artiest,
			genre.titel
		HAVING song.Speelduur IS NOT NULL
) as Dataset

-- [DKSQ06] 98.60% of the songs in the Top2000 list in 2019 has a value for composer
SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Top2000Lijst WHERE editiejaar = '2019')) as completeness_percentage
FROM (
		SELECT song.Artiest, 
			song.titel, 
			song.Jaar,
			song.Speelduur,
			song.Componist,
			list.editiejaar,
			COUNT(genre.genre) AS number_of_genres
		FROM Top2000Lijst AS list
		INNER JOIN Song AS song
		ON list.Artiest = song.Artiest 
		AND list.Titel = song.titel
		LEFT JOIN SongGenre as genre
		ON genre.artiest = song.Artiest 
		AND genre.titel = song.titel
		WHERE list.editiejaar = '2019'
		GROUP BY song.Artiest, 
			song.titel, 
			song.Jaar,
			song.Speelduur,
			song.Componist,
			list.editiejaar,
			genre.artiest,
			genre.titel
		HAVING song.Componist IS NOT NULL
) as Dataset

-- [DKSQ07] 97.25% of the songs in the Top2000 list in 2019 has a value for genre
SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Top2000Lijst WHERE editiejaar = '2019')) as completeness_percentage
FROM (
		SELECT song.Artiest, 
			song.titel, 
			song.Jaar,
			song.Speelduur,
			song.Componist,
			list.editiejaar,
			COUNT(genre.genre) AS number_of_genres
		FROM Top2000Lijst AS list
		INNER JOIN Song AS song
		ON list.Artiest = song.Artiest 
		AND list.Titel = song.titel
		LEFT JOIN SongGenre as genre
		ON genre.artiest = song.Artiest 
		AND genre.titel = song.titel
		WHERE list.editiejaar = '2019'
		GROUP BY song.Artiest, 
			song.titel, 
			song.Jaar,
			song.Speelduur,
			song.Componist,
			list.editiejaar,
			genre.artiest,
			genre.titel
		HAVING COUNT(genre.genre) >= 1
) as Dataset


-- [DKSQ08] Check op tabel Top2000Lijst.
SELECT editiejaar, positie
FROM Top2000Lijst
GROUP BY editiejaar, positie
HAVING COUNT(*) <> 1


-- [DKSQ09] Check op tabel Song.
SELECT Artiest, titel
FROM Song
GROUP BY Artiest, titel
HAVING COUNT(*) > 1


-- [DKSQ10] Check op tabel SongGenre.
SELECT artiest, titel, genre
FROM SongGenre
GROUP BY artiest, titel, genre 
HAVING COUNT(*) > 1


-- [DKSQ11] IR1. Een song staat maximaal een keer in een editie van de Top 2000.
SELECT editiejaar, Artiest, Titel, COUNT(1)
FROM Top2000Lijst
GROUP BY editiejaar, Artiest, Titel
HAVING COUNT(*) > 1


-- [DKSQ12] IR2. Elke song die in een editie van de Top 2000 staat, is voor of in het jaar van de betreffende editie uitgebracht.
SELECT song.Artiest, 
	song.titel,
	song.Jaar,
	list.editiejaar
FROM Top2000Lijst AS list
INNER JOIN Song AS song
ON list.Artiest = song.Artiest
AND list.Titel = song.titel
WHERE song.Jaar > list.editiejaar

-- [DKSQ13] Check on population completeness
SELECT [editiejaar], count(*)
FROM [Top2000].[dbo].[Top2000Lijst]
GROUP BY editiejaar
ORDER BY editiejaar desc

-- [DKSQ14] Check on accuracy
SELECT TOP (1000) [Artiest]
      ,[titel]
      ,[Jaar]
      ,[Componist]
      ,[Speelduur]
  FROM [Top2000].[dbo].[Song]
  where [Speelduur] = '00:00:00'
