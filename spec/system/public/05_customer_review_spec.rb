require 'rails_helper'

describe '[STEP5] 顧客レビュー一覧のテスト' do
  let(:customer) { create(:customer) }
  let!(:review) { create(:review) }


  before do
    visit new_customer_session_path
    fill_in 'customer[name]', with: customer.name
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'ログイン'
  end

  describe '投稿画面のテスト' do
    before do
      visit new_public_review_path
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/public/reviews/new'
      end
      it 'レビュー投稿画面が表示される' do
        expect(page).to have_content 'レビュー投稿画面'
      end
      it 'valueフォームが表示される' do
        # expect(page).to have_field 'review[value]',:visible => false
        # expect(page).to page.find_by_id('#rating-value', visible: false)
        # click_link 'rating-value'
        expect(find('#rating-value', visible: false)).not_to be_visible
      end
      it 'good_pointフォームが表示される' do
        expect(page).to have_field 'review[good_point]'
      end
      it 'bad_pointフォームが表示される' do
        expect(page).to have_field 'review[bad_point]'
      end
      it 'improvement_pointフォームが表示される' do
        expect(page).to have_field 'review[improvement_point]'
      end
      it '投稿ボタンが表示される' do
        expect(page).to have_button '投稿する'
      end
    end

    context '投稿成功のテスト' do
      before do
        find('#rating-value', visible: false).set(Faker::Number.between(from: 1, to: 5))
        fill_in 'review[good_point]', with: Faker::Lorem
        fill_in 'review[bad_point]', with: Faker::Lorem
        fill_in 'review[improvement_point]', with: Faker::Lorem
      end

      it '正しく投稿される' do
        click_button '投稿する'
        expect(Review.all.count).to eq 1
      end
      it '投稿後のリダイレクト先が、投稿完了画面になっている' do
        click_button '投稿する'
        expect(current_path).to eq '/public/reviews'
      end
    end
  end
end