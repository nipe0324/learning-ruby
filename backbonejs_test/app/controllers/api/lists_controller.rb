module Api
  class ListsController < ApplicationController
    def index
      lists = List.all
      render json: lists
    end

    def show
      list = List.find(params[:id])
      render json: list.as_json(include: :todos)
    end
  end
end
