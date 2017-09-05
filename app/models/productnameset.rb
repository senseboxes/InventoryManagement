class Productnameset < ApplicationRecord
  has_many :product_productnamesets
  has_many :products :product_productnamesets
end
