# Opdracht 1: Onderzoek de datakwaliteit

## B

### Duiding databasestructuur



### Primary key violation check

Check on table **Top2000Lijst**. See [t-sql statement](./checks.sql).

``` t-sql
SELECT editiejaar, positie
FROM Top2000Lijst
GROUP BY editiejaar, positie
HAVING COUNT(positie) <> 1
```

> :green_square: No primary key violation.

Check on table **SongGenre**. See [t-sql statement](./checks.sql).

``` t-sql
SELECT artiest, titel, genre, COUNT(1)
FROM SongGenre
GROUP BY artiest, titel, genre 
HAVING COUNT(1) > 1
```

> :green_square: No (logical) primary key violation.

Check on table **Song**. See [t-sql statement](./checks.sql).

``` t-sql
SELECT Artiest, titel, COUNT(1)
FROM Song
GROUP BY Artiest, titel
HAVING COUNT(1) > 1
```

> :green_square: No (logical) primary key violation.

### Referential integrity check

Check on Top2000Lijst (logically) referencing Song. See [t-sql statement](./checks.sql).

``` t-sql
SELECT Artiest, Titel
FROM Top2000Lijst as list
WHERE NOT EXISTS (
	SELECT *
	FROM Song as song
	WHERE list.Artiest = song.Artiest
	AND list.Titel = song.titel
)
```

> :red_square: Referential integrity violation on 122 records.

Check on SongGenre (logically) referencing Song. See [t-sql statement](./checks.sql).

``` t-sql
SELECT artiest, titel
FROM SongGenre as genre
WHERE NOT EXISTS (
	SELECT *
	FROM Song as song
	WHERE genre.Artiest = song.Artiest
	AND genre.Titel = song.titel
)
```

> :red_square: Referential integrity violation on 7 records.

### Third Normal Form (3NF) check

According to theory a table is in First Normal Form (1NF) if every cell contains an atomic value. Each cell for all columns for every table contain a reasonable atomic (= indivisible) value except for the 'Componist' column in table 'Song'. It contains a comma separated list of values which violates the First Normal Form. This means the table is not normalized and definitely not in Third Normal Form.

> :red_square: Not normalized 'Song' table.

### Integrity rule check

IR1. Een song staat maximaal één keer in een editie van de Top 2000.

See [t-sql statement](./checks.sql).

```
SELECT editiejaar, Artiest, Titel, COUNT(1)
FROM Top2000Lijst
GROUP BY editiejaar, Artiest, Titel
HAVING COUNT(*) > 1
```

> :red_square: IR1 violation on 2 records.

IR2. Elke song die in een editie van de Top 2000 staat, is vóór of ìn het jaar van de 
betreffende editie uitgebracht.

```
SELECT song.Artiest, 
	song.titel, 
	song.Jaar,
	list.editiejaar
FROM Top2000Lijst AS list
INNER JOIN Song AS song
ON list.Artiest = song.Artiest 
AND list.Titel = song.titel
WHERE song.Jaar > list.editiejaar
```

> :green_square: No IR2 violation.

### Completeness check

Check on value for duration for songs in the Top2000 list in 2019. See [t-sql statement](./checks.sql).

```
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
```

> :green_square: 100% of the songs in the Top2000 list in 2019 has a value for duration.

Check on value for composer for songs in the Top2000 list in 2019. See [t-sql statement](./checks.sql).

```
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
```

> :red_square: 98.60% of the songs in the Top2000 list in 2019 has a value for composer.

Check on value for genre for songs in the Top2000 list in 2019. See [t-sql statement](./checks.sql).

```
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
```

> :red_square: 97.25% of the songs in the Top2000 list in 2019 has a value for genre.

Check on value for every given property for songs in the Top2000 list in 2019. See [t-sql statement](./checks.sql).

```
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
```

> :red_square: 96.00% of the songs in the Top2000 list in 2019 has a value for every given property.

### Other remarks

