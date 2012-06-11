class Movie < ActiveRecord::Base

def self.all_ratings
    # Returns a enumerable list of all possible ratings
    ['G','PG','PG-13','R']
end

end
