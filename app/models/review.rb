class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  attachment :image
  validates :value, :good_point, :bad_point, :improvement_point, presence: true
  validates :good_point, :bad_point, :improvement_point, length: { maximum: 140 }

  def review_value_percentage
    if value.nil?
      0
    else
      value * 20
    end
  end
end
