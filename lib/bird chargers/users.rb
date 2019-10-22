class Users < ActiveRecord::Base
    has_many :orders
    has_many :birds, through: :orders

end 


;ladhsfl;adfhsladfhsl;adfhsla;dfhslhasd;fhl
