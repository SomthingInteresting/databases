require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'

DatabaseConnection.connect('music_library') # real data base used here as rspec only uses the test database

artist_repository = ArtistRepository.new

artist_repository.all.each do |artist|
  puts "#{artist.id} - #{artist.name} - #{artist.genre}"
end