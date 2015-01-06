module Api
  class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :edit, :update, :destroy]

    # GET /products.json
    def index
      @products = Product.all
      render json: @products
    end

    # GET /products/1.json
    def show
      render json: @product
    end

    # GET /products/1/edit
    def edit
    end

    # POST /products.json
    def create
      @product = Product.new(product_params)

      if @product.save
        render :show, status: :created, location: @product
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /products/1.json
    def update
      if @product.update(product_params)
        render :show, status: :ok, location: @product
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end

    # DELETE /products/1.json
    def destroy
      @product.destroy
      head :no_content
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = Product.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def product_params
        params.require(:product).permit(:name, :price, :publised_at, :category_id)
      end
  end
end