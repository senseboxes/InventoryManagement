class Product < ApplicationRecord
  
  belongs_to :inventory
  
  self.per_page = 10
end
