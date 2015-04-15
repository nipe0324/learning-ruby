class HomeController < ApplicationController
  def index
    @omake = Omake.first
  end
end
