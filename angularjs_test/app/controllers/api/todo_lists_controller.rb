module Api
  class TodoListsController < ApplicationController
    before_action :set_todo_list, only: [:show, :update, :destroy]

    def index
      render json: TodoList.all
    end

    def show
    end

    def create
      list = TodoList.create!(todo_list_params)
      render json: list, status: 201
    end

    def update
      @todo_list.update(todo_list_params)
      render nothing: true
    end

    def destroy
      @todo_list.destroy
      render nothing: true
    end

    private

      def set_todo_list
        @todo_list ||= TodoList.find(params[:id])
      end

      def todo_list_params
        params.require(:todo_list).permit(:name)
      end
  end
end