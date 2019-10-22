class CreateBirds < ActiveRecord::Migration[5.2]
    def change 
        create_table :birds do |t|
            t.string :location
            t.float :battery_percentage
        end
    end
end