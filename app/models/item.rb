class Item < ApplicationRecord
  belongs_to :genre
  attachment :image
  validates :name, presence: true, uniqueness: true
end
