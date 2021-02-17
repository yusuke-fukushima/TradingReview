require 'rails_helper'

describe '[STEP3] ユーザログイン後のテスト' do
  let!(:other_customer) { create(:customer) }
  let(:customer) { build(:customer) }

  before do
    visit new_customer_session_path
    fill_in 'customer[name]', with: customer.name
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
      subject { current_path }
      
      it 'マイページを押すと、マイページ画面に遷移する' do
        customer_link = find_all('a')[1].native.inner_text
        customer_link = customer_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link customer_link
        is_expected.to eq 'public/customers/' + customer.id.to_s
      end
      
      it 'ジャンル一覧を押すと、ジャンル一覧画面に遷移する' do
        genres_link = find_all('a')[2].native.inner_text
        genres_link = genres_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link genres_link
        is_expected.to eq 'public/genres'
      end
      
    end
  end

  describe 'マイページ画面のテスト' do
    before do
      visit public_customer_path(customer.id)
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/public/customer/' + Customer.last.id.to_s
      end
      it '自分のユーザ編集画面へのリンクが存在する' do
        expect(page).to have_link '', href: edit_public_customer_path(customer.id)
      end
    end
    
    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link '編集する'
        expect(current_path).to eq '/public/customers/' + customer.id.to_s + '/edit'
      end
    end
  end
  
  describe '自分のユーザ情報編集画面のテスト' do
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
        expect(page).to have_button '編集内容を保存'
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
        fill_in 'customer[postal_code]', with: Faker::Address.postal_code
        fill_in 'customer[address]', with: Faker::Address.address
        click_button '編集内容を保存'
      end

      it 'nameが正しく更新される' do
        expect(customer.reload.name).not_to eq @customer_old_name
      end
      it 'emailが正しく更新される' do
        expect(customer.reload.email).not_to eq @customer_old_email
      end
      it 'nameが正しく更新される' do
        expect(customer.reload.postal_code).not_to eq @customer_old_postal_code
      end
      it 'nameが正しく更新される' do
        expect(customer.reload.address).not_to eq @customer_old_address
      end
      it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
        expect(current_path).to eq '/public/customers/' + customer.id.to_s
      end
    end
  end
  
  # describe 'ジャンル一覧画面のテスト' do
  #   before do
  #     visit public_genres_path
  #   end

  #   context '表示の確認' do
  #     it 'URLが正しい' do
  #       expect(current_path).to eq '/public/genres'
  #     end
  #     it 'ジャンル一覧が表示される' do
  #       expect(page).to have_content 'ジャンル一覧'
  #     end
  #     # it 'ジャンルの画像が表示される' do
  #     #   expect(page).to have_button 'Update Customer'
  #     # end
  #     it 'ジャンルの商品一覧リンクが表示される' do
  #       expect(page).to have_link '', href: public_genre_items_path(genre.id)
  #     end
  #   end
  # end
  
  # describe '商品一覧画面のテスト' do
  #   before do
  #     visit public_genre_items_path
  #   end

  #   context '表示の確認' do
  #     it 'URLが正しい' do
  #       expect(current_path).to eq '/public/genres' + genre.id.to_s + '/items'
  #     end
  #     it '商品一覧が表示される' do
  #       expect(page).to have_content '商品一覧'
  #     end
  #     # it '商品の画像が表示される' do
  #     #   expect(page).to have_button 'Update Customer'
  #     # end
  #     it '商品詳細リンクが表示される' do
  #       expect(page).to have_link '', href: public_genre_item_path(genre.id,item.id)
  #     end
  #   end
  # end
  
  # describe '商品詳細画面のテスト' do
  #   before do
  #     visit public_genre_item_path
  #   end

  #   context '表示の確認' do
  #     it 'URLが正しい' do
  #       expect(current_path).to eq '/public/genres' + genre.id.to_s + '/items' + item.id.to_s
  #     end
  #     it '商品詳細が表示される' do
  #       expect(page).to have_content '商品詳細'
  #     end
  #     # it '商品の画像が表示される' do
  #     #   expect(page).to have_button 'Update Customer'
  #     # end
  #     it '商品のnameが表示される' do
  #       expect(page).to have_content item.name
  #     end
  #     it '商品のdetailが表示される' do
  #       expect(page).to have_content item.detail
  #     end
  #     it '投稿画面に進むリンクが表示される' do
  #       expect(page).to have_link '', href: new_public_review_path(item_id: item.id)
  #     end
  #   end
  # end
  
  # describe '投稿画面のテスト' do
  #   before do
  #     visit new_public_review_path
  #   end

  #   context '表示の確認' do
  #     it 'URLが正しい' do
  #       # expect(current_path).to eq '/public/reviews/' + genre.id.to_s + '/items' + item.id.to_s
  #     end
  #     it 'レビュー投稿画面が表示される' do
  #       expect(page).to have_content 'レビュー投稿画面'
  #     end
  #     it 'valueフォームが表示される' do
  #       expect(page).to have_field 'review[value]'
  #     end
  #     it 'good_pointフォームが表示される' do
  #       expect(page).to have_field 'review[good_point]'
  #     end
  #     it 'bad_pointフォームが表示される' do
  #       expect(page).to have_field 'review[bad_point]'
  #     end
  #     it 'improvement_pointフォームが表示される' do
  #       expect(page).to have_field 'review[improvement_point]'
  #     end
  #     it '投稿をするリンクが表示される' do
  #       expect(page).to have_link '', href: public_reviews_path
  #     end
  #   end
  # end
end
