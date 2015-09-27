class TopController < ApplicationController
  def index
    @search_form = RestaurantSearchForm.new(search_params)
    @restaurants = @search_form.search
    # @restaurant_count = Restaurant.count
  end

  def search
    @search_form = RestaurantSearchForm.new(search_params)
    @restaurants = @search_form.search
    # @restaurant_count = Restaurant.count
    render :index
  end

  private

    def search_params
      params.permit(:query, :categories, :pref, :page, :sort, :order)
    end
end
