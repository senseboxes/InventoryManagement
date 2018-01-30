class Category < ApplicationRecord
  has_many :inventories
  has_many :productnamesets
  validates :name, :presence => { :message => "이름을 입력해주세요!"}
end
