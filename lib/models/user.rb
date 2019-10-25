class User < ActiveRecord::Base
    
    has_many :orders
    has_many :birds, through: :order

end 

