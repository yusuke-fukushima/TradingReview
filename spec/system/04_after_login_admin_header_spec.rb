require 'rails_helper'

describe '[STEP3] 管理者ログイン後のヘッダーのテスト' do
  let(:admin) { create(:admin) }
  
  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'ログイン'
  end
  
  describe 'ヘッダーのテスト' do
    
    context 'リンクの内容を確認' do
      it '商品一覧を押すと、商品一覧画面に遷移する' do
        expect(page).to have_link '商品一覧'
        click_link '商品一覧', href: admin_items_path
      end
      it 'ジャンル一覧を押すと、ジャンル一覧画面に遷移する' do
        expect(page).to have_link 'ジャンル一覧'
        click_link 'ジャンル一覧', href: admin_genres_path
      end
      it '会員一覧を押すと、会員一覧画面に遷移する' do
        expect(page).to have_link '会員一覧'
        click_link '会員一覧', href: admin_customers_path
      end
      it 'レビュー履歴一覧を押すと、レビュー履歴一覧画面に遷移する' do
        expect(page).to have_link 'レビュー履歴一覧'
        click_link 'レビュー履歴一覧', href: admin_reviews_path
      end
    end
  end
end
