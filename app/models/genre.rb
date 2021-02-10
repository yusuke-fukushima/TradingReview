class Genre < ApplicationRecord
  has_many :items
  attachment :image
  validates :name, presence: true, uniqueness: true
  validates :name, length: { in: 1..20 }

end
