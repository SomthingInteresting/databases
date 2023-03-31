require 'album_repository'

RSpec.describe AlbumRepository do
  
  def reset_album_table
    seed_sql = File.read('spec/seeds_album.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_album_table
  end
  
  it 'returns the list of albums' do
    repo = AlbumRepository.new

    album = repo.all
    expect(album.length).to eq(2) 
    expect(album.first.id).to eq('1')
    expect(album.first.title).to eq 'Doolittle'
  end

  it 'returns Surfer Rosa as a single album' do
    repo = AlbumRepository.new

    album = repo.find(2)
    expect(album.title).to eq('Surfer Rosa')
    expect(album.release_year).to eq('1988')
  end

  it 'creates a new album' do
    repo = AlbumRepository.new
    
    new_album = Album.new
    new_album.title = 'Trompe le Monde'
    new_album.release_year = 1991
    new_album.artist_id = 3
    
    repo.create(new_album)
    albums = repo.all
    last_album = albums.last

    expect(last_album.id).to eq '3'
    expect(last_album.title).to eq 'Trompe le Monde'
    expect(last_album.release_year).to eq '1991'
    expect(last_album.artist_id).to eq '3'
  end
end