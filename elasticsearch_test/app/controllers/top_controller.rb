class TopController < ApplicationController
  def index
    @restaurants = Restaurant.search(params).page(params[:page]).per(params[:per])
  end
end
