require 'artist_repository'

RSpec.describe ArtistRepository do
  
  def reset_artists_table
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_artists_table
  end
  
  it 'returns the list of artists' do
    repo = ArtistRepository.new

    artists = repo.all
    expect(artists.length).to eq(2) 
    expect(artists.first.id).to eq('1')
    expect(artists.first.name).to eq 'Pixies'
  end

  it 'returns the Pixies as a single artist' do
    repo = ArtistRepository.new

    artist = repo.find(1)
    expect(artist.name).to eq('Pixies')
    expect(artist.genre).to eq('Rock')
  end

  it 'returns the ABBA as a single artist' do
    repo = ArtistRepository.new

    artist = repo.find(2)
    expect(artist.name).to eq('ABBA')
    expect(artist.genre).to eq('Pop')
  end

  it 'creates a new artist' do
    repo = ArtistRepository.new

    artist = Artist.new
    artist.name = 'The Beatles'
    artist.genre = 'Rock'

    repo.create(artist)

    artists = repo.all
    last_artist = artists.last

    expect(last_artist.name).to eq('The Beatles')
    expect(last_artist.genre).to eq('Rock')
  end

  it 'deletes artist id 1' do
    repo = ArtistRepository.new

    id_to_delete = 1

    repo.delete(id_to_delete)

    all_artists = repo.all
    expect(all_artists.length).to eq 1
    expect(all_artists.first.id).to eq '2'
  end

  it 'deletes two artists' do
    repo = ArtistRepository.new

    repo.delete(1)
    repo.delete(2)

    all_artists = repo.all
    expect(all_artists.length).to eq 0
  end

  it 'updates the name and genre of artist id 1' do
    repo = ArtistRepository.new

    artist = repo.find(1)
    artist.name = 'Something else'
    artist.genre = 'Disco'

    repo.update(artist)

    updated_artist = repo.find(1)
    expect(updated_artist.name).to eq('Something else')
    expect(updated_artist.genre).to eq('Disco')
  end
end