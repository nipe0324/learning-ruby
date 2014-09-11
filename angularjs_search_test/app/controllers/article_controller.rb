class ArticleController < ApplicationController
  def index
    render json: Article.order("created_at DESC")
  end

  def show
    render json: Article.find(params[:id])
  end
end
