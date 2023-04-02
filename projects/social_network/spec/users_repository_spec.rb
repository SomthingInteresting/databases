require 'users_repository'

RSpec.describe UsersRepository do

  def reset_users_table
    seed_sql = File.read('spec/seeds_users.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_users_table
  end

  it 'returns all users' do
    repo = UsersRepository.new

    user = repo.all

    expect(user.length).to eq 2
    expect(user[0].id).to eq 1
    expect(user[0].name).to eq 'David'
    expect(user[0].email).to eq 'example1@gmail.com'

    expect(user[1].id).to eq 2
    expect(user[1].name).to eq 'Anna'
    expect(user[1].email).to eq 'example2@hotmail.co.uk'
  end

  it 'returns David and his email' do
    repo = UsersRepository.new

    user = repo.find(1)

    expect(user.id).to eq 1
    expect(user.name).to eq 'David'
    expect(user.email).to eq 'example1@gmail.com'
  end

  it 'creates Bob as new user' do
    repo = UsersRepository.new

    new_user = User.new
    new_user.name = 'Bob'
    new_user.email = 'bobbobby@yahoo.com'
    
    repo.create(new_user)
    
    users = repo.all
    last_user = users.last
    
    expect(last_user.id).to eq 3
    expect(last_user.name).to eq 'Bob'
    expect(last_user.email).to eq 'bobbobby@yahoo.com'
  end

  xit 'deletes user with id 1' do
    repo = UsersRepository.new
    id_to_delete = 1
    repo.delete(id_to_delete)
    users = repo.all
    expect(users.length).to eq 1
    expect(users.first.id).to eq  2
  end
end



