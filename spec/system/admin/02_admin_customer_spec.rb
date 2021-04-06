require 'rails_helper'

describe '[STEP2] 管理者会員一覧のテスト' do
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
    end
  end
end