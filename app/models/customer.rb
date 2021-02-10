class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :email, :postal_code, :address, presence: true
  validates :is_deleted, inclusion: { in: [true, false] }

  has_many :reviews

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
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
