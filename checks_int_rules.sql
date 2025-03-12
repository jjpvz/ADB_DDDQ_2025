-- IR1. Een song staat maximaal een keer in een editie van de Top 2000.
SELECT editiejaar, Artiest, Titel, COUNT(1)
FROM Top2000Lijst
GROUP BY editiejaar, Artiest, Titel
HAVING COUNT(*) > 1

-- IR2. Elke song die in een editie van de Top 2000 staat, is voor of in het jaar van de betreffende editie uitgebracht.
SELECT song.Artiest, 
	song.titel,
	song.Jaar,
	list.editiejaar
FROM Top2000Lijst AS list
INNER JOIN Song AS song
ON list.Artiest = song.Artiest
AND list.Titel = song.titel
WHERE song.Jaar > list.editiejaar