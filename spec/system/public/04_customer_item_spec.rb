require 'rails_helper'

describe '[STEP4] 顧客商品一覧のテスト' do
  let!(:customer) { create(:customer) }
  let!(:genre) { create(:genre) }
  let!(:item) { create(:item, genre_id: genre.id) }


  before do
    visit new_customer_session_path
    fill_in 'customer[name]', with: customer.name
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'ログイン'
  end

  describe '商品一覧画面のテスト' do
    before do
      visit public_genre_items_path(genre.id)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/public/genres/' + genre.id.to_s + '/items'
      end
      it '商品一覧が表示される' do
        expect(page).to have_content '商品一覧'
      end
      it '商品の画像が表示される' do
        expect(page).to have_selector "img[src='#{item.image_url}']"
      end
      it '商品詳細リンクが表示される' do
        expect(page).to have_link item.name, href: public_genre_item_path(genre.id,item.id)
        click_link item.name, href: public_genre_item_path(genre.id,item.id)
      end
    end
  end

  describe '商品詳細画面のテスト' do
    before do
      visit public_genre_item_path(genre.id,item.id)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/public/genres/' + genre.id.to_s + '/items/' + item.id.to_s
      end
      it '商品詳細が表示される' do
        expect(page).to have_content '商品詳細'
      end
      it '商品の画像が表示される' do
        expect(page).to have_selector "img[src='#{item.image_url}']"
      end
      it '商品のnameが表示される' do
        expect(page).to have_content item.name
      end
      it '商品のdetailが表示される' do
        expect(page).to have_content item.detail
      end
      it '投稿画面に進むリンクが表示される' do
        expect(page).to have_link '投稿画面に進む', href: new_public_review_path(item_id: item.id)
        click_link '投稿画面に進む', href: new_public_review_path(item_id: item.id)
      end
    end
  end
end
