class Public::GenresController < ApplicationController
before_action :authenticate_customer!

  def index
    @genres = Genre.all
  end
end
