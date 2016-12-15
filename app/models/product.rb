class Product < ApplicationRecord
  
  belongs_to :inventory
  
  validates :pname, presence: true
  validates :puchase_kg, :release_kg, presence: true
end
