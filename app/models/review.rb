class Review < ApplicationRecord
  belongs_to :customer
  has_many :items
  attachment :image
  validates :customer_id, :good_point, :bad_point, :improvement_point, presence: true
end
