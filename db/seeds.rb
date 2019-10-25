require 'open-uri'
require 'json'

url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"

data = URI.open(url).read
ingredients = JSON.parse(data)

initial_array = ingredients["drinks"]
ingredients_array = []
initial_array.each do |i|
  ingredients_array << i["strIngredient1"]
end

p ingredients_array

30.times do
  new_i = Ingredient.new(name: ingredients_array.sample)
  puts "new ingredient #{new_i.name} was created"
  new_i.save!
end
