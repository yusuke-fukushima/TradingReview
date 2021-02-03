class Genre < ApplicationRecord
  has_many :items
  attachment :image
  validates :name, presence: true, uniqueness: true
end
