class Item < ApplicationRecord
  belongs_to :genre
  has_many :reviews
  attachment :image
  validates :name, presence: true, uniqueness: true
end
