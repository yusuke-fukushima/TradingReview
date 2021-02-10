class Item < ApplicationRecord
  belongs_to :genre
  has_many :reviews
  attachment :image
  validates :name, presence: true, uniqueness: true

  def avg_value
    if reviews.empty?
      0.0
    else
      reviews.average(:value).to_f
    end
  end

  def review_value_percentage
    if reviews.empty?
      0.0
    else
      reviews.average(:value).to_f * 100 / 5
    end
  end
end
