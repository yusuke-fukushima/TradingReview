require 'rails_helper'

describe '[STEP1] 管理者ログイン、ログアウト、ヘッダーのテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit admin_root_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin'
      end
    end
  end
  
  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit admin_root_path
    end
    
    context '表示内容の確認' do
      it 'タイトルが表示される' do
        expect(page).to have_content 'TradingReview'
      end
    end
    
    context 'リンクの内容を確認' do
      subject { root_path }
    end
  end

  describe '管理者ログイン' do
    let(:admin) { create(:admin) }
    
    before do
      visit new_admin_session_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admins/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'admin[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'admin[password]'
      end
    end
    
    context 'ログイン成功のテスト' do
      before do
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_button 'ログイン'
      end
      
      it 'ログイン後のリダイレクト先が、レビュー履歴一覧画面になっている' do
        expect(current_path).to eq '/admin/reviews'
      end
    end
    
    context 'ログイン失敗のテスト' do
      before do
        fill_in 'admin[email]', with: ''
        fill_in 'admin[password]', with: ''
        click_button 'ログイン'
      end
      
      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/admins/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:admin) { create(:admin) }
    
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
    end
    
    context 'ヘッダーの表示を確認' do
      it 'タイトルが表示される' do
        expect(page).to have_content 'TradingReview'
      end
      it '商品一覧リンクが表示される' do
        expect(page).to have_link '商品一覧'
      end
      it 'ジャンル一覧リンクが表示される' do
        expect(page).to have_link 'ジャンル一覧'
      end
      it '会員一覧リンクが表示される' do
        expect(page).to have_link '会員一覧'
      end
      it 'レビュー履歴一覧リンクが表示される' do
        expect(page).to have_link 'レビュー履歴一覧'
      end
      it 'ログアウトリンクが表示される' do
        expect(page).to have_link 'ログアウト'
      end
    end
  end

  describe '管理者ログアウトのテスト' do
    let(:admin) { create(:admin) }
    
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      logout_link = find_all('a')[5].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end
    
    context 'ログアウト機能のテスト' do
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end
