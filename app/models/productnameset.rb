class Productnameset < ApplicationRecord
  has_many :inventories
  has_many :products, through: :product_pnamesets
end
