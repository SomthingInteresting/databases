-- SELECT title
--   FROM albums
--   WHERE release_year >= 1980 AND release_year <= 1990 AND artist_id = 1;

-- -- UPDATE albums
-- --    SET release_year = '1972'
-- --  WHERE id = '3';

-- DELETE FROM albums
--  WHERE id = '12';

INSERT INTO artists 
  (name, genre)
  VALUES('The National', 'Indie Rock');

INSERT INTO albums
  ( title, release_year, artist_id )
  VALUES('Trouble Will Find Me', '2013', '6');

  UPDATE albums
    SET artist_id = '5'
  WHERE id = '13';