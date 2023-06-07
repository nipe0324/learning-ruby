class TopController < ApplicationController
  def index
    ActiveRecord::Base
    render plain: "called ActiveRecord::Base"
  end
end
