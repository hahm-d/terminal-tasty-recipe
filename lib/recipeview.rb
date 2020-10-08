require 'rainbow'

def view_recipe(userid, recipe_remote_id)
    #find recipe instance 
    this_recipe = Recipe.find_by(tasty_remote_id: recipe_remote_id)
    puts `clear`
    wok_image
    puts Rainbow("****************************************************************").green.bright
    puts Rainbow("Recipe Name:").blue + Rainbow("#{this_recipe.name}").cyan.bright
    puts Rainbow("Recipe Tasy ID:").blue + Rainbow("#{recipe_remote_id}").cyan
    puts Rainbow("Total Calories:").blue + Rainbow("#{this_recipe.calories}").cyan
    puts Rainbow("Total Est. Time:").blue + Rainbow("#{this_recipe.total_time}").cyan
    puts Rainbow("Number of Servings:").blue + Rainbow("#{this_recipe.num_serving}").cyan
    puts Rainbow("Recipe description:").blue + Rainbow("#{this_recipe.description}").cyan
    puts Rainbow("Related Keywords:").blue + Rainbow("#{this_recipe.keywords}").cyan
    puts Rainbow("****************************************************************").green.bright
    many_instructions = Instruction.find_by(recipe: this_recipe)
    puts 
    puts Rainbow("Instructions:").blue + Rainbow("#{many_instructions.step}").cyan
    #check if relationship already exists
    dup_check = DishSearch.find_by(recipe: this_recipe, user_id: userid)
    if dup_check == nil
        dup_check = DishSearch.create(recipe: this_recipe, user_id: userid)
        prompt_fav(dup_check.id)
    else
        #check if already in favorite
        if dup_check.user_like == 1
            puts
            puts Rainbow("★★★★★ Your Favorite Recipe ★★★★★ ").yellow.bright
            puts
        else
            prompt_fav(dup_check.id)
        end
    end
    user_helper
end


def prompt_fav(user_dish_id)
    prompt = TTY::Prompt.new 
    userchoice = prompt.select("Add this recipe to favorites?", %w(Yes No))
    if userchoice == "Yes"
        DishSearch.update(user_dish_id, user_like: 1)
    end
    puts Rainbow("Recipe ID saved! See your updated Favorites!").white.bright.bg(:blue)
end