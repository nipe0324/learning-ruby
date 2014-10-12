class TaskListsController < ApplicationController
  before_action :authenticate_user!

  def show
    @task_list = TaskList.find(params[:id])

    permission_denied if @task_list.owner != current_user
  end
end
