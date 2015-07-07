class ReportsController < ApplicationController
  def index
    @tweets = Tweet.includes(:tags)
    @tags = Tag.all
  end
end
