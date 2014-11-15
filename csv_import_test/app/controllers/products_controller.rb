class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def import
    # fileはtmpに自動で一時保存される
    Product.import(params[:file])
    redirect_to root_url, notice: "商品を追加しました。"
  end
end
