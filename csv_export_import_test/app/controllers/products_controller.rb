class ProductsController < ApplicationController
  def index
    @report_products = ProductReport.all

    respond_to do |format|
      format.html
      format.csv { send_data ProductReport.to_csv(@report_products) }
      format.xls { send_data ProductReport.to_csv(@report_products, {col_sep: "\t"}) }
    end
  end
end
