# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'rest-client'
require 'json'

cocktail_rows = 100
ingredients_url = "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
cocktail_random_url = "http://www.thecocktaildb.com/api/json/v1/1/random.php"

def get_json(url)
 JSON.parse(RestClient.get(url))
end

puts "Creating rows for Ingredients"
get_json(ingredients_url)["drinks"].each do |ingredient|
 Ingredient.create(name: ingredient["strIngredient1"])
end

puts "Adding #{cocktail_rows} rows to Cocktails"
cocktail_rows.times do
 cocktail_hash = get_json(cocktail_random_url)["drinks"][0]
 cocktail_obj = Cocktail.create(name: cocktail_hash["strDrink"], remote_photo_url: cocktail_hash["strDrinkThumb"])

 15.times do |n|
   index_number = n + 1
   ingredient_name = cocktail_hash["strIngredient#{index_number}"]

   unless ingredient_name.nil? || ingredient_name.empty?
     ingredient = Ingredient.where(name: ingredient_name).first
   end
 end
end
