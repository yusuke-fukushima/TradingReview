class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  attachment :image
  validates :customer_id, :good_point, :bad_point, :improvement_point, presence: true
end
