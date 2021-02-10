class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @reviews = Review.all.page(params[:page]).per(5)
  end

  def show
    @review = Review.find(params[:id])
  end

  require 'csv'

  def new
    @review = Review.new
    @reviews = Review.all
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_posts_csv(@reviews)
      end
    end
  end

  private

  def send_posts_csv(posts)
    csv_data = CSV.generate do |csv|
      column_names = %w(投稿者名 商品名 商品評価 良い点 悪い点 改善点)
      csv << column_names
      posts.each do |post|
        column_values = [
          post.review.datetime,
          post.customer.name,
          post.item.name,
          post.value,
          post.good_point,
          post.bad_point,
          post.improvement_point,
        ]
        csv << column_values
      end
    end
    send_data(csv_data, filename: "投稿一覧.csv")
  end
end
