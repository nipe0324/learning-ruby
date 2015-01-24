module Api
  class TodosController < ApplicationController
    before_action :set_todo_list

    def index
      @q            = @todo_list.todos.ransack(params[:q]).result # ransackの検索
      @todos        = @q.page(params[:page])  # kaminariのページネーション
      @total_todos  = @q.count
    end

    def create
      todo = @todo_list.todos.create!(todo_params)
      render json: todo, status: 201
    end

    def update
      todo.update!(todo_params)
      render nothing: true, status: 204
    end

    def destroy
      todo.destroy
      render nothing: true, status: 204
    end

    private

    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end

    def todo
      @todo = @todo_list.todos.find(params[:id])
    end

    def todo_params
      params.require(:todo).permit(:description, :completed, :target_position)
    end

  end
end