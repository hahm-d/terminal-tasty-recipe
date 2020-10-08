def title
    puts Rainbow("
        ______)              _____                     _____          
      (, /                 (, /   )        ,         (, /  |         
        /   _   _  _/_       /__ /  _  _    __    _    /---| __  __  
     ) /   (_(_/_)_(__(_/_) /   \__(/_(___(_/_)__(/_) /    |_/_)_/_)_
    (_/              .-/ (_/             .-/       (_/    .-/ .-/    
                    (_/                 (_/              (_/ (_/     
    
    ").blue.bright

    puts Rainbow("Welcome to ").green + Rainbow("Tasty Recipe App!").blue.bright.bg(:white)
    puts Rainbow("Start by creating an account if this is your first time here.").green.bright
    puts Rainbow("For returning users: login").green.bright
    puts Rainbow("For list of available commands type: tasty").green.bright
end

def wok_image
puts <<PARAGRAPH 
    
 __     / ___,.-------..__        __ 
//\\ _,-'\\               `'--._ //\\
\\ ;'      \\                   `: //
`(          \\                   )'
  :.          \\,----,         ,;
   `.`--.___   (    /  ___.--','
     `.     ``-----'-''     ,'
        -.               ,-
     gpyy  `-._______.-'
     
PARAGRAPH
end

