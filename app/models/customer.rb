class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :postal_code, :address, presence: true
  validates :is_deleted, inclusion: { in: [true, false] }

  has_many :reviews

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.name = 'ゲスト'
      customer.password = SecureRandom.urlsafe_base64
      customer.postal_code = '1234567'
      customer.address = 'ゲストスポット'
      customer.is_deleted = false
    end
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def total_point
    if reviews.empty?
      0
    else
      reviews.count * 10
    end
  end

  def avg_value
    if reviews.empty?
      0
    else
      reviews.average(:value).to_f
    end
  end
end
