class Orders < ActiveRecord::Base
     belongs_to :bird
     belongs_to :user
end
