require 'rails_helper'

describe '[STEP3] 顧客ジャンル一覧のテスト' do
  let(:customer) { create(:customer) }
  let!(:genre) { create(:genre) }

  before do
    visit new_customer_session_path
    fill_in 'customer[name]', with: customer.name
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'ログイン'
  end

  describe 'ジャンル一覧画面のテスト' do
    before do
      visit public_genres_path
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/public/genres'
      end
      it 'ジャンル一覧が表示される' do
        expect(page).to have_content 'ジャンル一覧'
      end
      it 'ジャンルの画像が表示される' do
        expect(page).to have_selector "img[src='#{genre.image_url}']"
      end
      it '商品一覧リンクが表示される' do
        expect(page).to have_link genre.name, href: public_genre_items_path(genre.id)
        click_link genre.name, href: public_genre_items_path(genre.id)
      end
    end
  end
end