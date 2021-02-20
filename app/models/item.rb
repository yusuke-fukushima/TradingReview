class Item < ApplicationRecord
  belongs_to :genre
  has_many :reviews
  attachment :image
  validates :name, presence: true, uniqueness: true
  validates :detail, presence: true
  validates :name, length: {maximum: 20, minimum: 2}
  validates :detail, length: {maximum: 100, minimum: 2}
  validate :image_should_be_present

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

  private

  def image_should_be_present
    return if image.present?

    errors.add(:image_id, 'should be attached')
  end
end
