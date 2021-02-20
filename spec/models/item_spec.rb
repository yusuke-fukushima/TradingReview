require 'rails_helper'

RSpec.describe 'Itemモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { item.valid? }
    
    let!(:item) { build(:item) }
    
    context 'imageカラム' do
      it '空欄でないこと' do
        item.image = ''
        is_expected.to eq false
      end
    end
    
    context 'nameカラム' do
      it '空欄でないこと' do
        item.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        item.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        item.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        item.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        item.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
    
    context 'detailカラム' do
      it '空欄でないこと' do
        item.detail = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        item.detail = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        item.detail = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '100文字以下であること: 100文字は〇' do
        item.detail = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
      end
      it '100文字以下であること: 101文字は×' do
        item.detail = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Genreモデルとの関係' do
      it '1:Nとなっている' do
        expect(Item.reflect_on_association(:genre).macro).to eq :belongs_to
      end
    end
  end
end
