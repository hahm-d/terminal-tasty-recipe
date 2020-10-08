require_relative '../config/environment'

title

prompt = TTY::Prompt.new
choices = [
    {name: 'login', value: 1},
    {name: 'register', value: 2},
    {name: 'tasty options', value: 3},
    {name: 'exit', value: 4}
    ]
while pick = prompt.select("Select your pick?", choices)
    case pick
    when 1
        login_user
    when 2
        new_user
    when 3
        tasty_help
    when 4
        puts `clear`
        puts Rainbow("Time for dishes! See you again!").white.bg(:blue)
        exit
    end
end