class TopController < ApplicationController
  def index
    @restaurants = Restaurant.search(params)
  end
end
