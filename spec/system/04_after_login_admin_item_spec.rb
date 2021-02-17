require 'rails_helper'

describe '[STEP3] 管理者ログイン後の商品一覧のテスト' do
  let(:admin) { create(:admin) }
  let!(:item) { create(:item) }
  let!(:genre) { create(:genre) }

  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'ログイン'
  end

  describe '商品一覧画面のテスト' do
     before do
      visit admin_items_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/items'
      end
      it 'item.nameを押すと、商品詳細画面に遷移する' do
        expect(page).to have_link item.name, href: admin_item_path(item.id)
        click_link item.name, href: admin_item_path(item.id)
      end
      it '新規登録を押すと、新規登録画面に遷移する' do
        expect(page).to have_link '新規登録'
        click_link '新規登録', href: new_admin_item_path
      end
    end

  end

  describe '商品詳細画面のテスト' do
    before do
      visit admin_item_path(item.id)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/items/' + item.id.to_s
      end
      it '編集を押すと、編集画面に遷移する' do
        expect(page).to have_link '編集', href: edit_admin_item_path(item.id)
        click_link '編集', href: edit_admin_item_path(item.id)
      end
    end
  end

  describe '商品情報編集画面のテスト' do
    before do
      visit edit_admin_item_path(item.id)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/items/' + item.id.to_s + '/edit'
      end
      # it 'ジャンル名編集フォームにジャンル名が表示される' do
      #   expect(page).to have_field 'genre[name]', with: genre.name
      # end
      it '商品名編集フォームに商品名が表示される' do
        expect(page).to have_field 'item[name]', with: item.name
      end
      it '商品説明編集フォームに商品説明が表示される' do
        expect(page).to have_field 'item[detail]', with: item.detail
      end
      it '変更内容保存ボタンが表示される' do
        expect(page).to have_button '変更内容保存'
      end
    end

    # context '更新成功のテスト' do
    #   before do
    #     @genre_old_name = genre.name
    #     @item_old_email = item.name
    #     @item_old_detail = item.detail
    #     fill_in 'genre[name]', with: Faker::Name.name
    #     fill_in 'item[name]', with: Faker::Name.name
    #     fill_in 'item[detail]', with: Faker::Lorem
    #     click_button '編集内容を保存'
    #   end

    #   it 'genre.nameが正しく更新される' do
    #     expect(genre.reload.name).not_to eq @genre_old_name
    #   end
    #   it 'item.nameが正しく更新される' do
    #     expect(item.reload.name).not_to eq @item_old_name
    #   end
    #   it 'item.detailが正しく更新される' do
    #     expect(item.reload.detail).not_to eq @item_old_detail
    #   end
    #   it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
    #     expect(current_path).to eq '/admin/items/' + item.id.to_s
    #   end
    # end
  end

  describe '商品新規登録画面のテスト' do
    before do
      visit new_admin_item_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/items/new'
      end
      it '「新規登録」と表示される' do
        expect(page).to have_content '新規登録'
      end
      # it 'genre.nameフォームが表示される' do
      #   expect(page).to have_field 'genre[name]'
      # end
      it 'item.nameフォームが表示される' do
        expect(page).to have_field 'item[name]'
      end
      it 'item.detailフォームが表示される' do
        expect(page).to have_field 'item[detail]'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'genre[name]', with: Faker::Name.name
        fill_in 'item[name]', with: Faker::Name.name
        fill_in 'item[detail]', with: Faker::Lorem
      end

      # it '正しく新規登録される' do
      #   expect { click_button '新規登録' }.to change(Item.all, :count).by(1)
      # end
      # it '新規登録後のリダイレクト先が、新規登録できた商品の詳細画面になっている' do
      #   click_button '新規登録'
      #   expect(current_path).to eq '/admin/items/' + Item.last.id.to_s
      # end
    end
  end
end
