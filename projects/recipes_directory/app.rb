require_relative 'lib/database_connection'
require_relative 'lib/recipes_repository'

DatabaseConnection.connect('recipes_directory')

recipe_repository = RecipeRepository.new

recipe_repository.all.each do |recipe|
  puts "#{recipe.id} - #{recipe.name} - #{recipe.time} mins - Rated #{recipe.rating}"
end

# recipe = recipe_repository.find(5)
#   puts "#{recipe.id} - #{recipe.name} - #{recipe.time} mins - #{recipe.rating}"