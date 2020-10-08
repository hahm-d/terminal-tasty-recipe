
def user_helper
    puts Rainbow("****************************************************************").blue 
    puts "                          " + Rainbow("Main Menu").white.bright.bg(:blue)
    puts Rainbow("List of commands:").green.bright
    puts Rainbow("  Search ").yellow.bright
    puts Rainbow("    Favorites ").yellow.bright
    puts Rainbow("        History ").yellow.bright
    puts Rainbow("             Exit ").yellow.bright    
    puts Rainbow("Type any of the commands above!").green.bright
    puts Rainbow("****************************************************************").blue 
end

def tasty_help
    puts `clear`
    puts Rainbow("****************************************************************").blue
    puts Rainbow("Here are the list of commands:\n").cyan
    puts Rainbow("register").yellow + "           # create new user" 
    puts Rainbow("login").yellow + "              # login with username"
    puts Rainbow("exit").yellow + "               # quit application"
    puts Rainbow("****************************************************************").blue
    puts Rainbow("After log-in, User options:\n").cyan 
    puts Rainbow("Search by Recipe name or recipe id").magenta  
    puts Rainbow("Add recipe to favorites").magenta         
    puts Rainbow("View/delete favorite Recipe list").magenta 
    puts Rainbow("View/delete search history").magenta 
    puts Rainbow("****************************************************************").blue
end

def is_integer(string)
    string.to_i.to_s
end

def yes_or_no(question)
    prompt = TTY::Prompt.new
    prompt.select(question, %w(Yes No))
end

def valid_dob(dob)
    if dob.match('^(\d\d\d\d)(\d\d)(\d\d)$')
    return true
    else
    return false 
    end
end

def new_user
    prompt = TTY::Prompt.new
    puts `clear`
    first = prompt.ask('Please enter your first name:')
    last =  prompt.ask('Please enter your last name:')
    check = false
    while check == false do
        dob = prompt.ask('Please enter your date of birth (yyyymmdd): ')
        check = valid_dob(dob)
        if check == true
            break
        end
        puts "Please enter a valid date of birth (yyyymmdd):"
    end

    username = prompt.ask('Input a unique username: ')
    pass_valid = 1
    userpass = 2
    while pass_valid != userpass
        userpass = prompt.mask('What is your secret sauce? (password)')
        pass_valid = prompt.mask('Re-enter your password')
        if userpass == pass_valid 
            break
        end
        puts "Password did not match. Try again."
    end
    fav = prompt.ask('favorite food? ')

    User.create(f_name: first, l_name: last, username: username, password: userpass, dob: dob, f_food: fav)
    userid = User.validmember(username, userpass)
    usermenu(userid) 
end


def login_user
    puts `clear`
    prompt = TTY::Prompt.new
    user = prompt.ask('What is your username?')
    pass = prompt.mask('What is your secret sauce? (password)')

    #database method to check if your exists
    userid = User.validmember(user, pass)
    if userid.is_a? Numeric
        puts
        puts Rainbow("Welcome back #{user}!").white.bg(:blue)
        puts
        usermenu(userid)
    else
        puts Rainbow("invalid log-in.").red.bright
    end
end



def usermenu(userid)

user_helper
    while user_input = gets.chomp.downcase
        case user_input   # search
        when 'search' 
            userchoice = yes_or_no("would you like to search by recipe id?")
            if userchoice == "Yes"
                puts "enter id: "
                user_input2 = gets.chomp.downcase
                #API call using input 
                validation = recipeDetail(user_input2)
                if validation == "Found!"
                    view_recipe(userid, user_input2)
                end
            elsif userchoice == "No"
                puts "search Tasty recipes by name: "
                user_input2 = gets.chomp.downcase
                # API call happens (finds list of recipes)
                validation = searchForRecipe(user_input2)
                SearchHistory.create(s_text: user_input2, user_id: userid)
                user_helper
            end

        when 'favorites' # user can delete / view favorite recipes   
            fav = DishSearch.user_like(userid)
            puts `clear`
            puts Rainbow("Here are your favorites: ").blue.bright
            array_nil = fav.map {|val| val }.compact #remove nil
            fav_list = array_nil.each.with_index {|x, i| puts Rainbow("number: #{i + 1}  ").yellow + Rainbow("recipe: #{x}").cyan.bright}
            if fav_list.any?
                puts
                userchoice = yes_or_no("Remove a recipe from favorites list?")
                if userchoice == "Yes"
                    begin
                        puts 
                        puts Rainbow("Select by order number above").cyan                
                        user_input2 = Integer(gets.chomp.downcase)
                    rescue
                        puts `clear`
                        puts "Please enter one of the numbers above"
                        retry
                    end
                    if fav_list.size > user_input2 - 1 && user_input2 != 0
                        recipe_name = fav_list[user_input2 - 1]
                        local_dish_id = DishSearch.user_dish(userid, recipe_name) 
                        DishSearch.destroy(local_dish_id)
                        puts Rainbow("Removed! type: Favorites to see updated list").blue.bright.bg(:white)
                        puts
                    else
                        puts `clear`
                        puts Rainbow("Invalid number").red.bright
                        puts
                    end
                end
            else
                puts Rainbow("Wait.. Nothing to see here... Please find a recipe!").blue.bright
                puts
            end
            user_helper

        when 'history'  # user delete or view search history
            hist = SearchHistory.user_history(userid)
            if hist.any? 
                puts `clear`
                puts "Here is your search history: #{hist}"
                puts
                userchoice = yes_or_no("Delete history?")
                if userchoice == "Yes"
                    SearchHistory.clear_history(userid)
                    puts Rainbow("Search history deleted!").blue.bright.bg(:white)
                end
            else
                puts `clear`
                puts Rainbow("No search history available.").black.bg(:white)
                puts 
            end
            user_helper

        when 'exit'
            puts `clear`
            puts Rainbow("Good Bye! See you again!").black.bg(:white)
            exit

        else 
            puts `clear` 
            user_helper
        end

    end

end