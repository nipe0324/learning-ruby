class TopController < ApplicationController
  def index
    @restaurants = Restaurant.search(params).page(params[:page]).per(params[:per])
  end

  def suggest
    names = Restaurant.suggest(params[:term])
    render json: names
  end
end
