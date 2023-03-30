require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

DatabaseConnection.connect('music_library') # real data base used here as rspec only uses the test database

artist_repository = ArtistRepository.new
album_repository = AlbumRepository.new

# artist_repository.all.each do |artist|
#   puts "#{artist.id} - #{artist.name} - #{artist.genre}"
# end

# album_repository.all.each do |album|
#   puts "#{album.id} - #{album.title} - #{album.release_year} - #{album.artist_id}"
# end

# artist = artist_repository.find(4)
# puts artist.name

album = album_repository.find(3)
  puts "#{album.id} - #{album.title} - #{album.release_year} - #{album.artist_id}"

# artist = Artist.new
# artist.name = "The Beatles"
# artist.genre = "Rock"

# repo.create(artist) # INSERT INTO artists (name, genre) VALUES ('The Beatles', 'Rock')

# repo.delete(id) # DELETE FROM artists WHERE id = 1 for example

# artist = repo.find(1)
# artist.name = "Whatever"

# repo.update(artist) # UPDATE artists SET name = 'Whatever' WHERE id = 1 for example