class Genre < ApplicationRecord
  has_many :items
  attachment :image
  validates :name, presence: true, uniqueness: true
  validates :name, length: {maximum: 20, minimum: 2}
  validate :image_should_be_present

  private

  def image_should_be_present
    return if image.present?

    errors.add(:image_id, 'should be attached')
  end
end
