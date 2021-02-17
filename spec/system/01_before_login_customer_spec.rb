require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'タイトルが表示される' do
        expect(page).to have_content 'TradingReview'
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }
    end
  end

  describe 'ユーザー新規登録のテスト' do
    before do
      visit new_customer_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_up'
      end
      it '「新規登録」と表示される' do
        expect(page).to have_content '新規登録'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'customer[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'customer[email]'
      end
      it 'postal_codeフォームが表示される' do
        expect(page).to have_field 'customer[postal_code]'
      end
      it 'addressフォームが表示される' do
        expect(page).to have_field 'customer[address]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'customer[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'customer[password_confirmation]'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'customer[name]', with: Faker::Name.name
        fill_in 'customer[email]', with: Faker::Internet.email
        fill_in 'customer[postal_code]', with: Faker::Address.postcode
        fill_in 'customer[address]', with: Faker::Address.city
        fill_in 'customer[password]', with: 'password'
        fill_in 'customer[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button '新規登録' }.to change(Customer.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button '新規登録'
        expect(current_path).to eq '/public/customers/' + Customer.last.id.to_s
      end
    end
  end

  describe 'ユーザログイン' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'customer[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'customer[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'customer[password]'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'customer[name]', with: customer.name
        fill_in 'customer[email]', with: customer.name
        fill_in 'customer[password]', with: customer.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、ログインしたユーザのマイページ画面になっている' do
        expect(current_path).to eq '/public/customers/' + customer.id.to_s
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'customer[name]', with: ''
        fill_in 'customer[email]', with: ''
        fill_in 'customer[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/customers/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
      fill_in 'customer[name]', with: customer.name
      fill_in 'customer[email]', with: customer.email
      fill_in 'customer[password]', with: customer.password
      click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it 'タイトルが表示される' do
        expect(page).to have_content 'TradingReview'
      end
      it 'マイページリンクが表示される: 左上から1番目のリンクが「マイページ」である' do
        customers_link = find_all('a')[1].native.inner_text
        expect(customers_link).to match(public/customers/i)
      end
      it 'ジャンル一覧リンクが表示される: 左上から2番目のリンクが「ジャンル一覧」である' do
        genres_link = find_all('a')[2].native.inner_text
        expect(genres_link).to match(public/genres)
      end
      it 'リンクが表示される: 左上から3番目のリンクが「ログアウト」である' do
        logout_link = find_all('a')[3].native.inner_text
        expect(logout_link).to match(public/logout/i)
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
      fill_in 'customer[name]', with: customer.name
      fill_in 'customer[email]', with: customer.email
      fill_in 'customer[password]', with: customer.password
      click_button 'ログイン'
      logout_link = find_all('a')[3].native.inner_text
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
