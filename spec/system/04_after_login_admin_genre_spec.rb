require 'rails_helper'

describe '[STEP3] 管理者ログイン後のジャンル一覧のテスト' do
  let(:admin) { create(:admin) }
  let!(:genre) { create(:genre) }
  
  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'ログイン'
  end
  
  describe 'ジャンル一覧画面のテスト' do
    before do
      visit admin_genres_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/genres'
      end
      it '編集を押すと、編集画面に遷移する' do
        expect(page).to have_link '編集', href: edit_admin_genre_path(genre.id)
        click_link '編集', href: edit_admin_genre_path(genre.id)
      end
      it '新規登録を押すと、新規登録画面に遷移する' do
        expect(page).to have_link '新規登録', href: new_admin_genre_path
        click_link '新規登録', href: new_admin_genre_path
      end
    end
  end
  
  describe 'ジャンル編集画面のテスト' do
    before do
      visit edit_admin_genre_path(genre.id)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/genres/' + genre.id.to_s + '/edit'
      end
      it 'ジャンル名編集フォームにジャンル名が表示される' do
        expect(page).to have_field 'genre[name]', with: genre.name
      end
      it '変更内容保存ボタンが表示される' do
        expect(page).to have_button '変更内容保存'
      end
    end

    context '更新成功のテスト' do
      before do
        @genre_old_name = genre.name
        fill_in 'genre[name]', with: Faker::Name.name
        click_button '変更内容保存'
      end

      it 'nameが正しく更新される' do
        expect(genre.reload.name).not_to eq @genre_old_name
      end
      it 'リダイレクト先が、ジャンル画面になっている' do
        expect(current_path).to eq '/admin/genres'
      end
    end
  end
  
  describe 'ジャンル新規登録画面のテスト' do
     before do
      visit new_admin_genre_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/genres/new'
      end
      it '「新規登録」と表示される' do
        expect(page).to have_content '新規登録'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'genre[name]'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'genre[name]', with: Faker::Name.name
      end

      it '正しく新規登録される' do
        expect { click_button '新規登録' }.to change(Gnere.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できた商品の詳細画面になっている' do
        click_button '新規登録'
        expect(current_path).to eq '/admin/genres/' + Genre.last.id.to_s
      end
    end
  end
end
