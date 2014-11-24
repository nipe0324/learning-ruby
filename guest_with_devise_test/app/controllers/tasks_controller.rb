class TasksController < ApplicationController
  def index
    if current_or_guest_user
      @incomplete_tasks = current_or_guest_user.tasks.where(complete: false)
      @complete_tasks = current_or_guest_user.tasks.where(complete: true)
    end
  end

  def create
    @task = current_or_guest_user.tasks.create!(task_params)
    redirect_to tasks_url
  end

  def update
    @task = current_or_guest_user.tasks.find(params[:id])
    @task.update!(task_params)
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.js
    end
  end

  def destroy
    @task = current_or_guest_user.tasks.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.js
    end
  end

  private

    def task_params
      params.require(:task).permit(:name, :complete)
    end
end
