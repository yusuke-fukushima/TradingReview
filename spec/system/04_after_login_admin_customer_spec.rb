require 'rails_helper'

describe '[STEP3] 管理者ログイン後の会員一覧のテスト' do
  let(:admin) { create(:admin) }
  let!(:customer) { create(:customer) }
  
  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'ログイン'
  end
  
  describe '会員一覧画面のテスト' do
     before do
      visit admin_customers_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/customers'
      end
      it 'customer.nameを押すと、会員詳細画面に遷移する' do
        expect(page).to have_link customer.name, href: admin_customer_path(customer.id)
        click_link customer.name, href: admin_customer_path(customer.id)
      end
    end
    
  end
  
  describe '会員詳細画面のテスト' do
    before do
      visit admin_customer_path(customer.id)
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/customers/' + customer.id.to_s
      end
      it '編集を押すと、編集画面に遷移する' do
        expect(page).to have_link '編集', href: edit_admin_customer_path(customer.id)
        click_link '編集', href: edit_admin_customer_path(customer.id)
      end
    end
  end
  
  describe '会員情報編集画面のテスト' do
    before do
      visit edit_admin_customer_path(customer.id)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/customers/' + customer.id.to_s + '/edit'
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'customer[name]', with: customer.name
      end
      it 'メールアドレス編集フォームに自分のメールアドレスが表示される' do
        expect(page).to have_field 'customer[email]', with: customer.email
      end
      it '郵便番号編集フォームに自分の郵便番号が表示される' do
        expect(page).to have_field 'customer[postal_code]', with: customer.postal_code
      end
      it '住所編集フォームに自分の住所が表示される' do
        expect(page).to have_field 'customer[address]', with: customer.address
      end
      it '変更内容保存ボタンが表示される' do
        expect(page).to have_button '変更内容保存'
      end
    end

    context '更新成功のテスト' do
      before do
        @customer_old_name = customer.name
        @customer_old_email = customer.email
        @customer_old_postal_code = customer.postal_code
        @customer_old_address = customer.address
        fill_in 'customer[name]', with: Faker::Name.name
        fill_in 'customer[email]', with: Faker::Internet.email
        fill_in 'customer[postal_code]', with: Faker::Address.postcode
        fill_in 'customer[address]', with: Faker::Address.city
        click_button '変更保存'
      end

      it 'nameが正しく更新される' do
        expect(customer.reload.name).not_to eq @customer_old_name
      end
      it 'emailが正しく更新される' do
        expect(customer.reload.email).not_to eq @customer_old_email
      end
      it 'postal_codeが正しく更新される' do
        expect(customer.reload.postal_code).not_to eq @customer_old_postal_code
      end
      it 'addressが正しく更新される' do
        expect(customer.reload.address).not_to eq @customer_old_address
      end
      it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
        expect(current_path).to eq '/admin/customers/' + customer.id.to_s
      end
    end
  end
end
