require 'rails_helper'

describe '[STEP3] 顧客ログイン後の顧客のテスト' do
  let(:customer) { create(:customer) }

  before do
    visit new_customer_session_path
    fill_in 'customer[name]', with: customer.name
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'ログイン'
  end

  describe 'マイページ画面のテスト' do
    before do
      visit public_customer_path(customer.id)
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/public/customers/' + customer.id.to_s
      end
      it '編集するを押すと、編集画面に遷移する' do
        expect(page).to have_link '編集する'
        click_link '編集する', href: edit_public_customer_path(customer.id)
      end
    end

  end

  describe '自分の顧客情報編集画面のテスト' do
    before do
      visit edit_public_customer_path(customer.id)
    end
    
    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/public/customers/' + customer.id.to_s + '/edit'
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
      it '編集内容を保存ボタンが表示される' do
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
        click_button '変更内容保存'
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
      it 'リダイレクト先が、自分の顧客詳細画面になっている' do
        expect(current_path).to eq '/public/customers/' + customer.id.to_s
      end
    end
  end
end