class WelcomeController < ApplicationController
  def index
    redirect_to tasks_url if current_user
  end

  def guest
    guest_user # guest_userを作成する
    redirect_to tasks_url
  end
end
