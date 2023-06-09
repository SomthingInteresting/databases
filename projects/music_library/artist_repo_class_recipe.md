# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

TABLE ALREADY CREATED

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

TRUNCATE TABLE artists RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO artists (name, genre) VALUES ('Pixies', 'Rock');
INSERT INTO artists (name, genre) VALUES ('ABBA', 'Pop');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 music_library_test < seeds_artists.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: artists

# Model class
# (in lib/artist.rb)
class Artist
end

# Repository class
# (in lib/artist_repository.rb)
class ArtistRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: artists

# Model class
# (in lib/artist.rb)

class Student

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :cohort_name
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: artists

# Repository class
# (in lib/artists_repository.rb)

class ArtistRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists;

    # Returns an array of Artist objects.
  end

  #Selects a single record 
  #Given the id in argument (a number)
  def find(id)
  # Executes the SQL query:
  # SELECT id, name, genre FROM artists WHERE id = $1;

  # Returns a single Artist object.
  end

  # Inserting a record
  # Given an Artist object in argument
  def create(artist)
  # Executes the SQL query:
  # INSERT INTO artists (name, genre) VALUES ($1, $2);

  # Doesn't need to return anything.
  end

  # Updating a record
  # Given an Artist object in argument
  def update(artist)
  # Executes the SQL query:
  # UPDATE artists SET name = $1, genre = $2 WHERE id = $3;

  # Doesn't need to return anything.
  end

  # Deleting a record
  # Given the id in argument (a number)
  def delete(id)
  # Executes the SQL query:
  # DELETE FROM artists WHERE id = $1;

  # Doesn't need to return anything.
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all artists

repo = ArtistRepository.new

artists = repo.all
artists.length # => 2
artists.first.id => 1
artists.first.name => 'Pixies'

# 2
# Get a single artist

repo = ArtistRepository.new

artist = repo.find(1)
artist.name => 'Pixies'
artist.genre => 'Rock'

# 3
# Get another single artist

repo = ArtistRepository.new

artist = repo.find(2)
artist.name => 'ABBA'
artist.genre => 'Pop'

# 4
# Create a new artist

repo = ArtistRepository.new

artist = Artist.new
artist.name = 'The Beatles'
artist.genre = 'Rock'

repo.create(artist) # => nil

artists = repo.all

last_artist = artists.last
last_artist.name => 'The Beatles'
last_artist.genre => 'Rock'

# 5
# Delete an artist

repo = ArtistRepository.new

id_to_delete = 1

artist = repo.find(id_to_delete)

artist.delete(artist.id) # => nil

all_artists = repo.all
all_artists.length => 1
all_artists.first.id => '2'

# 6
# Update an artist

repo = ArtistRepository.new

artist = repo.find(1)

artist.name = 'Something else'
artist.genre = 'Disco'

repo.update(artist) # => nil

updated_artist = repo.find(1)

updated_artist.name => 'Something else'
updated_artist.genre => 'Disco'



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
