class Admin::ItemsController < ApplicationController
before_action :authenticate_admin!

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "新商品を登録しました!!"
      redirect_to admin_item_path(@item)
    else
      flash[:notice] = "入力漏れがあります"
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "商品を編集しました。"
      redirect_to admin_item_path(@item)
    else
      flash[:notice] = "入力漏れがあります"
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :detail, :genre_id)
  end
end
