class Bird < ActiveRecord::Base
    has_many :orders
    has_many :users, through: :order
    
end
