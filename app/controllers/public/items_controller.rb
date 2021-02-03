class Public::ItemsController < ApplicationController
  def index
    #@genre = Genre.find(params[:id])
    @items = Item.all
  end

  def show
  end
end
