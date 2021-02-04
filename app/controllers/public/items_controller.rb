class Public::ItemsController < ApplicationController
  def index
    @genre = Genre.find(params[:id])
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name, :image_id)
  end
end
