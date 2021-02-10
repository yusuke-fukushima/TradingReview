class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  attachment :image
  validates :customer_id, :good_point, :bad_point, :improvement_point, presence: true
  validates :good_point, :bad_point, :improvement_point, length: { in: 1..144 } 

  def review_value_percentage
    if value.nil?
      0
    else
      value * 20
    end
  end
end
