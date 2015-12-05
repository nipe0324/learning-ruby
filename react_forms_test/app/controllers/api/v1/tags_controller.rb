class Api::V1::TagsController < ApplicationController

  def index
    @tags = Tag.order(:name)
  end

end
