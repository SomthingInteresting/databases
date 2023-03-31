TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, views, user_id) VALUES ('fancy title', 'very fancy content here', 4, 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('boring title', 'extremely boring content', 10, 2);
INSERT INTO posts (title, content, views, user_id) VALUES ('double title', 'double content', 9, 1);