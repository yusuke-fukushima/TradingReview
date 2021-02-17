require 'rails_helper'

RSpec.describe 'Genreモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { genre.valid? }

    let!(:genre) { build(:genre) }

    context 'imageカラム' do
      it '空欄でないこと' do
        genre.image = ''
        is_expected.to eq false
      end
    end

    context 'nameカラム' do
      it '空欄でないこと' do
        genre.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        genre.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        genre.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        genre.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        genre.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Itemモデルとの関係' do
      it '1:Nなっている' do
        expect(Genre.reflect_on_association(:items).macro).to eq :has_many
      end
    end
  end
end
