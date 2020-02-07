USE albums_db;

DESCRIBE albums;

#Name of all albums by Pink Floyd
SELECT name
FROM albums
WHERE artist = 'Pink Floyd';

#Year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

#Genre for the album Nevermind
SELECT genre
FROM albums
WHERE name = 'Nevermind';

#Albums that were released in the 1990s
SELECT *
FROM albums
WHERE release_date BETWEEN 1990 and 1999;

#Albums that had less than 20 million certified sales
SELECT *
FROM albums
WHERE sales < 20;

/* Albums with a genre of "Rock". This query does not return the albums with a genre of "Hard rock" or "Progressive rock" because the WHERE clause is looking for exact matches of only the word "Rock" in the genre column */
SELECT *
FROM albums
WHERE genre = "Rock";

#This query returns all albums that have the word "Rock" in the genre column
SELECT *
FROM albums
WHERE genre LIKE '%rock%';
