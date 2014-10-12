class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to task_list_path(current_user.task_list.id)
    end
  end
end
