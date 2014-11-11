class ProductsController < ApplicationController
  def index
    @products = Product.includes(:manufacture)

    respond_to do |format|
      format.html
      format.csv { send_data ProductCsv.csv(@products) }
    end
  end
end
