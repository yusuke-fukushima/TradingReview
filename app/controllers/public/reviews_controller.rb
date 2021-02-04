class Public::ReviewsController < ApplicationController
before_action :authenticate_customer!

  def new
    @reviews = Review.new
  end
  
  def confirm
    @review = Review.new
  end
  
  def complete
    
  end
end
