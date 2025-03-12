-- Check on Top2000Lijst's (logically) referentie naar Song
SELECT Artiest, Titel
FROM Top2000Lijst as list
WHERE NOT EXISTS (
	SELECT *
	FROM Song as song
	WHERE list.Artiest = song.Artiest
	AND list.Titel = song.titel
)

-- Check on SongGenre's (logically) referentie naar Song
SELECT artiest, titel
FROM SongGenre as genre
WHERE NOT EXISTS (
	SELECT *
	FROM Song as song
	WHERE genre.Artiest = song.Artiest
	AND genre.Titel = song.titel
)