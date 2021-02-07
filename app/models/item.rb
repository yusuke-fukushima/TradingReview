class Item < ApplicationRecord
  belongs_to :genre
  has_many :reviews
  attachment :image
  validates :name, presence: true, uniqueness: true
  
  def avg_value
    unless self.reviews.empty?
      reviews.average(:value).to_f
    else
      0.0
    end
  end

  def review_value_percentage
    unless self.reviews.empty?
      reviews.average(:value).to_f*100/5
    else
      0.0
    end
  end
end
