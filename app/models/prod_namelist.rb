class ProdNamelist < ApplicationRecord
  has_many :product_namelists
  has_many :products, through: :product_namelists
  belongs_to :inventory
end
