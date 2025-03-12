
-- No primary key violation.
SELECT editiejaar, positie
FROM Top2000Lijst
GROUP BY editiejaar, positie
HAVING COUNT(positie) <> 1

-- No (logical) primary key violation.
SELECT Artiest, titel, COUNT(1)
FROM Song
GROUP BY Artiest, titel
HAVING COUNT(1) > 1

-- No (logical) primary key violation.
SELECT artiest, titel, genre, COUNT(1)
FROM SongGenre
GROUP BY artiest, titel, genre 
HAVING COUNT(1) > 1

-- Referential integrity violation on 122 records.
SELECT Artiest, Titel
FROM Top2000Lijst as list
WHERE NOT EXISTS (
	SELECT *
	FROM Song as song
	WHERE list.Artiest = song.Artiest
	AND list.Titel = song.titel
)

-- Referential integrity violation on 7 records.
SELECT artiest, titel
FROM SongGenre as genre
WHERE NOT EXISTS (
	SELECT *
	FROM Song as song
	WHERE genre.Artiest = song.Artiest
	AND genre.Titel = song.titel
)

-- IR1 violation on 2 records.
SELECT editiejaar, Artiest, Titel, COUNT(1)
FROM Top2000Lijst
GROUP BY editiejaar, Artiest, Titel
HAVING COUNT(*) > 1

-- No IR2 violation.
SELECT song.Artiest, 
	song.titel, 
	song.Jaar,
	list.editiejaar
FROM Top2000Lijst AS list
INNER JOIN Song AS song
ON list.Artiest = song.Artiest 
AND list.Titel = song.titel
WHERE song.Jaar > list.editiejaar

-- 100% of the songs in the Top2000 list in 2019 has a value for duration
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

-- 98.60% of the songs in the Top2000 list in 2019 has a value for composer
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

-- 97.25% of the songs in the Top2000 list in 2019 has a value for genre
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

-- 96.00% of the songs in the Top2000 list in 2019 has a value for every given property
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