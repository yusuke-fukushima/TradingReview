class Public::ItemsController < ApplicationController
before_action :authenticate_customer!

  def index
    @genre = Genre.find(params[:genre_id])
    @items = @genre.items
  end

  def show
    @item = Item.find(params[:id])
  end
  
end
