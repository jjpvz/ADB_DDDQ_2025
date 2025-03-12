SELECT editiejaar, positie
FROM Top2000Lijst
GROUP BY editiejaar, positie
HAVING COUNT(positie) <> 1

SELECT Artiest, Titel
FROM Top2000Lijst as list
WHERE NOT EXISTS (
	SELECT *
	FROM Song as song
	WHERE list.Artiest = song.Artiest
	AND list.Titel = song.titel
)