class CreateOrders < ActiveRecord::Migration[5.2]
    def change 
        create_table :orders do |t|
            t.integer :scooter_id
            t.integer :user_id
            t.float :earnings
        end
    end
end
