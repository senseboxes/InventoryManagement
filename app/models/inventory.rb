class Inventory < ApplicationRecord
  has_many :products, :dependent => :destroy
  validates :iname, presence: true
end
