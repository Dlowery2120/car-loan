class Dealership < ActiveRecord::Base
        has_many :cars
        has_many :users
end