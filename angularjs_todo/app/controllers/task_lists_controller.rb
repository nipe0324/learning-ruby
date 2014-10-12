class TaskListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @task_lists = current_user.task_lists
  end

  def show
    @task_list = TaskList.find(params[:id])

    permission_denied if @task_list.owner != current_user
  end
end
