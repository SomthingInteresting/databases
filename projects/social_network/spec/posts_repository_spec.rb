require 'posts_repository'

RSpec.describe PostsRepository do

  def reset_posts_table
    seed_sql = File.read('spec/seeds_posts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_posts_table
  end

  it 'returns all posts' do
    repo = PostsRepository.new

    post = repo.all

    expect(post.length).to eq 3

    expect(post[0].id).to eq 1
    expect(post[0].title).to eq 'fancy title'
    expect(post[0].content).to eq 'very fancy content here'
    expect(post[0].views).to eq 4
    expect(post[0].user_id).to eq 1

    expect(post[1].id).to eq 2
    expect(post[1].title).to eq 'boring title'
    expect(post[1].content).to eq 'extremely boring content'
    expect(post[1].views).to eq 10
    expect(post[1].user_id).to eq 2

    expect(post[2].id).to eq 3
    expect(post[2].title).to eq 'double title'
    expect(post[2].content).to eq 'double content'
    expect(post[2].views).to eq 9
    expect(post[2].user_id).to eq 1
  end

  xit 'returns David and his email' do
    repo = UsersRepository.new

    user = repo.find(1)

    expect(user.id).to eq 1
    expect(user.name).to eq 'David'
    expect(user.email).to eq 'example1@gmail.com'
  end

  xit 'creates Bob as new user' do
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