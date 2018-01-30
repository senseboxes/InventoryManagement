class Productnameset < ApplicationRecord
  belongs_to :category
  has_many :inventories
  has_many :products
end
