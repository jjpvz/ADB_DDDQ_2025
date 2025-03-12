-- Check op tabel Top2000Lijst.
SELECT editiejaar, positie
FROM Top2000Lijst
GROUP BY editiejaar, positie
HAVING COUNT(*) <> 1

-- Check op tabel Song.
SELECT Artiest, titel
FROM Song
GROUP BY Artiest, titel
HAVING COUNT(*) > 1

-- Check op tabel SongGenre.
SELECT artiest, titel, genre
FROM SongGenre
GROUP BY artiest, titel, genre 
HAVING COUNT(*) > 1