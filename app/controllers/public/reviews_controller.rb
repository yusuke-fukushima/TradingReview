class Public::ReviewsController < ApplicationController
before_action :authenticate_customer!

  def new
    @reviews = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to public_reviews_complete_path(@review)
    else
      render :new
    end
  end
  
  def complete
  end
end
