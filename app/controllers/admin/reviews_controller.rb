class Admin::ReviewsController < ApplicationController
before_action :authenticate_admin!

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end
end
