class Category < ApplicationRecord
  has_many :inventories
  validates :name, :presence => { :message => "카테고리 이름을 입력해주세요!"}
end