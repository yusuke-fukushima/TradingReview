require 'rails_helper'

describe '[STEP4] 管理者商品一覧のテスト' do
  let(:admin) { create(:admin) }
  let!(:genre) { create(:genre) }
  let!(:item) { create(:item, genre_id: genre.id) }

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
      it '商品名を押すと、商品詳細画面に遷移する' do
        expect(page).to have_link item.name, href: admin_item_path(item.id)
        click_link item.name, href: admin_item_path(item.id)
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
      it 'ジャンル名編集フォームにジャンル名が表示される' do
        expect(page).to have_select('item[genre_id]', selected: genre.name)
      end
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

    context '更新成功のテスト' do
      before do
        @genre_old_name = genre.name
        @item_old_email = item.name
        @item_old_detail = item.detail
        select(value = genre.name, from: "item[genre_id]")
        fill_in 'item[name]', with: Faker::Name.name
        fill_in 'item[detail]', with: Faker::Lorem
        click_button '変更内容保存'
      end

      it 'genre.nameが正しく更新される' do
        expect(genre.reload.name).to eq @genre_old_name
      end
      it '商品名が正しく更新される' do
        expect(item.reload.name).not_to eq @item_old_name
      end
      it '商品説明が正しく更新される' do
        expect(item.reload.detail).not_to eq Faker::Lorem
      end
      it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
        expect(current_path).to eq '/admin/items/' + item.id.to_s
      end
    end
  end
end
