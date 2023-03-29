require 'recipes_repository'
  
describe RecipeRepository do

  def reset_recipes_table
    seed_sql = File.read('spec/seeds_recipes.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_recipes_table
  end

  it 'should return first recipe' do

    repo = RecipeRepository.new
    recipes = repo.all
    expect(recipes.first.id).to eq('1')
    expect(recipes.first.name).to eq('Spaghetti Carbonara')
    expect(recipes.first.time).to eq('25')
    expect(recipes.first.rating).to eq('4')
  end

  it 'find a recipe by rating' do
    repo = RecipeRepository.new
    recipes = repo.find(3)
    expect(recipes.id).to eq('2')
    expect(recipes.name).to eq('Grilled Cheese Sandwich')
    expect(recipes.time).to eq('10')
    expect(recipes.rating).to eq('3')
  end
end