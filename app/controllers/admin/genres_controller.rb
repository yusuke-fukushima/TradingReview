class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genre = Genre.new
    @genres = Genre.all.page(params[:page]).per(4)
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:success] = "ジャンルを新規登録しました。"
      redirect_to admin_genres_path
    else
      render :new
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:success] = "ジャンルを編集しました。"
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name, :image)
  end
end
