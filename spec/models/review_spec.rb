require 'rails_helper'

RSpec.describe 'Reviewモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { review.valid? }

    let!(:review) { build(:review) }

    context 'valueカラム' do
      it '空欄でないこと' do
        review.value = ''
        is_expected.to eq false
      end
    end

    context 'good_pointカラム' do
      it '空欄でないこと' do
        review.good_point = ''
        is_expected.to eq false
      end
      it '140文字以下であること: 140文字は〇' do
        review.good_point = Faker::Lorem.characters(number: 140)
        is_expected.to eq true
      end
      it '140文字以下であること: 141文字は×' do
        review.good_point = Faker::Lorem.characters(number: 141)
        is_expected.to eq false
      end
    end

    context 'bad_pointカラム' do
      it '空欄でないこと' do
        review.bad_point = ''
        is_expected.to eq false
      end
      it '140文字以下であること: 140文字は〇' do
        review.bad_point = Faker::Lorem.characters(number: 140)
        is_expected.to eq true
      end
      it '140文字以下であること: 141文字は×' do
        review.bad_point = Faker::Lorem.characters(number: 141)
        is_expected.to eq false
      end
    end

    context 'improvement_pointカラム' do
      it '空欄でないこと' do
        review.improvement_point = ''
        is_expected.to eq false
      end
      it '140文字以下であること: 140文字は〇' do
        review.improvement_point = Faker::Lorem.characters(number: 140)
        is_expected.to eq true
      end
      it '140文字以下であること: 141文字は×' do
        review.improvement_point = Faker::Lorem.characters(number: 141)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:reviews).macro).to eq :has_many
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Itemモデルとの関係' do
      it '1:Nとなっている' do
        expect(Item.reflect_on_association(:reviews).macro).to eq :has_many
      end
    end
  end
end
