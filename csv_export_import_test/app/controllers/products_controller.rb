class ProductsController < ApplicationController
  def index
    @products = Product.includes(:manufacture)
    @product_report = ProductReport.new
  end

  def export
    @product_report = ProductReport.new

    respond_to do |format|
      format.csv { send_data @product_report.download }
      format.xls { send_data @product_report.download({col_sep: "\t"}) }
    end
  end

  def import
    @products = Product.includes(:manufacture)
    @product_report = ProductReport.new(file)
    if @product_report.import
      redirect_to root_url, notice: "Imported products successfully."
    else
      render :index
    end
  end

  private

    def file
      return  nil unless params.keys.include?("product_report")

      params.require(:product_report).permit(:file)[:file]
    end
end
