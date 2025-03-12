-- Check on value for every given property for songs in the Top2000 list in 2019.
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