# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require "json"

puts "Seeding DB with cocktails"

url = "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
file_json = open(url).read
json = JSON.parse(file_json)

puts json

drinks = json["drinks"]

puts drinks

drinks.each do |ingredient|
  puts ingredient
  Ingredient.create!(name: ingredient["strIngredient1"])
end


