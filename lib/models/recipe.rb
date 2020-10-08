class Recipe < ActiveRecord::Base
    has_many :dish_searches
    has_many :instructions

end