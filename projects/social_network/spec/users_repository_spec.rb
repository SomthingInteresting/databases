require 'users_repository'
require 'pg'

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
    expect(user[0].cohort_name).to eq 'example1@gmail.com'

    expect(user[1].id).to eq 2
    expect(user[1].name).to eq 'Anna'
    expect(user[1].cohort_name).to eq 'example2@hotmail.co.uk'
  end
end



