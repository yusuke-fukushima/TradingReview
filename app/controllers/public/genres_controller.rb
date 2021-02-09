class Public::GenresController < ApplicationController
before_action :authenticate_customer!

  def index
    @genres = Genre.all.page(params[:page]).per(4)
  end
end
