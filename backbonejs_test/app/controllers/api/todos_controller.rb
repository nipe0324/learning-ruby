module Api
  class TodosController < ApplicationController
    def index
      list = List.find(params[:list_id])
      todos = list.todos.order(:position)
      render json: todos
    end
  end
end