#### 1. The attribute 'artiest' regards a person and should therefore be it's own entity (table).

#### 2. The table 'SongGenre' is not normalized past the First Normal Form and has therefore a lot of redundant data.

#### 3. Alternative writing styles for genres in table 'SongGenre'.

```
SELECT DISTINCT genre
  FROM [Top2000].[dbo].[SongGenre]
```

| Original             | Alternative 1       | Alternative 2         |
|----------------------|--------------------|-----------------------|
| allternatieve rock   | alternatieve rock  | -     |
| elektronisch        | elektronische muziek | elketronische muziek |
| hard rock          | hardrock           | -                     |
| Keltisch           | Keltische muziek   | -                     |
| kerstlied          | kerstmuziek        | -                     |
| klassiek           | klassieke muziek   | -                     |
| poppunk           | popunk             | -           |
| psychedelic rock  | psychedelische rock | -                     |
| rock-'n -roll     | rock-'n-roll       | -         |
| trash metal       | trashmetal         | -         |

#### 4. The tables 'Song' and 'SongGenre' do not have a primary key.

#### 5. Table and column names are written in dutch and english and multiple casing styles are applied.

#### 6. The column 'Jaar' in table 'Song' has a datatype float.

| Column Name      | Data Type          | Allow Nulls |
|------------|--------------|-------------|
| Artiest    | nvarchar(255) | Yes     |
| Titel      | nvarchar(255) | Yes     |
| **Jaar**       | **float**         | **Yes**     |
| Componist  | nvarchar(255) | Yes     |
| Speelduur  | time(0)       | Yes     |


#### 7. The nullability of columns which should be mandatory such as 'Artiest' and 'Titel'.

| Column Name      | Data Type          | Allow Nulls |
|------------|--------------|-------------|
| **Artiest**    | **nvarchar(255)** | **Yes**     |
| **Titel**      | **nvarchar(255)** | **Yes**     |
| Jaar       | float         | Yes     |
| Componist  | nvarchar(255) | Yes     |
| Speelduur  | time(0)       | Yes     |


#### 8. The table 'Top2000Lijst' includes records up to edition year 2020.

```
SELECT TOP (1000) [editiejaar]
      ,[positie]
      ,[Artiest]
      ,[Titel]
  FROM [Top2000].[dbo].[Top2000Lijst]
  ORDER BY editiejaar desc
```

| editiejaar | positie | Artiest                     | Titel                          |
|------------|---------|----------------------------|--------------------------------|
| 2020       | 2000    | Electric Light Orchestra   | Can't Get It Out of My Head    |


#### 9. Songs can have a duration of 0 seconds.

| Artiest                         | titel             | Jaar | Componist                                             | Speelduur  |
|----------------------------------|------------------|------|------------------------------------------------------|------------|
| André Hazes                      | Geef mij je angst | 1984 | Udo Jürgens, Michael Kunze, André Hazes              | 00:00:00   |
| BLØF & Counting Crows            | Holiday in Spain | 2004 | NULL                                                 | 00:00:00   |
| Ella Fitzgerald & Louis Armstrong | Summertime       | 1957 | George Gershwin, DuBose Heyward                      | 00:00:00   |
| Elton John                       | Circle of Life   | 1994 | Elton John, Tim Rice                                 | 00:00:00   |
| Guus Meeuwis                     | Geef mij je angst | 2004 | Udo Jürgens, Michael Kunze, André Hazes              | 00:00:00   |
| Mike Oldfield                    | Tubular Bells    | 1974 | Mike Oldfield                                        | 00:00:00   |
| Nena                             | 99 Luftballons   | 1983 | Carlo Karges, Uwe Fahrenkrog-Petersen               | 00:00:00   |
| Nielson                          | IJskoud          | 2018 | Niels Littooij, Don Zwaaneveld, Lodewijk Martens     | 00:00:00   |
| Sammy Davis jr.                  | Mr. Bojangles    | 1972 | Jerry Jeff Walker                                    | 00:00:00   |

