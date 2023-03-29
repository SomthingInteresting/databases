require_relative './recipes'

class RecipeRepository
  def all
    sql = 'SELECT id, name, time, rating FROM recipes;'
    result_set = DatabaseConnection.exec_params(sql, [])

    recipes = []

    result_set.each do |record|
      recipe = Recipe.new
      recipe.id = record['id']
      recipe.name = record['name']
      recipe.time = record['time']
      recipe.rating = record['rating']

      recipes << recipe
    end

    return recipes
  end

  def find(rating)
    sql = 'SELECT id, name, time, rating FROM recipes WHERE rating = $1;'
    sql_params = [rating]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    recipe = Recipe.new
    recipe.id = record['id']
    recipe.name = record['name']
    recipe.time = record['time']
    recipe.rating = record['rating']

    return recipe
  end
end