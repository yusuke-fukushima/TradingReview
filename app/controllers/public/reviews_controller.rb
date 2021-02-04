class Public::ReviewsController < ApplicationController
  def new
    @reviews = Review.new
  end
  
  def confirm
    @review = Review.new
  end
  
  def complete
    
  end
end
