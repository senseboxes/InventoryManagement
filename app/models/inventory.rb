class Inventory < ApplicationRecord
  has_many :products, :dependent => :destroy
  validates :iname, presence: true
  self.per_page = 5
end
