class Public::ReviewsController < ApplicationController
before_action :authenticate_customer!

  def new
    @review = Review.new(item_id: params[:item_id])
  end

  def create
    @review = current_customer.reviews.new(review_params)
    if @review.save
      redirect_to public_reviews_complete_path
    else
      render :new
    end
  end

  def complete
  end

  private

  def review_params
    params.require(:review).permit(:item_id, :good_point, :bad_point, :improvement_point)
  end
end
