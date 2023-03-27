TRUNCATE TABLE books RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO books (title, author_name) VALUES ('Dracula', 'Bram Stoker');
INSERT INTO books (title, author_name) VALUES ('Emma', 'Jane Austen');