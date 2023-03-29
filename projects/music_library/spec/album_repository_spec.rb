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
end