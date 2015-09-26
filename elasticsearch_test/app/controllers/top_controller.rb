class TopController < ApplicationController
  def index
    @search_form = RestaurantSearchForm.new(page_params)
    @restaurants = @search_form.search
    # @restaurant_count = Restaurant.count
  end

  def search
    @search_form = RestaurantSearchForm.new(search_params.merge(page_params))
    @restaurants = @search_form.search
    # @restaurant_count = Restaurant.count
    render :index
  end

  private

    def page_params
      params.permit(:page)
    end

    def search_params
      params.require(:restaurant_search_form).permit(:query)
    end
end
