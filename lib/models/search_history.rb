class SearchHistory < ActiveRecord::Base
    belongs_to :user


    def self.user_history(user_id)
       SearchHistory.all.map {|ele| ele.s_text if ele.user_id == user_id}.compact
    end

    def self.clear_history(user_id)
        search_id_arr = SearchHistory.all.map {|ele| ele.id if ele.user_id == user_id}.compact
         
        SearchHistory.all.delete(search_id_arr)
    end

end