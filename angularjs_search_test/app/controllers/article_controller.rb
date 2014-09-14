class ArticleController < ApplicationController
  def index
    @articles = Article.order("created_at DESC")

    render json: @articles
  end

  def show
    render json: Article.find(params[:id])
  end
end
