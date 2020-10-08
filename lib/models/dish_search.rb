class DishSearch < ActiveRecord::Base
    belongs_to :user
    belongs_to :recipe

    

    #user_like method 
    def self.user_like(userid)
        likelist = DishSearch.all.map {|ele| ele.recipe.name if (ele.user_id == userid && ele.user_like == 1)}
    end

    #user_dish_remove method
    def self.user_dish(userid, recipe_name)
        DishSearch.all.map {|ele| ele.id if (ele.recipe.name == recipe_name && ele.user_id = userid)}
    end

end