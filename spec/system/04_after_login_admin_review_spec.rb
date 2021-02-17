require 'rails_helper'

describe '[STEP3] 管理者ログイン後の商品一覧のテスト' do
  let(:admin) { create(:admin) }
  let(:review) { create(:review) }
  let(:item) { create(:item) }
  
  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'ログイン'
  end
  
  describe 'レビュー一覧画面のテスト' do
     before do
      visit admin_reviews_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/reviews'
      end
      # it 'item.nameを押すと、レビュー詳細画面に遷移する' do
      #   expect(page).to have_link item.name, href: admin_review_path(review.id)
      #   click_link item.name, href: admin_review_path(review.id)
      # end
      # it 'csvで出力するボタンが表示される' do
      #   expect(page).to have_button 'csvで出力する'
      # end
    end
    
  end
  
  describe 'レビュー詳細画面のテスト' do
    before do
      visit admin_review_path(review)
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/reviews/' + review.id.to_s
      end
    end
    
  end
end
