class Inventory < ApplicationRecord
  has_many :products, :dependent => :destroy
  has_many :monthaverages
  belongs_to :category
  has_many :productnamesets
  validates :iname, presence: true
  self.per_page = 10
end
