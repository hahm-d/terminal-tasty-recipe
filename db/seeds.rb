#clear existing seed data
User.destroy_all
SearchHistory.destroy_all
Recipe.destroy_all
DishSearch.destroy_all
Instruction.destroy_all

user1 = User.create(f_name: "Anthony", l_name: "Griffin", username: "Beach", password: "a", dob: "1995-09-11", f_food: "Samoan food")
user2 = User.create(f_name: Faker::Name.first_name, l_name: Faker::Name.last_name, username: Faker::Twitter.screen_name, password: Faker::Twitter.screen_name, dob: Faker::Date.in_date_period, f_food: Faker::Food.dish)
user3 = User.create(f_name: Faker::Name.first_name, l_name: Faker::Name.last_name, username: Faker::Twitter.screen_name, password: Faker::Twitter.screen_name, dob: Faker::Date.in_date_period, f_food: Faker::Food.dish)

search1 = SearchHistory.create(s_text: Faker::Food.dish, user: user1)
search2 = SearchHistory.create(s_text: Faker::Food.fruits, user: user1)
search3 = SearchHistory.create(s_text: Faker::Food.dish, user: user1)
search4 = SearchHistory.create(s_text: Faker::Food.dish, user: user1)

recipe1 = Recipe.create(name: Faker::Food.dish, tasty_remote_id: 6335, calories: Faker::Number.between(from: 400, to: 2000), description: Faker::Food.description, total_time: Faker::Number.between(from: 7, to: 60), num_serving: Faker::Number.between(from: 1, to: 9), keywords: Faker::Food.ingredient)
recipe2 = Recipe.create(name: Faker::Food.dish, tasty_remote_id: 6337, calories: Faker::Number.between(from: 400, to: 2000), description: Faker::Food.description, total_time: Faker::Number.between(from: 7, to: 60), num_serving: Faker::Number.between(from: 1, to: 9), keywords: Faker::Food.ingredient)
recipe3 = Recipe.create(name: Faker::Food.dish, tasty_remote_id: 6055, calories: Faker::Number.between(from: 400, to: 2000), description: Faker::Food.description, total_time: Faker::Number.between(from: 7, to: 60), num_serving: Faker::Number.between(from: 1, to: 9), keywords: Faker::Food.ingredient)
recipe4 = Recipe.create(name: Faker::Food.dish, tasty_remote_id: 6126, calories: Faker::Number.between(from: 400, to: 2000), description: Faker::Food.description, total_time: Faker::Number.between(from: 7, to: 60), num_serving: Faker::Number.between(from: 1, to: 9), keywords: Faker::Food.ingredient)
recipe5 = Recipe.create(name: Faker::Food.dish, tasty_remote_id: 5806, calories: Faker::Number.between(from: 400, to: 2000), description: Faker::Food.description, total_time: Faker::Number.between(from: 7, to: 60), num_serving: Faker::Number.between(from: 1, to: 9), keywords: Faker::Food.ingredient)

#belongs to recipes
step1 = Instruction.create(step: Faker::Food.measurement + ", " + Faker::Food.ingredient, recipe: recipe1)
step2 = Instruction.create(step: Faker::Food.measurement + ", " + Faker::Food.ingredient, recipe: recipe2)
step3 = Instruction.create(step: Faker::Food.measurement + ", " + Faker::Food.ingredient, recipe: recipe3)
step4 = Instruction.create(step: Faker::Food.measurement + ", " + Faker::Food.ingredient, recipe: recipe4)
step5 = Instruction.create(step: Faker::Food.measurement + ", " + Faker::Food.ingredient, recipe: recipe5)

#join class for users and recipes
dish1 = DishSearch.create(recipe: recipe1, user: user1, user_like: 1)
dish2 = DishSearch.create(recipe: recipe2, user: user1, user_like: 1)
dish3 = DishSearch.create(recipe: recipe3, user: user1, user_like: nil)
dish4 = DishSearch.create(recipe: recipe4, user: user2, user_like: nil)
dish5 = DishSearch.create(recipe: recipe5, user: user2)

puts "/////////////////////////////////////////////// SUCCESS ///////////////////////////////////////////////"
puts "seed data successfully added!\n"
puts
puts "start app using: rake console\n"
puts
puts "type tasty_help for all available commands"
puts "//////////////////////////////////////////////// TASTY ////////////////////////////////////////////////"