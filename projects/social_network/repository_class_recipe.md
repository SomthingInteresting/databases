# {{TABLE NAME}} Model and Repository Classes Design Recipe


## 1. Design and create the Table


## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE users RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (name, email) VALUES ('David', 'example1@gmail.com');
INSERT INTO users (name, email) VALUES ('Anna', 'example2@hotmail.co.uk');



TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, views, user_id) VALUES ('fancy title', 'very fancy content here', 4, 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('boring title', 'extremely boring content', 10, 2);
INSERT INTO posts (title, content, views, user_id) VALUES ('double title', 'double content', 9, 1);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network_test < seeds_posts.sql

psql -h 127.0.0.1 social_network_test < seeds_users.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: users

# Model class
# (in lib/users.rb)
class Users
end

# Repository class
# (in lib/users_repository.rb)
class UsersRepository
end

# Table name: posts

# Model class
# (in lib/posts.rb)
class Posts
end

# Repository class
# (in lib/posts_repository.rb)
class PostsRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: users

# Model class
# (in lib/users.rb)

class Users

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :email
end

class Posts

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :views, :user_id
end


```

## 5. Define the Repository Class interface


```ruby
# EXAMPLE
# Table name: users

# Repository class
# (in lib/users_repository.rb)

class UsersRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, email FROM users;

    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, email FROM users WHERE id = $1;

    # Returns a single User object.
  end

  # Creates a single record
  def create(user)
    # Executes the SQL query:
    # INSERT INTO users (name, email) VALUES ($1, $2);
  end

  # Updates a record
  def update(user)
    # Executes the SQL query:
    # UPDATE users SET name = $1, email = $2 WHERE id = $3
  end

  # Deletes a record
  def delete(user)
    # Executes the SQL query:
    # DELETE FROM users WHERE id = $1
  end
end

class PostsRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, views, user_id FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, views, user_id FROM posts WHERE id = $1;

    # Returns a single Post object.
  end

  # Creates a single record
  def create(post)
    # Executes the SQL query:
    # INSERT INTO posts (title, content, views, user_id) VALUES ($1, $2, $3, $4);
  end

  # Updates a record
  def update(user)
    # Executes the SQL query:
    # UPDATE posts SET title = $1, content = $2, views = $3, user_id = $4 WHERE id = $5
  end

  # Deletes a record
  def delete(user)
    # Executes the SQL query:
    # DELETE FROM posts WHERE id = $1
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all users

repo = PostsRepository.new

user = repo.all

user.length # =>  2

user[0].id # =>  1
user[0].name # =>  'David'
user[0].email # =>  'example1@gmail.com'

user[1].id # =>  2
user[1].name # =>  'Anna'
user[1].email # =>  'example2@hotmail.co.uk'


# 2
# Find a single user

repo = UsersRepository.new

user = repo.find(1)


user.id # =>  1
user.name # =>  'David'
user.email # =>  'example1@gmail.com'

# 3
# Create a single user

repo = UsersRepository.new

user = User.new
user.name = 'Bob'
user.email = 'bobbobby@yahoo.com'

repo.create(user)

users = repo.all
last_user = user.last


user.id # =>  3
user.name # =>  'Bob'
user.email # =>  'bobbobby@yahoo.com'

# 4
# Delete a single user

repo = UsersRepository.new

id_to_delete = 1

repo.delete(id_to_delete)

users = repo.all

user.length => 1
user.first.id  =>  2


# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->
