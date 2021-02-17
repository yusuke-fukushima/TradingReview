require 'rails_helper'

RSpec.describe 'Customerモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { customer.valid? }

    let!(:other_customer) { create(:customer) }
    let(:customer) { build(:customer) }

    context 'nameカラム' do
      it '空欄でないこと' do
        customer.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        customer.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        customer.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        customer.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        customer.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
      it '一意性があること' do
        customer.name = other_customer.name
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      it '空欄でないこと' do
        customer.email = ''
        is_expected.to eq false
      end
      it '一意性があること' do
        customer.email = other_customer.email
        is_expected.to eq false
      end
    end

    context 'postal_codeカラム' do
      it '空欄でないこと' do
        customer.postal_code = ''
        is_expected.to eq false
      end
      it '一意性があること' do
        customer.postal_code = other_customer.postal_code
        is_expected.to eq false
      end
    end

    context 'addressカラム' do
      it '空欄でないこと' do
        customer.address = ''
        is_expected.to eq false
      end
      it '一意性があること' do
        customer.address = other_customer.address
        is_expected.to eq false
      end
    end

    context 'passwordカラム' do
      it '空欄でないこと' do
        customer.password = ''
        is_expected.to eq false
      end
    end
  end
end