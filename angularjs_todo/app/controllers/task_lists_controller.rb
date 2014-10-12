class TaskListsController < ApplicationController
  def show
    @task_list = TAskList.find_by_id(params[:id])
  end
end
