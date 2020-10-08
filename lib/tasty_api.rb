require 'uri'
require 'net/http'
require 'openssl'
require 'dotenv'
require 'json'
Dotenv.load


#get recipes (using Recipe ID)
def recipeDetail(recipe_remote_id)
    url = URI("https://tasty.p.rapidapi.com/recipes/detail?id=#{recipe_remote_id}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'tasty.p.rapidapi.com'
    request["x-rapidapi-key"] = ENV['APIKEY']
    
    response = http.request(request)

    if Recipe.exists?(tasty_remote_id: recipe_remote_id)
        return "Found!"
    elsif  response.read_body
        json = JSON.parse(response.read_body)
        
        rec_name = json['name']
        rec_desc = json['description']
        rec_serving = json['num_servings']
        rec_keyword = json['keywords']
        rec_time = json['cook_time_minutes']
        rec_calo = json['nutrition']['calories']
        
        Recipe.create(name: rec_name, tasty_remote_id: recipe_remote_id, calories: rec_calo, description: rec_desc, total_time: rec_time, num_serving: rec_serving, keywords: rec_keyword)

        #nested hash for instructions
        instr_hash = json['instructions']
        def add_instructions(instr_hash)
            instr_hash.map do |step|
                step['display_text']
            end.join
        end
        #create instructors for above recipe
        local_recipe_id = Recipe.find_by(tasty_remote_id: recipe_remote_id) 
        Instruction.create(step: add_instructions(instr_hash), recipe: local_recipe_id)

        return "Found!"
    else
        puts "Recipe ID: #{recipe_id} does not exist."
    end

end


#get recipes/list
def searchForRecipe(word) #word is "cheesecake or apple pie"
    #condition for more than one word 
    words_array = word.strip.split(" ")

   if words_array.length == 1  
    url = URI("https://tasty.p.rapidapi.com/recipes/list?q=#{words_array[0]}&from=0&sizes=10")
   elsif words_array.length == 2
    url = URI("https://tasty.p.rapidapi.com/recipes/list?q=#{words_array[0]}%20#{words_array[1]}&from=0&sizes=10")
   else
    return "Please limit your search to 1 or 2 words"
    #prompt user input 
   end

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'tasty.p.rapidapi.com'
    request["x-rapidapi-key"] = ENV['APIKEY']

    response = http.request(request)
    bodyparse = JSON.parse(response.read_body)
    puts `clear`
    puts bodyparse['results'].map {|json| "Tasty ID: #{json['id']}, Recipe Name: #{json['name']},--------- Image: #{json['thumbnail_url']}}\n"}

end
