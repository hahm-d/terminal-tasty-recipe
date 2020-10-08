class User < ActiveRecord::Base
    has_many :search_histories
    has_many :dish_searches
    has_many :recipes, through: :dish_searches


    #username must not already exist in database
   
    def self.validmember(user, pass)
        User.all.select {|ele| return curr_user = ele.id if (ele.username == user && ele.password == pass)}
    end

end