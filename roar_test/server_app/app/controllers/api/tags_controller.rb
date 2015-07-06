module Api
  class TagsController < ApplicationController
    skip_before_action :verify_authenticity_token

    # GET /tweets
    def index
      @tags = Tag.all
      render json: @tags.extend(::Json::Tag::Server.for_collection)
    end
  end
end
